from pydantic import BaseModel
from util.const.common_const import COMMON_VALUE_1
from util.const.common_const import UserRole
from util.const.common_const import AppConfig
from util.db.sql_helper import (
    get_test_query,
    get_common_value,
    get_util_const_common_const,
)


import json
import os


def main():

    # -----------------------------------------------------------
    # from,importの動作を確認
    # -----------------------------------------------------------
    print("execute main")
    print(f"COMMON_VALUE_1: {COMMON_VALUE_1}")
    print(f"get_test_query:{get_test_query()}")
    print(f"get_common_value:{get_common_value()}")
    print(f"get_util_const_common_const:{get_util_const_common_const()}")

    # -----------------------------------------------------------
    # 固定値、Enumを確認
    # -----------------------------------------------------------
    print(f"UserRole.ADMIN:{UserRole.ADMIN}")
    print(f"AppConfig.DataBase.Host:{AppConfig.DataBase.Host}")

    # -----------------------------------------------------------
    # JSON
    # -----------------------------------------------------------
    # --------------------
    # 1. JSON構造に対応するPydanticモデルの定義
    # --------------------
    # チームメンバーのJSONオブジェクトに対応するクラス
    class TeamMember(BaseModel):
        """チームメンバーの情報を保持するモデル"""

        name: str
        role: str

    # プロジェクトマネージャーのJSONオブジェクトに対応するクラス
    class Manager(BaseModel):
        """プロジェクトマネージャーの情報を保持するモデル"""

        id: int
        name: str
        email: str

    # トップレベルのJSONオブジェクト全体に対応するクラス
    class Project(BaseModel):
        """プロジェクト全体の情報を保持するルートモデル"""

        project_name: str
        version: str
        is_active: bool

        # ネストされたJSONオブジェクトは、定義したクラスで型を指定する
        manager: Manager

        # JSON配列は、List[クラス名]で型を指定する
        team_members: list[TeamMember]

    # --------------------
    # 2. サンプルJSONデータ
    # --------------------
    JSON_DATA = """
    {
        "project_name": "Project Alpha",
        "version": "1.0",
        "manager": {
            "id": 101,
            "name": "Tanaka Taro",
            "email": "tanaka@example.com"
        },
        "team_members": [
            {"name": "Sato Kenji", "role": "Developer"},
            {"name": "Yamada Hana", "role": "Designer"}
        ],
        "is_active": true
    }
    """

    # --------------------
    # 1. JSON文字列をPythonの辞書に変換
    # --------------------
    data_dict = json.loads(JSON_DATA)
    # 2. 辞書をPydanticモデルにバインド（自動で型チェックと変換が実行される）
    try:
        project_obj: Project = Project(**data_dict)
        print("✅ JSONデータをクラスに正常にバインドしました！")

        print("\n--- Project オブジェクトからのデータアクセス ---")
        print(f"プロジェクト名: {project_obj.project_name}")
        print(f"バージョン: {project_obj.version}")
        print(f"アクティブ: {'はい' if project_obj.is_active else 'いいえ'}")

        print("\n--- ネストされたデータへのアクセス ---")

        # マネージャー情報 (Managerクラスのオブジェクト)
        print(f"マネージャー名: {project_obj.manager.name}")
        print(f"マネージャーID: {project_obj.manager.id}")

        print("\n--- リスト（配列）データの反復処理 ---")

        # チームメンバー情報 (List[TeamMember]のリスト)
        print("チームメンバーリスト:")
        for member in project_obj.team_members:
            print(f"  - 名前: {member.name}, 役割: {member.role}")

    except Exception as e:
        print(f"🔴 JSONデータのバインド中にエラーが発生しました: {e}")

    # オブジェクトをJSONへ
    #  print(project_obj.model_dump_json())


if __name__ == "__main__":
    main()
