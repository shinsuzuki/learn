use MySample
-- ロック

-- nolock
-- with(nolock) : READ UNCOMMITTED と同様
select * from customer with(nolock)
