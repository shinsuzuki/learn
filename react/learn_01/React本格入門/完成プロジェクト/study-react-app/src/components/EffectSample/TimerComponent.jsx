import { useEffect, useState } from 'react';

function TimerComponent() {
    const [seconds, setSeconds] = useState(0); // 秒数の状態

    useEffect(() => {
        console.log('⏰ タイマー開始！');

        const timer = setInterval(() => {
            setSeconds((prev) => prev + 1); // 毎秒＋1
            console.log("タイマーが実行中...");
        }, 1000);

        // クリーンアップ関数：タイマー停止
        return () => {
            clearInterval(timer);
            console.log('🧹 タイマーを止めました（クリーンアップ）');
        };
    }, []);

    return (
        <div>
            <h2>タイマー：{seconds} 秒</h2>
        </div>
    );
}

export default TimerComponent;
