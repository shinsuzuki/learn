import sys


# コマンドラインサンプル
def main(argv):
    print("main start")

    for arg in argv:
        print(arg)

    print("main end")


if __name__ == "__main__":
    main(sys.argv[1:])  # 引数は1以降
