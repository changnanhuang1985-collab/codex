# 使用 SAP Integration Suite 实现集成现代化

来源：SAP Learning Journey  
主链接：https://learning.sap.com/learning-journeys/modernizing-integration-with-sap-integration-suite  
整理日期：2026-03-13

## 说明

本文是对 SAP Learning Journey `Modernizing Integration with SAP Integration Suite` 的中文展开整理版。

- 本文覆盖该 Learning Journey 的全部子页面主题。
- 其中每个 Lesson 的标题、页面目标和课程结构来自 SAP Learning 官方页面。
- `Introduction` 页可见信息相对完整，本文按可见内容做了较细整理。
- 其他 Lesson 页面在当前可访问内容中主要显示标题、课程目标与页面导航，因此本文中的“内容展开”和“学习重点”部分，属于基于 SAP 官方标题与目标进行的结构化整理，便于团队培训、提案和内部知识沉淀。

## 课程概览

本学习旅程聚焦如何使用 `SAP Integration Suite` 推动企业集成现代化，帮助企业在 SAP 与第三方系统并存的异构环境中，建立统一、可扩展、实时、可治理的集成能力。

- 课程类型：SAP Learning Journey
- Lessons 数量：13
- 总时长：约 1 小时 55 分钟
- 目标方向：
  - 集成战略
  - 云迁移与现代化
  - API 治理
  - B2B 集成
  - 事件驱动架构
  - 运维与质量保障

## 学习目标

完成本学习旅程后，学习者将能够：

- 理解课程结构与学习路径安排。
- 理解 `SAP Integration Suite` 的核心创新能力及其对现代企业集成的价值。
- 使用 `SAP Integration Solution Advisory Methodology (ISA-M)` 进行集成战略设计。
- 采用混合集成方式推动企业集成上云。
- 使用迁移工具从 `SAP Process Orchestration` 演进到 `SAP Integration Suite`。
- 掌握业务流程集成、API 管理、B2B 集成和事件驱动架构的关键能力。
- 了解如何验证、监控和优化运行中的集成流。

## Lesson 1. Introduction

官方页面：  
https://learning.sap.com/learning-journeys/modernizing-integration-with-sap-integration-suite/introduction_a57b5437-56ee-40ad-b89b-4e71302c476c

### 官方目标

- Understand the structure of this SAP Learning MOOC and get introduced to the experts.

### 中文整理

这一页主要是课程导入，目的是让学习者先建立全局视角，而不是直接进入某个具体功能点。它回答的是三个基础问题：

- 这门课讲什么
- 为什么现在要学 `SAP Integration Suite`
- 后面每个章节会如何展开

### 内容展开

从课程定位来看，这个 Learning Journey 并不是单纯教某一个工具按钮怎么点，而是围绕“企业集成现代化”来组织内容。SAP 把现代集成能力拆成几条主线：

- 用统一平台承接企业内部和企业间集成
- 用方法论支撑集成战略，而不是只做项目级开发
- 用云平台与混合集成能力替换传统集成孤岛
- 用 API、B2B、事件驱动等能力拓宽集成边界

### 对团队的意义

这部分很适合作为内部培训的第一讲开场页，也适合作为客户说明时的总览页。它帮助团队统一认识：`Integration` 不是只做 `CPI iFlow`，而是企业架构、业务流程、技术治理和运行保障的组合能力。

## Lesson 2. Modernizing the Business Landscape with an AI-Driven Integration Suite

官方页面：  
https://learning.sap.com/learning-journeys/modernizing-integration-with-sap-integration-suite/modernizing-the-business-landscape-with-an-ai-driven-integration-suite_b1dc9df5-c63d-4dbf-92e1-3c6881d13d5c

### 官方目标

- Understand the latest innovations in SAP Integration Suite and how they support scalable and real-time business processes across SAP and third-party systems.

### 中文整理

