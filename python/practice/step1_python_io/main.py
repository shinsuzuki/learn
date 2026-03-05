import os
import shutil
from pathlib import Path


def main():
    print("--> start")

    # ========================================
    # file
    # ========================================
    # read file
    print("\n - read file -")
    with open("data/test.txt", "r", encoding="utf8") as rf:
        lines = rf.readlines()
        for line in lines:
            print(line, end="")  # print側の改行を消す

    # write file
    print("\n - write file -")
    with open("output/test.txt", "w", encoding="utf8") as wf:
        wf.writelines(lines)

    # ========================================
    # path
    # ========================================
    # sep
    print("\n - sep -")
    print(f"sep:[{os.sep}]")

    # path join
    print("\n - path join -")
    print(os.path.join(".", "data", "test.txt"))
    with open(os.path.join(".", "data", "test.txt"), "r", encoding="utf8") as rf:
        print(rf.read())

    # path split
    print("\n - path split -")
    (dir, file) = os.path.split("./data_a/data_b/test.txt")
    print(f"末尾以外のパス:{dir}, パスの末尾:{file}")

    print("\n<-- end")

    # カレンドディレクトリ
    print("\n - カレンドディレクトリ(pythonを実行したパス) -")
    print(f"current dir:{os.getcwd()}")

    # 絶対パスを取得
    print("\n - 絶対パスを取得 -")
    print(f"絶対パス:{os.path.abspath("./data")}")

    # パスの存在を確認
    print("\n - パスの存在を確認 -")
    print(f"パスの存在:{os.path.exists("./data")}")
    print(f"パスの存在:{os.path.exists("./data_xx")}")
    print(f"パスの存在:{os.path.exists("./data/test.txt")}")

    # パス直下の一覧を取得
    print("\n - パス直下の一覧を取得 -")
    print(os.listdir(path="."))

    # パスかファイルをチェック
    print("\n - パスかファイルをチェック -")
    print(f"isfile-file:{os.path.isfile("./data/test.txt")}")
    print(f"isfile-dir:{os.path.isfile("./data/")}")
    print(f"isdir-dir:{os.path.isdir("./data/")}")

    # 拡張子を取得
    print("\n - 拡張子を取得 -")
    (root, ext) = os.path.splitext("./data/test.txt")
    print(f"拡張子:{ext}")

    # ========================================
    # dir操作
    # ========================================
    # DIRを作成
    print("\n - DIRを作成 -")
    shutil.rmtree("./data1/data2/data3")
    os.makedirs("./data1/data2/data3")

    #  一旦消してからDIRをコピー
    print("\n - 一旦消してからDIRをコピー -")
    shutil.rmtree("./data3")
    shutil.copytree("./data", "./data3")

    # ========================================
    # Path
    # ========================================
    # 拡張子を指定したファイル一覧の取得
    print("\n - 拡張子を指定したファイル一覧の取得 -")
    files = Path("./")
    for file in files.glob("*.py"):
        print(f"file:{file}")

    # 拡張子を指定したファイル一覧の取得(再帰)
    print("\n - 拡張子を指定したファイル一覧の取得(再帰) -")
    files = Path("./")
    for file in files.rglob("*.txt"):
        print(f"file:{file}")

    # 拡張子を指定したファイル一覧の取得,除外DIRを指定(再帰)
    print("\n - 拡張子を指定したファイル一覧の取得,除外DIRを指定(再帰) -")
    exclude_dirs = {".venv"}  # 除外したいディレクトリ名
    files = Path("./")
    for file in files.rglob("*.txt"):
        if not any(ex in file.parts for ex in exclude_dirs):
            print(f"file:{file}")


if __name__ == "__main__":
    main()
