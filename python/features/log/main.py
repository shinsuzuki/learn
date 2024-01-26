from utils.loggerService import Logger


def main():
    print("========> main start")

    logger = Logger()
    logger.info("information!")
    logger.warning("warninig!")

    print("========> main end")


if __name__ == "__main__":
    main()
