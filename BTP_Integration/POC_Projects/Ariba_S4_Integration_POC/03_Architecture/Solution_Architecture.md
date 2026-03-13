# ソリューションアーキテクチャ

## アーキテクチャ目的

SAP Ariba と SAP S/4HANA の間において、`SAP Integration Suite` を中核とした、モジュール性・レビュー性・再利用性・調査容易性を備えた連携構成を定義する。

## 基本方針

- 接続制御と連携処理の責務を分離する
- iFlow はシナリオ単位で責務を明確化する
- マッピングおよびバリデーションは明示的に設計する
- ログ、監視、再処理方針を設計段階から組み込む

## 目標構成

```text
SAP Ariba
   |
API / OData Connectivity
   |
SAP Integration Suite
   |- iFlow 1: Supplier Master Integration
   |- iFlow 2: Purchase Transaction Integration
   |- iFlow 3: Error Handling / Notification
   |
SAP S/4HANA
```

## アーキテクチャ上の判断

- 連携中核は CPI とする
- シナリオごとに iFlow を分離し、責務を明確にする
- 業務キーおよびメッセージ ID による追跡性を確保する
- 再処理を考慮した例外設計とする

## SAP 標準整合観点

- アプリケーション本体に過剰なロジックを持たせず、連携責務は Integration Suite 側で制御する
- Point-to-Point を避け、再利用しやすい連携構造を優先する
- 将来の API Management や監視標準拡張にも接続しやすい構成とする
