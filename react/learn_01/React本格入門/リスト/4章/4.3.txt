import { useState } from 'react';
import CounterApp from '../components/CounterApp';

function TotalDisplay() {
    // ①カウンターAとカウンターBの状態を管理（状態のリフトアップ）
    const [countA, setCountA] = useState(0); // カウンターA用
    const [countB, setCountB] = useState(0); // カウンターB用

    return (
        <div>
            {/* ②合計カウントを表示 */}
            <h2>合計カウント: {countA + countB}</h2>

            {/* ③子に状態と操作関数を渡す */}
            {/* ④子から呼び出せる「+1ボタンの動作」を親が用意 */}
            <CounterApp count={countA} onIncrement={() => setCountA(countA + 1)} />
            <CounterApp count={countB} onIncrement={() => setCountB(countB + 1)} />
        </div>
    );
}

export default TotalDisplay;