这一课聚焦 `SAP Integration Suite` 的整体价值主张，即它如何在 SAP 与非 SAP 并存的现实环境中，作为企业的集成中台，支撑端到端流程、实时响应以及未来扩展。

### 内容展开

从课程标题和目标可以看出，这一课想传达的重点不是“某个功能是否存在”，而是“为什么企业应该用现代集成平台替代碎片化集成方式”。

可以把这一课理解为以下几个层次：

- 第一层：企业系统环境已经高度异构化  
  典型环境包括 `S/4HANA`、`SuccessFactors`、`Ariba`、第三方 SaaS、本地系统、文件传输场景和外部伙伴系统。

- 第二层：传统集成方式难以支撑实时性与扩展性  
  比如点对点接口过多、数据流向不透明、变更影响面大、监控薄弱、交付周期长。

- 第三层：`SAP Integration Suite` 提供现代化能力组合  
  包括云集成、API 管理、B2B 集成、事件驱动机制以及统一治理能力。

- 第四层：AI 驱动意味着平台会越来越强调效率增强  
  包括设计辅助、运维分析、资产复用、规则建议等方向。

### 学习重点

- 理解 `SAP Integration Suite` 为什么不是单点工具，而是能力集合。
- 理解“实时业务流程”在现代企业中的价值。
- 理解 SAP 与第三方系统协同已是默认场景，而不是例外。

## Lesson 3. Strategizing Integrations with SAP Integration Solution Advisory Methodology

官方页面：  
https://learning.sap.com/learning-journeys/modernizing-integration-with-sap-integration-suite/strategizing-integrations-with-sap-integration-solution-advisory-methodology_d13e5438-27a7-4be1-bda1-f12f57cf9bc7

### 官方目标

- Use the SAP Integration Solution Advisory Methodology to strategize integrations aligned with enterprise architecture and business goals.

### 中文整理

这一课的核心是：集成不能只在项目实施阶段被动处理，而应该在企业层面建立统一的规划方法。`ISA-M` 就是 SAP 提供的集成战略方法论。

### 内容展开

`ISA-M` 的价值在于把“接口开发”提升为“企业集成规划”。从团队实践角度，它通常解决以下问题：

- 哪些场景应该用 API
- 哪些场景适合事件驱动
- 哪些场景适合流程集成
- 企业当前集成 landscape 存在哪些重复建设和风险
- 如何让集成设计与企业架构原则一致

如果一个团队没有方法论，常见结果是：

- 接口风格不统一
- 命名和规范各自为政
- 场景分类混乱
- 后续运维和扩展成本越来越高

### 学习重点

- 认识 `ISA-M` 的角色：它首先是战略与治理工具，其次才是项目落地辅助工具。
- 学会把业务目标、架构原则和技术落地连接起来。
- 用统一的场景分类方式支撑后续项目交付。

## Lesson 4. How to Strategize with ISA-M

官方页面：  
https://learning.sap.com/learning-journeys/modernizing-integration-with-sap-integration-suite/how-to-strategize-with-isa-m_795f2cd1-c533-4449-82b4-e9d77adf297c

### 官方目标

- Use the SAP Integration Solution Advisory Methodology to strategize integrations aligned with enterprise architecture and business goals.

### 中文整理

如果说上一课在讲“为什么要用 `ISA-M`”，这一课更像是在讲“怎么把 `ISA-M` 真正用起来”。

### 内容展开

在实践中，`ISA-M` 往往不是一份单独的理论文档，而是需要和以下内容结合使用：

- 企业集成场景盘点
- 场景分类标准
- 集成原则和架构原则
- 平台能力映射
- 目标架构蓝图

团队可以把这一课理解为“战略落地操作指南”的入口。常见的落地动作包括：

- 梳理企业现有系统和集成关系
- 定义标准场景模型
- 建立场景到技术方案的映射
- 形成路线图和演进顺序

### 学习重点

