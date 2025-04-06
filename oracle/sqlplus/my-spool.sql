col now_time new_value v_now_time;
select to_char(sysdate, 'YYYYMMdd-HH24MISS') now_time from dual;
spool result_&v_now_time..txt;
select * from emp;
spool off;
