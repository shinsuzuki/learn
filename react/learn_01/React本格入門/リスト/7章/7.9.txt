import { useNavigate } from "react-router-dom";

export default function Contact() {
    // ナビゲーション用フック
    const navigate = useNavigate();

    return (
        <div>
            <h2>📞お問い合わせ</h2>
            {/* ボタンを押すと Home ページへ移動 */}
            <button onClick={() => navigate("/")}>Homeへ移動</button>
        </div>
    );
}
