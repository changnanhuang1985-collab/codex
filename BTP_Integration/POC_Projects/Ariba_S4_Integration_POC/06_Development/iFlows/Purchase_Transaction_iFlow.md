# Purchase Transaction iFlow 開発メモ

## iFlow 名

`IF_AR_S4_002_Purchase_Transaction_Sync`

## 目的

Ariba の購買関連トランザクションを、制御性および追跡性を担保しながら S/4HANA へ連携する。

## 主な構成要素

- HTTPS Sender
- Content Modifier
- Groovy Pre-check Script
- Splitter / Aggregator
- Message Mapping
- Request-Reply to S/4HANA API
- MPL 補足ログ
- Exception Subprocess

## 実装ルール

- Splitter は明細粒度の追跡が必要な場合に限定して利用する
- 元の Order ID を全工程で保持する
- Backend 応答は呼出元が理解しやすい形へ正規化する
- 業務ルールを Script に隠蔽しない

## レビューポイント

- 部分処理設計の妥当性
- 応答正規化の品質
- 冪等性考慮
- 明細単位追跡性
