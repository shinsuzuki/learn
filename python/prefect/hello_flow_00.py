from prefect import task, flow


# 文字列を整形するタスク
@task
def get_title(text: str) -> str:
    return text.strip().title()


# 文字列を逆順にして出力するタスク
@task
def hello(title_text: str):
    reversed_text = title_text[::-1]
    print(f"Hello, {title_text}! (reversed: {reversed_text})")


# フローを定義する
@flow
def hello_flow():
    # 実行する順番にタスクを呼び出す
    title_text = get_title(" prefect flow ")
    hello(title_text)


if __name__ == "__main__":
    hello_flow()
