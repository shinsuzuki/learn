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
SQL> CREATE USER {username}
    IDENTIFIED BY {password}
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
-- 特定のカラムを条件にして選択
SQL> SELECT * FROM {table_name} WHERE {column1} = {value1};
-- 範囲を指定して選択
SQL> SELECT * FROM {table_name} WHERE {column1} BETWEEN {value1} AND {value2};
-- 値のリストを指定して選択
SQL> SELECT * FROM {table_name} WHERE {column1} IN ({value1}, {value2}, ...);
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


