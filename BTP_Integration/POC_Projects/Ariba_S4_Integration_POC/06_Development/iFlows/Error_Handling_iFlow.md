# Error Handling iFlow 開発メモ

## iFlow 名

`IF_AR_S4_003_Error_Notification`

## 目的

例外通知および共通エラー処理パターンを再利用可能な形で提供する。

## 主な構成要素

- Exception Subprocess 入口
- Content Modifier
- 重大度別 Router
- Mail / Alert Adapter
- MPL ログ補足

## 実装ルール

- 通知文は簡潔かつ対応可能な内容とする
- IF ID、業務キー、エラー概要を含める
- 機微情報をメール本文へ出力しない
- 共通ロジックはシナリオ依存ロジックと分離する

## レビューポイント

- 重大度別分岐の妥当性
- 通知文の分かりやすさ
- 機微情報制御
- 再利用性
