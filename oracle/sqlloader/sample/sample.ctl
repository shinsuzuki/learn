OPTIONS(SKIP=1)             -- オプション（ヘッダスキップを記述した）
LOAD DATA                   --
INFILE 'department.csv'     -- ロードするデータファイルを指定
BADFILE 'department.bad'    -- 拒否レコードが出力されるファイルを指定
APPEND                      -- 空でない表にデータをロードする場合に指定、空の表の場合はINSERTを指定
INTO TABLE DEPARTMENT       -- データと表の関係
FIELDS TERMINATED BY ","    -- 区切り文字指定
TRAILING NULLCOLS           -- レコードが存在しない場合はNULL
(
 ID,
 NAME
)