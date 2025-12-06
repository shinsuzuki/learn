import oracledb
from typing import Generator
from contextlib import contextmanager
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, Session
from sqlalchemy import (
    select,
    insert,
    update,
    delete,
    desc,
    func,
)


# ==============================================================================
# database.py
# ==============================================================================
# oracle接続情報
ORACLE_USER = "dbuser"
ORACLE_PASSWORD = "sasa"
ORACLE_CONNECT_STRING = "localhost:1521/orcl"
ORACLE_HOST = "localhost"
ORACLE_PORT = "1521"
ORACLE_SERVICE = "orcl"
DATABASE_URL = f"oracle+oracledb://{ORACLE_USER}:{ORACLE_PASSWORD}@{ORACLE_HOST}:{ORACLE_PORT}/{ORACLE_SERVICE}"

# 同期セッションの設定
engine = create_engine(DATABASE_URL, echo=True)  # echoTrueにしてSQLを出力

db_session = sessionmaker(
    bind=engine,
    autocommit=False,
    autoflush=False,
    expire_on_commit=False,
)


# DBとのセッションを扱う関数
@contextmanager  # << 必要
def get_dbsession() -> Generator[Session, None, None]:

    # db: Session = session()
    db: Session = db_session()

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
