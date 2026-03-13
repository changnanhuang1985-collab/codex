# Value Mapping 技术设计标准

## 1. 文档目的

本文档用于定义 `SAP Ariba` 与 `SAP S/4HANA` 集成 POC 中 `Value Mapping` 的设计原则、对象清单、维护方式、错误处理与测试要求。

本文档既作为本 POC 的详细技术文档，也可作为后续 `Ariba-S/4` 集成项目的标准参考文档。

## 2. 背景与定位

在 Ariba 与 S/4 的集成中，字段映射并不只是结构转换，很多字段还涉及“代码语义转换”。例如：

- 国家代码可能需要在不同系统间统一编码规则
- 支付条件可能在 Ariba 与 S/4 中采用不同代码体系
- 工厂、组织、状态等字段通常涉及企业内部主数据治理

这类映射如果散落在 Script、Message Mapping 或人工约定中，后续会带来以下问题：

- 映射规则不可见，难以审查
- 变更影响难以评估
- 不同接口重复实现，导致规则不一致
- 出错时难以快速定位与修复

因此，本项目规定：凡属于“受控代码转换”的场景，优先通过 `Value Mapping` 统一管理。

## 3. 适用范围

本文档适用于以下接口与场景：

- `IF-AR-S4-001` 供应商主数据集成
- `IF-AR-S4-002` 采购交易集成
- `IF-AR-S4-003` 采购响应返还集成

适用的转换对象包括但不限于：

- 国家代码
- 支付条件
- 工厂
- 业务状态
- 组织代码
- 采购组、公司代码等主数据类代码

以下场景原则上不使用 Value Mapping：

- 单纯格式修正，如大小写转换、前后空格去除
- 可通过明确算法直接推导的值
- 临时性、一次性且无复用价值的转换

## 4. 设计原则

### 4.1 集中管理

所有受控代码映射应统一定义在 `Value Mapping` 对象中，不允许在多个 iFlow 中重复硬编码。

### 4.2 命名清晰

映射对象名称需体现业务含义，避免使用含糊命名。

### 4.3 可追踪

当 Value Mapping 命中失败时，日志中必须能够定位：

- 接口 ID
- Value Mapping 名称
- 源系统
- 源字段名
- 源值
- 业务键

### 4.4 可治理

Value Mapping 不仅是技术配置，也是业务规则的一部分。变更需有明确责任人与审批机制。

### 4.5 可复用

若同一类代码转换在多个接口场景中重复出现，应复用已有 Value Mapping，不重复定义。

## 5. Value Mapping 适用判断标准

当某字段满足以下任一条件时，应优先考虑使用 Value Mapping：

- 源系统与目标系统代码体系不同
- 转换结果由业务治理决定，而非技术逻辑自动推导
- 同一映射规则会被多个接口复用
- 映射关系未来可能变更，且需由配置驱动维护

当字段满足以下条件时，可不使用 Value Mapping：

- 仅做固定格式标准化
- 一对一直接传递，且不存在代码体系差异
- 完全由主数据查询或业务规则引擎负责解析

## 6. 本 POC 的 Value Mapping 对象清单

| VM 名称 | 接口 | 源字段 | 目标字段 | 用途 | 失败时处理 |
| --- | --- | --- | --- | --- | --- |
| `VM_COUNTRY` | IF-AR-S4-001 | Ariba.Country | S4.Country | 国家代码统一 | 记录错误并中止 |
| `VM_PAYMENT_TERMS` | IF-AR-S4-001 | Ariba.PaymentTerms | S4.PaymentTerms | 支付条件转换 | 记录错误并中止 |
| `VM_PLANT` | IF-AR-S4-002 | Ariba.Item.Plant | S4.Item.Plant | 工厂代码统一 | 记录错误并中止 |
| `VM_STATUS_ARIBA_FROM_S4` | IF-AR-S4-003 | S4.Status | AribaResponse.Status | 状态回传转换 | 记录错误并中止 |

说明：

- `VM_COUNTRY` 已在详细映射中被明确引用
- `VM_PAYMENT_TERMS` 已在映射总览中出现，应补充到详细设计与测试清单
- `VM_PLANT` 为采购交易场景中的关键主数据映射
- `S4 -> Ariba` 方向的状态映射建议单独命名，避免与 `Ariba -> S4` 状态映射混淆

## 7. 命名规范

Value Mapping 建议采用以下命名规则：

```text
VM_<业务对象或代码类型>
```

推荐示例：

- `VM_COUNTRY`
- `VM_PAYMENT_TERMS`
- `VM_PLANT`
- `VM_COMPANY_CODE`
- `VM_PURCH_ORG`

若同一业务对象存在明显方向差异，可采用：

```text
VM_<业务对象>_<方向或语义>
```

示例：

- `VM_STATUS_ARIBA_TO_S4`
- `VM_STATUS_ARIBA_FROM_S4`

不推荐示例：

