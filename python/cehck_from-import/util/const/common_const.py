import enum

COMMON_VALUE_1 = "A"
COMMON_VALUE_2 = "B"


class UserRole(enum.Enum):
    """ユーザー権限を表す固定値のセット"""

    ADMIN = 1
    EDITOR = 2
    VIEWER = 3
    GUEST = 4


class AppConfig:
    class DataBase:
        Host = "loclahost"
        Port = 8080
