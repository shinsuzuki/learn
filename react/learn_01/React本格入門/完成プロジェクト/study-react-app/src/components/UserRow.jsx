function UserRow(props) {
  // 仮のデータは削除またはコメントアウト
  // const id = 1;
  // const name = "山田太郎";
  // const age = 33;

    // スタイルをJSオブジェクトで宣言
    const cellStyle = {
        border: "1px solid #222",
        padding: "8px",
        textAlign: "center"
    };

    return (
        <tr>
            <td style={cellStyle}>{props.id}</td>
            <td style={cellStyle}>{props.name}</td>
            <td style={cellStyle}>{props.age}</td>
        </tr>
    );
}

export default UserRow;