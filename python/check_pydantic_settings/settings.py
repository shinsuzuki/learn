from pydantic import Field
from pydantic_settings import BaseSettings, SettingsConfigDict
import os


def get_settings():
    return Settings()


class Settings(BaseSettings):
    """
    アプリケーション全体の設定を保持するモデル。
    """

    # ----------------------------------------
    # 設定値を定義
    # ----------------------------------------
    # データベース設定
    DATABASE_URL: str = "none"

    # API設定
    APP_NAME: str = ""
    API_VERSION: str = Field(default="v1.0", description="APIのバージョン")
    MAX_WORKERS: int = Field(default=4, description="処理に使用するワーカースレッドの最大数")
    IS_DEBUG: bool = Field(default=True, description="デバッグモードの有効/無効")

    # Pydantic Settings v2 の設定メタクラス
    model_config = SettingsConfigDict(
        # 環境変数[EXECUTE_TYPE]により、.env.(local,development,production)を
        env_file=[".env.base", f".env.{os.environ.get('EXECUTE_TYPE', 'local')}"],
        # 環境変数名の大文字小文字を区別しない
        case_sensitive=False,
        # 環境変数が設定ファイルよりも優先されることを明示
        env_nested_delimiter="__",
    )
