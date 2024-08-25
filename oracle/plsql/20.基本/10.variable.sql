-- 変数
declare
    -- 変数
    point number := 0;
    user_name varchar2(10) default 'scotto';
    -- 定数
    MAX_VALUE constant number := 100;
begin
    point := 10;
    dbms_output.put_line(point);
    point := point + 10;
    dbms_output.put_line(point);
    dbms_output.put_line(user_name);

    dbms_output.put_line(MAX_VALUE);
end;
/
