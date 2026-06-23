import { useState } from "react";

function ValidationForm() {
    // ステートの定義
    const [name, setName] = useState("");
    const [error, setError] = useState("");

    const handleSubmit = (e) => {
        // フォームのデフォルトの送信を防ぐ
        // これをしないとページがリロードされてしまう
        e.preventDefault();

        // ifで作成したバリデーション（必須チェックと文字数）
        if (name.trim() === "") {
            setError("※名前は必須です");
        } else if (name.length < 2) {
            setError("※2文字以上で入力してください");
        } else {
            setError(""); // エラーを消す
            alert(`送信された名前：${name}`);
        }
    };

    return (
        <form onSubmit={handleSubmit}>
            <input
                value={name}
                onChange={(e) => setName(e.target.value)}
                placeholder="名前を2文字以上で入力"
            />
            <p style={{ color: "red" }}>{error}</p>
            <button type="submit">送信</button>
        </form>
    );
}

export default ValidationForm;
