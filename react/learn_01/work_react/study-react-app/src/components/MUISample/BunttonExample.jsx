import { Box, Button, Stack } from "@mui/material";

import { Add, Delete, Edit } from "@mui/icons-material";

export function ButtonExample() {
  return (
    <Box sx={{ p: 3 }}>
      <h2>ボタンの種類</h2>
      <Stack direction="row" spacing={2} sx={{ mb: 2 }}>
        <Button variant="contained">標準ボタン</Button>
        <Button variant="outlined">枠線ボタン</Button>
        <Button variant="text">テキストボタン</Button>
      </Stack>

      <h2>ボタンのサイズ</h2>
      <Stack direction="row" spacing={2} sx={{ mb: 2 }}>
        <Button variant="contained" color="primary">
          プライマリ
        </Button>
        <Button variant="contained" color="secondary">
          セカンダリ
        </Button>
        <Button variant="contained" color="error">
          エラー
        </Button>
        <Button variant="contained" color="success">
          成功
        </Button>
      </Stack>

      <h2>アイコン付きボタン</h2>
      <Stack direction="row" spacing={2} sx={{ mb: 2 }}>
        <Button variant="contained" startIcon={<Add />}>
          追加
        </Button>
        <Button variant="contained" startIcon={<Edit />} color="warning">
          編集
        </Button>
        <Button variant="contained" startIcon={<Delete />} color="error">
          削除
        </Button>
      </Stack>
    </Box>
  );
}
