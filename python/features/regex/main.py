import re


def main():
    # 正規表現の書き方
    targetAlp = "abcde"
    targetNum = "12345"

    print("====> re")
    if re.match(r"^[a-z]", targetAlp):
        print("alphabet ok.")
    if re.match(r"^[a-z]", targetNum):
        print("alphabet ng")

    print("====> re.compile")
    regex = re.compile(r"^[a-z]")
    if regex.match(targetAlp):
        print("alphabet ok")

    if regex.match(targetNum):
        print("alphabet ng")


if __name__ == "__main__":
    main()


# > python main.py
#
# ====> re
# alphabet ok.
# ====> re.compile
# alphabet ok
