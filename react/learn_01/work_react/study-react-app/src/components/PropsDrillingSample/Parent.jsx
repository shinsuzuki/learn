import { Child } from "@/components/PropsDrillingSample/Child";

export function Parent({ user }) {
  return (
    <div style={{ border: "3px solid green", padding: "10px" }}>
      <p>親コンポーネント</p>
      <Child user={user} />
    </div>
  );
}
