rem [select...]:              テーブル名を指定
rem [queryout qoutput.csv]: 出力CSVファイルを指定
rem [/S localhost]:           サーバーを指定
rem [/T]:                     Windows認証
rem [/c]:                     テキスト形式で出力
rem [/t ","]                  区切り文字を指定
bcp "select * from MySample.dbo.customer where id between 2 and 4" queryout qoutput.csv /S localhost /T /c /t ","
