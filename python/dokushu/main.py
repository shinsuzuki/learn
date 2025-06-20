# main.py
import sys

def greet(name: str) -> None:
    """指定された名前で挨拶を表示する"""
    print(f"Hello, {name}!")

def main():
    """メイン処理"""
    if len(sys.argv) > 1:
        name = sys.argv[1]
    else:
        name = "World"

    greet(name)

if __name__ == "__main__":
    main()
