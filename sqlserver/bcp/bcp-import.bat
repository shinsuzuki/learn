rem [MySample.dbo.customer]: テーブル名を指定
rem [in input.csv]:          入力CSVファイルを指定
rem [/S localhost]:          サーバーを指定
rem [/T]:                    Windows認証
rem [/c]:                    テキスト形式で出力
rem [/t ","]                 区切り文字を指定
bcp MySample.dbo.customer in input.csv /S localhost /T /c /t ","