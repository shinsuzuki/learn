import { Child } from "@/components/ContextSample/Child";

export function Parent() {
  return (
    <div style={{ border: "3px solid green", padding: "10px" }}>
      <p>親コンポーネント</p>
      <Child />
    </div>
  );
}
