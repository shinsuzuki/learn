import { useParams } from "react-router-dom";

function UserDetail() {
    const { id } = useParams(); // ← URLの「:id」部分を取得

    return (
        <div>
            <h2>ユーザー詳細ページ</h2>
            <h3>👤ユーザーID: {id}のページ</h3>
        </div>
    );
}

export default UserDetail;
