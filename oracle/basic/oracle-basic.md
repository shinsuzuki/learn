# Oracle - 基本操作

## 1. 接続

### OS認証で接続
```cmd
> sqlplus / as sydba
SQL*Plus: Release 19.0.0.0.0 - Production on 水 4月 16 23:12:06 2025
Version 19.3.0.0.0
Copyright (c) 1982, 2019, Oracle.  All rights reserved.
Oracle Database 19c Standard Edition 2 Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
に接続されました。

SQL> show user
ユーザーは"SYS"です。
```
### SYSユーザー（as sysdbaが必要）
```cmd
> sqlplus sys/{password} as sysdba
SQL*Plus: Release 19.0.0.0.0 - Production on 水 4月 16 23:12:06 2025
Version 19.3.0.0.0
Copyright (c) 1982, 2019, Oracle.  All rights reserved.
Oracle Database 19c Standard Edition 2 Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
に接続されました。

SQL> show user
ユーザーは"SYS"です。
```

### SYSTEMユーザー
```cmd
>sqlplus system/{password}
SQL*Plus: Release 19.0.0.0.0 - Production on 水 4月 16 23:18:59 2025
Version 19.3.0.0.0
Copyright (c) 1982, 2019, Oracle.  All rights reserved.
最終正常ログイン時間: 水 4月  16 2025 23:06:58 +09:00
Oracle Database 19c Standard Edition 2 Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
に接続されました。

SQL> show user
ユーザーは"SYSTEM"です。
```

### 作成したユーザーから接続
```cmd
>sqlplus {username}/{password}@{host}:{port}/{service_name}
```


## 2. ユーザーを作成

### Cratee User
```sql
SQL> CREATE USER {username}     -- ユーザー名を指定
    IDENTIFIED BY {password}    -- パスワードを指定
    DEFAULT TABLESPACE users    -- デフォルトの表領域
    TEMPORARY TABLESPACE temp;  -- 一時表領域

ユーザーが作成されました。
```

### Drop User
```sql
-- ユーザーを削除する。CASCADEオプションは、ユーザーが所有するオブジェクトも削除することを意味します。
SQL> DROP USER {username} CASCADE;

ユーザーが削除されました。
```

### アカウントをロック
```sql
SQL> ALTER USER {username} ACCOUNT LOCK; -- アカウントをロックする
SQL> ALTER USER {username} ACCOUNT UNLOCK; -- アカウントをロックを解除
```

### パスワードを変更
```sql
SQL> ALTER USER {username} IDENTIFIED BY {new_password};
ユーザーが変更されました。
```

###  他のユーザーのオブジェクトへアクセス

```sql
-- dbuserから接続
-- 他のユーザー(dbuser2)のオブジェクトにアクセスするには、権限が必要です。
-- 例えば、SELECT権限が必要です。
SQL> select * from dbuser2.books;
```

### 接続先のコンテナ名
```sql
-- コンテナ名を表示する
SQL> show con_name
```

## 3.テーブルとデータ操作

### テーブルを作成
```sql
SQL> CREATE TABLE {table_name} (
    {column_name1} {data_type1} [{constraint1}],
    {column_name2} {data_type2} [{constraint2}],
    ...
);
```

### 文字列を日付に変換
```sql
SQL> SELECT TO_DATE('2024-9-2 13:34:45', 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;

TO_DATE(
--------
24-09-02
```

### テーブル定義を確認
```sql
SQL> desc member
 名前                                      NULL?    型
 ----------------------------------------- -------- ----------------------------
 ID                                                 CHAR(4)
 NAME                                               VARCHAR2(16)
 SALARY                                             NUMBER(10)

```

### データを追加
```sql
SQL> INSERT INTO {table_name} ({column1}, {column2}, ...)
    VALUES ({value1}, {value2}, ...);
-- 例）
SQL>INSERT INTO MEMBER (ID, NAME, SALARY) VALUES ('A001', 'TRON', 100);
1行が作成されました。
SQL> COMMIT;
コミットが完了しました。
```

