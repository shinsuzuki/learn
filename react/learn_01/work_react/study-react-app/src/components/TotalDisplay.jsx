import { useState } from "react";
import { CounterApp } from "@/components/CounterApp";

export function TotalDisplay() {
  const [countA, setCountA] = useState(0);
  const [countB, setCountB] = useState(0);

  return (
    <div>
      <h2>total count: {countA + countB}</h2>

      <h2>total count</h2>
      <CounterApp count={countA} onIncrement={() => setCountA(countA + 1)} />
      <CounterApp count={countB} onIncrement={() => setCountB(countB + 1)} />
    </div>
  );
}