- 不要把 `ISA-M` 只当成售前材料。
- 让方法论产出真正进入设计标准、命名规范、项目模板和评审流程。
- 建立“战略到项目”的传导链路。

## Lesson 5. Consolidating and Transforming Business Processes Across Heterogeneous Landscapes

官方页面：  
https://learning.sap.com/learning-journeys/modernizing-integration-with-sap-integration-suite/consolidating-and-transforming-business-processes-across-heterogeneous-landscapes_2dfdc314-815d-4f7f-a159-93595e509d1b

### 官方目标

- Adopt hybrid integration to move integrations to the cloud.

### 中文整理

这部分强调的是：企业不会一夜之间把所有系统都搬到云上，因此集成现代化必须支持混合环境。

### 内容展开

所谓混合集成，通常意味着以下情况并存：

- 云上 SAP 系统与本地 SAP 系统共存
- SAP 系统与第三方 SaaS 共存
- 实时 API 与批处理文件接口共存
- 旧系统改造与新系统建设同时发生

这一课关注的是如何在这样的现实条件下整合和改造业务流程，而不是假设企业已经拥有理想化的目标架构。

### 学习重点

- 理解“异构 landscape”是企业常态。
- 理解现代化不是推倒重来，而是逐步整合、迁移和优化。
- 集成平台需要兼顾连接能力、变换能力和流程协同能力。

## Lesson 6. How to Assess, Migrate, and Elevate Your Integrations

官方页面：  
https://learning.sap.com/learning-journeys/modernizing-integration-with-sap-integration-suite/how-to-assess-migrate-and-elevate-your-integrations_d3146c01-a22d-4ed2-9ea6-37f687579c60

### 官方目标

- Use Migration Assessment, Migration Accelerator, and Edge Integration Cell to migrate from SAP Process Orchestration to SAP Integration Suite.

### 中文整理

这一课围绕迁移路径展开，特别是从 `SAP Process Orchestration` 向 `SAP Integration Suite` 演进。

### 内容展开

从目标可以看出，这一课会重点覆盖三个迁移相关能力：

- `Migration Assessment`  
  用于盘点现状、评估哪些集成资产可迁、难度如何、优先级如何。

- `Migration Accelerator`  
  用于提升迁移效率，减少重复工作。

- `Edge Integration Cell`  
  用于在某些有特殊边界要求的场景中，平衡云平台能力与本地部署诉求。

这类内容对存量 SAP 客户特别重要，因为他们通常已经拥有大量历史集成资产，不可能从零重建。

### 学习重点

- 迁移不是“导过去”这么简单，而是评估、分层、重构和运营模式切换的组合。
- 迁移过程要兼顾技术可行性和业务连续性。
- 对客户沟通时，可以把迁移说成“现代化演进”，而不是“系统替换”。

## Lesson 7. Simplifying and Accelerating Business Process Integrations

官方页面：  
https://learning.sap.com/learning-journeys/modernizing-integration-with-sap-integration-suite/simplifying-and-accelerating-business-process-integrations_9d565017-bc37-478c-8bf8-1f48ec6a4855

### 官方目标

- Identify the latest innovations in end-to-end business process integration.

### 中文整理

这一课关注的是端到端业务流程集成，不只是单个接口是否打通，而是完整业务链路是否高效、稳定、可持续演进。

### 内容展开

在企业中，业务流程往往会横跨多个系统。例如：

- 从采购申请到采购订单
- 从招聘到入职
- 从销售到开票
- 从主数据变更到多系统同步

端到端流程集成的难点不只是系统连接，还包括：

- 流程时序
- 数据一致性
- 异常处理
- 可追踪性
- 多团队协同

这一课强调“最新创新”，意味着 SAP 在不断把流程编排、标准连接、预构建资产和治理能力组合起来，让业务流程集成更快落地。

### 学习重点

- 把“接口交付”提升为“业务流程交付”。
- 关注端到端链路，而不是局部最优。
- 重视可视化、可追踪和标准化资产复用。

