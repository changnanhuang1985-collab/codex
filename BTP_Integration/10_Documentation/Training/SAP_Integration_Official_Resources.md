# SAP Integration 官方资源清单

## 1. 使用原则

本清单优先收录：
- SAP 官方学习平台
- SAP 官方教程
- SAP Help Portal
- SAP Community 官方入口

备注：
- 以下链接检查时间为 `2026-03-12`
- 部分资源免费，部分功能需要企业账号或额外许可
- `Trial` 环境适合个人学习，不适合团队正式开发

## 2. 学习主线资源

### 2.1 SAP Learning Journey

#### Developing with SAP Integration Suite

适合对象：
- 入门开发者
- 想系统建立全景认知的新人

覆盖内容：
- Integration Strategy
- API Management
- Cloud Integration
- Event Mesh

链接：
- https://learning.sap.com/learning-journeys/developing-with-sap-integration-suite

说明：
- SAP Learning 页面显示该学习路径包含 `API Management`、`Cloud Integration`、`Event Mesh` 等单元，也提供 `SAP Learning Group` 入口与认证信息。

#### Administering SAP Integration Suite

适合对象：
- 需要理解租户、角色、连接与监控的同事

链接：
- https://learning.sap.com/learning-journeys/administering-sap-integration-suite

说明：
- 适合和开发学习并行使用，补足管理、连接与监控视角。

#### Modernizing Integration with SAP Integration Suite

适合对象：
- 希望更早建立架构与方法论认知的人

链接：
- https://learning.sap.com/learning-journeys/modernizing-integration-with-sap-integration-suite

说明：
- 页面内容涵盖 `ISA-M`、迁移、API、B2B、事件驱动等主题，更适合 `Level 2+` 学习者。

## 3. 练习环境与入门任务

### 3.1 SAP BTP Trial

用途：
- 个人练习入口
- 后续启用 `Integration Suite Trial` 的基础

相关教程：
- https://developers.sap.com/tutorials/cp-trial-entitlements.html
- https://developers.sap.com/tutorials/btp-cockpit-entitlements.html

说明：
- SAP 官方教程说明可在 Trial 中配置 entitlements 和 quota。

### 3.2 Integration Suite Trial

最关键的入门练习环境。

链接：
- https://developers.sap.com/tutorials/cp-starter-isuite-onboard-subscribe.html

说明：
- SAP 官方教程说明可在 `SAP BTP Trial` 上订阅 `Integration Suite Trial`、分配角色并激活能力。
- 该教程也明确说明：`Trial` 不适用于生产用途或团队正式开发。

### 3.3 官方入门 Mission

建议作为新人第一条实战主线。

链接：
- https://developers.sap.com/mission.cp-starter-integration-cpi.html

说明：
- 这是 SAP 官方的初学者 Mission，包含：
  - `Set Up Integration Suite Trial`
  - `Design and Deploy Your First Integration Flow`
  - `Expose Integration Flow Endpoint as API and Test the Flow`

## 4. 分阶段推荐教程

### 4.1 第一个 iFlow

链接：
- https://developers.sap.com/tutorials/cp-starter-integration-cpi-design-iflow.html

说明：
- 官方教程，适合 `Level 2`
- 重点是第一次设计和部署 `iFlow`

### 4.2 把 iFlow 暴露成 API

链接：
- https://developers.sap.com/tutorials/api-mgmt-isuite-initial-setup.html

说明：
- 官方教程，适合 `Level 3`
- 学习如何启用与进入 `API Management`

### 4.3 调用鉴权练习

链接：
- https://developers.sap.com/tutorials/btp-integration-suite-oauth-integration-flow.html

说明：
- 官方教程通过 `OAuth client credentials` 演示如何调用 `integration flow`
- 适合作为“不是只会拖图形”的进阶练习

### 4.4 设计规范与最佳实践入门

链接：
- https://developers.sap.com/tutorials/btp-integration-suite-design-guidelines.html

说明：
- 官方教程介绍 `integration flow design guidelines`
- 很适合拿来做“简单易上手，但高分不容易”的训练关卡

## 5. Help Portal 重点入口

### 5.1 Integration Suite 总览

链接：
- https://help.sap.com/docs/integration-suite/sap-integration-suite

说明：
- Help Portal 的总入口，可作为总导航页使用。

### 5.2 Cloud Integration 监控与运行

链接：
- https://help.sap.com/docs/cloud-integration/sap-cloud-integration/operating-and-monitoring-cloud-integration

说明：
- 官方文档说明 `Cloud Integration` 的运行和监控任务，适合 `Level 4` 排错训练。

### 5.3 API Management 文档入口示例

链接：
- https://help.sap.com/docs/sap-api-management/sap-api-management/consume-apis
- https://help.sap.com/docs/sap-api-management/sap-api-management/creating-versioned-api

说明：
- 适合让学员感受到 `API productization`、`Developer Hub`、版本治理等概念。

