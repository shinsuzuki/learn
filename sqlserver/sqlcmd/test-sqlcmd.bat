rem --------------------------------------------------
rem [-E]:               Windows認証を指定
rem [-S]:               サーバーを指定
rem [-d pubs]:          DBを指定
rem [-h-1]:             ヘッダを非表示
rem [-s,]:              カンマ区切り
rem [-W]:               余計な余白を削除
rem [-i test.sql]:      処理するSQLファイル
rem [-o output.txt]:    結果ファイル
rem --------------------------------------------------
sqlcmd -E -S localhost -d pubs -s, -W -h-1 -i test.sql -o output.txt