### データを選択
```sql
-- 全てのデータを選択
SQL> SELECT * FROM {table_name};
-- 特定のカラムを選択
SQL> SELECT {column1}, {column2} FROM {table_name};
-- 条件を指定して選択
SQL> SELECT * FROM {table_name} WHERE {condition};

```
### データを更新
```sql
SQL> UPDATE {table_name}
    SET {column1} = {value1}, {column2} = {value2}, ...
    WHERE {condition};
-- 例）
SQL> UPDATE MEMBER SET SALARY = 200 WHERE ID = 'A001';
1行が更新されました。
SQL> COMMIT;
コミットが完了しました。
```

### データを削除
```sql
-- 条件を指定して削除
SQL> DELETE FROM {table_name} WHERE {condition};
-- 例）
SQL DELETE FROM MEMBER WHERE ID = 'A001';
1行が削除されました。
SQL> COMMIT;
コミットが完了しました。

```

### テーブルを削除
```sql
-- テーブルを削除する。CASCADEオプションは、テーブルに関連する制約も削除することを意味します。
SQL> DROP TABLE {table_name} CASCADE CONSTRAINTS;

```
### テーブルのデータを削除
```sql
-- テーブルのデータを削除する。テーブル自体は削除しない。
SQL> TRUNCATE TABLE {table_name};
-- 例）
SQL > TRUNCATE TABLE MEMBER;
```

## 4.複雑な条件検索
### 列の表示を変える
```sql
-- 列の表示を変える
SQL> COLUMN {column_name} FORMAT {format};
```
### 結果をソートする
```sql
-- 結果をソートする, ASCは昇順、DESCは降順を意味します。
SQL> SELECT * FROM {table_name} ORDER BY {column1} ASC|DESC, {column2} ASC|DESC;
```

### 特定のカラムを条件にして選択
```sql
SQL> SELECT {column1}, {column2} FROM {table_name} WHERE {column1} = {value1};
```

### 範囲を指定して選択
```sql
SQL> SELECT * FROM {table_name} WHERE {column1} BETWEEN {value1} AND {value2};
```

### 値のリストを指定して選択
```sql
SQL> SELECT * FROM {table_name} WHERE {column1} IN ({value1}, {value2}, ...);
```
### LIKEを使用して部分一致検索
```sql
SQL> SELECT * FROM {table_name} WHERE {column1} LIKE '%{value}%';
```

### NULLを含むデータを選択
```sql
SQL> SELECT * FROM {table_name} WHERE {column1} IS NULL;
```

### NULLを含まないデータを選択
```sql
SQL> SELECT * FROM {table_name} WHERE {column1} IS NOT NULL;
```

### AND条件を指定して選択
```sql
SQL> SELECT * FROM {table_name} WHERE {column1} = {value1} AND {column2} = {value2};
```

### OR条件を指定して選択
```sql
SQL> SELECT * FROM {table_name} WHERE {column1} = {value1} OR {column2} = {value2};
```

### NOT条件を指定して選択
```sql
SQL> SELECT * FROM {table_name} WHERE NOT {column1} = {value1};
```

## 5.データを加工、集計
### データを加工して選択
```sql
SQL> SELECT {function}({column1}) FROM {table_name};
-- 例）
SQL> SELECT LOWER(DNAME) FROM DEPT;
```
### 集計関数を使用して選択
```sql
-- 行数をカウント（*はNULLを含む、カラム指定はNULLを除外する）
SQL> SELECT COUNT(*) FROM {table_name};
-- 合計を計算（集計関数はNULLを除外する）
SQL> SELECT SUM({column1}) FROM {table_name};
```

