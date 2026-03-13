# iFlow Inventory

## 目的

本文档用于统一管理当前部门或项目中的 `iFlow` 清单。

## iFlow 清单

| iFlow 名称 | Source System | Target System | 集成模式 | Trigger | Owner | Package | 状态 | 备注 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `SuccessFactors_to_S4_Employee_Replicate` | SuccessFactors | S/4 | Process / Data | Scheduled | 待补充 | HR_Integration | Draft | |
| `Ariba_to_S4_Supplier_Create` | Ariba | S/4 | Process | Event / API | 待补充 | Procurement_Integration | Draft | |
| `File_to_SAP_Product_Import` | File | SAP | Data | SFTP Polling | 待补充 | MasterData_Integration | Draft | |

## 建议字段说明

- `iFlow 名称`：统一命名后的接口名称
- `Source System`：源系统
- `Target System`：目标系统
- `集成模式`：例如 `Process`、`Data`、`API-based`、`Event-driven`
- `Trigger`：触发方式，例如 `Scheduled`、`API`、`Event`
- `Owner`：责任人
- `Package`：所属包
- `状态`：`Draft / Active / Deprecated`

## 使用建议

- 每次新建 `iFlow` 时同步登记
- 上线后更新状态和包信息
- 与运行环境定期对账，避免文档与系统不一致
