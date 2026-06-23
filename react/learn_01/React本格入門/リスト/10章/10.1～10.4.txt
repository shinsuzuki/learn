// Material-UIのレイアウトとボタンコンポーネントをインポート
import { Box, Button, Stack } from '@mui/material';
// Material-UIのアイコンコンポーネントをインポート
import { Add, Delete, Edit } from '@mui/icons-material';

function ButtonExample() {
    return (
        // 全体のコンテナ：padding: 3で余白を設定
        <Box sx={{ p: 3 }}>
            <h2>ボタンの種類</h2>
            {/* Stackで横並び配置、間隔2、下マージン2 */}
            <Stack direction="row" spacing={2} sx={{ mb: 2 }}>
                {/* variant="contained": 塗りつぶしボタン（最も目立つ） */}
                <Button variant="contained">
                    標準ボタン
                </Button>
                {/* variant="outlined": 枠線ボタン（中程度の目立ち具合） */}
                <Button variant="outlined">
                    アウトラインボタン
                </Button>
                {/* variant="text": テキストボタン（最も控えめ） */}
                <Button variant="text">
                    テキストボタン
                </Button>
            </Stack>

            <h3>色の種類</h3>
            <Stack direction="row" spacing={2} sx={{ mb: 2 }}>
                {/* color="primary": テーマのプライマリカラー（青） */}
                <Button variant="contained" color="primary">
                    プライマリ
                </Button>
                {/* color="secondary": テーマのセカンダリカラー（ムラサキ） */}
                <Button variant="contained" color="secondary">
                    セカンダリ
                </Button>
                {/* color="error": エラー用の赤色 */}
                <Button variant="contained" color="error">
                    エラー
                </Button>
                {/* color="success": 成功用の緑色 */}
                <Button variant="contained" color="success">
                    成功
                </Button>
            </Stack>

            <h3>アイコン付きボタン</h3>
            <Stack direction="row" spacing={2}>
                {/* startIcon: ボタンの左側にアイコンを配置 */}
                <Button variant="contained" startIcon={<Add />}>
                    追加
                </Button>
                {/* color="warning": 警告用のオレンジ色 */}
                <Button variant="contained" startIcon={<Edit />} color="warning">
                    編集
                </Button>
                {/* Delete アイコンとエラー色の組み合わせ */}
                <Button variant="contained" startIcon={<Delete />} color="error">
                    削除
                </Button>
            </Stack>
        </Box>
    );
}

export default ButtonExample;
