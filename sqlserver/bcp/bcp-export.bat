rem [MySample.dbo.customer]: テーブル名を指定
rem [out output.csv]:        出力CSVファイルを指定
rem [/S localhost]:          サーバーを指定
rem [/T]:                    Windows認証
rem [/c]:                    テキスト形式で出力
rem [/t ","]                 区切り文字を指定
bcp MySample.dbo.customer out output.csv /S localhost /T /c /t ","
