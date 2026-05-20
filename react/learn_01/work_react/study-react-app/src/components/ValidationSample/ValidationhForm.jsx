import { useState } from "react";

export function ValidationForm() {
  const [name, setName] = useState("");
  const [error, setError] = useState("");

  const handleSubmit = (e) => {
    e.preventDefault();

    if (name.trim() === "") {
      setError("名前は必須です。");
    } else if (name.length < 2) {
      setError("名前は2文字以上です。");
    } else {
      setError("");
      alert(`ようこそ${name}さん`);
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <input type="text" value={name} onChange={(e) => setName(e.target.value)} placeholder="input name..." />
      <p style={{ color: "red" }}>{error}</p>
      <button type="submit">submit</button>"
    </form>
  );
}
