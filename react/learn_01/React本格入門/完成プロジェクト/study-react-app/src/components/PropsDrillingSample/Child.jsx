import GrandChild from "./GrandChild";

function Child({ user }) {
    return (
        <div style={{ border: "3px solid blue", padding: "10px" }}>
            <p>子コンポーネント</p>
            <GrandChild user={user} />
        </div>
    );
}

export default Child;
