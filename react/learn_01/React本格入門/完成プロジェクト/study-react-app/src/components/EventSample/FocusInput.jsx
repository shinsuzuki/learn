import { useState } from 'react';

function FocusInput() {
    // フォーカス状態を管理するステート
    const [isFocused, setIsFocused] = useState(false);

    return (
        <div>
            <h3>名前を入力してください</h3>
            <input
                type="text"
                onFocus={() => setIsFocused(true)}
                onBlur={() => setIsFocused(false)}
                placeholder="ここに入力"
                style={{
                    padding: '8px',
                    border: '2px solid',
                    backgroundColor: isFocused ? 'lightgreen' : 'lightgray'
                }}
            />
        </div>
    );
}

export default FocusInput;
