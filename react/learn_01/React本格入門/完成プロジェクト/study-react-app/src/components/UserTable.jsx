import UserRow from "./UserRow";

function UserTable(props) {
    // テーブル全体のスタイル
    const tableStyle = {
        borderCollapse: "collapse", // セルの境界線
        width: "100%",              // テーブルの横幅を100%
        margin: "auto"              // テーブルを中央に配置
    };

    // ヘッダー行（見出しセル）のスタイル
    const thStyle = {
        border: "1px solid #222",   // 枠線をつける
        padding: "8px",             // セルの内側に余白をつける
        background: "#c8e6c9"       // ヘッダーの背景色を薄い緑色
    };

    // ユーザーデータの配列：コメントアウトしてpropsから受け取るように変更
    // const users = [
    //   { id: 1, name: "山田太郎", age: 33 },
    //   { id: 2, name: "佐藤花子", age: 28 }
    // ];

    return (
        <table style={tableStyle}>
        <thead>
            <tr>
            <th style={thStyle}>ID</th>
            <th style={thStyle}>名前</th>
            <th style={thStyle}>年齢</th>
            </tr>
        </thead>
        <tbody>
            {props.users.map((user) => (
                <UserRow
                    key={user.id}        // key設定は、繰り返し表示のときのReactルール
                    id={user.id}         // propsとして渡す
                    name={user.name}
                    age={user.age}
                />
                ))}
            </tbody>
        </table>
    );
}

export default UserTable;
