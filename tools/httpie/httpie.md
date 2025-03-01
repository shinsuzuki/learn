# 環境

- Windows11
- コマンドプロンプト
- httpie

## get

```
> http GET "https://httpbin.org/get?name=sato&age=30"
```

## post

JSON ファイルを読み込み、リクエスト。

```
> http POST https://httpbin.org/post < post_data_del-utf8-bom.json
```
