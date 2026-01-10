import glob
import pickle
import pandas as pd
import time
from person import Person


def main():
    print("> start main_pandas")

    # ---------- xlsx読込速度 ----------
    print("\n============ xlsx読込速度 ============")
    start_time = time.time()
    # pd.read_excel("./data/50mb.xlsx")
    pd.read_excel("./data/SampleDocs-SampleXLSFile_6800kb.xls")
    print(f"read xlsx normal: {time.time() - start_time}")
    # read xlsx normal: 12.610586404800415 << 50MBで12秒

    start_time = time.time()
    pd.read_excel("./data/SampleDocs-SampleXLSFile_6800kb.xls", engine="calamine")
    # pd.read_excel("./data/50mb.xlsx", engine="calamine")
    print(f"read xlsx calamine: {time.time() - start_time}")
    # engine="calamine"に変えた場合、半分程度の時間で対応している
    # read xlsx calamine: 5.16440486907959 << 50MBで5秒

    # ---------- df 縦結合 ----------
    print("\n============ df 縦結合 ============")
    start_time = time.time()

    # ファイルパスのリストを取得（例：dataフォルダ内の全てのcsv）
    files = glob.glob("data/xls/*.xls")

    # 内包表記でDFのリストを作成（メモリ効率が良い）
    # df_list = [pd.read_excel(f) for f in files]
    # df_list = [pd.read_excel(f, engine="calamine") for f in files]

    # 遅い処理で試す
    df_list = pd.DataFrame()
    for file in files:
        df_temp = pd.read_excel(file)
        df_list = pd.concat([df_list, df_temp])  # 毎回コピーが発生

    # 最後に一度だけ縦に結合
    # df_combined = pd.concat(df_list, axis=0, ignore_index=True)
    # df 縦結合: 2.0660922527313232 << normal
    # df 縦結合: 0.9016640186309814 << calamine
    # print(df_combined)

    print(df_list)

    print(f"df 縦結合: {time.time() - start_time}")

    # ---------- class pickle ----------
    print("\n============ pickle (class) ============")
    print("\n=== 1.オブジェクトをファイルに保存")
    p = Person("akai")
    with open("./data/output_person.pkl", "wb") as wf:
        pickle.dump(p, wf)

    p.hello()

    print("\n=== 2.pickleからオブジェクト読込")
    with open("./data/output_person.pkl", "rb") as rf:
        person_return = pickle.load(rf)

    person_return.hello()

    print("\n=== 3.メモリ上に変換")
    df_person = pickle.dumps(p)
    print(df_person)

    # ---------- pickle ----------
    print("\n============ pickle ============")
    print("\n=== 1.DataFrame から pickleに保存")
    df_sample_file_csv = pd.read_csv("./data/base_sample_file.csv")

    print("\n=== 2. df.to_pickle を利用して保存")
    df_sample_file_csv.to_pickle("./data/outuput_base_sample_file_by_to_pickle.pkl")

    print("\n=== 3.pickle.dumps を使用して保存")
    with open("./data/outuput_base_sample_file.pkl", "wb") as wf:
        pickle.dump(df_sample_file_csv, wf)

    print("\n=== 4.pickle から DataFrameに読込")
    df_sample_file_pkl = pd.read_pickle("./data/outuput_base_sample_file.pkl")
    print(df_sample_file_pkl)

    # ---------- csv ----------
    print("\n============ csv ============")
    print("\n1.csv から DataFrame に読込")
    df_sample_file_csv = pd.read_csv("./data/base_sample_file.csv")
    print(df_sample_file_csv)

    print("\n2.DataFrame から csvの保存")
    df_sample_file_csv.to_csv("./data/output_base_sample_file.csv", index=False)

    # ---------- xlsx ----------
    print("\n============ xlsx ============")
    print("\n1.excel(xlsx) から DataFrame に読込")
    df_sample_file_excel = pd.read_excel("./data/base_sample_fille_excel.xlsx")
    print(df_sample_file_excel)

    print("\n2.DataFrame から excel(xlsx) に保存")
    df_sample_file_excel.to_excel("./data/output_base_sample_file_excel.xlsx", index=False)


if __name__ == "__main__":
    main()
