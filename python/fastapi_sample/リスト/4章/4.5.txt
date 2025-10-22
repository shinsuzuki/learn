from datetime import datetime
from pydantic import BaseModel

# イベントを表すクラス
class Event(BaseModel):
    # イベント名、デフォルトは未定
    name: str = "未定"
    # 開催日時
    start_datetime: datetime
    # 参加者リスト、デフォルトは空リスト
    participants: list[str] = []

# ダミーデータ（外部からのイベントデータのつもり）
external_data = {
    "name": "FastAPI勉強会",
    "start_datetime": "2023-07-07 07:00",
    "participants": ["山田", "鈴木", "田中"]
}
# 辞書のアンパック
event = Event(**external_data)
print("イベント名：", event.name, type(event.name))
print("開催日時：", event.start_datetime, type(event.start_datetime))
print("参加者：", event.participants, type(event.participants))