- `VM01`
- `COMMON_VM`
- `STATUS_MAP_NEW`

## 8. 逻辑设计标准

### 8.1 输入要素

调用 Value Mapping 时，至少应明确以下要素：

- Source Agency
- Source Identifier
- Source Value
- Target Agency
- Target Identifier

建议 Agency / Identifier 体现系统与字段语义，而不是仅写项目简称。

示例：

| 要素 | 示例值 |
| --- | --- |
| Source Agency | `ARIBA` |
| Source Identifier | `COUNTRY` |
| Source Value | `JP` |
| Target Agency | `S4` |
| Target Identifier | `COUNTRY` |

### 8.2 调用位置

Value Mapping 应尽量在 Message Mapping 或明确的转换步骤中调用，不建议：

- 深埋在复杂 Groovy Script 内
- 与业务判断逻辑混写
- 多处重复调用相同映射却没有统一封装说明

### 8.3 失败处理

对于关键业务字段的 Value Mapping 命中失败，原则上应视为业务可识别的设计性错误，不允许静默忽略。

推荐处理方式：

1. 记录错误日志
2. 标记接口状态为失败
3. 将源值、映射对象名、业务键写入异常上下文
4. 交由异常处理 iFlow 发送通知

### 8.4 默认值策略

除非经过业务确认，不建议在 Value Mapping 失败时自动赋默认值。

允许使用默认值的前提：

- 默认值具有明确业务意义
- 已在需求或设计文档中获得确认
- 使用默认值不会导致错误数据入账

本 POC 当前建议：

- `Country`：不设默认值
- `Payment Terms`：不设默认值
- `Plant`：不设默认值
- `Status`：不设默认值

## 9. 详细设计模板

每个 Value Mapping 对象至少应记录以下内容：

| 项目 | 说明 |
| --- | --- |
| VM 名称 | Value Mapping 对象名称 |
| 业务说明 | 此映射解决什么业务语义差异 |
| 使用接口 | 被哪些 IF / iFlow 使用 |
| Source Agency | 源系统标识 |
| Source Identifier | 源字段标识 |
| Target Agency | 目标系统标识 |
| Target Identifier | 目标字段标识 |
| 命中失败处理 | 错误、警告或默认值 |
| 维护责任人 | 业务 / 主数据 / 开发 / 运维 |
| 变更频率 | 高频 / 低频 |
| 测试用例 | 正常、异常、边界案例 |

## 10. 本 POC 推荐的 Value Mapping 设计明细

### 10.1 VM_COUNTRY

| 项目 | 内容 |
| --- | --- |
| VM 名称 | `VM_COUNTRY` |
| 业务说明 | Ariba 国家代码转换为 S/4 国家代码 |
| 使用接口 | `IF-AR-S4-001` |
| Source Agency | `ARIBA` |
| Source Identifier | `COUNTRY` |
| Target Agency | `S4` |
| Target Identifier | `COUNTRY` |
| 失败处理 | 失败即报错，中止消息处理 |
| 当前风险 | 已出现部分国家代码未维护缺陷 |

样例：

| Source Value | Target Value | 备注 |
| --- | --- | --- |
| `JP` | `JP` | ISO 标准代码 |
| `CN` | `CN` | ISO 标准代码 |
| `US` | `US` | ISO 标准代码 |

### 10.2 VM_PAYMENT_TERMS

| 项目 | 内容 |
| --- | --- |
| VM 名称 | `VM_PAYMENT_TERMS` |
| 业务说明 | Ariba 支付条件转换为 S/4 支付条件 |
| 使用接口 | `IF-AR-S4-001` |
| Source Agency | `ARIBA` |
| Source Identifier | `PAYMENT_TERMS` |
| Target Agency | `S4` |
| Target Identifier | `PAYMENT_TERMS` |
| 失败处理 | 失败即报错，中止消息处理 |
| 当前建议 | 与业务确认标准代码表后集中维护 |

样例：

| Source Value | Target Value | 备注 |
| --- | --- | --- |
| `IMMEDIATE` | `0001` | 示例 |
| `NET30` | `0030` | 示例 |
| `NET60` | `0060` | 示例 |

### 10.3 VM_PLANT

| 项目 | 内容 |
| --- | --- |
| VM 名称 | `VM_PLANT` |
| 业务说明 | Ariba 行项目工厂代码转换为 S/4 工厂代码 |
| 使用接口 | `IF-AR-S4-002` |
| Source Agency | `ARIBA` |
| Source Identifier | `PLANT` |
| Target Agency | `S4` |
| Target Identifier | `PLANT` |
| 失败处理 | 失败即报错，中止当前消息处理 |
| 当前建议 | 与采购组织 / 公司代码一并纳入主数据治理 |

样例：

| Source Value | Target Value | 备注 |
| --- | --- | --- |
| `SH01` | `1000` | 示例 |
| `BJ01` | `1100` | 示例 |
| `GZ01` | `1200` | 示例 |

