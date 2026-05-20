import { GrandChild } from "@/components/ContextSample/GrandChild";

export function Child() {
  return (
    <div style={{ border: "3px solid green", padding: "10px" }}>
      <p>子コンポーネント</p>
      <GrandChild />
    </div>
  );
}
