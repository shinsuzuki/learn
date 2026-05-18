import { defineConfig } from "vite"
import react from "@vitejs/plugin-react"
import path from "path" // 追加（Node.jsの標準モジュール）

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
  },
})
