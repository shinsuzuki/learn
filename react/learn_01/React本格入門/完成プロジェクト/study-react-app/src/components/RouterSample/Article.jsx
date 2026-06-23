import { useParams } from "react-router-dom";

function Article() {
    // useParamsフックを使ってURLパラメータを取得
    // :category と :id の2つのパラメータを
    // 分割代入を利用して取得
    const { category, id } = useParams();

    return (
        <div>
            <h2>記事詳細ページ</h2>
            <h3>カテゴリ: {category}</h3>
            <p>記事ID: {id}</p>
        </div>
    );
}

export default Article;
