import configparser
import yaml


def main():
    print("========> main start")

    print("== ini")
    config = configparser.ConfigParser()
    config.read("config.ini")
    print(config["server"]["host"])
    print(config["server"]["port"])
    print(config["user"]["name"])

    print("== yaml")
    with open("config.yml", "r") as yamlfile:
        yconfig = yaml.safe_load(yamlfile)
        print(yconfig["server"]["host"])
        print(yconfig["server"]["port"])
        print(yconfig["user"]["name"])

    print("========> main end")


if __name__ == "__main__":
    main()
