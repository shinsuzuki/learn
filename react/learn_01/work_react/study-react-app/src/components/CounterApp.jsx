import { useState } from "react";

export function CounterApp({ count, onIncrement }) {
  // const [count, setCount] = useState(0);

  const handleClick = () => {
    // setCount(count + 1);
    onIncrement();
  };

  return (
    <div>
      <p>count: {count}</p>
      <button onClick={handleClick}>++。</button>
    </div>
  );
}
