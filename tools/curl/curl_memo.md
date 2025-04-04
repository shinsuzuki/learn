# 環境

- Windows11
- コマンドプロンプト
- curl

## POST リクエスト

JSON ファイルを読み込み、POST リクエスト。

```cmd
> curl -X POST "https://httpbin.org/post" ^
 -H "Content-Type: application/json" ^
 -H "my-add: value1" ^
 -d @post_data.json ^
 -o post_result.txt
```

```cmd
> curl https://httpbin.org/post --json @post_data.json
```

## GET リクエスト。

```
> curl -X GET "https://httpbin.org/get" ^
-H "my-add1: valu1" ^
-H "my-add2: valu2"
```

```cmd
> curl https://httpbin.org/get
```

ヘッダをファイルから読み込みます。

```cmd
> curl -X GET "https://httpbin.org/get" -K my.curlrc
```

## ページを取得

```cmd
> curl https://example.com
> curl https://example.com:8000
```

## FTP サーバーからファイルを取得

```cmd
> curl ftp://ftp.example.com/README
```

## FTP サイトのディレクトリリストを取得

```cmd
> curl ftp://ftp:example.com
```

## FTPS サーバーからファイルを取得

```cmd
> curl ftps://files.are.example.com/secrets.txt
```

## リファラー

```cmd
> curl -e www.example.org http://www.example.com/
```
