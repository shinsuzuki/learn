# ----------------------------------------------------------------------
# openpyxlの使い方
# ----------------------------------------------------------------------
from excel_op import ExcelOperation


def main():
    excel = ExcelOperation()

    # セルの操作
    excel.update_cell_test()

    # シートの操作
    # excel.update_sheet_test()


if __name__ == "__main__":
    main()
