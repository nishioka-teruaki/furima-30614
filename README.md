# README

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
| user_birth_date_1i | string | null: false |
| user_birth_date_2i | string | null: false |
| user_birth_date_3i | string | null: false |

### Association

- has_many :items

## items テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| item_name           | string     | null: false                    |
| info                | text       | null: false                    |
| category            | string     | null: false                    |
| sales_status        | string     | null: false                    |
| shipping_fee_status | string     | null: false                    |
| item_prefecture     | string     | null: false                    |
| scheduled_delivery  | string     | null: false                    |
| price               | string     | null: false                    |
| user                | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :comment
- has_one :card
- has_one :prefecture

## comments テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| comment | text       | null: false                    |
| item    | references | null: false, foreign_key: true |

### Association

- belongs_to :item

## cards テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| number    | string     |                                |
| exp_month | string     | null: false                    |
| exp_year  | string     | null: false                    |
| item      | references | null: false, foreign_key: true |

### Association

- belongs_to :item

## prefectures テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| postal_code  | string     | null: false                    |
| prefecture   | string     | null: false                    |
| city         | string     | null: false                    |
| addresses    | references | null: false                    |
| building     | string     |                                |
| phone_number | string     | null: false                    |
| item        | references | null: false, foreign_key: true |

### Association

- belongs_to :item