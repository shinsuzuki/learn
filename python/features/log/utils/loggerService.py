import logging
import logzero
from logzero import logger


class Logger:
    #
    # logzero
    # https://logzero.readthedocs.io/en/latest/#
    #

    _logger = None

    def __new__(cls, *args, **kwargs):
        if cls._logger is None:
            _logger = logzero.setup_logger(
                name="logzero-sample",  # loggerの名前、複数loggerを用意するときに区別できる
                logfile="test.log",  # ログファイルの格納先
                level=logging.INFO,  # 標準出力のログレベル/
                formatter=logzero.LogFormatter(
                    fmt="%(asctime)s %(levelname)s: %(message)s",
                    datefmt="%Y/%m/%d %H:%M:%S",
                ),  # ログのフォーマット
                maxBytes=1000,  # ログローテーションする際のファイルの最大バイト数
                backupCount=3,  # ログローテーションする際のバックアップ数
                fileLoglevel=logging.INFO,  # ログファイルのログレベル
                disableStderrLogger=False,  # 標準出力するかどうか
            )

            return _logger
