import Child from "./Child";

function Parent() {
    return (
        <div style={{ border: "3px solid red", padding: "10px" }}>
            <p>親コンポーネント</p>
            <Child />
        </div>
    );
}

export default Parent;