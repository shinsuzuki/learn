import { useEffect, useState } from 'react';

function EveryRender() {
    const [count, setCount] = useState(0);

    useEffect(() => {
        console.log('毎回レンダリングされるたびに実行されます！');
    });

    return (
        <div>
            <p>カウント: {count}</p>
            <button onClick={() => setCount(count + 1)}>+1</button>
        </div>
    );
}

export default EveryRender;
