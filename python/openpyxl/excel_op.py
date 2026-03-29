import openpyxl
from openpyxl.styles.borders import Border, Side
from openpyxl.styles import PatternFill


# ------------------------------------------------------------
class ExcelOperation:
    def __init__(self):
        pass

    # ------------------------------------------------------------
    def init_excel_file(self, excel_path: str):
        """エクセルファイル初期作成"""
        file_path = excel_path

        # エクセルファイルを新規作成
        wb = openpyxl.Workbook()

        # シート名をリネーム
        ws = wb["Sheet"]
        ws.title = "data_1"

        # セルの内容を更新
        ws.cell(row=1, column=1, value="A1")
        ws.cell(row=2, column=1, value="A2")

        # セルの値を参照
        print(ws.cell(row=1, column=1).value)
        print(ws.cell(row=2, column=1).value)

        # エクセル保存
        wb.save(file_path)

    # ------------------------------------------------------------
    def update_cell_test(self):
        """Excelの読み込み、セルの値を取得、更新、保存する"""

        file_path = "./data/read_data_1.xlsx"
        self.init_excel_file(file_path)

        # 既存のエクセル読み込み
        # ※関数式ではなく結果の値のみ取り出したい場合は "data_only=true"
        wb = openpyxl.load_workbook(file_path, data_only=False)

        # 対象のシートを指定
        ws = wb["data_1"]

        # セルの値を設定
        print("セルの値を設定")
        rows = [1, 2, 3]
        columns = [1, 2, 3, 4]
        for row in rows:
            for column in columns:
                print(f"{row}-{column}")
                ws.cell(row=row, column=column, value=f"{row}-{column}")

        # シートの行を取得
        print("シートの行を取得(for)")
        row = ws[1]
        for cell in row:
            print(cell.value)

        print("シートの行を取得(index)")
        print(row[0].value)
        print(row[1].value)
        print(row[2].value)
        print(row[3].value)

        # エクセル保存
        wb.save(file_path)

    # ------------------------------------------------------------
    def update_sheet_test(self):
        """シートの追加、参照"""

        file_path = "./data/read_data_1.xlsx"
        self.init_excel_file(file_path)

        wb = openpyxl.load_workbook(file_path, data_only=False)

        # シートを追加
        wb.create_sheet(title="add_sheet1", index=1)
        wb.create_sheet(title="add_sheet2")  # indexを指定しないと一番右側に追加される

        # シートを取得
        ws = wb["data_1"]
        ws.cell(row=1, column=1, value="update_value")

        # シート名を変更
        ws.title = "update_sheet"

        # シートをコピー(コピ^したシート名は末尾に Copyがつきます)
        wb.copy_worksheet(wb["update_sheet"])
        print(f"sheetnames: {wb.sheetnames}")

        # シートの色を設定
        ws.sheet_properties.tabColor = "FF8000"

        # エクセル保存
        wb.save(file_path)
