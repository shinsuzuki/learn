import { useRef, useImperativeHandle } from "react";
import { createPortal } from "react-dom";

export default function ResultModal({ ref, targetTime, remaingTime, onReset }) {
  const dialog = useRef();
  const userLost = remaingTime <= 0;
  const formattedRemaingTime = (remaingTime / 1000).toFixed(2);
  const score = Math.round((1 - remaingTime / (targetTime * 1000)) * 100);

  useImperativeHandle(ref, () => {
    return {
      open() {
        dialog.current.showModal();
      },
      close() {
        dialog.current.close();
      },
    };
  });

  return createPortal(
    <dialog ref={dialog} className="result-modal" onClose={onReset}>
      {userLost && <h2>Your lost</h2>}
      {!userLost && <h2>Your Score: {score}</h2>}
      <p>
        The target time was <strong>{targetTime} seconds.</strong>
      </p>
      <p>
        You stopped the timer with{" "}
        <strong>{formattedRemaingTime} seconds left.</strong>
      </p>
      {/* <form method="dialog" onSubmit={onReset}> */}
      <form method="dialog">
        <button>Close</button>
      </form>
    </dialog>,
    document.getElementById("modal"),
  );
}
