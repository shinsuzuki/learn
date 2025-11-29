from typing import List, cast, Optional
from fastapi import FastAPI, APIRouter, Depends
from pydantic import BaseModel
from sqlalchemy import or_
from sqlalchemy import select, update, Column
from sqlalchemy.orm import Session
from app.utils.db.database import get_dbsession
from app.models.departments_model import DepartmentsModel
from app.schemas.hoge.DepartmentsOut import DepartmentsOut
from app.schemas.hoge.DepartmentsListOut import DepartmentsListOut, Department
from app.schemas.hoge.DepartmentsQueryParams import DepartmentsQueryParams
from app.schemas.hoge.DepartmentsCreate import DepartmentCreate
from app.schemas.hoge.DepartmentsUpdate import DepartmentUpdate
from app.schemas.hoge.DepartmentsDelete import DepartmentsDelete
from app.schemas.common.MutationResponse import MutationResponse

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
    dept_list = db.execute(
        select(DepartmentsModel).where(DepartmentsModel.department_id == params.department_id)
    )

    response = DepartmentsOut(id=1, departments=cast(List[Department], dept_list.scalars().all()))

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
        dept = DepartmentsModel(**department.model_dump())
        db.add(dept)
        db.commit()
        db.refresh(dept)
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

        dept = (
            db.execute(
                select(DepartmentsModel).where(
                    DepartmentsModel.department_id == department.department_id
                )
            )
            .scalars()
            .first()
        )

        if dept:
            # castで対応
            dept.department_name = cast(Column[str], department.department_name)
            dept.location = cast(Column[str], department.location)
            db.commit()
            db.refresh(dept)
            return MutationResponse(status="success")
        else:
            return MutationResponse(status="failure", message="not found")

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

        dept = (
            db.execute(
                select(DepartmentsModel).where(
                    DepartmentsModel.department_id == department.department_id
                )
            )
            .scalars()
            .first()
        )

        if dept:
            db.delete(dept)
            db.commit()
            return MutationResponse(status="success")
        else:
            return MutationResponse(status="failure", message="not found")

    except Exception as e:
        db.rollback()
        print(f"exception: {e}")
        return MutationResponse(status="failure", message=str(e))


# ========================================================== employees
# ======================================
# 従業員
# ======================================
@router.get("/employees")
def get_employees():
    return {"message": "employees"}
