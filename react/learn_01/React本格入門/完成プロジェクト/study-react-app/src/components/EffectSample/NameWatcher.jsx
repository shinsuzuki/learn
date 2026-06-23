import { useEffect, useState } from 'react';

function NameWatcher() {
    const [name, setName] = useState('');

    useEffect(() => {
        console.log(`名前が変わりました：${name}`);
    }, [name]); // nameが変わったときだけ実行

    return (
        <div>
            <input
                type="text"
                value={name}
                onChange={(e) => setName(e.target.value)}
                placeholder="名前を入力"
            />
        </div>
    );
}

export default NameWatcher;
