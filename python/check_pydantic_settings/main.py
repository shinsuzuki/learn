from settings import get_settings
from util.db.sql_helper import log_write


def main():
    print("main")
    print(">> settings.Settings 1")
    config = get_settings()
    print(f"$config.DATABASE_URL: {config.DATABASE_URL}")
    print(f"$config.API_VERSION: {config.API_VERSION}")
    print(f"$config.MAX_WORKERS: {config.MAX_WORKERS}")
    print(f"$config.IS_DEBUG: {config.IS_DEBUG}")
    print(f"$config.APP_NAME: {config.APP_NAME}")

    print(">> settings.Settings 2")
    log_write()


if __name__ == "__main__":
    main()
