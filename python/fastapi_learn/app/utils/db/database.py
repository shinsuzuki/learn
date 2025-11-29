import oracledb
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, Session
from sqlalchemy.orm import declarative_base


# ==============================================================================
# database.py
# ==============================================================================
# ベースクラスの定義
Base = declarative_base()

# oracle接続情報
ORACLE_USER = "dbuser"
ORACLE_PASSWORD = "sasa"
ORACLE_CONNECT_STRING = "localhost:1521/orcl"
DATABASE_URL = f"oracle+oracledb://{ORACLE_USER}:{ORACLE_PASSWORD}@{ORACLE_CONNECT_STRING}"

# 同期セッションの設定
engine = create_engine(DATABASE_URL, echo=True)
session = sessionmaker(
    bind=engine,
    autocommit=False,
    autoflush=False,
    expire_on_commit=False,
)


# DBとのセッションを扱う関数
def get_dbsession():
    db: Session = session()

    try:
        print(">> db session yield.")
        yield db
    except Exception as e:
        db.rollback()
        print(f">> db session exception occurred. {e}")
        raise e
    finally:
        print("<< db session close.")
        db.close()
