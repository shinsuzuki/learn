import { useState } from 'react';

function ToggleSwitch() {
    // ①スイッチの状態を管理するステート
    // 初期値はfalse（OFF）
    const [isOn, setIsOn] = useState(false);

    const handleClick = () => {
        // ②スイッチの状態を反転させる
        setIsOn(!isOn);
    };

    return (
        <div>
            <h2>トグルスイッチ</h2>
            {/* ③三項演算子を使って表示を切り替え */}
            <h2>スイッチの状態：{isOn ? 'ON' : 'OFF'}</h2>
            {/* ④イベント */}            
            <button onClick={handleClick}>
                {isOn ? 'OFFにする' : 'ONにする'}
            </button>
        </div>
    );
}

export default ToggleSwitch;
