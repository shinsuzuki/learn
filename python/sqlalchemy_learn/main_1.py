import os
import pprint
from sqlalchemy import or_, select, desc, insert, update, delete
from models.item import Item
from models.item_category import ItemCategory
from util.db import get_session


def main():
    """メイン実行関数"""
    db = get_session()

    # -------------------- 全件取得
    # for item in db.query(Item).all():
    #     print(item.item_info)

    # ==== new
    print(">> select")
    stmt = select(Item)
    results = db.execute(stmt)
    for row in results.scalars():
        print(row)

    # -------------------- OR
    # item = db.query(Item).filter_by(name="爪切り").first()
    # print(item.name)

    # ==== new
    print(">> select where")
    stmt = select(Item).where(or_(Item.id == 2, Item.id == 3))
    # print(stmt)

    results = db.execute(stmt)

    for row in results.scalars():
        print(row)

    # -------------------- 条件(fiter_by, and)
    # item = db.query(Item).filter_by(name="爪切り", price=1100).first()
    # print(item.name)

    # ==== new
    print(">> select and")
    stmt = select(Item).where(Item.name == "爪切り", Item.price == 1100)
    results = db.execute(stmt).scalars()
    for row in results:
        print(row)

    # -------------------- フィルター
    # items = db.query(Item).filter(Item.price < 1000)
    # for item in items:
    #     print(item.name)

    # ==== new
    print(">> select filter")
    stmt = select(Item).filter(Item.price <= 300)
    results = db.execute(stmt)
    for row in results:
        print(row)

    # -------------------- IN
    # items = db.query(Item).filter(Item.price.in_([120, 1100]))
    # for item in items:
    #     print(item.name)

    # ==== new
    print(">> select in")
    stmt = select(Item).where(Item.price.in_([120, 1100]))
    results = db.execute(stmt)
    for item in results.scalars():
        print(item)

    # -------------------- LIKE
    # item = db.query(Item).filter(Item.name.like("%エリア%")).first()
    # print(item.name)

    # ==== new
    print(">> select like")
    stmt = select(Item).where(Item.name.like("%新商品%"))
    results = db.execute(stmt)
    for row in results.scalars():
        print(row)

    # -------------------- OR
    # items = db.query(Item).filter(or_(Item.id == 1, Item.id == 3))
    # for item in items:
    #     print(item.name)

    # ==== new
    print(">> select or")
    # condition1 = Item.price == 500
    # condition2 = Item.price == 80
    stmt = select(Item).where((Item.price == 500) | (Item.price == 80))
    results = db.execute(stmt)
    for row in results.scalars():
        print(row)

    # -------------------- between
    # items = db.query(Item).filter(or_(Item.price.between(30, 200)))
    # for item in items:
    #     print(item.name)

    # ==== new
    print(">> select between")
    stmt = select(Item).where(Item.price.between(200, 2000))
    results = db.execute(stmt).scalars()
    for row in results:
        print(row)

    # -------------------- Order_By(昇順)
    # items = db.query(Item).order_by(Item.price.desc())
    # for item in items:
    #     print(item.item_info)

    # ==== new
    print(">> select order by asc")
    stmt = select(Item).order_by(Item.price)
    results = db.execute(stmt).scalars()
    for row in results:
        print(row)

    # -------------------- Order_By(降順)
    # items = db.query(Item).order_by(Item.price.asc())
    # for item in items:
    #     print(item.item_info)

    # ==== new
    print(">> select order by desc")
    stmt = select(Item).order_by(desc(Item.price))
    results = db.execute(stmt).scalars()
    for row in results:
        print(row)

    # -------------------- 追加
    # addItem = Item(name="新商品", price=500, memo="新商品のメモ", category_id=4)
    # db.add(addItem)
    # db.commit()
    # for item in db.query(Item).order_by(Item.id.desc()):
    #     print(item.item_info)

    # ==== new
    print(">> insert")
    try:
        item1 = Item(id=11, name="追加商品1", price=999, memo="メモ追加", category_id=2)
        db.add(item1)
        db.commit()
    except:
        db.rollback()
    finally:
        db.close()

    results = db.execute(select(Item)).scalars()
    for row in results:
        print(row)

    # -------------------- 複数追加
    print(">> insert multi")
    try:
        addItems = [
            Item(
                id=30,
                name="複数商品20",
                price=150,
                memo="複数商品のメモ1",
                category_id=2,
            ),
            Item(
                id=31,
                name="複数商品21",
                price=250,
                memo="複数商品のメモ2",
                category_id=3,
            ),
        ]

        db.add_all(addItems)
        db.commit()
    except:
        db.rollback()
    finally:
        db.close()

    for item in db.query(Item).order_by(Item.id.desc()):
        print(item.item_info)

    # -------------------- 更新
    # updateItem = db.query(Item).filter_by(name="複数商品1").first()
    # updateItem.memo += updateItem.memo + "(更新済み)"
    # db.commit()
    # for item in db.query(Item).all():
    #     print(item.item_info)

    # ==== new
    print(">> update")
    try:
        stmt = select(Item).where(Item.id == 30)
        update_item = db.execute(stmt).scalar_one_or_none()
        if update_item:
            # pylanceのエラーがでるが動きます
            update_item.name = "更新!"
            db.commit()
    except:
        db.rollback()
    finally:
        db.close()

    for item in db.query(Item).all():
        print(item.item_info)

    # -------------------- 削除
    # db.query(Item).filter_by(name="複数商品2").delete()
    # db.commit()
    # for item in db.query(Item).all():
    #     print(item.item_info)

    # ==== new
    print(">> delete")
    try:
        stmt = select(Item).where(Item.id.in_([11, 30, 31]))
        delete_items = db.execute(stmt).scalars().all()

        if delete_items:
            for row in delete_items:
                if row:
                    db.delete(row)
                else:
                    print("削除対象なし")
        db.commit()
    except:
        db.rollback()
    finally:
        db.close()

    for item in db.query(Item).all():
        print(item.item_info)

    # -------------------- トランザクション制御
    # try:
    #     updateItem = db.query(Item).filter_by(name="複数商品1").first()
    #     updateItem.memo = updateItem.memo + "(更新済み2"
    #     raise Exception("障害発生")
    #     db.commit()
    # except Exception as e:
    #     print("rollbackします")
    #     db.rollback()
    # finally:
    #     db.close()

    # item = db.query(Item).filter_by(name="複数商品1").first()
    # if item:
    #     print(item.item_info)
    # else:
    #     print("データが存在しません")

    # -------------------- JOIN(JOINのキーはカスタム)
    # joined = (
    #     # joinしたカラムに名前をつける⇛category
    #     db.query(Item.id, ItemCategory.name.label("category_name"), Item.name)
    #     .join(ItemCategory, Item.category_id == ItemCategory.id)
    #     .all()
    # )

    # for row in joined:
    #     print(f"商品ID：{row.id}, カテゴリ：{row.category_name}, 商品名：{row.name}")

    # ==== new
    print(">> join (core)、キーを指定してJOIN")

    stmt_custom_key = select(
        Item.id,
        Item.name.label("item_name"),
        ItemCategory.name.label("category_name"),
    ).join(Item, ItemCategory.id == Item.category_id)

    results = db.execute(stmt_custom_key).all()
    for item in results:
        print(f"{item.id},{item.item_name}, {item.category_name}")


if __name__ == "__main__":
    main()
