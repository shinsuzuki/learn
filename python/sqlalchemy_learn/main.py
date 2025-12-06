import os
import pprint
from sqlalchemy import or_, select, desc, insert, update, delete, func

from utils.db.database import get_dbsession
from models.department_model import Department
from models.employee_model import Employee


def main():
    os.system("cls")

    """メイン実行関数"""
    gen = get_dbsession()
    db = next(gen)

    # ============================================================ セレクト系を試す

    # ====================
    # 全取得
    # ====================
    print(">> 全取得")
    stmt = select(Employee).order_by(Employee.id)
    for row in db.execute(stmt):
        print(row)

    # ====================
    # 特定のカラムを取得
    # ====================
    print(">> 特定のカラムを取得")
    stmt = select(Employee.id, Employee.name).order_by(Employee.id)
    for row in db.execute(stmt):
        print(row)

    # ====================
    # Where取得
    # ====================
    print(">> Where取得")
    stmt = select(Employee.id, Employee.name, Employee.salary).where(Employee.salary > 70000)
    for row in db.execute(stmt):
        print(row)

    # ====================
    # 集計とグループ
    # ====================
    print(">> 集計とグループ")
    stmt = (
        select(
            # fmt: off
            Employee.job_title,
            func.avg(Employee.salary).label("avg_employee_salary")
            # fmt: on
        )
        .group_by(Employee.job_title)
        .order_by(Employee.job_title)
    )

    for row in db.execute(stmt):
        print(row)

    # ====================
    # 外部結合(最初にselectの項目に書いたものが基準、otuerjoinの第一引数に結合したいモデル・テーブルを指定)
    # ====================
    print(">> 外部結合")
    stmt = select(Employee.name, Department.name).outerjoin(Department, Department.id == Employee.department_id)

    for row in db.execute(stmt):
        print(row)

    # ====================
    # 副問合せ(平均,scalar_subquery)
    # ====================
    print(">> 副問合せ(scalar_subquery)")
    # 内部selectを作成
    avg_salary_sq = select(func.avg(Employee.salary)).scalar_subquery()

    # 作成したサブクエリーを設定
    stmt = select(Employee.name, Employee.salary).where(Employee.salary > avg_salary_sq).order_by(Employee.salary)
    for row in db.execute(stmt):
        print(row)

    # ====================
    # 副問合せ(IN句を利用する,subquery)
    # ====================
    print(">> 副問合せ(IN句を利用する)")
    tokyo_depts_sq = select(Department.id).where(Department.location == "Tokyo").scalar_subquery()

    stmt = (
        select(Employee.name, Department.name, Department.location)
        .outerjoin(Department, Department.id == Employee.department_id)
        .where(Department.id.in_(tokyo_depts_sq))
        .order_by(Employee.name)
    )
    for row in db.execute(stmt):
        print(row)


if __name__ == "__main__":
    main()
