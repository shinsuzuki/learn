import { useState } from 'react';

// ①分割代入で受け取る
function CounterApp({ count, onIncrement }) {
    // propsで受け取るのでコメントアウト
    // const [count, setCount] = useState(0);

    const handleClick = () => {
        // ②ボタンがクリックされたときにカウントを1増やす
        onIncrement();
    };

    return (
        <div>
            {/* ③カウントの値を表示 */}
            <p>現在のカウント: {count}</p> 
            {/* ④クリックイベント */}
            <button onClick={handleClick}>+1する</button>
        </div>
    );
}

export default CounterApp;
