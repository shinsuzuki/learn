# 1. 同期処理
# 同期処理は、タスクを順番に一つずつ実行する方法
# 一つのタスクが終わるまで、次のタスクは待機
import time

# 処理関数
def sync_task(name):
    print(f"{name} タスク開始")
    time.sleep(2) # タスクの実行（2秒待機）
    print(f"{name} タスク終了")

# 処理をまとめた関数
def run_sync_tasks():
    sync_task("タスク1")
    sync_task("タスク2")
    sync_task("タスク3")

print("同期処理の例：")
run_sync_tasks()

# 2. 非同期処理
# 非同期処理は、複数のタスクを同時に開始し、
# 完了を待たずに次のタスクに進む
import asyncio

# 非同期：処理関数
async def async_task(name):
    print(f"{name} タスク開始")
    await asyncio.sleep(2) # 非同期的な待機（他のタスクが実行可能）
    print(f"{name} タスク終了")

# 非同期：処理をまとめた関数
async def run_async_tasks():
    await asyncio.gather(
        async_task("タスクA"),
        async_task("タスクB"),
        async_task("タスクC")
    )

print("\n非同期処理の例：")
asyncio.run(run_async_tasks())