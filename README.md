# アプリ名 name
* 文字る

# 概要 Description
* 造語をシェア出来る投稿サイト
* 「言葉、意味、例文, 画像」を含む投稿をし、ユーザー同士が「フォロー、いいね」などで繋がり、「タグ、人気ユーザー、ランキング」などで飽きないアプリとなっております。

# 説明 Features
## 基礎機能
* haml/SASS記法と、命名規則BEMを使ったマークアップ
* ログイン
* 投稿機能
* 投稿閲覧機能
* 投稿編集/消去機能
## 追加機能
* トップページ
* 投稿検索 機能
* ユーザー検索機能(ユーザー一覧)
* タグ付け機能
* admin機能(ユーザー、コメント削除)
* twitterシェア機能
* 閲覧数取得機能
* 投稿閲覧数順表示機能
* 人気ユーザー表示(閲覧数順表示機能)
* いいね機能(ユーザーがいいねした投稿一覧)
* いいね順表示機能
* ページネーション機能(bootstrap)
* ゲストログイン機能
* コメント機能(投稿、削除)
* エラー日本語化
* レスポンシブ対応(一部のみ)
* フォロー機能
* フォロワー/フォロー表示機能
* 投稿詳細ページの前と次の詳細ページへ遷移のリンク付け
* RSpecを使った単体テスト


# 使用技術
* Haml
* Saas
* Git(GitHub)
* Ruby
* Ruby on Rails
* AWS(EC2)
* RSpec

# DEMO

# 工夫したポイント
## ユーザーがアプリ内のページにいる時に次にどうするかという思考を無くすために一つのページになるべく色々なリンクに飛べるように設計しました。

# 環境条件 Requirement/gem
* Ruby'2.6.5'
* Rails'~> 6.0.0'

# 本番環境
* 本番環境のIPアドレス
  http://54.95.52.225/
* テスト用ログイン情報
- 「ログイン」から「ゲストログイン(閲覧用)」をクリック

# 制作背景
## 自分が留学時に日本人が日常的に新しい文字を作り出していく造語が独特な文化だと気付き、小さなコミュニティーで使うものから流行語大賞になるまでのものなど、様々な言葉が毎年生まれていることに対して、それを記録としてユーザーが気軽にシェアできればなと思いこのアプリを作りました。

# 課題や今後実装したい機能
* いいね/コメント/投稿消去,検索などの非同期化
* プレビュー機能
* タイムライン機能
* 通知機能
* 問い合わせ機能
* 動画投稿機能
* パスワードリセット機能
* dockerでの環境構築

# フリマ DB設計
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|profile|string|null: false|
|image|text|null:false|
|image|text|null:false|
|admin|boolean|default: false|
|email|string|null: false|
|password|string|null: false|

### Association
- has_many :posts, dependent: :destroy
- has_many :comments
- has_many :likes, dependent: :destroy
- has_many :liked_posts
- has_many :sns_credentials
- has_many :follower
- has_many :followed
- has_many :following_user
- has_many :follower_user

## postsテーブル
|Column|Type|Options|
|------|----|-------|
|vocab|string|null: false|
|definition|text|null: false|
|example|text|null: false|
|image|text|null:false|
|user_id|integer|null: false|

### Association
- belongs_to :user
- has_many :comments
- has_many :images
- belongs_to :category
- has_many :likes
- has_many :liked_users,

## likesテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false|
|post|references|null: false|


### Association
- belongs_to :user
- belongs_to :post

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|user|references|null: false, foreign_key: true|
|post|references|null: false, foreign_key: true|

### Association
- belongs_to :post
- belongs_to :user

## relationshipsテーブル
|Column|Type|Options|
|------|----|-------|
|follower|references|null: false, foreign_key: true|
|follwed|references|null: false, foreign_key: true|

### Association
- belongs_to :follower
- belongs_to :followed
