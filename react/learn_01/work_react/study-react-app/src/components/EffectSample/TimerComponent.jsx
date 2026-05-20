import { useState, useEffect } from "react";

export function TimerComponent() {
  const [seconds, setSeconds] = useState(0);

  // 初回のみ実行
  useEffect(() => {
    console.log("Timer開始");

    const timer = setInterval(() => {
      setSeconds((seconds) => seconds + 1);
      console.log("Timer実行中");
    }, 1000);

    return () => {
      clearInterval(timer);
      console.log("timerを終了しました");
    };
  }, []);

  return (
    <div>
      <h2>timer: {seconds}</h2>
    </div>
  );
}
