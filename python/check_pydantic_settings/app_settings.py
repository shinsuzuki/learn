from pydantic import Field
from pydantic_settings import BaseSettings, SettingsConfigDict
import os
import pprint


class ServerConfig(BaseSettings):
    """サーバー接続設定"""

    host: str = "127.0.0.1"
    port: int = 8080
    user_id: str = "xxxx"

    # 環境変数プレフィックスを 'SERVER_' に設定
    model_config = SettingsConfigDict(env_prefix="SERVER_", case_sensitive=True)


class DbConfig(BaseSettings):
    """DB接続設定"""

    host: str = "localhost"
    port: int = 5432
    user: str = "testuser"
    password: str = Field(default="", description="DBのパスワード")

    # 環境変数プレフィックスを 'DB_' に設定
    model_config = SettingsConfigDict(env_prefix="DB_", case_sensitive=True)


class AppSettings(BaseSettings):
    """
    アプリケーション全体の設定を保持するモデル。
    """

    # ----------------------------------------
    # 設定値を定義
    # ----------------------------------------
    # サーバー情報
    server: ServerConfig = ServerConfig()

    # データベース設定
    db: DbConfig = DbConfig()

    # API設定
    app_name: str = ""
    api_version: str = Field(default="v1.0", description="APIのバージョン")
    max_workers: int = Field(default=4, description="処理に使用するワーカースレッドの最大数")
    is_debug: bool = Field(default=True, description="デバッグモードの有効/無効")

    # Pydantic Settings v2 の設定メタクラス
    model_config = SettingsConfigDict(
        # 環境変数[EXECUTE_TYPE]により、.env.(local,development,production)を読み込む
        env_file=[".env.base", f".env.{os.environ.get('EXECUTE_TYPE', 'local')}"],
        # 環境変数名の大文字小文字を区別しない
        case_sensitive=False,
        # 環境変数が設定ファイルよりも優先されることを明示
        env_nested_delimiter="__",
    )


_settings_instance: AppSettings | None = None


def get_settings() -> AppSettings:
    global _settings_instance

    # 初回アクセス時のみロード処理を実行
    if _settings_instance is None:
        _settings_instance = AppSettings()

        #
        print("<app_settings>")
        pprint.pprint(_settings_instance.model_dump(), indent=2, depth=3)

    return _settings_instance
