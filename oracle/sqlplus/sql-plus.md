# SQL*Plus

## 接続と切断
### SQL*Plusを起動、接続する

``` dosbatch
> sqlplus /nolog
> connect {user}/{password}
```

### SQL*Plusの起動と同時に接続
``` dosbatch
> sqlplus {user}/{password}
```

### DBへの接続を切断 
``` dosbatch
SQL> exit
```

## 機能

### テストデータ
https://github.com/mv/mvdba/blob/master/demo/demobld.sql  
※日付のフォーマット修正が必要だった

### 画面をクリア
``` dosbatch
SQL> clear screen
``` 

### テーブル定義を確認
``` dosbatch
SQL> describe emp
```
<結果>
``` dosbatch
 名前                                      NULL?    型
 ----------------------------------------- -------- ----------------------------
 EMPNO                                     NOT NULL NUMBER(4)
 ENAME                                              VARCHAR2(10)
 JOB                                                VARCHAR2(9)
 MGR                                                NUMBER(4)
 HIREDATE                                           DATE
 SAL                                                NUMBER(7,2)
 COMM                                               NUMBER(7,2)
 DEPTNO                                             NUMBER(2)
```

### 接続しているユーザーを切り替える
``` dosbatch
SQL> connect {usre}/{password}
```

### システム変数情報を表示
``` dosbatch
SQL> show all
```
<結果>
```
appinfoはOFFであり、設定先は "SQL*Plus"です。
arraysize 15
autocommit OFF
autoprint OFF
autorecovery OFF
autotrace OFF
blockterminator "." (hex 2e)
btitle OFFであり、次のSELECT文の先頭から数文字です。
  :
```

### システム変数を変更
``` dosbatch
SQL> set {システム変数名} {設定する値}
```

<1行の表示サイズを80から200へ変更>
``` dosbatch
SQL> set linesize 200
```

<ページサイズを変更>
``` dosbatch
SQL> set pagesize 100
```

## SQLスクリプトファイルを呼び出す
### STARTコマンド（指定したファイルの内容を実行する）
```
SQL> start my-select.sql
```
<my-select.sql>
``` dosbatch
connect dbuser/sasa;
set line 200;
set pagesize 1000;
select * from emp;
RUN
```

<結果>
``` dosbatch
接続されました。

     EMPNO ENAME      JOB              MGR HIREDATE        SAL       COMM     DEPTNO
---------- ---------- --------- ---------- -------- ---------- ---------- ----------
      7369 SMITH      CLERK           7902 80-12-17        800                    20
      7499 ALLEN      SALESMAN        7698 81-02-20       1600        300         30
      7521 WARD       SALESMAN        7698 81-02-22       1250        500         30
      7566 JONES      MANAGER         7839 81-04-02       2975                    20
      7654 MARTIN     SALESMAN        7698 81-09-28       1250       1400         30
      7698 BLAKE      MANAGER         7839 81-05-01       2850                    30
      7782 CLARK      MANAGER         7839 81-06-09       2450                    10
      7788 SCOTT      ANALYST         7566 82-12-09       3000                    20
      7839 KING       PRESIDENT            81-11-17       5000                    10
      7844 TURNER     SALESMAN        7698 81-09-08       1500          0         30
      7876 ADAMS      CLERK           7788 83-01-12       1100                    20
      7900 JAMES      CLERK           7698 81-12-03        950                    30
      7902 FORD       ANALYST         7566 81-12-03       3000                    20
      7934 MILLER     CLERK           7782 82-01-23       1300                    10

14行が選択されました。
```


### @コマンド（sqlplusを起動してファイルの内容を実行する）
 ``` dosbatch
 > sqlplus {user}/{password} @my-select.sql
 ```
※@の場合はSQL*Plusを実行したディレクトリが検索され、@@の場合は呼び出し元のSQLスクリプトが存在する場所が検索される。

<結果>
``` dosbatch
接続されました。

     EMPNO ENAME      JOB              MGR HIREDATE        SAL       COMM     DEPTNO
---------- ---------- --------- ---------- -------- ---------- ---------- ----------
      7369 SMITH      CLERK           7902 80-12-17        800                    20
      7499 ALLEN      SALESMAN        7698 81-02-20       1600        300         30
      7521 WARD       SALESMAN        7698 81-02-22       1250        500         30
      7566 JONES      MANAGER         7839 81-04-02       2975                    20
      7654 MARTIN     SALESMAN        7698 81-09-28       1250       1400         30
      7698 BLAKE      MANAGER         7839 81-05-01       2850                    30
      7782 CLARK      MANAGER         7839 81-06-09       2450                    10
      7788 SCOTT      ANALYST         7566 82-12-09       3000                    20
      7839 KING       PRESIDENT            81-11-17       5000                    10
      7844 TURNER     SALESMAN        7698 81-09-08       1500          0         30
      7876 ADAMS      CLERK           7788 83-01-12       1100                    20
      7900 JAMES      CLERK           7698 81-12-03        950                    30
      7902 FORD       ANALYST         7566 81-12-03       3000                    20
      7934 MILLER     CLERK           7782 82-01-23       1300                    10

14行が選択されました。
```


