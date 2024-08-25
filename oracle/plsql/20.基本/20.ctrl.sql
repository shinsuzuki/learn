-- 制御
declare
  count_data number := 10;
  lp_count number := 0;
begin
  ---------------- if
  if count_data = 10 then
    dbms_output.put_line('count_data eq 10');
  elsif count_data = 20 then
    dbms_output.put_line('count_data eq 20');
  else
    dbms_output.put_line('count_data not 10 or 20');
  end if;

  ---------------- case文
  -- case文1(等価比較)
  case count_data
    when 10 then
      dbms_output.put_line('count_data eq 10');
    when 20 then
      dbms_output.put_line('count_data eq 20');
    else
      dbms_output.put_line('count_data not 10 or 20');
  end case;

  -- case文2(等価比較以外の条件式も指定可能)
  case
    when count_data <= 10 then
      dbms_output.put_line('count_data <= 10');
    when count_data <= 20 then
      dbms_output.put_line('count_data <= 20');
    else
      dbms_output.put_line('count_data > 20');
  end case;

  ---------------- 反復処理
  -- ループ制御 exit / exit when / continue when

  -- 反復処理1(loop)
  loop
    exit when lp_count >= 3;
    lp_count := lp_count + 1;
    dbms_output.put_line('loop-ok');
  end loop;

  -- 反復処理1(for-loop)
  for lp in 0..5 loop
    exit when lp >= 3;
    dbms_output.put_line('for-loop-ok');
  end loop;

  -- 反復処理1(while-loop)
  lp_count := 0;
  while lp_count < 3 loop
    lp_count := lp_count + 1;
    dbms_output.put_line('while-loop-ok');
  end loop;

  -- continue when
  for lp in 1..5 loop
    continue when lp > 3;
    dbms_output.put_line('continue-ok' || to_char(lp));
  end loop;

  ---------------- GOTO文
  goto label1;
    dbms_output.put_line('goto1');
    dbms_output.put_line('goto2');
  <<label1>>
    dbms_output.put_line('goto3');

  ---------------- NULL
  if lp_count < 0 then
    dbms_output.put_line('null: lp_count < 0');
  else
    -- NULLは何も処理しない
    NULL;
  end if;


end;
/
