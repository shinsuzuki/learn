import pandas as pd
import numpy as np
from sqlalchemy import create_engine


def main():
    print("--> start main sql\n")

    # oracle接続情報
    ORACLE_USER = "dbuser"
    ORACLE_PASSWORD = "sasa"
    ORACLE_HOST = "localhost"
    ORACLE_PORT = "1521"
    ORACLE_SERVICE = "orcl"
    DATABASE_URL = f"oracle+oracledb://{ORACLE_USER}:{ORACLE_PASSWORD}@{ORACLE_HOST}:{ORACLE_PORT}/{ORACLE_SERVICE}"

    # DBから値を取得
    engine = create_engine(DATABASE_URL, echo=False)
    df = pd.read_sql("select * from employee", engine)
    print(df)

    #      id     name    job_title  salary  hire_date  department_id
    # 0   101    Alice      Manager   80000 2020-01-01           10.0
    # 1   102      Bob    Sales Rep   50000 2021-05-15           10.0
    # 2   103  Charlie    Sales Rep   52000 2022-10-10           10.0
    # 3   201    David     Engineer   75000 2019-03-20           20.0
    # 4   202      Eve     Engineer   75000 2023-07-07           20.0
    # 5   203    Frank   Technician   40000 2024-01-01           20.0
    # 6   301    Grace     Director  120000 2018-11-05           30.0
    # 7   302    Heidi    Assistant   35000 2023-09-25           30.0
    # 8   401     Ivan  Coordinator   60000 2024-05-01           40.0
    # 9   501     Jack         Temp   30000 2024-10-01            NaN
    # 10  901      AAA      Manager   80000 2025-01-01           10.0
    # 11  902      BBB    Sales Rep   50000 2021-05-15           10.0
    # 12  903      CCC    Sales Rep   52000 2022-10-10           10.0
    # 13  904      DDD     Engineer   75000 2019-03-20           20.0

    print("\n<-- end main sql")


if __name__ == "__main__":
    main()
