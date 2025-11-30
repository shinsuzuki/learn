from typing import List, cast, Optional, Tuple
from fastapi import FastAPI, APIRouter, Depends
from pydantic import BaseModel

from sqlalchemy import or_
from sqlalchemy import insert, update, select, delete
from sqlalchemy.engine import Result, CursorResult
from sqlalchemy.orm import Session
from app.utils.db.database import get_dbsession
from app.models.departments_model import DepartmentsModel
from app.models.employees_model import EmployeesModel
from app.schemas.hoge.DepartmentsCommon import Department
from app.schemas.hoge.DepartmentsOut import DepartmentsOut
from app.schemas.hoge.DepartmentsListOut import DepartmentsListOut
from app.schemas.hoge.DepartmentsQueryParams import DepartmentsQueryParams
from app.schemas.hoge.DepartmentsCreate import DepartmentCreate
from app.schemas.hoge.DepartmentsUpdate import DepartmentUpdate
from app.schemas.hoge.DepartmentsDelete import DepartmentsDelete
from app.schemas.common.MutationResponse import MutationResponse
from app.schemas.hoge.EmployeesCommon import Employees
from app.schemas.hoge.EmployeesListOut import EmployeesListOut

router = APIRouter(
    prefix="/hoge",
    tags=["hoge"],
)


# ======================================
# ルート用
# ======================================
@router.get("/")
def root():
    return {"message": "hoge:Hello World"}


# ========================================================== departments
# ======================================
# 部署を全て取得
# ======================================
@router.get("/departments_all")
def get_departments(db: Session = Depends(get_dbsession)) -> DepartmentsListOut:
    # クラスが違う場合はcastする
    dept_list = db.execute(select(DepartmentsModel))
    # dept_list = db.execute(select(DepartmentsModel).where(DepartmentsModel.department_id == 10))
    response = DepartmentsListOut(
        id=1, departments=cast(List[Department], dept_list.scalars().all())
    )

    return response


# ======================================
# IDにより部署を1件取得
# ======================================
@router.get("/departments_by_params")
def get_departments_by_params(
    params: DepartmentsQueryParams, db: Session = Depends(get_dbsession)
) -> DepartmentsOut:

    # クラスが違う場合はcastする
    stmt = select(DepartmentsModel).where(DepartmentsModel.department_id == params.department_id)
    result = db.execute(stmt)
    dept = result.scalar_one_or_none()
    # print(f"dept: {dept}")
    response = DepartmentsOut(id=1, department=cast(Department, dept))

    return response


# ======================================
# 部署を登録
# ======================================
@router.post("/departments")
def post_departments(
    department: DepartmentCreate, db: Session = Depends(get_dbsession)
) -> MutationResponse:

    try:
        print("insertを実行")

        # ------------------------------古いかもしれない
        # dept = DepartmentsModel(**department.model_dump())
        # db.add(dept)
        # db.commit()
        # db.refresh(dept)
        # return MutationResponse(status="success")

        # ------------------------------推奨の書き方
        stmt = insert(DepartmentsModel).values(
            department_id=department.department_id,
            department_name=department.department_name,
            location=department.location,
        )

        db.execute(stmt)
        db.commit()
        return MutationResponse(status="success")

    except Exception as e:
        db.rollback()
        return MutationResponse(status="failure", message=str(e))


# ======================================
# 部署を更新
# ======================================
@router.put("/departments")
def put_departments(
    department: DepartmentUpdate, db: Session = Depends(get_dbsession)
) -> MutationResponse:

    try:
        print("udpateを実行")

        # ------------------------------古いかもしれない
        # ①この取得の書き方もあり
        # dept = db.query(DepartmentsModel).filter_by(department_id=department.department_id).first()

        # ②こちらもOK
        # dept = (
        #     db.execute(
        #         select(DepartmentsModel).where(
        #             DepartmentsModel.department_id == department.department_id
        #         )
        #     )
        #     .scalars()
        #     .first()
        # )

        # if dept:
        #     # castで対応
        #     dept.department_name = cast(Column[str], department.department_name)
        #     dept.location = cast(Column[str], department.location)
        #     db.commit()
        #     db.refresh(dept)
        #     return MutationResponse(status="success")
        # else:
        #     return MutationResponse(status="failure", message="not found")

        # ------------------------------ 推奨の書き方
        try:
            stmt = (
                update(DepartmentsModel)
                .where(DepartmentsModel.department_id == department.department_id)
                .values(department_name=department.department_name)
            )

            # ステートメントの実行
            # result: Result = db.execute(stmt)  # これはrowcountでエラー
            # result: CursorResult = db.execute(stmt)   # これはrowcountでエラー
            result = cast(CursorResult, db.execute(stmt))  # これはOK
            db.commit()
            msg = f"{result.rowcount} 件のレコードが更新されました。"
            print(msg)
            return MutationResponse(status="success", message=msg)
        except Exception as e:
            # print("An exception occurred")
            return MutationResponse(status="failure", message=str(e))

    except Exception as e:
        db.rollback()
        return MutationResponse(status="failure", message=str(e))


