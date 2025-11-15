class User:
    def __init__(self, name: str, password: str):
        self.name = name
        self.password = password

    # @property
    # def name(self) -> str:
    #     return self.name


def join_string(s1: str, s2: str) -> str:
    """
    文字列を結合する関数

    Args:
        s1 (str): 文字①
        s2 (str): 文字②

    Returns:
        str: 結合した文字列
    """
    return s1 + s2


def main():
    print(">> start")
    user = User("Alice", "SecretPassword")
    print(f"{user.name}/{user.password}")

    user_dic = {
        "name": user.name,
        "password": user.password,
    }

    user2 = User(**user_dic)
    print(f"{user2.name}/{user2.password}")

    print(join_string("Hello, ", "World!"))

    print(">> end")


if __name__ == "__main__":

    main()
