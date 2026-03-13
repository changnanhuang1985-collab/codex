# iFlow 詳細設計書

## 目的

対象 iFlow ごとの詳細処理手順を定義する。

## iFlow 1: Supplier Master Integration

### 処理手順

1. HTTPS Sender で Ariba からサプライヤ payload を受信
2. Content Modifier で IF 定数および correlation 情報を設定
3. Groovy Script で必須ヘッダおよび payload ノードを検証
4. Message Mapping で S/4 向け構造へ変換
5. Request-Reply で S/4 サプライヤ API を呼出
6. Router で正常 / 異常を判定
7. 正常系は完了ログを出力
8. 異常系は Exception Subprocess へ遷移

### 主な Header / Property

- `InterfaceId = IF-AR-S4-001`
- `BusinessKey = SupplierID`
- `SourceSystem = Ariba`
- `TargetSystem = S4`

## iFlow 2: Purchase Transaction Integration

### 処理手順

1. HTTPS Sender で購買トランザクションを受信
2. Content Modifier でシナリオ情報を設定
3. Groovy Script で前提チェックを実施
4. 必要に応じて Splitter で明細単位処理
5. Message Mapping で S/4 購買構造へ変換
6. Request-Reply で S/4 API を呼出
7. Split を使用した場合は Aggregator で応答集約
8. MPL に最終ステータスを記録

### 設計上の考慮点

- 部分処理があり得る場合は明細単位の追跡性を確保する
- 生の backend エラーをそのまま返さず、調査可能な形に正規化する

## iFlow 3: Error Handling / Notification

### 処理手順

1. Exception Subprocess でエラーコンテキストを取得
2. Content Modifier で通知本文を作成
3. Router で環境 / 重大度に応じて分岐
4. Mail adapter または alert endpoint を呼出
5. MPL 補足情報を更新

## 共通設計ルール

- Endpoint や credential 依存値は外部化する
- Script は入力検証または軽微な補助処理に限定する
- 業務統制に関わるロジックを Script に埋め込まない
