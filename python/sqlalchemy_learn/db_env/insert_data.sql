-- SQLite
INSERT INTO item (id, name, memo, price, category_id) VALUES
(1, 'アクエリアス', 'スポーツドリング', 120, 1),
(2, 'ハンバーガー', 'マクドナルド', 80, 2),
(3, '爪切り', NULL, 1100, 3);

INSERT INTO item_category (id, name, memo) VALUES
(1, '飲料水', '飲み物'),
(2, '食品', '食べ物'),
(3, '生活用品', '生活用品');