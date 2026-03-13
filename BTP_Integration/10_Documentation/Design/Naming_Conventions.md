# Naming Conventions

## 目的

本文档用于统一 `SAP BTP Integration` 相关对象命名，提升可读性与可维护性。

## 1. 通用原则

- 名称应表达业务含义
- 命名尽量使用英文
- 使用统一分隔符，推荐下划线 `_`
- 避免使用 `final`、`new`、`test2` 这类无语义名称
- 同类对象保持相同结构

## 2. iFlow 命名建议

推荐格式：

```text
<Source>_to_<Target>_<BusinessObject>_<Action>
```

示例：

```text
SuccessFactors_to_S4_Employee_Replicate
Ariba_to_S4_Supplier_Create
File_to_SAP_Product_Import
```

## 3. API 命名建议

推荐格式：

```text
<Domain>_<BusinessObject>_<Action>
```

示例：

```text
HR_Employee_Query
Procurement_Supplier_Create
Sales_SalesOrder_Get
```

## 4. Package 命名建议

推荐格式：

```text
<Domain>_<IntegrationArea>
```

示例：

```text
HR_Integration
Procurement_Integration
Finance_Integration
```

## 5. Script 命名建议

推荐格式：

```text
<Purpose>_<Action>
```

示例：

```text
Payload_Normalize
Date_Format
Error_Handle
```

## 6. Mapping 命名建议

推荐格式：

```text
<SourceFormat>_to_<TargetFormat>_<BusinessObject>
```

示例：

```text
SF_to_S4_Employee
Ariba_to_S4_Supplier
CSV_to_SAP_Product
```

## 7. 文档命名建议

推荐格式：

```text
<Topic>_<DocumentType>.md
```

示例：

```text
API_Inventory.md
iFlow_Inventory.md
Integration_Standards.md
```