### グループ化して集計
```sql
-- グループ化して集計する。GROUP BY句を使用します。
SQL> SELECT {column1}, COUNT(*) FROM {table_name} GROUP BY {column1};
-- HAVING句を使用して、グループ化した結果に条件を指定することもできます。
SQL> SELECT {column1}, COUNT(*) FROM {table_name} GROUP BY {column1} HAVING COUNT(*) > {value};
```
### グループ化して集計（複数のカラム）
```sql
SQL> SELECT {column1}, {column2}, COUNT(*) FROM {table_name} GROUP BY {column1}, {column2};
```
### グループ化して集計（複数のカラム、条件付き）
```sql
SQL> SELECT {column1}, {column2}, COUNT(*) FROM {table_name} WHERE {condition} GROUP BY {column1}, {column2};
```
### グループ化して集計（複数のカラム、条件付き、HAVING句）
```sql
SQL> SELECT {column1}, {column2}, COUNT(*) FROM {table_name} WHERE {condition} GROUP BY {column1}, {column2} HAVING COUNT(*) > {value};
```
### グループ化して集計（複数のカラム、条件付き、HAVING句、ORDER BY句）
```sql
SQL> SELECT {column1}, {column2}, COUNT(*) FROM {table_name} WHERE {condition} GROUP BY {column1}, {column2} HAVING COUNT(*) > {value} ORDER BY {column1}, {column2};
```
### グループ化して集計（複数のカラム、条件付き、HAVING句、ORDER BY句、LIMIT句）
```sql
SQL> SELECT {column1}, {column2}, COUNT(*) FROM {table_name} WHERE {condition} GROUP BY {column1}, {column2} HAVING COUNT(*) > {value} ORDER BY {column1}, {column2} LIMIT {value};
```
### グループ化して集計（複数のカラム、条件付き、HAVING句、ORDER BY句、LIMIT句、OFFSET句）
```sql
SQL> SELECT {column1}, {column2}, COUNT(*) FROM {table_name} WHERE {condition} GROUP BY {column1}, {column2} HAVING COUNT(*) > {value} ORDER BY {column1}, {column2} LIMIT {value} OFFSET {value};
```
### グループ化して集計（複数のカラム、条件付き、HAVING句、ORDER BY句、LIMIT句、OFFSET句、DISTINCT句）
```sql
SQL> SELECT DISTINCT {column1}, {column2}, COUNT(*) FROM {table_name} WHERE {condition} GROUP BY {column1}, {column2} HAVING COUNT(*) > {value} ORDER BY {column1}, {column2} LIMIT {value} OFFSET {value};
```
### グループ化して集計（複数のカラム、条件付き、HAVING句、ORDER BY句、LIMIT句、OFFSET句、DISTINCT句、UNION句）
```sql
SQL> SELECT DISTINCT {column1}, {column2}, COUNT(*) FROM {table_name} WHERE {condition} GROUP BY {column1}, {column2} HAVING COUNT(*) > {value} ORDER BY {column1}, {column2} LIMIT {value} OFFSET {value} UNION SELECT DISTINCT {column1}, {column2}, COUNT(*) FROM {table_name} WHERE {condition} GROUP BY {column1}, {column2} HAVING COUNT(*) > {value} ORDER BY {column1}, {column2} LIMIT {value} OFFSET {value};
```
### グループ化して集計（複数のカラム、条件付き、HAVING句、ORDER BY句、LIMIT句、OFFSET句、DISTINCT句、UNION ALL句）
```sql
SQL> SELECT DISTINCT {column1}, {column2}, COUNT(*) FROM {table_name} WHERE {condition} GROUP BY {column1}, {column2} HAVING COUNT(*) > {value} ORDER BY {column1}, {column2} LIMIT {value} OFFSET {value} UNION ALL SELECT DISTINCT {column1}, {column2}, COUNT(*) FROM {table_name} WHERE {condition} GROUP BY {column1}, {column2} HAVING COUNT(*) > {value} ORDER BY {column1}, {column2} LIMIT {value} OFFSET {value};
```

