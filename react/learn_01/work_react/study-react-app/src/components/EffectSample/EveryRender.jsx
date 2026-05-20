import { useEffect, useState } from "react";

export function EveryRender() {
  const [count, setCount] = useState(0);

  useEffect(() => console.log("EveryRender - 初期化"));

  return (
    <div>
      <p>count: {count}</p>
      <button onClick={() => setCount(count + 1)}>+</button>
    </div>
  );
}
