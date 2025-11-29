------ 表を作成
create table product (
   product_id      number(5),
   product_name    varchar(50) ,
   price           number(8),
   release_date    DATE
)

insert into product (product_id,procuct_name,price,release_date)values (1, '商品A', 1000, sysdate);
commit;
select * from product;
desc product;

------  表を作成
create table product2 (
   product_id      number(5),
   product_name    varchar(50) not null,
   price           number(8),
   release_date    date,
   empno           number(4),
   --
   constraint      pk_product2 primary key(product_id),
   constraint      fk_product2_emp foreign key(empno) references emp(empno),
   constraint      chk_product2_price check(price>=0)
);

------  テーブルの制約の確認
select * from user_constraints where table_name = 'PRODUCT2'
insert into product2 (product_id, product_name, price, release_date, empno) values (101, '高機能マウス', 8000, sysdate, 7839);
commit;
select * from product2;
select * from emp

追加
alter table product add (empno number(4));
削除
alter table product drop column empno;

後から制約を追加する
alter table product add constraint pk_product primary key (product_id);  -- 制約の追加 add constraint
alter table product add constraint chk_product_price  (price >= 0);      -- 制約の追加 add constraint
alter table product modify (product_name not null);                      --  not null は modify

後から制約を削除する
altet table product drop constraint check_product_chk;   -- 制約を drop で削除
alter table product modify (product_name null);          -- not null は modify で null へ
alter table product drop primary key;                    -- 主キー削除

select * from user_constraints where table_name = 'product';
describe product;

------ テーブルをコピーする（データのみコピーされる、制約やインデックス等はコピーされない
create table xxx as select ....
create table emp_backup as select * from emp;
select * from emp_backup;
select * from user_constraints where table_name = 'emp_backup';
truncate table emp_backup;
drop table emp_backup;

------ view
作成
create or replace view v_emp_dname as
select
   e.empno,
   e.ename,
   e.job,
   d.dname
from
   emp e
inner join
   dept d on e.deptno = d.deptno;

select * from v_emp_dname;
desc v_emp_dname;

削除
drop view V_EMP_DNAME;

guid
select sys_guid() from dual;

------ seq
作成
create sequence product_id_seq
start with 1001
increment by 1
maxvalue 9999;

採番(nextvalue)
select product_id_seq.nextval from dual;
現在の番号(currval)
select product_id_seq.currval from dual;

add
insert into product (product_id, product_name, price, release_date) values (product_id_seq.nextval, '製品3', 11000, sysdate);
commit;
select * from product;

削除
drop sequence product_id_seq;
select product_id_seq.nextval from dual;

------ index
作成
create index idx_emp_job on emp(job);
desc emp;
clear screen;
select * from emp;

削除
drop index idx_emp_job;

------ 権限(SYSユーザー)
ユーザーを作成、事前定義済みの権限を付与
create user testuser identified by "password";
grant connect, resource to testuser;

ロールを作成
create role readonly_role;
ロールに権限を付与
grant select on dbuser.emp to readonly_role;
grant select on dbuser.dept to readonly_role;

ユーザーにロールを付与
grant readonly_role to testuser;

(testuser)で権限をチェック
select * from dbuser.emp;
select * from dbuser.dept;


------ システム権限の付与(Grant)、取り消し(Revoke)
権限がないため失敗
create table dbuser.test_from_user(id number);

(SYS)で権限を付与
grant create any table to testuser;

(testuser)でテーブル作成、成功
create table dbuser.test_from_user(id number);
select * from dbuser.test_from_user;

(SYS)で権限を取り消し
revoke create any table from testuser;
(dbuser)で削除
drop table test_from_user;


------ オブジェクト権限の付与(Grant)、取り消し(Revoke)
オブジェクト権限付与
grant select on emp to testuser;
grant update on product to developer_role

オブジェクト権限取り消し
revoke select on emp from testuser;
revoke update on product from developer_role;

(dbuser)がオブジェクト権限を付与
grant select on product to testuser;
(testusre)がセレクトできる
select * from dbuser.product;

(dbuser)がオブジェクト権限を取り消す
revoke select on product from testuser;
(testuser)がセレクトに失敗する
select * from dbuser.product;

------ 権限を確認する方法(USER)
現在のユーザーが持つ権限
select * from user_sys_privs;
他のユーザーのテーブルに対するオブジェクト権限
select * from user_tab_privs_recd;
自分が付与された権限
select * from user_role_privs;
自分が与えた権限
select * from user_tab_privs;

------ 権限を確認する方法(ROLE)
select * from role_sys_privs where role = 'readonly_role';

------ 表領域割当、テーブル作成、データ登録
表領域割当(SYS)
alter user testuser quota unlimited on users;

テーブル作成()
create table my_products (
 product_id        number,
 product_name      varchar2(100)
);
insert into my_products (product_id, product_name) values(100, 'test_user_1');
commit;
select * from my_products;
drop table my_products;

------ シノニム作成、削除
(testuser)シノニムを作成(先に権限を付与しておく)
create or replace synonym emp for dbuser.emp;
empからdbuser.empにアクセス可能
select * from emp;
drop synonym emp;


------ default
create table my_products (
 product_id        number,
 product_name      varchar2(100),
 created_on_1        timestamp(6)    default current_timestamp,
 created_on_2        timestamp(6)    default sysdate
);

insert into my_products (product_id,product_name) values ( 100, 'test1');
commit;
