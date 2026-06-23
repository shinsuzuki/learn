import { useContext } from "react";
import UserContext from "./UserContext";

function GrandChild() {
    // Contextから直接値を取得
    const user = useContext(UserContext);

    return (
        <div style={{ border: "3px solid green", padding: "10px" }}>
            <p>孫コンポーネント：こんにちは、{user.name}！</p>
            <p>年齢：{user.age}</p>
            <p>趣味：{user.hobby}</p>
        </div>
    );
}

export default GrandChild;
