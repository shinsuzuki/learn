use MySample

-- 行ロック
-- 他のトランザクションから更新ができない
-- 他のトランザクションはSelectできる。※xlockの場合はSelectで値を取得できない！

begin tran

select * from
	customer with(updlock, rowlock) -- 更新ロック、行ロック
	where id = 2

commit tran