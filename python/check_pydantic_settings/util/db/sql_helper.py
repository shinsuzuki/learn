from settings import get_settings


def log_write():
    config = get_settings()
    print(f"log_write:{config .API_VERSION}")
