from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from schemas.memo import InsertAndUpdateMemoSchema, MemoSchema, ResponseSchema
import cruds.memo as memo_crud
import db

# ルーターを作成し、タグとURLパスのプレフィックスを設定
router = APIRouter(tags=["Memos"], prefix="/memos")

# ==================================================
# メモ用のエンドポイント
# ==================================================
# メモ新規登録のエンドポイント
@router.post("/", response_model=ResponseSchema)
async def create_memo(memo: InsertAndUpdateMemoSchema,
                    db: AsyncSession = Depends(db.get_dbsession)):
    try:
        # 新しいメモをデータベースに登録
        await memo_crud.insert_memo(db, memo)
        return ResponseSchema(message="メモが正常に登録されました")
    except Exception as e:
        # 登録に失敗した場合、HTTP 400エラーを返す
        raise HTTPException(status_code=400, detail="メモの登録に失敗しました。")

# メモ情報全件取得のエンドポイント
@router.get("/", response_model=list[MemoSchema])
async def get_memos_list(db: AsyncSession = Depends(db.get_dbsession)):
    # 全てのメモをデータベースから取得
    memos = await memo_crud.get_memos(db)
    return memos

# 特定のメモ情報取得のエンドポイント
@router.get("/{memo_id}", response_model=MemoSchema)
async def get_memo_detail(memo_id: int,
                    db: AsyncSession = Depends(db.get_dbsession)):
    # 指定されたIDのメモをデータベースから取得
    memo = await memo_crud.get_memo_by_id(db, memo_id)
    if not memo:
        # メモが見つからない場合、HTTP 404エラーを返す
        raise HTTPException(status_code=404, detail="メモが見つかりません")
    return memo

# 特定のメモを更新するエンドポイント
@router.put("/{memo_id}", response_model=ResponseSchema)
async def modify_memo(memo_id: int, memo: InsertAndUpdateMemoSchema,
                    db: AsyncSession = Depends(db.get_dbsession)):
    # 指定されたIDのメモを新しいデータで更新
    updated_memo = await memo_crud.update_memo(db, memo_id, memo)
    if not updated_memo:
        # 更新対象が見つからない場合、HTTP 404エラーを返す
        raise HTTPException(status_code=404, detail="更新対象が見つかりません")
    return ResponseSchema(message="メモが正常に更新されました")

# 特定のメモを削除するエンドポイント
@router.delete("/{memo_id}", response_model=ResponseSchema)
async def remove_memo(memo_id: int,
                    db: AsyncSession = Depends(db.get_dbsession)):
    # 指定されたIDのメモをデータベースから削除
    result = await memo_crud.delete_memo(db, memo_id)
    if not result:
        # 削除対象が見つからない場合、HTTP 404エラーを返す
        raise HTTPException(status_code=404, detail="削除対象が見つかりません")
    return ResponseSchema(message="メモが正常に削除されました")