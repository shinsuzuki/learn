# ========================================== コマンド
import subprocess
from subprocess import PIPE

# lsresult = subprocess.run(
#     "ls -al",
#     shell=True,
#     stdout=subprocess.PIPE,
#     stderr=subprocess.PIPE,
#     encoding="utf-8",
# )

lsresult = subprocess.run("ls -al", shell=True, capture_output=True)

print("ls -al 結果")
print("---------- result")
print("" + str(lsresult.returncode))  # 終了ステータス
print("---------- ")
print(lsresult.stdout.decode("utf-8"))  # 標準出力
print(lsresult.stderr.decode("utf-8"))  # 標準エラー


# ls -al 結果
# ---------- result
# 0
# ----------
# total 26
# drwxr-xr-x 1 shins 197609    0  1月 24 02:24 .
# drwxr-xr-x 1 shins 197609    0  1月 21 15:32 ..
# drwxr-xr-x 1 shins 197609    0  1月 21 15:31 .idea
# drwxr-xr-x 1 shins 197609    0  1月 21 15:31 .venv
# drwxr-xr-x 1 shins 197609    0  1月 21 18:19 .vscode
# -rw-r--r-- 1 shins 197609  240  1月 23 02:26 cmdargv.py
# -rw-r--r-- 1 shins 197609 6715  1月 23 02:16 lesson.py
# -rw-r--r-- 1 shins 197609 1383  1月 24 01:30 my.py
# drwxr-xr-x 1 shins 197609    0  1月 24 00:01 mypackage
# -rw-r--r-- 1 shins 197609  229  1月 24 02:11 mytime.py
# -rw-r--r-- 1 shins 197609  593  1月 24 02:28 process.py
# -rw-r--r-- 1 shins 197609   19  1月 24 01:45 test.txt
# -rw-r--r-- 1 shins 197609   19  1月 24 01:44 text.txt
# -rw-r--r-- 1 shins 197609  465  1月 24 01:53 use_file.py
# -rw-r--r-- 1 shins 197609    0  1月 24 02:24 ダミーファイル.txt
