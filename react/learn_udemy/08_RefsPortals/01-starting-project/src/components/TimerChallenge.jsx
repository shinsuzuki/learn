import { useState, useRef } from "react";
import ResultModal from "./ResultModal";

export default function TimerChallenge({ title, targetTime }) {
  const timer = useRef();
  const resultModal = useRef();
  // const [timerStarted, setTimerStarted] = useState(false);
  // const [timerExpired, setTimerExpired] = useState(false);
  const [timeRemaining, setTimeRemaining] = useState(targetTime * 1000);
  const timerIsActivate =
    timeRemaining > 0 && timeRemaining < targetTime * 1000;

  if (timeRemaining <= 0) {
    clearInterval(timer.current);
    //setTimeRemaining(targetTime * 1000);
    resultModal.current.open();
  }

  function handleReset() {
    setTimeRemaining(targetTime * 1000);
  }

  function handleStart() {
    timer.current = setInterval(() => {
      setTimeRemaining((prevTimeRemaining) => prevTimeRemaining - 10);
    }, 10);
  }

  function handleStop() {
    resultModal.current.open();
    clearInterval(timer.current);
  }

  return (
    <>
      <ResultModal
        ref={resultModal}
        result="lost"
        targetTime={targetTime}
        remaingTime={timeRemaining}
        onReset={handleReset}
      />

      <section className="challenge">
        <h2>{title}</h2>
        {/* {timerExpired && <p>You lost!</p>} */}
        <p className="challenge-time">
          {targetTime} second {targetTime > 1 ? "s" : ""}
        </p>
        <p>
          <button onClick={timerIsActivate ? handleStop : handleStart}>
            {timerIsActivate ? "Stop" : "Start"} Challenge
          </button>
        </p>

        <p className={timerIsActivate ? "active" : undefined}>
          {timerIsActivate ? "Time is running..." : "Timer inactive"}
        </p>
      </section>
    </>
  );
}
