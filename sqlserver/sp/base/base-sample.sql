use sampleDB
-------------------- 変数定義、設定
declare @val int
set @val = 100
select @val
declare @str varchar(100) = 'abc'
select @str

-------------------- バッチの終了
go

-------------------- print
declare @x1 int = 100
print 'test' + convert(varchar, @x1)

-------------------- 制御文:if else
declare @x2 int = 10
if (@x2 >= 10)
    begin
        print '10以上'
    end
else
    begin
        print '10未満'
    end

-------------------- 制御文:if exists / not exists
if exists (select * from emp)
    begin
        print 'データあり'
    end

if not exists (select * from emp where empno = 9999)
    begin
        print 'データなし'
    end

-------------------- 制御文:case
declare @msg varchar(20)
declare @x3 int
set @x3 = DATEPART(hour, getdate())
set @msg =
    case
        when @x3 < 12 then 'おはよう'
        when @x3 < 17 then 'こんにちは'
        else 'こんばんわ'
    end

print @msg

-------------------- 制御文:while
declare @x4 int = 1
while @x4 < 3
    begin
        print @x4
        --set @x4 = @x4 + 1
        set @x4 += 1
    end

-------------------- 制御文:goto
goto jumplbl
print '実行されない'

jumplbl:
print 'goto後'

-------------------- 制御文:waitfor delay
--waitfor delay '00:00:01'
--select * from emp

-------------------- 日付メソッド
select GETDATE()
select SYSDATETIME()
select YEAR(GETDATE())
select MONTH(GETDATE())
select DATEPART(year,GETDATE())
select DATEPART(month,GETDATE())
select DATEPART(day,GETDATE())
select DATEPART(hour,GETDATE())
select DATEPART(minute,GETDATE())
select DATEADD(day, 1, GETDATE())
select EOMONTH(GETDATE())
select DATEFROMPARTS('2016','2','3')
select FORMAT(GETDATE(), 'yyyy年MM月dd日')

-------------------- 変換関数
select CONVERT(char(4), DATEPART(year, GETDATE())) + '年'
select CAST(DATEPART(year, GETDATE()) as char(4)) + '年'
select CONVERT(varchar, GETDATE(), 111)

-------------------- ユーザー定義関数
go
--create function TRIM ( @param1 varchar(100) )
--returns varchar(100)
--as
--begin
-- return RTRIM(LTRIM(@param1))
--end

select dbo.TRIM('   abcdefg   ')

-------------------- select結果をローカル変数へ
declare @shimei varchar(50), @hiredate datetime
select @shimei = empname, @hiredate = hiredate from emp where empno = 1
select @shimei, @hiredate

-------------------- 動的SQL①
exec ('select * from emp')

declare @pempname varchar(10)= 'empname'
declare @pemp varchar(10)= 'emp'
exec ('select ' + @pempname + ' from ' + @pemp )

-------------------- 動的SQL②
declare @sql nvarchar(100), @x varchar(100)
select @x = 'emp'
select @sql = N'select * from ' + @x
exec sp_executesql @sql

--------------------- 動的SQL③
-- パラメータはwhere句のみ
sp_executesql
 N'SELECT * FROM emp WHERE empname LIKE @p1 AND sal > @p2'
,N'@p1 varchar(50), @p2 int'
, @p1 = '%田%'
, @p2 = 290000

-------------------- カーソル
declare @empno int
declare @empname varchar (50)
declare @sal int

declare empcur cursor for
select empno, empname, sal from emp

open empcur

fetch next from empcur into @empno, @empname, @sal

while(@@FETCH_STATUS = 0)
    begin
        print cast(@empno as varchar) + ' ' + @empname + ' ' + cast(isnull(@sal, 0) as varchar)
        fetch next from empcur into @empno, @empname ,@sal
    end

close empcur
deallocate empcur

select empno, empname, sal from emp

-------------------- ストアド作成
create procedure proc1
as
select * from emp where deptno = 20

exec proc1

-------------------- ストアドパラメーター①
alter procedure proc1
    @param1 int = null
as
    if @param1 is null
        begin
            print 'パラメータ未入力'
        return (0)
    end
    select * from emp where deptno = @param1

exec proc1 20

-------------------- ストアドパラメーター②
create procedure proc2
    @param1 varchar(100)
as
 exec ('select * from emp where empno in (' + @param1 + ')')

exec proc2 '1,2'

-------------------- ストアドパラメーター③
-- ユーザー定義テーブル
CREATE TYPE valuelist
AS TABLE ( val int )

CREATE PROCEDURE proc3
@v valuelist READONLY
AS
SELECT * FROM emp
WHERE empno IN ( SELECT val FROM @v )

declare @v as  valuelist
insert into @v (val)
 values(1),(5)

exec proc3 @v


-------------------- 出力パラメーター
create procedure proc4
 @param1 int,
 @param2 int OUTPUT
as
 select * from emp where deptno = @param1
 select @param2 = @@ROWCOUNT

declare @out1 int
exec proc4 10, @out1 OUTPUT
select @out1

-------------------- 出力パラメーター：identity
create table idTest
(a int identity(1,1)
,b int)

insert into idTest(b) values(111)
insert into idTest(b) values(222)
select * from idTest
select SCOPE_IDENTITY()

create procedure proc5
 @p1 int
,@p2 int output
as
 insert into idTest values(@p1)
 select @p2 = SCOPE_IDENTITY()

declare @out2 int
exec proc5 10, @out2 OUTPUT
select @out2
select * from idTest

-------------------- トランザクション
create table tranTest
(a int primary key,
 b int)

insert into tranTest values(1,777)
select * from tranTest

begin tran
insert into tranTest values(2,777)
commit tran
select * from tranTest

begin tran
insert into tranTest values(3,777)
rollback tran
select * from tranTest

-------------------- SET XACT_ABORT ON(制約違反エラー対応)
create PROCEDURE procTranTest
@param1 int
AS
SET XACT_ABORT ON
BEGIN TRAN
INSERT INTO tranTest VALUES ( @param1, 999 )
INSERT INTO tranTest VALUES ( 1, 999 )
COMMIT TRAN
SET XACT_ABORT OFF

EXEC procTranTest @param1 = 3
select * from tranTest

-------------------- 例外処理
create procedure procTranTest2
    @param1 int
as
begin try
    begin tran
        insert into tranTest values(@param1, 999)
        insert into trantest values(1,999)
    commit tran
end try
begin catch
    -- throwでエラーを上げることも可能
    rollback tran
    select ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_SEVERITY(),ERROR_LINE(), ERROR_PROCEDURE()
end catch

exec procTranTest2 @param1 = 4
select * from tranTest

-------------------- ユーザー定義エラー
-- [with log]でWindowsのイベント ログ（アプリケーション ログ）へエラーを記録
raiserror('error test1', 16, 1)
with log

-- エラーメッセージ登録（error_no:50001～2,147,483,647）
sp_addmessage 50001, 16, 'エラーテスト２！', 'us_english'
raiserror(50001, 16, 1)
SELECT * FROM sys.messages


