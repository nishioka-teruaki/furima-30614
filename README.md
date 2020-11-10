# README

# アプリケーション名
フリマアプリケーション

# アプリケーション概要
ユーザーが自由に商品を出品し売買が行える環境を提供するサービスです。

# URL
54.178.83.235

# テスト用アカウント

## Basic認証のIDとパスワード  
 ID:admin  
 PASS:2222  

## 出品者用のメールアドレスとパスワード  
 メールアドレス:aaa@bbb.ccc  
 パスワード:1qaz2wsx  

## 購入者用のメールアドレスとパスワード  
 メールアドレス:aaa@bbb.com  
 パスワード:1qaz2wsx  

## 購入用カードの番号・期限・セキュリティコード  
 番号:4242424242424242  
 期限:明日以降の日にち  
 セキュリティコード:123

# 利用方法
 利用者は新規にアカウント作成してください。
 出品を行いたい方は、右下の出品ボタンを押下してください。
 出品された商品を購入したい方は、商品の写真をクリックし購入画面へ進んでください。

# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| password           | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| user_birth_date    | date   | null: false |

### Association

- has_many :items
- has_many :purchases
- has_many :comments

## items テーブル

| Column                 | Type       | Options                        |
| ---------------------- | ---------- | ------------------------------ |
| name                   | string     | null: false                    |
| info                   | text       | null: false                    |
| category_id            | integer    | null: false                    |
| sales_status_id        | integer    | null: false                    |
| shipping_fee_status_id | integer    | null: false                    |
| item_prefecture_id     | integer    | null: false                    |
| scheduled_delivery_id  | integer    | null: false                    |
| price                  | integer    | null: false                    |
| user                   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :comment
- has_one :purchases

## comments テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| comment | text       | null: false                    |
| item    | references | null: false, foreign_key: true |
| user    | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user

## shipping_add テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postal_code   | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| addresses     | string     | null: false                    |
| building      | string     |                                |
| phone_number  | string     | null: false                    |
| purchase      | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase

## purchases テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| item       | references | null: false, foreign_key: true |
| user       | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :shipping_add