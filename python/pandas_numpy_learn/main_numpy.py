import numpy as np


def main():
    print(">> start numpy")
    # ========================================
    print("1次元配列を作成")
    a = np.array([1, 2, 3])
    print(a)

    print("2次元配列を作成")
    a = np.array([[1, 2, 3], [4, 5, 6]])
    print(a)

    print("配列を作成,形を変更")
    a = np.array([1, 2, 3, 4, 5, 6]).reshape(2, 3)  # reshape(縦,横)を指定
    print(a)

    print("一元配列に戻す")
    b = a.flatten()  # コピーを返す
    c = a.ravel()  # 参照を返す
    print(b)
    print(c)

    print("データタイプ")
    print(a.dtype)

    # ========================================
    print("<< end numpy")


if __name__ == "__main__":
    main()
