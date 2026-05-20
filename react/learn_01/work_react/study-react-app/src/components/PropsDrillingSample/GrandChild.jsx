export function GrandChild({ user }) {
  return (
    <div style={{ border: "3px solid green", padding: "10px" }}>
      <p>孫コンポーネント: {user.name} </p>
      <p>年齢: {user.age}</p>
      <p>趣味: {user.hobby}</p>
    </div>
  );
}
