# Supplier Master iFlow 開発メモ

## iFlow 名

`IF_AR_S4_001_Supplier_Master_Sync`

## 目的

Ariba から S/4HANA へサプライヤマスタを同期するための iFlow 実装方針を定義する。

## 主な構成要素

- HTTPS Sender
- Content Modifier
- Groovy Validation Script
- Message Mapping
- Request-Reply to S/4HANA
- Router
- Exception Subprocess

## 実装ルール

- Endpoint URL を iFlow 内へ直接埋め込まない
- Property 名は設計書記載ルールに合わせる
- ステップ名は調査しやすい名称とする
- Backend 呼出前に業務キーをログへ残す

## レビューポイント

- バリデーションの網羅性
- マッピング整合性
- 例外分岐の実装有無
- ログ検索性
