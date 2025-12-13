@echo off
@rem ######################################################################
@rem # FastAPIプロジェクトのリリースファイルを抽出するRobocopyスクリプト
@rem ######################################################################

@rem ======================================================================
@rem 1. 変数定義
@rem ======================================================================

@rem ソースディレクトリをカレントディレクトリに設定
set SOURCE_DIR="."

@rem 宛先ディレクトリ：必ずリリース先のパスに変更してください
set DEST_DIR="dist"

@rem ログファイルパス
@REM set LOG_FILE="robocopy_log.txt"

@rem ======================================================================
@rem 2. 除外リストの定義 (ここを編集してください)
@rem ======================================================================

@rem 除外ディレクトリの定義 。(スペース区切りで羅列)
@rem 末尾に \ は不要です。
set EXCLUDE_DIRS=".git" ".vscode" ".venv" "env" "__pycache__" "node_modules" "dist" "build" "tests" ".mypy_cache"

@rem 除外ファイルの定義 (スペース区切りで羅列、ワイルドカード(*)使用可能)
set EXCLUDE_FILES=".gitignore" ".env" ".DS_Store" "Thumbs.db" "settings_dev.py" "*.pyc" "*.bak" "*.bat" "*.http"

@rem ======================================================================
@rem 3. 宛先ディレクトリのクリーンアップ
@rem ======================================================================

echo.
echo ---------- Cleaning up destination directory ----------
echo DEST_DIR: [%DEST_DIR%]

@rem 宛先ディレクトリが存在する場合、削除を実行
if exist %DEST_DIR% (
    echo [INFO] Destination directory found. Deleting: %DEST_DIR%

    @rem /S: サブディレクトリを含むすべてのファイルを削除 /Q: 確認プロンプトを表示しない
    rmdir /S /Q %DEST_DIR%

    echo [INFO] Previous release directory deleted.
) else (
    echo [INFO] Destination directory does not exist. Proceeding to creation.
)

@rem 宛先ディレクトリを再作成
mkdir %DEST_DIR%
if errorlevel 1 (
    echo [ERROR] Failed to create destination directory. Aborting.
    goto :eof
)

@rem ======================================================================
@rem 4. Robocopyコマンドの実行
@rem    - ログが必要ならオプションに追加: /LOG+:%LOG_FILE%
@rem ======================================================================

echo.
echo ---------- Starting file copy for release ----------
echo SOURCE_DIR:    [%SOURCE_DIR%]
echo DEST_DIR:      [%DEST_DIR%]
echo EXCLUDE_DIRS:  [%EXCLUDE_DIRS%]
echo EXCLUDE_FILES: [%EXCLUDE_FILES%]
echo.


robocopy "%SOURCE_DIR%" "%DEST_DIR%" ^
  /E ^
  /S ^
  /XD %EXCLUDE_DIRS% ^
  /XF %EXCLUDE_FILES% ^
  /V ^
  /R:3 /W:5 ^
  /NP /NDL /NFL ^
  /TEE

@rem ----------------------------------------------------------------------
@rem 5. 処理結果の確認 (Robocopyの終了コードに基づく)
@rem ----------------------------------------------------------------------

echo.
echo ---------- Result ----------
if  %errorlevel% GEQ 8 (
  @rem 戻り値が 8以上 の場合に、ファイルがコピーされなかったなどの重大なエラー
  echo [FATAL] Fatal error during Robocopy operation. error_level: %errorlevel%
  echo.
) else (
  echo [SUCCESS] Extraction process completed.
  echo.
)
