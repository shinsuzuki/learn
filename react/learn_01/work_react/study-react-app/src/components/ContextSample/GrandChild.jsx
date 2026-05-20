import { useContext } from "react";
import { UserContext } from "@/components/ContextSample/UserContext";

export function GrandChild() {
  const user = useContext(UserContext);

  return (
    <div style={{ border: "3px solid green", padding: "10px" }}>
      <p>孫コンポーネント</p>
      <p>名前: {user.name}</p>
      <p>年齢: {user.age}</p>
      <p>趣味: {user.hobby}</p>
    </div>
  );
}