### 外部結合:INNER JOINは、両方のテーブルの一致する行を取得します。
```sql
SQL> SELECT {column1}, {column2} FROM {table_name1} INNER JOIN {table_name2} ON {table_name1}.{column1} = {table_name2}.{column1};
```

### 外部結合:LEFT JOINは、左側のテーブルの全ての行を取得し、右側のテーブルの一致する行を取得します。
```sql
    SQL> SELECT {column1}, {column2} FROM {table_name1} LEFT JOIN {table_name2} ON {table_name1}.{column1} = {table_name2}.{column1};
```

### 外部結合: CROSS JOINは、両方のテーブルの全ての行を取得します。
```sql
SQL> SELECT {column1}, {column2} FROM {table_name1} CROSS JOIN {table_name2};
```

## 6.トランザクション制御
### コミット
```sql
-- トランザクションをコミットする。データベースに変更を保存します。
SQL> COMMIT;
```

### ロールバック
```sql
-- トランザクションをロールバックする。データベースの変更を元に戻します。
SQL> ROLLBACK;
```

## 7.インデックス
### インデックスを作成
```sql
SQL> CREATE INDEX {index_name} ON {table_name} ({column1}, {column2}, ...);
```

### インデックスを削除
```sql
SQL> DROP INDEX {index_name};
```

### インデックスを表示
```sql
SQL>  SELECT INDEX_NAME, TABLE_OWNER,TABLE_NAME,STATUS FROM USER_INDEXES WHERE TABLE_NAME = 'EMP';
```

### インデックスを有効化
```sql
SQL> ALTER INDEX {index_name} ENABLE;
```

### インデックスを無効化
```sql
SQL> ALTER INDEX {index_name} DISABLE;
```

### インデックスを再構築
```sql
SQL> ALTER INDEX {index_name} REBUILD;
```

## 8.ビュー
### ビューを作成
```sql
SQL> CREATE VIEW {view_name} AS SELECT {column1}, {column2} FROM {table_name} WHERE {condition};
```


## 9.制約

### テーブル作成時に制約を指定
```sql
SQL> CREATE TABLE EMP (
    ID NUMBER(4) PRIMARY KEY,       -- 主キー制約
    NAME VARCHAR2(20) NOT NULL,     -- NOT NULL制約
    SALARY NUMBER(10, 2) CHECK (SALARY > 0),    -- CHECK制約
    DEPT_ID NUMBER(4) REFERENCES DEPT(ID)   -- 外部キー制約
);
```

### 主キー制約
```sql
SQL> ALTER TABLE {table_name} ADD CONSTRAINT {constraint_name} PRIMARY KEY ({column1}, {column2}, ...);
-- 例）
SQL> ALTER TABLE MEMBER ADD CONSTRAINT PK_MEMBER PRIMARY KEY (ID);
```

### NOT NULL制約
```sql
-- NULLを許可しない
SQL> ALTER TABLE {table_name} ADD CONSTRAINT {constraint_name} NOT NULL ({column1}, {column2}, ...);
-- 例）
SQL> ALTER TABLE MEMBER ADD CONSTRAINT NN_MEMBER NOT NULL (ID, NAME);

-- NULLを許可しない（変更）
SQL> ALTER TABLE {table_name} MODIFY {column_name} NOT NULL;
-- NULLを許可する（変更）
SQL> ALTER TABLE {table_name} MODIFY {column_name} NULL;
```

### 一意制約
```sql
SQL> ALTER TABLE {table_name} ADD CONSTRAINT {constraint_name} UNIQUE ({column1}, {column2}, ...);
-- 例）
SQL> ALTER TABLE MEMBER ADD CONSTRAINT UQ_MEMBER UNIQUE (ID);
```

