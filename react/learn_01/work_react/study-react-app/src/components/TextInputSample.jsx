import { useState } from "react";

export function TextInputSample() {
  const [value, setValue] = useState("");

  const onChange = (e) => setValue(e.target.value);

  return (
    <div>
      <input value={value} onChange={onChange} />
      <p>value: {value}</p>
    </div>
  );
}
