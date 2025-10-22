import os
from sqlalchemy.ext.asyncio import create_async_engine
from models.memo import Base
import asyncio

# ==================================================
# DB作成＆テーブル作成
# ==================================================
# DBファイル作成
base_dir = os.path.dirname(__file__)
# データベースのURL
DATABASE_URL = 'sqlite+aiosqlite:///' + os.path.join(base_dir, 'memodb.sqlite')

# 非同期エンジンの作成
engine = create_async_engine(DATABASE_URL, echo=True)

# データベースの初期化
async def init_db():
    print("=== データベースの初期化を開始 ===")
    async with engine.begin() as conn:
        # 既存のテーブルを削除
        await conn.run_sync(Base.metadata.drop_all)
        print(">>> 既存のテーブルを削除しました。")
        # テーブルを作成
        await conn.run_sync(Base.metadata.create_all)
        print(">>> 新しいテーブルを作成しました。")

# スクリプトで実行時のみ実行
if __name__ == "__main__":
    asyncio.run(init_db())