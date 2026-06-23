function UserCount(props) {
    const count = props.userCount;
    // // ユーザー数（仮の値）
    // const count = 3;   コメントにする

    // 最低限のスタイル
    const style = {
        border: "1px solid #222",
        padding: "8px",
        marginTop: "16px"
    };

    return (
        <div style={style}>
            ユーザー数：{count}人
        </div>
    );
}

export default UserCount;
