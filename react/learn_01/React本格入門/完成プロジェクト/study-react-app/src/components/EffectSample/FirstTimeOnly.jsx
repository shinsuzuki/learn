import { useEffect, useState } from 'react';

function FirstTimeOnly() {
    const [message, setMessage] = useState('');

    useEffect(() => {
        console.log('これは最初の1回だけ実行されます');
        setMessage('ようこそ！');
    }, []); // 空配列 = 最初の1回だけ

    return <p>{message}</p>;
}

export default FirstTimeOnly;
