// import { defineConfig } from "vite";
// import react from "@vitejs/plugin-react";

// // https://vitejs.dev/config/
// export default defineConfig({
//   plugins: [react()]
// });

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
