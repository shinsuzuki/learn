# SQL Sample Data

## ファイル構成
* CSV
  * ハンズオン用テストデータ
  * CSVファイル3つ

## テーブル定義
ハンズオンで使うテーブル定義です。ハンズオンでは以下3つのテーブルを使います。

### users
ユーザー情報が格納されたテーブルです。

|カラム名|意味|型|備考|
|:---|:---|:---|:---|
|user_id|ユーザーID|TEXT||
|gender|性別|TEXT|女性 / 男性|
|birth|誕生日|INTEGER|誕生年が数字で入ります|
|is_deleted|削除フラグ|INTEGER|0：通常ユーザー <br> 1：削除ユーザー|

### products
商品情報が格納されたテーブルです。

|カラム名|意味|型|備考|
|:---|:---|:---|:---|
|product_id|商品ID|TEXT||
|name|商品名|TEXT||
|price|金額|INTEGER||
|large_category|大カテゴリ|TEXT||
|medium_category|中カテゴリ|TEXT||
|small_category|小カテゴリ|TEXT||

### orders
注文情報が格納されたデータです。

|カラム名|意味|型|備考|
|:---|:---|:---|:---|
|order_id|注文ID|TEXT||
|user_id|ユーザーID|TEXT||
|order_product_id|商品ID|TEXT||
|order_date|注文日時|INTEGER||
|is_discounted|割引フラグ|INTEGER|0：割引なし <br> 1：割引あり|
|is_canceled|キャンセルフラグ|INTEGER|0：キャンセルなし <br> 1：キャンセルあり|

## 利用環境
* SQLite

## 最新版ファイルのダウンロード
* https://github.com/hikarut/SQL-Sample-Data/releases/latest
  * ※「Source code (zip)」からダウンロード
