# BTP_Integration 使用说明

## 1. 目的

`BTP_Integration` 文件夹用于统一管理部门内部与 `SAP BTP Integration` 相关的资料、设计、实施资产和运维文档。

适用范围包括：
- `SAP Integration Suite` 能力建设
- 集成架构设计
- `iFlow` 设计与实现资料
- `API`、`Event`、`B2B` 相关文档
- 安全、监控、测试、运维资料
- 培训材料、成长路径、能力地图

本目录的目标不是只存“开发文件”，而是作为团队共享的 `Integration Knowledge Base`。

## 2. 目录结构

当前目录结构如下：

- `01_Architecture`
  - 存放架构设计文档、系统关系图、集成分层说明、Landscape 资料
- `02_APIs`
  - 存放 `Inbound` / `Outbound API` 设计、接口说明、调用约定
- `03_iFlows`
  - 存放 `iFlow` 设计稿、包结构说明、实现清单、交付资产说明
- `04_Mappings`
  - 存放 `Message Mapping`、`Value Mapping` 相关资料
- `05_Adapters`
  - 按适配器分类管理资料，例如 `HTTP`、`OData`、`SOAP`、`IDoc`、`SFTP`
- `06_Security`
  - 存放证书、`OAuth`、权限和授权相关说明
- `07_Monitoring`
  - 存放监控、日志、告警、排查手册
- `08_Testing`
  - 存放测试案例、测试数据、报文样例
- `09_Operations`
  - 存放部署、运行手册、运维操作说明
- `10_Documentation`
  - 存放方法论、设计文档、培训材料、能力地图、说明性文档

## 3. 推荐使用方式

建议按“资料类型”而不是“个人习惯”来归档，这样后续团队成员更容易查找。

推荐原则：
- 架构类内容放到 `01_Architecture`
- 接口清单和 API 设计放到 `02_APIs`
- `iFlow` 相关内容放到 `03_iFlows`
- 字段映射、代码值映射放到 `04_Mappings`
- 按协议或适配器沉淀经验放到 `05_Adapters`
- 安全认证和权限方案放到 `06_Security`
- 日志、监控、排错经验放到 `07_Monitoring`
- 测试案例和样例报文放到 `08_Testing`
- 部署、发布、运行手册放到 `09_Operations`
- 培训、能力建设、方法论文档放到 `10_Documentation`

## 4. 文件命名建议

建议文件名尽量清晰、稳定，避免使用“新建文档”“最终版”“最新版”这类名称。

推荐命名方式：
- 主题型文档：`SAP_Integration_Suite_Consultant_Growth_Path.md`
- 设计型文档：`SuccessFactors_to_S4_Interface_Design.md`
- 清单型文档：`API_Inventory.md`
- 规范型文档：`Integration_Naming_Conventions.md`

命名建议：
- 文件名优先使用英文或英文加下划线
- 正文内容可以中文为主
- 避免文件名过长
- 同类文件保持统一风格

## 5. Markdown 文档约定

当前目录中的说明类文档，建议采用以下规则：

- 正文以中文为主
- 专业术语可保留英文
- 代码、配置名、对象名保持原文
- 标题结构尽量清晰，便于后续转成知识库

例如：
- 文档正文使用中文说明
- `iFlow`、`API Management`、`Event Mesh` 这类术语保留英文
- 代码块、配置项、对象名称不要翻译

## 6. 脑图查看方式

当前已安装两类 Markdown 相关插件：

- `Markdown Preview Enhanced`
  - 适合查看普通 Markdown 和 `mermaid` 图
- `Markmap`
  - 适合把 Markdown 标题和列表渲染成更整齐的脑图

推荐使用 `Markmap` 查看脑图类文档。

### 查看普通 Markdown

在 VS Code 中：
- 按 `Ctrl+Shift+V` 打开预览
- 或按 `Ctrl+K` 再按 `V` 打开侧边预览

### 查看 Markmap 脑图

在 VS Code 中：
- 打开对应 `.md` 文件
- 按 `Ctrl+Shift+P`
- 输入 `Markmap: Open as mindmap`

## 7. 当前已存在的示例文档

目前 `10_Documentation/Design` 中已包含：

- [SAP_Integration_Suite_Consultant_Growth_Path.md](C:\Users\Administrator\Desktop\changnan_codex\BTP_Integration\10_Documentation\Design\SAP_Integration_Suite_Consultant_Growth_Path.md)
  - SAP Integration Suite 顾问成长路径
- [Integration_Capability_Markmap.md](C:\Users\Administrator\Desktop\changnan_codex\BTP_Integration\10_Documentation\Design\Integration_Capability_Markmap.md)
  - 用于 `Markmap` 查看的能力脑图

## 8. 推荐维护原则

为了让这个目录后续能长期使用，建议遵循以下原则：

- 一份文档只表达一个主要主题
- 先分类再落文件，不要把所有内容都堆在根目录
- 脑图适合做概览，详细说明仍然放在正式文档里
- 优先沉淀可复用模板、规范和方法，而不仅是项目临时材料
- 如果内容会持续扩展，优先放到 `10_Documentation`

## 9. 后续可以继续补充的内容

建议后续逐步完善以下文档：

- `Capability Matrix`
- `Training Roadmap`
- `Integration Standards`
- `Naming Conventions`
- `API Inventory`
- `iFlow Inventory`
- `Troubleshooting Guide`
- `Project Template`

## 10. 一句话使用建议

把这个文件夹当成部门的 `SAP BTP Integration` 知识库来维护：脑图做导航，正式 Markdown 做沉淀，目录按主题分类，文件名保持统一。
