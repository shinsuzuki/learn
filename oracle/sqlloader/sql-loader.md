# SQL Loader学習

## SQL Loaderとは
SQL Loaderは、Oracle Databaseにデータをロードするためのユーティリティです。テキストファイルやCSVファイルなどの外部データソースから、Oracle Databaseのテーブルにデータを効率的にインポートすることができます。SQL Loaderは、特に大量のデータを一度にロードする際に非常に便利です。

## 公式
- [Oracle SQL Loader Documentation](https://docs.oracle.com/en/database/oracle/oracle-database/19/sutil/index.html)


##  SQL Loaderの基本的な使い方
SQL Loaderを使用するには、以下の手順を実行します。
1. **制御ファイルの作成**: データのフォーマットやロード先のテーブルを指定する制御ファイルを作成します。制御ファイルは、SQL Loaderにどのようにデータを処理するかを指示します。
2. **データファイルの準備**: ロードするデータを含むファイルを準備します。通常、CSV形式や固定長形式のテキストファイルが使用されます。
3. **SQL Loaderの実行**: コマンドラインからSQL Loaderを実行し、制御ファイルとデータファイルを指定します。SQL Loaderは、指定されたデータをOracle Databaseにロードします。
4. **ログファイルの確認**: SQL Loaderは、ロードの結果をログファイルに記録します。エラーや警告があれば、ログファイルを確認して問題を特定します。
5. **トランザクション管理**: SQL Loaderは、デフォルトで自動コミットを行いますが、必要に応じてトランザクション管理を行うこともできます。たとえば、`COMMIT`オプションを使用して、特定の条件でコミットを行うことができます。


## 実行

#### テーブル作成
```sql
CREATE TABLE DEPARTMENT (
    ID NUMBER PRIMARY KEY,
    NAME VARCHAR2(50) NOT NULL
);
```

#### 制御ファイル
``` txt
OPTIONS(SKIP=1)             -- オプション（ヘッダスキップを記述した）
LOAD DATA                   --
INFILE 'department.csv'     -- ロードするデータファイルを指定
BADFILE 'department.bad'    -- 拒否レコードが出力されるファイルを指定
APPEND                      -- 空でない表にデータをロードする場合に指定、空の表の場合はINSERTを指定
INTO TABLE DEPARTMENT       -- データと表の関係
FIELDS TERMINATED BY ","    -- 区切り文字指定
TRAILING NULLCOLS           -- レコードが存在しない場合はNULL
(
 ID,
 NAME
)

```

#### サンプルデータ
``` csv
ID,部門名
0,企画部
1,営業部
2,開発部
```

#### コマンド
```cmd
# コマンドフォーマット
# sqlldr username/password@database control=control_file.ctl data=data_file.dat log=log_file.log bad=bad_file.bad
# 例
> sqllder dbuser/sasa control=sample.ctl log=sample.log
```

#### ログ
``` txt

SQL*Loader: Release 19.0.0.0.0 - Production on 水 4月 30 14:25:00 2025
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle and/or its affiliates.  All rights reserved.

制御ファイル:    sample.ctl
データファイルdepartment.csv
  不良ファイル:  department.bad
  廃棄ファイル:  指定なし

 (すべて廃棄できます)

ロード数: ALL
スキップ数: 1
許容エラー数: 50
バインド配列:    250行、最大1048576バイト
継続文字:    指定なし
使用パス:      従来型

表DEPARTMENT、 ロード済 すべての論理レコードから
この表に対する有効な挿入オプション: APPEND
TRAILING NULLCOLSオプションは有効です。

   列名                  位置   長さ  用語暗号化データ型
------------------------------ ---------- ----- ---- ---- ---------------------
ID                                 FIRST    *  ,     CHARACTER
NAME                                NEXT    *  ,     CHARACTER


表DEPARTMENT:
  3 行は正常にロードされました。
  0 行はデータ・エラーのためロードされませんでした。
  0 行は、すべてのWHEN句が失敗したためロードされませんでした。
  0 行はすべてのフィールドがNULLであったためロードされませんでした。


バインド配列に割り当てられた領域:   129000バイト(250行)
読取りバッファのバイト数:  1048576

スキップされた論理レコードの合計:          1
読み込まれた論理レコードの合計:             3
拒否された論理レコードの合計:               0
廃棄された論理レコードの合計:        0

実行開始水 4月  30 14:25:00 2025
実行終了水 4月  30 14:25:00 2025

実行時間:        00: 00: 00.26
CPU時間 :        00: 00: 00.14

```

