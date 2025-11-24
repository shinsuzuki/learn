from app_settings import get_settings
from util.db.sql_helper import log_write


def main():
    print("main")
    config = get_settings()
    print(f"config.db.host: {config.db.host}")

    print(">> settings.Settings 2")
    log_write()


if __name__ == "__main__":
    main()
