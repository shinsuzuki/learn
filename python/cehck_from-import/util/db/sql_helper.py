from util.const.common_const import COMMON_VALUE_1, COMMON_VALUE_2
import util.const.common_const as util_const_common_const


def get_test_query():
    return "test_query!"


def get_test_query2():
    return "test_query!"


def get_common_value():
    return COMMON_VALUE_1 + ":" + COMMON_VALUE_2


def get_util_const_common_const():
    return (
        util_const_common_const.COMMON_VALUE_1
        + ":"
        + util_const_common_const.COMMON_VALUE_2
    )
