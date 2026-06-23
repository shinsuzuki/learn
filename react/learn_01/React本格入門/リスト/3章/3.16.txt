import { useState } from 'react';

function TextInputSample() {
    // ①ステートの初期値は空文字
    const [text, setText] = useState('');

    const handleChange = (event) => {
        // ②入力内容でステートを更新
        setText(event.target.value);
    };

    return (
        <div>
            <h2>テキスト入力フォーム</h2>
            {/* ③入力値　④イベント */}
            <input type="text" value={text} onChange={handleChange} />
            {/* ⑤表示 */}            
            <p>あなたが入力した文字：{text}</p>
        </div>
    );
}

export default TextInputSample;
