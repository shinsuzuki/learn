import os
from sqlalchemy import or_
from models.item import Item
from models.item_category import ItemCategory
from util.db import get_session


def main():
    """メイン実行関数"""
    db = get_session()

    # -------------------- 全件取得
    for item in db.query(Item).all():
        print(item.item_info)

    # -------------------- 条件(fiter_by)
    item = db.query(Item).filter_by(name="爪切り").first()
    print(item.name)

    # -------------------- 条件(fiter_by, and)
    item = db.query(Item).filter_by(name="爪切り", price=1100).first()
    print(item.name)

    # -------------------- 比較(filter)
    items = db.query(Item).filter(Item.price < 1000)
    for item in items:
        print(item.name)

    # -------------------- IN(filter)
    items = db.query(Item).filter(Item.price.in_([120, 1100]))
    for item in items:
        print(item.name)

    # -------------------- LIKE(filter)
    item = db.query(Item).filter(Item.name.like("%エリア%")).first()
    print(item.name)

    # -------------------- OR(fitler)
    items = db.query(Item).filter(or_(Item.id == 1, Item.id == 3))
    for item in items:
        print(item.name)

    # -------------------- OR(fitler)
    items = db.query(Item).filter(or_(Item.price.between(30, 200)))
    for item in items:
        print(item.name)

    # -------------------- Order_By(昇順)
    items = db.query(Item).order_by(Item.price.desc())
    for item in items:
        print(item.item_info)

    # -------------------- Order_By(降順)
    items = db.query(Item).order_by(Item.price.asc())
    for item in items:
        print(item.item_info)

    # -------------------- 追加
    addItem = Item(name="新商品", price=500, memo="新商品のメモ", category_id=4)
    db.add(addItem)
    db.commit()
    for item in db.query(Item).order_by(Item.id.desc()):
        print(item.item_info)

    # -------------------- 複数追加
    addItems = [
        Item(name="複数商品1", price=150, memo="複数商品のメモ1", category_id=2),
        Item(name="複数商品2", price=250, memo="複数商品のメモ2", category_id=3),
    ]
    db.add_all(addItems)
    db.commit()
    for item in db.query(Item).order_by(Item.id.desc()):
        print(item.item_info)

    # -------------------- 更新
    updateItem = db.query(Item).filter_by(name="複数商品1").first()
    updateItem.memo += updateItem.memo + "(更新済み)"
    db.commit()
    for item in db.query(Item).all():
        print(item.item_info)

    # -------------------- 削除
    db.query(Item).filter_by(name="複数商品2").delete()
    db.commit()
    for item in db.query(Item).all():
        print(item.item_info)

    # -------------------- トランザクション制御
    try:
        updateItem = db.query(Item).filter_by(name="複数商品1").first()
        updateItem.memo = updateItem.memo + "(更新済み2"
        raise Exception("障害発生")
        db.commit()
    except Exception as e:
        print("rollbackします")
        db.rollback()
    finally:
        db.close()

    item = db.query(Item).filter_by(name="複数商品1").first()
    if item:
        print(item.item_info)
    else:
        print("データが存在しません")

    # -------------------- join(これだとリレーションの設定は不要)
    joined = (
        # joinしたカラムに名前をつける⇛category
        db.query(Item.id, ItemCategory.name.label("category_name"), Item.name)
        .join(ItemCategory, Item.category_id == ItemCategory.id)
        .all()
    )

    for row in joined:
        print(f"商品ID：{row.id}, カテゴリ：{row.category_name}, 商品名：{row.name}")


if __name__ == "__main__":
    main()