### 外部キー制約
```sql
SQL> ALTER TABLE {table_name} ADD CONSTRAINT {constraint_name} FOREIGN KEY ({column1}, {column2}, ...) REFERENCES {referenced_table} ({referenced_column1}, {referenced_column2}, ...);
-- 例）
SQL> ALTER TABLE MEMBER ADD CONSTRAINT FK_MEMBER FOREIGN KEY (ID) REFERENCES EMP (ID);
```

### CHECK制約
```sql
SQL> ALTER TABLE {table_name} ADD CONSTRAINT {constraint_name} CHECK ({condition});
-- 例）
SQL> ALTER TABLE MEMBER ADD CONSTRAINT CK_MEMBER CHECK (SALARY > 0);
```

### 制約を削除
```sql
SQL> ALTER TABLE {table_name} DROP CONSTRAINT {constraint_name};
-- 例）
SQL> ALTER TABLE MEMBER DROP CONSTRAINT PK_MEMBER;
```

## 10.シーケンスの使用

### シーケンスを作成
```sql
SQL> CREATE SEQUENCE {sequence_name}
    START WITH {start_value}  -- 開始値
    INCREMENT BY {increment_value}  -- 増分値
    MINVALUE {min_value}  -- 最小値
    MAXVALUE {max_value}  -- 最大値
    CYCLE;  -- 循環するかどうか
-- 例)
SQL> CREATE SEQUENCE EMP_SEQ
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999
    CYCLE;
```

### シーケンスを使用してデータを挿入
```sql
SQL> INSERT INTO EMP (ID, NAME, SALARY, DEPT_ID) VALUES (EMP_SEQ.NEXTVAL, 'TRON', 1000, 1);
```

### シーケンスの値を取得
```sql
SQL> SELECT EMP_SEQ.NEXTVAL FROM DUAL;
```

### シーケンスの値を取得（前回の値を取得）
```sql
SQL> SELECT EMP_SEQ.CURRVAL FROM DUAL;
```

### シーケンスを削除
```sql
SQL> DROP SEQUENCE {sequence_name};
-- 例）
SQL> DROP SEQUENCE EMP_SEQ;
```

### シーケンスの情報を表示（特定のスキーマのシーケンス）
```sql
SQL> SELECT SEQUENCE_NAME, MIN_VALUE, MAX_VALUE, INCREMENT_BY, CYCLE_FLAG FROM ALL_SEQUENCES WHERE SEQUENCE_OWNER = '{schema_name}';
-- 例）
SQL> SELECT SEQUENCE_NAME, MIN_VALUE, MAX_VALUE, INCREMENT_BY, CYCLE_FLAG FROM ALL_SEQUENCES WHERE SEQUENCE_OWNER = 'HR';
```

## 権限

### システム権限の付与
```sql
SQL> GRANT {privilege} TO {username};
-- 例）
SQL> GRANT CREATE TABLE TO HR;
```

### システム権限の剥奪
```sql
SQL> REVOKE {privilege} FROM {username};
-- 例）
SQL> REVOKE CREATE TABLE FROM HR;
```

### オブジェクト権限の付与
```sql
SLQ> GRANT {privilege} ON {object} TO {username};
-- 例）
SQL> GRANT SELECT ON SCOT.EMP TO HR;
```

### オブジェクト権限の剥奪
```sql
SQL> REVOKE {privilege} ON {object} FROM {username};
-- 例）
SQL> REVOKE SELECT ON SCOT.EMP FROM HR;
```

### ロールへのシステム権限の付与
```sql
SQL> GRANT {privilege} TO {role};
-- 例）
SQL> GRANT CREATE TABLE TO HR_ROLE;
```

### ロールへのオブジェクト権限の付与
```sql
SQL> GRANT {role} TO {username};
-- 例）
SQL> GRANT DBA TO HR;
```

### ロールからオブジェクト権限の剥奪
```sql
SQL> REVOKE {role} FROM {username};
-- 例）
SQL> REVOKE DBA FROM HR;
```