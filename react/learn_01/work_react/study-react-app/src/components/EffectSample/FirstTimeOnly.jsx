import { useState, useEffect } from "react";

export function FirstTimeOnly() {
  const [message, setMessage] = useState("");

  // 初回のみ実行
  useEffect(() => {
    console.log("FirstTimeOnly - 初期化");
    setMessage("Hello, React!");
  }, []);

  return <p>{message}</p>;
}
