# ローカルのIISでReactを動かす

## プロジェクト作成（Vite）

    > npm create vite@latest react-sample --template react-ts
    > cd react-sample
    > npm install
    > npm run dev

ReactのAPP画面の表示を確認。


## Vite の base パス設定が必要な場合
もし IIS の仮想ディレクトリを /react-sample にしているなら、
Vite 側で base を設定しないと 404 になるケースがある。
変更しておくこと。

```
# vite.config.ts
export default defineConfig({
  base: '/react-sample/',
  plugins: [react()],
})

```


## 本番ビルド（IIS に置く用）
    > npm run build

distフォルダに出力されることを確認。
これを仮想ディレクトリに配置。


## IIS 用の web.config（SPA ルーティング対応）
React SPA を IIS で動かすには、Rewrite ルールが必要。
dist/web.config を作成して以下を入れる：

```
# dist/web.config
<?xml version="1.0" encoding="utf-8"?>
<configuration>
  <system.webServer>
    <rewrite>
      <rules>
        <rule name="React Routes" stopProcessing="true">
          <match url=".*" />
          <conditions logicalGrouping="MatchAll">
            <add input="{REQUEST_FILENAME}" matchType="IsFile" negate="true" />
            <add input="{REQUEST_FILENAME}" matchType="IsDirectory" negate="true" />
          </conditions>
          <action type="Rewrite" url="/index.html" />
        </rule>
      </rules>
    </rewrite>
  </system.webServer>
</configuration>

```


## IIS に配置して動作確認

- IIS マネージャーを開く
- Default Web Site → 右クリック → 仮想ディレクトリの追加
- エイリアス：react-sample
- 物理パス：dist/ を指定 
  - フォルダを作成、distフォルダを配置
   
    ```
        - 配置フォルダに IIS の読み取り権限を付与する
            C:\Users\shins\web_app を右クリック → プロパティ  
            → セキュリティ タブ → 編集

        - 以下のユーザーに「読み取り・実行」権限を付ける：
            - IIS_IUSRS
            - IUSR
            - （アプリプールが ApplicationPoolIdentity の場合） IIS AppPool\<アプリプール名>

        - 付ける権限
            - 読み取り
            - 読み取りと実行
            - フォルダーの一覧表示

        - 書き込みは不要。
    ```        

- ブラウザでアクセス
  - http://localhost/react-sample/


