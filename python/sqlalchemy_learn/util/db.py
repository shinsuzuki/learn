import os
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.orm import declarative_base

# ベースモデルを作成
Base = declarative_base()


def get_session():
    """セッション情報を返却"""
    # とりあえず、utilの下にDBファイル配置
    base_dir = os.path.dirname(__file__)

    # エンジンの作成
    url = "sqlite:///" + os.path.join(base_dir, "app.db")
    # print(f"url: {url}")
    engine = create_engine(url)

    # セッションオブジェクトの作成
    # DBと通信するセッションオブジェクトの作成
    # sqlite3におけるconnectionオブジェクトに近い
    Session = sessionmaker(bind=engine)
    session = Session()
    return session
