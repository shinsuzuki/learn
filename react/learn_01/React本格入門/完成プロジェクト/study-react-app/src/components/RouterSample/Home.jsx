import { useNavigate } from "react-router-dom";

export default function Home() {
    // ナビゲーション用フック
    const navigate = useNavigate();

    return (
        <div>
            <h2>🏠ホームページ</h2>
            {/* ボタンを押すと About ページへ移動 */}
            <button onClick={() => navigate("/about")}>Aboutへ移動</button>
        </div>
    );
}
