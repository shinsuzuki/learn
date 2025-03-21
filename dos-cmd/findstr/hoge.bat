@echo off

rem __findstr__
rem https://atmarkit.itmedia.co.jp/ait/articles/0412/18/news018.html#caution3
rem  注意1 - 正規表現での検索には「/r」「/c」オプションを指定すべき
rem  注意2 - findstrコマンドで使える正規表現は限られている
rem  注意3 - findstrコマンドが正しく検索できるのは、シフトJISのテキストに限られる。

rem filter
netstat -n | findstr 52512

