import pickle
import pandas as pd
from person import Person


def main():
    print("> start main_pandas")

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
