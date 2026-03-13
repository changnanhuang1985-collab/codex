# Contract Document Transformation Tool

## 1. 项目定位

本项目用于构建一个面向“客户契约依赖文档转换”的内部工具。

目标场景是：

- 客户提供一份或多份 `input` 文档
- 团队需要根据既定规则，输出公司内部格式的相关契约文档 `output`
- 文档内容中同时包含固定文字、动态字段、规则约束和文件命名逻辑
- 当前大量依赖人工转换，严谨性要求高，且手工作业容易出错

本项目的目标不是做一个简单脚本，而是构建一个：

- 可提炼模板
- 可管理规则
- 可自动生成文件
- 可检查输出准确性
- 可持续升级

的文档转换工作系统。

## 2. 核心目标

- 将客户 `input` 与公司内部 `output` 的转换流程标准化
- 将固定文本与动态内容区分并模板化
- 基于模板与规则自动生成输出文档及文件名
- 通过 checklist、review 和校验机制降低错误率
- 支持后续格式变化、规则变化和需求变化的持续升级

## 3. 当前项目结构

- `00_Project_Management`
- `01_Requirements`
- `02_Solution_Design`
- `03_AI_Project_Team`

## 4. 推荐阅读顺序

建议按以下顺序阅读：

1. `00_Project_Management/Project_Charter.md`
2. `01_Requirements/Business_Background_and_Pain_Points.md`
3. `01_Requirements/Functional_Requirements.md`
4. `02_Solution_Design/Tool_Concept_and_Workflow.md`
5. `02_Solution_Design/Template_Extraction_Strategy.md`
6. `02_Solution_Design/Quality_Control_and_Review_Design.md`
7. `03_AI_Project_Team/README.md`

## 5. 一句话说明

这是一个把“高风险手工契约文档转换”升级成“模板化、规则化、可审查、可演进工具”的项目起点。