## Lesson 8. How to Validate Integration Flows Using Design Guidelines

官方页面：  
https://learning.sap.com/learning-journeys/modernizing-integration-with-sap-integration-suite/how-to-validate-integration-flows-using-design-guidelines_e0a6d493-7084-45fa-bcb9-6d6506d1eb6e

### 官方目标

- Validate integration flows using design guidelines.

### 中文整理

这一课强调用设计规范来验证 `Integration Flow`，核心是让 iFlow 设计更规范、更可维护、更可交接。

### 内容展开

一个能跑的 iFlow，不一定是一个好的 iFlow。团队在实践中常见的问题包括：

- 命名不清晰
- 流程拆分不合理
- 错误处理缺失
- 映射逻辑难以理解
- 配置与脚本混杂

设计规范的价值在于建立统一标准，让不同顾问和开发者输出的结果具备一致性。

### 学习重点

- 用设计规范提升质量，而不是靠个人经验兜底。
- 让 iFlow 更易维护、更易评审、更易培训新人。
- 后续可以把这一课的方法转化为团队内部的 `CPI Quality Checklist`。

## Lesson 9. How to Inspect Resource Usage in Active Integration Flows

官方页面：  
https://learning.sap.com/learning-journeys/modernizing-integration-with-sap-integration-suite/how-to-inspect-resource-usage-in-active-integration-flows_98086f8a-b438-4ca6-af62-67d92d06cb03

### 官方目标

- Inspect resource usage in active integration flows.

### 中文整理

这一课的焦点已经从设计阶段进入运行阶段，关注的是活跃 iFlow 在资源消耗层面的可观察性。

### 内容展开

在真实项目中，很多问题并不是“接口不通”，而是：

- 性能不稳定
- 吞吐不足
- 某些流程占用资源过高
- 异常高峰时系统响应变慢

因此，资源使用检查是运维治理的一部分。它能帮助团队回答：

- 哪些 iFlow 是热点流程
- 哪些设计可能存在资源浪费
- 哪些流程需要优化拆分或缓存策略

### 学习重点

- 监控不仅是看报错，还要看资源使用和运行特征。
- 资源检查应服务于持续优化，而不是事后排查。
- 运维能力是现代集成交付的重要组成部分。

## Lesson 10. Governing and Securing Your APIs with API Management

官方页面：  
https://learning.sap.com/learning-journeys/modernizing-integration-with-sap-integration-suite/governing-and-securing-your-apis-with-api-management_e73f87ad-b700-4687-ac36-b6dca7f11f42

### 官方目标

- Use API Management and Graph to define, extend, govern, access, publish, and track APIs.

### 中文整理

这一课从“接口实现”提升到“API 产品化和治理”。重点不再只是把服务暴露出来，而是让 API 具备生命周期管理、访问控制和可追踪能力。

### 内容展开

企业在 API 管理上通常有几类诉求：

- 统一暴露服务入口
- 控制访问权限和安全策略
- 管理版本
- 提供开发者消费入口
- 跟踪 API 使用情况
- 支持 API 组合与扩展

课程中同时提到 `Graph`，说明 SAP 也在强调统一访问模型与跨系统数据访问体验。

### 学习重点

- API 不是“开发完成后顺便开放”的附属品，而是正式的治理对象。
- `API Management` 要和安全、门户、生命周期、监控一起看。
- 这部分内容对售前方案和架构说明都很重要。

## Lesson 11. Connecting Seamlessly with Your Business Partners

官方页面：  
https://learning.sap.com/learning-journeys/modernizing-integration-with-sap-integration-suite/connecting-seamlessly-with-your-business-partners_2f3f7b4f-b9d2-4c6d-ae35-c5e11f4ad43d

### 官方目标

- Understand how SAP Integration Suite simplifies B2B integration scenarios.

### 中文整理

这一课聚焦企业与外部合作伙伴的连接，也就是典型的 B2B 集成能力。

