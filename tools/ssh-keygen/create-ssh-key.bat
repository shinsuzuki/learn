@echo off
REM 【 ssh-keygen 】コマンド――SSHの公開鍵と秘密鍵を作成する
REM https://atmarkit.itmedia.co.jp/ait/articles/1908/02/news015.html

REM 2048ビットで作成
REM 暗号化形式はed25519
REM パスフレーズなし
ssh-keygen -b 2048 -t ed25519 -C "" -N ""  -f id_ed25519_openssh_xxxx
