# API Inventory

## 目的

本文档用于统一管理当前部门或项目中的 `API` 清单。

## API 清单

| API 名称 | 业务域 | 类型 | Source / Consumer | Backend System | 安全方式 | Owner | 状态 | 备注 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `HR_Employee_Query` | HR | Query | Portal | S/4 / SF | OAuth | 待补充 | Draft | |
| `Procurement_Supplier_Create` | Procurement | Command | Ariba | S/4 | OAuth | 待补充 | Draft | |
| `Sales_SalesOrder_Get` | Sales | Query | App / Portal | S/4 | OAuth | 待补充 | Draft | |

## 建议字段说明

- `API 名称`：统一命名后的接口名称
- `业务域`：例如 `HR`、`Sales`、`Procurement`
- `类型`：例如 `Query`、`Command`
- `Source / Consumer`：调用方
- `Backend System`：后端系统
- `安全方式`：例如 `OAuth`、`Basic`、`mTLS`
- `Owner`：责任人
- `状态`：`Draft / Active / Deprecated`

## 使用建议

- 新增 `API` 时同步维护
- 下线 `API` 时更新状态
- 定期与实际平台资产对账
