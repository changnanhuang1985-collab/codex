# 命名規約

## 1. 目的

本書は `SAP BTP Integration` プロジェクトにおけるオブジェクト命名の一貫性を確保するための規約を定義する。

## 2. 共通原則

- 名前で役割が推測できること
- 英語を基本とする
- 区切り文字は原則 `_` とする
- 略語は組織標準に従う
- 同一種別の命名構造は統一する

## 3. iFlow 命名

推奨形式：

```text
<Source>_to_<Target>_<BusinessObject>_<Action>
```

例：

```text
SuccessFactors_to_S4_Employee_Replicate
Ariba_to_S4_Supplier_Create
File_to_SAP_Product_Import
```

## 4. API 命名

推奨形式：

```text
<Domain>_<BusinessObject>_<Action>
```

## 5. Package 命名

推奨形式：

```text
<Domain>_Integration
```

## 6. Script 命名

推奨形式：

```text
<Purpose>_<Action>
```

## 7. 文書命名

- 文書名は内容を一意に表すこと
- `Final`、`Latest`、`New` 等の曖昧表現を避ける
- バージョン管理はファイル名ではなく版管理ルールで行う
