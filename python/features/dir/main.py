import glob
import os
import shutil
import time
from pathlib import Path

# dirを作成
print("====> dirを作成")
if not Path("test").is_dir():
    Path.mkdir("test")

# dirを作成(階層あり)
if not Path("a/b/c").is_dir():
    Path("a/b/c").mkdir(parents=True)

# wait
time.sleep(2)

# 空のdirを削除できる
# Path("test").rmdir()

# dirを中身ごと削除
print("====> dirを削除")
shutil.rmtree("test")
shutil.rmtree("a")


# フラットのファイル一覧を取得
print("====> glob file only")
for file in glob.glob("./*"):
    if os.path.isfile(file):
        print(file)


# 階層のファイル一覧を取得
print("====> glob recursive")
files = glob.glob("./tmpdir/**/*.txt", recursive=True)
print(files)
