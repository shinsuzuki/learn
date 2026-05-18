import { useState } from "react";

export function ToggleSwitch() {
  const [on, setOn] = useState(false);

  const handleClick = () => {
    setOn(!on);
  };

  return (
    <div>
      <h2>toggle switch</h2>
      <h2>switch status</h2>
      {on ? <p>on</p> : <p>off</p>}

      <button onClick={handleClick}>toggle</button>
    </div>
  );
}
