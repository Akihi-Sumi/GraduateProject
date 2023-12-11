# 卒業研究 - 緊急時用メッセンジャー

災害などの緊急時に、メッセージをすぐに送るためのアプリ。

## アプリの機能

- アカウント作成
- ログイン
- ログアウト
- メッセージを作成・編集・削除
- ギャラリーから画像を選択して送信
- カメラを起動して、撮影した写真を送信
- アカウント情報の編集
- 防災グッズのチェックリスト
- テーマの変更

## 使用技術

- Flutter
- Firebase
  - Authentication (認証)
  - Cloud Firestore (NoSQLデータベース)
  - Firestorage (画像用ストレージ)
  - Hosting (ホスティング)

## コマンド

```shell
flutter build web --web-renderer html --release
firebase deploy --only hosting:emergency6messenger
```
