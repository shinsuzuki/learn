// Material-UIのレイアウトと入力フィールドコンポーネントをインポート
import { Box, TextField, Stack } from '@mui/material';
// Reactのステート管理フックをインポート
import { useState } from 'react';

function TextFieldExample() {
    // 各入力フィールドの値を管理するステート
    const [name, setName] = useState('');        // 名前入力用
    const [email, setEmail] = useState('');      // メールアドレス入力用
    const [message, setMessage] = useState('');  // メッセージ入力用

    return (
        // 全体のコンテナ：padding: 3で余白を設定
        <Box sx={{ p: 3 }}>
            <h2>入力フィールドの例</h2>
            {/* 縦並びで要素を配置、間隔3 */}
            <Stack spacing={3}>
                {/* 標準的なテキスト入力フィールド */}
                <TextField
                    label="お名前"           // ラベル表示
                    fullWidth               // 幅いっぱいに表示
                    value={name}            // 現在の値をステートから取得
                    onChange={(e) => setName(e.target.value)}  // 入力時にステートを更新
                />
                {/* メールアドレス専用の入力フィールド */}
                <TextField
                    label="メールアドレス"
                    type="email"            // type="email"でメール入力に最適化
                    fullWidth
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                />
                {/* 複数行テキスト入力フィールド */}
                <TextField
                    label="メッセージ"
                    multiline               // 複数行入力を可能にする
                    rows={4}                // 初期表示行数を4行に設定
                    fullWidth
                    value={message}
                    onChange={(e) => setMessage(e.target.value)}
                />
            </Stack>
        </Box>
    );
}

export default TextFieldExample;
