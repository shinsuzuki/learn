import { useState } from 'react';

function FormApp() {
    // ① 入力内容を保存するステート（名前とメール）
    const [formData, setFormData] = useState({
        username: '',
        usermail: ''
    });

    // ② 登録されたデータ一覧
    const [submittedList, setSubmittedList] = useState([]);

    // ③ 入力欄の変化に応じてステートを更新
    const handleChange = (e) => {
        const { name, value } = e.target;

        // 既存の値を保ちつつ、変更された項目だけを上書き
        setFormData({
            ...formData,
            [name]: value
        });
    };

    // ④ フォーム送信時の処理
    const handleSubmit = (e) => {
        e.preventDefault(); // ページのリロードを防ぐ

        // 入力内容をリストに追加
        setSubmittedList([...submittedList, formData]);

        // 入力欄をリセット
        setFormData({ username: '', usermail: '' });
    };

    return (
        <div>
            <h2>ユーザー登録フォーム</h2>
            <form onSubmit={handleSubmit}>
                <div>
                <label>名前：</label>
                <input
                    type="text"
                    name="username"
                    value={formData.username}
                    onChange={handleChange}
                    required
                />
                </div>
                <div>
                <label>メール：</label>
                <input
                    type="email"
                    name="usermail"
                    value={formData.usermail}
                    onChange={handleChange}
                    required
                />
                </div>
                <button type="submit">登録</button>
            </form>
            
            <h3>登録されたユーザー一覧</h3>
            <ul>
                {submittedList.map((user, index) => (
                <li key={index}>
                    {user.username}（{user.usermail}）
                </li>
                ))}
            </ul>
        </div>
    );
}

export default FormApp;
