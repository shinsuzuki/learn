import json
import datetime as dt
from datetime import date
from pprint import pprint
from marshmallow import Schema, fields, post_load


def jsonJob():
    print("====> jsonJob start\n")

    # jsonファイルの読み込み
    with open("./sample.json", mode="r", encoding="utf8") as f:
        json_data = json.load(f)
        print(json_data["app"])
        print(json_data["db"]["authentication"]["user"])

    # jsonの書き込み
    with open("./sample_output.json", mode="w", encoding="utf8") as wf:
        dict1 = {"a": 10, "b": 20, "c": "日本語"}
        json.dump(dict1, wf, ensure_ascii=False)

    print("====> jsonJob  end\n")


# ---- marshmallow

# class ArtistSchema(Schema):
#     name = fields.Str()

#     @post_load
#     def build(self, data, **kwargs):
#         return ArtistSchema(**data)


# class AlbumSchema(Schema):
#     title = fields.Str()
#     release_date = fields.Date()
#     artist = fields.Nested(ArtistSchema())

#     @post_load
#     def build(self, data, **kwargs):
#         return AlbumSchema(**data)


# def marshmallowJob():
#     print("====> marshmallowJob start\n")

#     AlbumSchema(title="monkey", release_date='')

#     bowie = dict(name="David Bowie")
#     album = dict(artist=bowie, title="Hunky Dory", release_date=date(1971, 12, 17))

#     print("---- albumのデータ")
#     print(type(album))
#     pprint(album)
#     print("")

#     print("---- schema.dumps(album)のデータ")
#     schema = AlbumSchema()
#     albumStr = schema.dumps(album)  # strへ
#     print(type(albumStr))
#     pprint(albumStr)
#     print("")

#     print("---- schema.dump(album)")
#     albumDic = schema.dump(album)  # dicへ
#     print(type(albumDic))
#     pprint(albumDic)
#     print("")

# loadがわからない
# print("---- .load(album)")
# albumObj = AlbumSchema().load(album)  # ???
# print(type(albumObj))
# pprint(albumObj)
# print("")


class User:
    def __init__(self, name, email):
        self.name = name
        self.email = email
        self.created_at = dt.datetime.now()

    def __repr__(self):
        return "<User(name={self.name!r})>".format(self=self)


class UserSchema(Schema):
    name = fields.Str()
    email = fields.Email()
    created_at = fields.DateTime()

    def __repr__(self):
        return "<User(name={self.name!r})>".format(self=self)

    @post_load
    def make_user(self, data, **kwargs):
        return User(**data)


def marshmallowJob():
    # obj
    print("__________obj")
    user = User(name="monkey", email="xxx@xxx.org")
    print(type(user))
    pprint(user)

    # dic
    print("__________dic")
    schema = UserSchema()
    resultDic = schema.dump(user)
    print(type(resultDic))
    pprint(resultDic)

    # str
    print("__________str")
    resultStr = schema.dumps(user)
    print(type(resultStr))
    pprint(resultStr)

    # deserializing
    print("__________deserializing")
    user_data = {"name": "Ronnie", "email": "ronnie@stones.com"}
    userObject = schema.load(user_data)
    print(type(userObject))
    pprint(userObject)


if __name__ == "__main__":
    jsonJob()
    marshmallowJob()
