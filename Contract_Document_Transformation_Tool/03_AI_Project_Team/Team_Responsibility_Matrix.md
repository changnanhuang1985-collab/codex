# Team Responsibility Matrix

## 1. 目的

本文档用于明确 `Contract Document Transformation Tool` 项目中各 AI 角色的职责分工。

项目采用：

- `鞠` 统一推进
- 专业角色分工执行
- `Orion` 做治理与阶段汇报

的模式运行。

## 2. 角色分工

| 角色 | 担当定位 | 主要职责 | 当前阶段重点 |
| --- | --- | --- | --- |
| `鞠` | 项目负责人 | 统筹推进、拆解任务、安排节奏、统一收口 | 推动样例治理、模板拆解、规则草案 |
| `Contract Product Owner` | 需求负责人 | 明确真实需求、识别输入边界、确认输出目标 | 把 `input` 中的真实业务要求整理清楚 |
| `Template and Rule Architect` | 设计者 / 架构师 | 拆模板、定变量、定命名规则、定可复用边界 | 从参考输出中抽出固定结构与动态部分 |
| `Extraction and Transformation Engineer` | 实施者 | 规划读取、抽取、映射、生成逻辑 | 设计首版转换流程和实现路径 |
| `Quality and Review Lead` | 测试 / 质控负责人 | checklist、review、回归和高风险控制 | 设计验证点，避免错误自动化 |
| `Change Learning and Operations Lead` | 变更与运营负责人 | 记录变化、维护规则版本、管理升级与推广 | 建立后续变更吸收机制 |
| `Orion` | CIO / 治理负责人 | 放权、治理、阶段校准、报告输出 | 不管日常，管方向、节奏和报告 |

## 3. 当前执行原则

- 用户直接看结果，不需要逐个调度成员
- `鞠` 负责组织其他成员干活
- 专业角色要对自己的产物负责
- `Orion` 只在阶段汇报和治理问题上介入

## 4. 当前阶段任务分派

### 鞠

- 统筹 Phase 2 样例建模
- 推动第一组需求与参考输出映射
- 要求各角色按产物交付，不停留在讨论

### Contract Product Owner

- 识别当前真实需求中的业务主题
- 确认输入文档代表的业务意图

### Template and Rule Architect

- 从参考输出中提炼通用模板能力
- 区分固定内容、动态变量、项目特有内容

### Extraction and Transformation Engineer

- 输出第一版转换流程
- 评估读取和结构化抽取的实现路径

### Quality and Review Lead

- 输出检查点
- 设计首版测试与人工 review 路径

### Change Learning and Operations Lead

- 设计后续模板升级与版本维护方式

## 5. 一句话说明

这个项目不是“大家都懂一点”，而是 `鞠` 带着设计、架构、实施、测试和变更运营各自把活做清楚。
