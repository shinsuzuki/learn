import { useState } from 'react';

function HoverHint() {
    // マウスが乗っているかどうかの状態を管理する
    const [showHint, setShowHint] = useState(false);

    return (
        <>
            <div
                onMouseEnter={() => setShowHint(true)}
                onMouseLeave={() => setShowHint(false)}
                style={{ width: '200px', height: '100px', 
                    backgroundColor: 'yellowgreen' }}
            >
                ここにマウスを乗せると…
            </div>
            {showHint && (
                <div
                    style={{
                        position: 'absolute',
                        padding: '10px',
                        backgroundColor: 'yellow',
                        border: '1px solid blue'
                    }}
                >
                    ヒント：マウスを離すと消えます！
                </div>
            )}
        </>
    );
}

export default HoverHint;
