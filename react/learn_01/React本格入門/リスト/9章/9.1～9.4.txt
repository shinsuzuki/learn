import { useState } from "react";

const API = "https://dog.ceo/api/breeds/image/random";

export default function DogImageApp() {
    // 画面に表示したい情報（状態）
    const [imageUrl, setImageUrl] = useState("");     // 画像URL
    const [loading, setLoading] = useState(false);    // 読み込み中フラグ
    const [error, setError] = useState("");           // エラーメッセージ

    // 犬画像を取得する関数
    // async: 「この中で await を使うよ」
    const fetchDog = async () => {
        // 初期状態
        setLoading(true);   // 読み込み中
        setError("");       // エラーはない

        try {
            // サーバーへ取りに行く（Promiseが返る）
            const res = await fetch(API);

            // データ取得判定
            if (!res.ok) {
                throw new Error(`HTTP ${res.status}`);
            }

            // JSONを取り出す（これもPromise）
            const data = await res.json();
            // 画像URLを状態に保存 → 画面が更新される
            setImageUrl(data.message);
        } catch (e) {
            // エラーを表示
            console.error(e);
            setError("画像の取得に失敗しました。もう一度お試しください。");
        } finally {
            // 読み込み中を解除
            setLoading(false);
        }
    };

    return (
        <div style={{ maxWidth: 480, margin: "2rem auto", textAlign: "center" }}>
            <h2>🐶 ランダム犬画像</h2>

            {/* ボタン押下でfetchDogを実行。読み込み中は押せない */}
            <button onClick={fetchDog} 
                disabled={loading} style={{ padding: "8px 16px" }}>
                {loading ? "取得中..." : "画像を取得"}
            </button>

            {/* エラーがあれば赤文字で表示 */}
            {error && <p style={{ color: "red" }}>{error}</p>}

            {/* 画像URLが入ったら表示 */}
            {imageUrl && (
                <div style={{ marginTop: "1rem" }}>
                    <img src={imageUrl} alt="random dog"
                    style={{ width: "300px", borderRadius: 8 }} />
                </div>
            )}
        </div>
    );
}