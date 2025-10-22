import asyncio

# 非同期でデータを取得するコルーチン
async def fetch_data():
    print("データ取得を開始します...")
    # ネットワーク遅延を想定
    await asyncio.sleep(4)
    print("データが取得されました!!! 「data:xyz」")

# 非同期で計算を実行するコルーチン
async def perform_calculation():
    print("計算を開始します...")
    # 計算の遅延をシミュレート
    await asyncio.sleep(2)
    print("計算が完了しました!!! 答え「12345」")

# メインコルーチン
async def main():
    print("データ取得と計算を開始する前")
    # fetch_data と perform_calculation を同時に実行
    await asyncio.gather(fetch_data(), perform_calculation())
    print("すべてのタスクが完了しました")

# メインコルーチンを実行する
asyncio.run(main())