### 10.4 VM_STATUS_ARIBA_FROM_S4

| 项目 | 内容 |
| --- | --- |
| VM 名称 | `VM_STATUS_ARIBA_FROM_S4` |
| 业务说明 | S/4 响应状态转换为 Ariba 可识别状态 |
| 使用接口 | `IF-AR-S4-003` |
| Source Agency | `S4` |
| Source Identifier | `PURCHASE_STATUS` |
| Target Agency | `ARIBA` |
| Target Identifier | `STATUS` |
| 失败处理 | 失败即报错并进入异常通知 |
| 当前建议 | 按业务流程状态机统一治理 |

样例：

| Source Value | Target Value | 备注 |
| --- | --- | --- |
| `CREATED` | `ACCEPTED` | 示例 |
| `REJECTED` | `REJECTED` | 示例 |
| `IN_PROCESS` | `PENDING` | 示例 |

## 11. 配置维护标准

### 11.1 维护责任划分

| 角色 | 责任 |
| --- | --- |
| 业务负责人 | 确认业务语义与目标值是否合法 |
| 主数据负责人 | 确认代码表来源与治理归属 |
| 开发负责人 | 完成技术配置与调用实现 |
| 测试负责人 | 验证命中、未命中、边界值与回归场景 |
| 运维负责人 | 处理生产变更与缺失映射告警 |

### 11.2 变更流程建议

1. 提出新增或修改映射需求
2. 业务与主数据负责人确认目标代码
3. 开发更新 Value Mapping 配置
4. 执行单体测试与接口回归测试
5. 更新文档与变更记录
6. 再进入后续环境发布

### 11.3 版本管理建议

- 对每次 Value Mapping 调整保留变更记录
- 文档中记录新增、修改、删除的映射项
- 若项目规模扩大，建议单独维护 `Value Mapping Register`

## 12. 错误处理与日志标准

当发生 Value Mapping 未命中时，错误日志建议至少包含以下信息：

| 项目 | 示例 |
| --- | --- |
| InterfaceId | `IF-AR-S4-001` |
| MappingObject | `VM_COUNTRY` |
| SourceField | `Ariba.Country` |
| SourceValue | `ZZ` |
| BusinessKey | `SupplierID=SUP-10001` |
| CorrelationId | CPI 运行时生成值 |
| ErrorCategory | `VALUE_MAPPING_NOT_FOUND` |

建议错误消息格式：

```text
Value Mapping not found. VM=VM_COUNTRY, SourceField=Ariba.Country, SourceValue=ZZ, IF=IF-AR-S4-001
```

不建议仅输出：

```text
Mapping error
```

## 13. 测试标准

每个 Value Mapping 对象至少覆盖以下测试场景：

- 正常命中
- 源值为空
- 源值格式不合法
- 源值存在但未维护
- 大小写差异
- 批量场景下部分明细未命中

推荐测试样例：

| 测试类型 | 示例 |
| --- | --- |
| 正常 | `JP -> JP` |
| 异常 | `ZZ -> 未命中` |
| 边界 | ` jp ` 经标准化后命中 `JP` |
| 批量 | 10 条明细中 1 条 `Plant` 未命中 |

## 14. 与现有文档的对应关系

本文档与以下成果物联动使用：

- `04_Basic_Design/IF_Basic_Design.md`
- `04_Basic_Design/Mapping_Overview.csv`
- `05_Detail_Design/Mapping_Detail_Spec.csv`
- `05_Detail_Design/Log_and_Reprocessing_Design.md`
- `07_Testing/Test_Summary_Report.md`
- `07_Testing/Defect_Log.csv`

需要同步补强的点：

- 在 `Mapping_Detail_Spec.csv` 中补充 `VM_PAYMENT_TERMS` 的详细条目
- 在测试用例中补充所有 Value Mapping 的未命中场景
- 在缺陷收敛前，优先完成 `VM_COUNTRY` 的样例补齐与核对

## 15. 本 POC 的风险与改进建议

当前已识别风险如下：

- `VM_COUNTRY` 存在部分样例未维护问题
- `VM_PAYMENT_TERMS` 在总览中已定义，但详细设计粒度还不够
- `VM_PLANT` 对采购交易正确性影响较大，需要尽早与主数据治理对齐
- 状态映射若无统一状态机定义，后续容易在接口间出现语义不一致

建议下一步行动：

1. 建立统一的 `Value Mapping Register`
2. 对 `Country / Payment Terms / Plant / Status` 形成正式代码对照表
3. 在开发规范中明确禁止将受控代码转换写死在 Script 中
4. 将 Value Mapping 未命中纳入标准监控与告警分类

## 16. 一句话结论

对 Ariba 与 S/4 集成而言，`Value Mapping` 不是一个附属配置项，而是连接“业务语义一致性”和“接口可运维性”的关键控制点，应作为独立设计对象进行标准化管理。