### SQL*Plusの実行結果をファイルに出力します
``` dosbatch

SQL> spool result.txt
SQL> select * from emp;
SQL> spool off
```
<結果>
``` dosbatch
SQL> select * from emp;

     EMPNO ENAME      JOB              MGR HIREDATE        SAL       COMM     DEPTNO                                                                                                                    
---------- ---------- --------- ---------- -------- ---------- ---------- ----------                                                                                                                    
      7369 SMITH      CLERK           7902 80-12-17        800                    20                                                                                                                    
      7499 ALLEN      SALESMAN        7698 81-02-20       1600        300         30                                                                                                                    
      7521 WARD       SALESMAN        7698 81-02-22       1250        500         30                                                                                                                    
      7566 JONES      MANAGER         7839 81-04-02       2975                    20                                                                                                                    
      7654 MARTIN     SALESMAN        7698 81-09-28       1250       1400         30                                                                                                                    
      7698 BLAKE      MANAGER         7839 81-05-01       2850                    30                                                                                                                    
      7782 CLARK      MANAGER         7839 81-06-09       2450                    10                                                                                                                    
      7788 SCOTT      ANALYST         7566 82-12-09       3000                    20                                                                                                                    
      7839 KING       PRESIDENT            81-11-17       5000                    10                                                                                                                    
      7844 TURNER     SALESMAN        7698 81-09-08       1500          0         30                                                                                                                    
      7876 ADAMS      CLERK           7788 83-01-12       1100                    20                                                                                                                    
      7900 JAMES      CLERK           7698 81-12-03        950                    30                                                                                                                    
      7902 FORD       ANALYST         7566 81-12-03       3000                    20                                                                                                                    
      7934 MILLER     CLERK           7782 82-01-23       1300                    10                                                                                                                    

14行が選択されました。

SQL> spool off

```

### エラーを処理
SQLスクリプトファイルの先頭にエラーハンドリグの記述。

> whenever sqlerror exit {success|failure|warning|整数|変数} {commit|rollback}

例）
```
whenever sqlerror exit 1 rollback
```

### SQL分処理時間の計測
``` dosbatch
SQL> set timing on
SQL> select * from emp;
 :
 :
経過: 00:00:00.00
SQL> set timing off
```


### 処理単位での時間計測
``` dosbatch
SQL> timing start no1
SQL> select * from emp;
SQL> timing start no2
SQL> select * from emp;
SQL> timing stop
no2のタイミング。
経過: 00:00:06.80
SQL> timing stop
no1のタイミング。
経過: 00:00:27.21
```

### SQLプロンプトに時間を表示する
``` dosbatch
SQL> set time on
15:47:41 SQL>
SQL> set time off
```

### SQL文の実行結果を変数に保存する

<データ数を変数へ設定>
``` dosbatch
SQL> col emp_record new_value v_emp_record
SQL> select count(*) as emp_record from emp;

EMP_RECORD
----------
        14
SQL> define v_emp_record
DEFINE V_EMP_RECORD    =   14 (NUMBER)
```

<ファイル名に時間を設定>
``` dosbatch
SQL> col now_time new_value v_now_time
SQL> select to_char(sysdate, 'YYYYMMdd-HH24MISS') now_time from dual;

NOW_TIME
---------------
20250406-160830 

SQL> spool result_&v_now_time..txt
SQL> select * from emp;
SQL> spool off

```

### コマンド結果を出力する（コマンドは出力しない）

<検索結果のみをファイルへ出力>

``` dosbatch
col now_time new_value v_now_time;
select to_char(sysdate, 'YYYYMMdd-HH24MISS') now_time from dual;
spool result_&v_now_time..txt;
select * from emp;
spool off;
```

<出力ファイルの内容>
``` dosbatch
EMPNO ENAME      JOB        MGR HIREDATE  SAL COMM DEPTNO
----- ---------- --------- ---- -------- ---- ---- ------
 7369 SMITH      CLERK     7902 80-12-17  800          20
 7499 ALLEN      SALESMAN  7698 81-02-20 1600  300     30
 7521 WARD       SALESMAN  7698 81-02-22 1250  500     30
 7566 JONES      MANAGER   7839 81-04-02 2975          20
 7654 MARTIN     SALESMAN  7698 81-09-28 1250 1400     30
 7698 BLAKE      MANAGER   7839 81-05-01 2850          30
 7782 CLARK      MANAGER   7839 81-06-09 2450          10
 7788 SCOTT      ANALYST   7566 82-12-09 3000          20
 7839 KING       PRESIDENT      81-11-17 5000          10
 7844 TURNER     SALESMAN  7698 81-09-08 1500    0     30
 7876 ADAMS      CLERK     7788 83-01-12 1100          20
 7900 JAMES      CLERK     7698 81-12-03  950          30
 7902 FORD       ANALYST   7566 81-12-03 3000          20
 7934 MILLER     CLERK     7782 82-01-23 1300          10
```