### 内容展开

B2B 集成与企业内部系统集成相比，难点通常更高，因为它涉及：

- 外部伙伴接入标准不一
- 报文格式多样
- 网络与安全边界更复杂
- 错误处理和对账要求更高
- 多方协同周期更长

因此，B2B 集成不是简单把一个接口开放给外部，而是要考虑连接方式、协议、可审计性和稳定运营。

### 学习重点

- 理解 B2B 是 `Integration` 能力外延的重要部分。
- 团队如果只会企业内部接口，能力边界会偏窄。
- 对外表达时，B2B 能显著提升团队的综合能力形象。

## Lesson 12. Leveraging Real-Time Insights with Event-Driven Architectures

官方页面：  
https://learning.sap.com/learning-journeys/modernizing-integration-with-sap-integration-suite/leveraging-real-time-insights-with-event-driven-architectures_83c5b98e-cfa8-4c18-9c1b-d88e274235a1

### 官方目标

- Use event-driven architectures to enhance operational efficiency and respond in real-time to critical business events.

### 中文整理

这一课讲的是事件驱动架构，也就是从“同步调用驱动的集成”进一步扩展到“事件触发驱动的业务协同”。

### 内容展开

事件驱动架构适合以下场景：

- 业务事件需要被多个系统实时感知
- 不希望系统间形成强耦合
- 需要更灵活地扩展下游处理方
- 需要把业务状态变化快速传递给相关系统

相比传统点对点调用，事件驱动更强调：

- 解耦
- 实时性
- 可扩展订阅
- 更适合多消费者模式

### 学习重点

- 事件驱动不是 API 的替代，而是补充。
- 它适合高实时、高扩展、低耦合的业务协同场景。
- 对团队能力布局而言，这部分能显著提升“现代集成”形象。

## Lesson 13. Downloads

官方页面：  
https://learning.sap.com/learning-journeys/modernizing-integration-with-sap-integration-suite/downloads_4f0d78be-f800-4280-a0f9-5ad11aa1d610

### 官方说明

该页面提供课程相关下载材料。页面中可见资源包括：

- `All Lessons` 课件文件
- 英文 Transcript
- 机器翻译 Transcript

### 中文整理

这一页虽然不是知识点章节，但对做培训沉淀非常有用，因为它意味着：

- 可以下载完整课件用于内部学习
- 可以基于讲稿做二次整理
- 可以把课程内容沉淀为内部知识库

### 学习重点

- 团队做知识沉淀时，优先利用官方课件和讲稿。
- 可以把课件内容继续转化为内部版培训文档、讲师手册和客户版摘要。

## Quiz

官方页面：主 Learning Journey 中附带测验入口。

### 中文整理

课程最后通过测验验证学习成果。对于团队内部使用来说，也可以把这种结构借鉴过来：

- 学完一章有一个简短回顾
- 学完整门课有一次综合检查
- 用统一题库确保团队对关键概念理解一致

## 建议的团队用法

如果把这门课引入 `BTP_Integration` 团队，建议按下面方式使用：

### 1. 用作团队培训主线

可按以下顺序组织：

- 第 1 讲：为什么做 Integration Modernization
- 第 2 讲：`ISA-M` 与集成战略
- 第 3 讲：云迁移与混合集成
- 第 4 讲：iFlow 设计规范与质量控制
- 第 5 讲：监控与资源优化
- 第 6 讲：API Management
- 第 7 讲：B2B 集成
- 第 8 讲：事件驱动架构

### 2. 用作售前与方案材料

可把课程主线提炼成客户沟通语言：

- 我们不仅做 `CPI` 开发，也能做集成战略规划
- 我们不仅做接口打通，也能做 API 治理和 B2B 集成
- 我们不仅做上线，也关注监控、运行优化和演进路径

### 3. 用作内部能力地图

可把本课程结构映射为团队能力域：

