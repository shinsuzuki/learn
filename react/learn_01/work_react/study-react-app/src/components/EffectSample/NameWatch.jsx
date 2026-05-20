import { useEffect, useState } from "react";

export function NameWatch() {
  const [name, seName] = useState("");

  useEffect(() => {
    console.log(`change name: ${name}`);
  }, [name]);

  return (
    <div>
      <input type="text" value={name} onChange={(e) => seName(e.target.value)} placeholder="name input" />
    </div>
  );
}
