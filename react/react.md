# Reactについて学ぶ

## 学習の準備

### プロジェクトを作成
基本的なプロジェクトを作成します。

``` 
> npm create vite@latest react-app -- --template react --no--rolldown
```

#### インポートのフルパスの設定
インポートのパスを絶対パスで指定するよう設定します。

```
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
// import path from "path"; // 追加（Node.jsの標準モジュール）
import { fileURLToPath, URL } from "url"; //

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      // "@": path.resolve(__dirname, "./src"),
      "@": fileURLToPath(new URL("./src", import.meta.url)),
    },
  },
});
```