- Strategy
- Cloud Integration
- Migration
- API Governance
- B2B
- Event-Driven
- Operations

## 一句话总结

这门 Learning Journey 讲的不是“如何使用一个集成工具”，而是“如何以 `SAP Integration Suite` 为核心，系统化推进企业集成现代化”，覆盖战略、迁移、流程集成、API 治理、B2B、事件驱动和运维优化。

## 参考链接

- 主页面：https://learning.sap.com/learning-journeys/modernizing-integration-with-sap-integration-suite
- Introduction：https://learning.sap.com/learning-journeys/modernizing-integration-with-sap-integration-suite/introduction_a57b5437-56ee-40ad-b89b-4e71302c476c
- Modernizing the Business Landscape with an AI-Driven Integration Suite：https://learning.sap.com/learning-journeys/modernizing-integration-with-sap-integration-suite/modernizing-the-business-landscape-with-an-ai-driven-integration-suite_b1dc9df5-c63d-4dbf-92e1-3c6881d13d5c
- Strategizing Integrations with SAP Integration Solution Advisory Methodology：https://learning.sap.com/learning-journeys/modernizing-integration-with-sap-integration-suite/strategizing-integrations-with-sap-integration-solution-advisory-methodology_d13e5438-27a7-4be1-bda1-f12f57cf9bc7
- How to Strategize with ISA-M：https://learning.sap.com/learning-journeys/modernizing-integration-with-sap-integration-suite/how-to-strategize-with-isa-m_795f2cd1-c533-4449-82b4-e9d77adf297c
- Consolidating and Transforming Business Processes Across Heterogeneous Landscapes：https://learning.sap.com/learning-journeys/modernizing-integration-with-sap-integration-suite/consolidating-and-transforming-business-processes-across-heterogeneous-landscapes_2dfdc314-815d-4f7f-a159-93595e509d1b
- How to Assess, Migrate, and Elevate Your Integrations：https://learning.sap.com/learning-journeys/modernizing-integration-with-sap-integration-suite/how-to-assess-migrate-and-elevate-your-integrations_d3146c01-a22d-4ed2-9ea6-37f687579c60
- Simplifying and Accelerating Business Process Integrations：https://learning.sap.com/learning-journeys/modernizing-integration-with-sap-integration-suite/simplifying-and-accelerating-business-process-integrations_9d565017-bc37-478c-8bf8-1f48ec6a4855
- How to Validate Integration Flows Using Design Guidelines：https://learning.sap.com/learning-journeys/modernizing-integration-with-sap-integration-suite/how-to-validate-integration-flows-using-design-guidelines_e0a6d493-7084-45fa-bcb9-6d6506d1eb6e
- How to Inspect Resource Usage in Active Integration Flows：https://learning.sap.com/learning-journeys/modernizing-integration-with-sap-integration-suite/how-to-inspect-resource-usage-in-active-integration-flows_98086f8a-b438-4ca6-af62-67d92d06cb03
- Governing and Securing Your APIs with API Management：https://learning.sap.com/learning-journeys/modernizing-integration-with-sap-integration-suite/governing-and-securing-your-apis-with-api-management_e73f87ad-b700-4687-ac36-b6dca7f11f42
- Connecting Seamlessly with Your Business Partners：https://learning.sap.com/learning-journeys/modernizing-integration-with-sap-integration-suite/connecting-seamlessly-with-your-business-partners_2f3f7b4f-b9d2-4c6d-ae35-c5e11f4ad43d
- Leveraging Real-Time Insights with Event-Driven Architectures：https://learning.sap.com/learning-journeys/modernizing-integration-with-sap-integration-suite/leveraging-real-time-insights-with-event-driven-architectures_83c5b98e-cfa8-4c18-9c1b-d88e274235a1
- Downloads：https://learning.sap.com/learning-journeys/modernizing-integration-with-sap-integration-suite/downloads_4f0d78be-f800-4280-a0f9-5ad11aa1d610
