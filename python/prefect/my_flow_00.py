from prefect import task, flow


@task(log_prints=True)
def add(a, b):
    # print("start add")
    return a + b


@task(log_prints=True)
def display(a):
    # print("start display")
    print(f"display:{a}")


@flow
def flow_00():
    display(add(1, 2))


if __name__ == "__main__":
    flow_00()