### 5.4 Event Mesh 文档入口

链接：
- https://help.sap.com/docs/SAP_EM/event-mesh/what-is-sap-event-mesh
- https://help.sap.com/docs/event-mesh/event-mesh/manage-queues-97a0b3c0067044fcba0df174b9c38f5b

说明：
- `What is SAP Event Mesh?` 页面强调异步事件通信场景。
- `Manage Queues` 适合配合架构与运维视角理解。

### 5.5 Advanced Event Mesh

链接：
- https://help.sap.com/docs/sap-integration-suite/advanced-event-mesh/setting-up-sap-integration-suite-advanced-event-mesh
- https://help.sap.com/docs/integration-suite/sap-integration-suite/configure-advanced-event-mesh-sender-adapter

说明：
- 更偏进阶和企业账号场景。
- 官方文档明确写到 `advanced event mesh` 需要企业账户与相应 entitlement。

## 6. 社区与讨论入口

### 6.1 SAP Community - Integration Suite 主题页

链接：
- https://pages.community.sap.com/topics/integration-suite

说明：
- 适合做“总入口”，能看到专家内容、资源、Q&A 和示例。

### 6.2 SAP Community - Integration Group

链接：
- https://community.sap.com/t5/integration/gh-p/integration

说明：
- SAP Community 的 Integration 组，适合关注最新讨论、实践经验和产品更新。

### 6.3 Welcome to the Integration Group

链接：
- https://community.sap.com/t5/integration-blog-posts/welcome-to-the-integration-group-in-sap-community/ba-p/13995940

说明：
- 这篇官方社区文章说明了该小组适合讨论 `SAP Integration Suite`、`Cloud Integration`、`API lifecycle management`、事件流等主题。

### 6.4 Integration Suite 标签页

链接：
- https://community.sap.com/t5/tag/integration%20suite/tg-p/tag-id/5965

说明：
- 适合按问题检索。
- 可以让学员看到别人真实会遇到哪些错误与讨论。

## 7. 视频与课程型资源

### 7.1 SAP Learning 自带视频化课程

推荐入口：
- https://learning.sap.com/learning-journeys/developing-with-sap-integration-suite
- https://learning.sap.com/learning-journeys/administering-sap-integration-suite
- https://learning.sap.com/learning-journeys/modernizing-integration-with-sap-integration-suite

说明：
- 上述官方学习路径中本身包含课程化内容、单元、测验与部分视频化教学，优先级高于零散外部视频。

### 7.2 SAP Learning Group

入口：
- 可从 `Developing with SAP Integration Suite` 页面进入 `SAP Learning Group`

说明：
- 适合学员在完成每一单元后继续提问和参与讨论。

## 8. 对新人最实用的资源组合

如果只选一条最稳的新人路径，建议按这个顺序：

1. `SAP BTP Trial`
   - https://developers.sap.com/tutorials/cp-trial-entitlements.html
2. `Set Up Integration Suite Trial`
   - https://developers.sap.com/tutorials/cp-starter-isuite-onboard-subscribe.html
3. `Developing with SAP Integration Suite`
   - https://learning.sap.com/learning-journeys/developing-with-sap-integration-suite
4. `Request Product Details with an Integration Scenario`
   - https://developers.sap.com/mission.cp-starter-integration-cpi.html
5. `Operating and Monitoring Cloud Integration`
   - https://help.sap.com/docs/cloud-integration/sap-cloud-integration/operating-and-monitoring-cloud-integration
6. `SAP Community Integration Group`
   - https://community.sap.com/t5/integration/gh-p/integration

## 9. 培训组织建议

### PMO 建议

- 把所有人统一拉到同一条官方 Mission 上
- 每周检查：
  - 是否完成教程
  - 是否提交截图
  - 是否写出 3 条学习笔记

### Senior Consultant 建议

- 要求每位学员在做每个教程时回答：
  - 这个能力解决什么业务问题
  - 它适合什么场景
  - 它和其他能力的边界是什么

### Architect 建议

- 从第 2 周开始，不只问“会不会配”
- 要开始问：
  - 为什么用这个能力
  - 放在哪一层
  - 它和 `API Layer` / `Integration Layer` / `Event Layer` 的关系是什么

## 10. 许可与环境提醒

- `Trial` 适合个人练习，不适合正式项目交付
- `Advanced Event Mesh` 的官方文档明确要求企业账户与相应 entitlement
- 某些教程页面会直接写明 `Requires Customer/Partner License`
- 培训过程中要明确区分：
  - 免费试用可做什么
  - 企业账号可做什么

## 11. 结论

如果目标是构建一套新人“容易进入，但不容易混过去”的培训体系，最稳的做法不是自己从零发明所有内容，而是：

- 用 SAP 官方学习路径做主线
- 用 Trial 和官方 Mission 做练习环境
- 用 Help Portal 做排错与查阅底座
- 用 Community 做真实问题补充
- 再由团队内部用游戏化关卡把这些资源重新编排
