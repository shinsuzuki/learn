import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# %matplotlib inline


def main():
    print("--> start")

    # 折れ線グラフ
    data = [2, 4, 6, 3, 5, 8, 4, 5]
    plt.plot(data)
    plt.show()

    print("\n<-- end")


if __name__ == "__main__":
    main()