# ======================================
# 部署を削除
# ======================================
@router.delete("/departments")
def delete_departments(
    department: DepartmentsDelete, db: Session = Depends(get_dbsession)
) -> MutationResponse:

    try:
        print("delteを実行")

        # ------------------------------ 古いかもしれない
        #
        # dept = (
        #     db.execute(
        #         select(DepartmentsModel).where(
        #             DepartmentsModel.department_id == department.department_id
        #         )
        #     )
        #     .scalars()
        #     .first()
        # )

        # if dept:
        #     db.delete(dept)
        #     db.commit()
        #     return MutationResponse(status="success")
        # else:
        #     return MutationResponse(status="failure", message="not found")

        # ------------------------------ 推奨の書き方
        stmt = delete(DepartmentsModel).where(
            DepartmentsModel.department_id == department.department_id
        )

        result = cast(CursorResult, db.execute(stmt))
        db.commit()
        msg = f"{result.rowcount} 件のレコードが削除されました。"
        print(msg)
        return MutationResponse(status="success", message=msg)

    except Exception as e:
        db.rollback()
        print(f"exception: {e}")
        return MutationResponse(status="failure", message=str(e))


# ========================================================== employees
# ======================================
# 従業員
# ======================================
@router.get("/employees_all")
def get_employees(db: Session = Depends(get_dbsession)) -> EmployeesListOut:

    # joinはおいておく
    return EmployeesListOut(id=1, employees=None)

    # stmt = select(EmployeesModel, DepartmentsModel).join(DepartmentsModel)
    # result = db.execute(stmt)
    # joined_data: List[Tuple[EmployeesModel, DepartmentsModel]] = result.all()
    # output_employees: List[EmployeeOut] = []

    # db.query(Item.id, ItemCategory.name.label("category_name"), Item.name)
    # .join(ItemCategory, Item.category_id == ItemCategory.id)
    # .all()

    # stmt = (
    #     # select(
    #     #     DepartmentsModel.department_name.label("部門名"),
    #     #     EmployeesModel.last_name.label("従業員名"),
    #     # )
    #     # .join(EmployeesModel, DepartmentsModel.department_id == EmployeesModel.department_id)
    #     # .order_by(DepartmentsModel.department_name, EmployeesModel.employee_id)
    #     select(DepartmentsModel, EmployeesModel)
    #     .join(EmployeesModel, DepartmentsModel.department_id == EmployeesModel.department_id)
    #     .order_by(EmployeesModel.employee_id)
    # )

    # print("------------------------------> before")
    # result = db.execute(stmt)
    # print(result)
    # joined_data: List[Tuple[EmployeesModel, DepartmentsModel]] = result.all()

    # print("------------------------------> after")
    # print(emp_list)

    # if emp_list:
    #     print(f"取得件数: {len(emp_list)} 件")

    #     for dept_name, emp_name in emp_list:
    #         print(f"  部門: {dept_name}, 従業員: {emp_name}")
    # else:
    #     print("結果が見つかりませんでした。")

    # response = EmployeesListOut(id=1, employees=cast(List[Employees], emp_list.scalars().all()))

    # return response

    # # クラスが違う場合はcastする
    # dept_list = db.execute(select(DepartmentsModel))
    # # dept_list = db.execute(select(DepartmentsModel).where(DepartmentsModel.department_id == 10))
    # response = DepartmentsListOut(
    #     id=1, departments=cast(List[Department], dept_list.scalars().all())
    # )

    # return response

    # return {"message": "employees"}
