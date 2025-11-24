from app_settings import get_settings


def log_write():
    config = get_settings()
    print(f"log_write:{config.api_version}")
