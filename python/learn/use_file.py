# ======================================== ファイル
# f = open("test.txt", "w")
# f.write("test")
# f.close()

# ファイルに書き込み
lines = ["line1", "line2", "line3"]
with open("test.txt", "w", encoding="utf-8") as f:
    f.writelines("\n".join(lines))  # 改行する

# ファイルを読み込み（改行を削除し配列へ）
with open("test.txt", "r", encoding="utf-8") as f:
    lines = f.read().splitlines()
    print(lines)

