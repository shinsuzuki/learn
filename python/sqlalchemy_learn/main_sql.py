import os

from utils.db.database import get_dbsession, select, insert, update, delete, func
from models.department_model import Department
from models.employee_model import Employee
from sqlalchemy.orm import Session
from sqlalchemy import text
from schemas.employee_schema import EmployeeSchema


def main():
    os.system("cls")

    """メイン実行関数"""
    # ============================================================ セレクト系を試す
    # FastAPIの依存性注入（DI）システムが内部的に with 句と同じ役割を果たしています。
    # FastAPIではWithは不要です

    with get_dbsession() as db:

        # ====================
        # 全取得
        # ====================
        print("========== 全件取得")
        results = db.execute(text("select * from employee"))
        for row in results.fetchall():
            print(f"{row.name}, {row.job_title}")
        # > Alice, Manager
        # > Bob, Sales Rep
        #       :

        # ====================
        # 全取得し、データクラスのリストへバインド（辞書を使用）
        # ====================
        print("========== 全取得し、データクラスのリストへバインド（辞書を使用）")
        results = db.execute(text("select * from employee"))

        # Resultから辞書に変換、アンパックしてバインド
        emp_list: list[EmployeeSchema] = [EmployeeSchema(**dict(emp)) for emp in results.mappings()]
        for emp in emp_list:
            print(f"{emp.id},{emp.name},{emp.job_title}")
        # > 101,Alice,Manager
        # > 102,Bob,Sales Rep
        #       :

        # ====================
        # 全取得し、データクラスのリストへバインド（model_validateを使用）
        # ====================
        print("========== 全取得し、データクラスのリストへバインド（model_validateを使用）")
        results = db.execute(text("select * from employee"))

        # model_validateを使用してバインド
        emp_list: list[EmployeeSchema] = [EmployeeSchema.model_validate(row) for row in results]
        for emp in emp_list:
            print(f"{emp.id},{emp.name},{emp.job_title}")
        # > 101,Alice,Manager
        # > 102,Bob,Sales Rep
        #       :

        # ====================
        # 1件取得し、データクラスへバインド（辞書を使用）
        # ====================
        print("========== 1件取得し、データクラスへバインド")
        result = db.execute(text("select * from employee where id = 101"))

        # Resultから辞書に変換し最初のデータを取得
        row = result.mappings().fetchone()

        if row:
            # 辞書に変換、アンパックでバインド
            emp_dict = dict(row)
            employee_instance = EmployeeSchema(**emp_dict)
            print(employee_instance.__dict__)
        else:
            print("データがない")
        # > {'id': 101, 'name': 'Alice', 'job_title': 'Manager', 'salary': 80000, 'hire_date': datetime.date(2020, 1, 1), 'department_id': 10}

        # ====================
        # 1件取得し、データクラスへバインド（model_validateを使用）
        # ====================
        print("========== 1件取得し、データクラスへバインド（model_validateを使用）")
        result = db.execute(text("select * from employee where id = 101"))

        row = result.first()
        if row:
            # model_validateによりバインド
            emp = EmployeeSchema.model_validate(row)
            print(f"{emp.id},{emp.name},{emp.job_title}")
        else:
            print("データがない")
        # > 101,Alice,Manager

        # ====================
        # 単一の列を取得
        # ====================
        print("========== 単一の列を取得")
        names = db.execute(text("select name from employee")).scalars().all()
        print(f"names: {names}")
        # > names: ['Alice', 'Bob', 'Charlie', 'David', 'Eve', 'Frank', 'Grace

        # ====================
        # 件数を取得
        # ====================
        print("========== 件数を取得")
        count = db.execute(text("select count(*) from employee")).scalar_one()
        print(f"count: {count}")
        # > count: 10


if __name__ == "__main__":
    main()
