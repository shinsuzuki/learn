import Child from "./Child";

function Parent({ user }) {
    return (
        <div style={{ border: "3px solid red", padding: "10px" }}>
            <p>親コンポーネント</p>
            <Child user={user} />
        </div>
    );
}

export default Parent;
