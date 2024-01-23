# ======================================== パッケージ

# パッケージを読み込みするとフルパス指定
# パッケージを読み込みするとフルパス指定# import mypackage.utils
# print(mypackage.utils.say_twice("hello"))


# パッケージを指定し読み込み
# from mypackage import utils

# print(utils.say_twice("hello"))


# フォルダ階層を下げて読み込み
# from mypackage.tools import utils

# print(utils.say_twice("hello"))

# from termcolor import colored

# print(colored("test", "red"))


# ======================================== Classについて
class Person(object):
    def __init__(self, name) -> None:
        self.name = name

    def attack(self):
        print(f"{self.name}:person attack!")


p = Person("sato")
p.attack()


class Hero(Person):
    MaxPower = 100

    def __init__(self, name) -> None:
        super().__init__(name)

    def attack(self):
        super().attack()
        print(f"{self.name}:hero attack!")

    @classmethod
    def getMaxPower(cls):
        return cls.MaxPower

    @staticmethod
    def getStringPlusGod(addString):
        return addString + "!God!"


h = Hero("kato")
h.attack()
t = Hero("tinen")

# class method
print(h.getMaxPower())
print(t.getMaxPower())

# statc method
print(Hero.getStringPlusGod("hello"))
