# Output Template Model Draft

## 1. 目的

本文档定义当前项目的第一版输出模板模型。

目标不是还原某个历史项目，而是先把“我们未来要生成的内部文档”按类型拆成可设计对象。

## 2. 输出类型分层

当前建议将输出文档分成 3 类：

### A. 文书型输出

典型代表：

- 再委托先承诺申请书

结构特征：

- 标题区
- 基本信息区
- 申请 / 说明正文
- 确认 / 签章区

### B. 表格型输出

典型代表：

- 月次管理表
- 台账型内部文档

结构特征：

- 标题区
- 基本信息区
- 明细表格区
- 汇总区

### C. 检查型输出

典型代表：

- 原籍确认 sheet
- reviewer 检查附表

结构特征：

- 标题区
- 对象信息区
- 核对项区
- 结果 / 备注区

## 3. 通用模板区块

### 3.1 标题区

通用变量：

- `customer_name`
- `project_title`
- `document_category`
- `period_or_fiscal_year`

### 3.2 基本信息区

通用变量：

- `request_or_estimate_no`
- `project_title`
- `customer_name`
- `project_period_start`
- `project_period_end`

### 3.3 正文 / 明细区

按文档类型拆分：

- 文书型：固定说明 + 动态条款变量
- 表格型：固定列头 + 动态明细值
- 检查型：固定检查项 + 动态核对对象

### 3.4 输出控制区

用于控制：

- reviewer 是否必需
- 文档版本
- 模板版本
- 规则版本

## 4. 第一版模板变量建议

### 共通变量

- `customer_name`
- `project_title`
- `document_category`
- `request_or_estimate_no`
- `project_period_start`
- `project_period_end`
- `period_label`
- `template_version`
- `rule_version`

### 文书型扩展变量

- `vendor_name`
- `statement_body`
- `approval_scope`

### 表格型扩展变量

- `sheet_title`
- `summary_id`
- `line_items`
- `total_hours_or_amount`

### 检查型扩展变量

- `check_target_name`
- `check_items`
- `review_result`
- `review_comment`

## 5. 第一版实现建议

第一轮原型不追求复杂动态排版，建议优先实现：

1. 标题区变量替换
2. 基本信息区变量替换
3. 文件名自动生成
4. reviewer checklist 输出

## 6. 当前结论

当前已经可以把输出建模为：

- 文书型模板
- 表格型模板
- 检查型模板

下一步就是为每一类模板补固定结构和变量清单。
