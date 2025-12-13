@echo off
@rem ######################################################################
@rem # FastAPIプロジェクトのファイルを抽出するスクリプト
@rem ######################################################################

@rem ======================================================================
@rem 0. デプロイ先を選択
@rem ======================================================================
echo.
echo ==================================================
echo  - Select Deployment Target -
echo ==================================================
CHOICE /C DP /M "Select environment. ([D]:Development or [P]:Production)"
set DEPLOY_ENV=
if %errorlevel% == 1 (
  set DEPLOY_ENV=development
) else (
  set DEPLOY_ENV=production
)
echo DEPLOY_ENV: [%DEPLOY_ENV%]


@rem ======================================================================
@rem 1. 変数定義
@rem ======================================================================
@rem ソースディレクトリをカレントディレクトリに設定
set SOURCE_DIR="."

@rem 宛先ディレクトリ
set DEST_DIR="dist/%DEPLOY_ENV%"
echo DEST_DIR:   [%DEST_DIR%]


@rem ======================================================================
@rem 2. 除外リストの定義
@rem ======================================================================
@rem 除外ディレクトリの定義 。(スペース区切りで羅列)
@rem 末尾に \ は不要です。
set EXCLUDE_DIRS=
set EXCLUDE_DIRS=%EXCLUDE_DIRS% ".git" ".vscode" ".venv" "env"
set EXCLUDE_DIRS=%EXCLUDE_DIRS% "__pycache__" "node_modules" "dist"
set EXCLUDE_DIRS=%EXCLUDE_DIRS% "build" "tests" ".mypy_cache"

@rem 除外ファイルの定義 (スペース区切りで羅列、ワイルドカード(*)使用可能)
set EXCLUDE_FILES=
set EXCLUDE_FILES=%EXCLUDE_FILES% ".gitignore" ".env" ".DS_Store" "Thumbs.db"
set EXCLUDE_FILES=%EXCLUDE_FILES% "settings_dev.py" "*.pyc" "*.bak"
set EXCLUDE_FILES=%EXCLUDE_FILES% "*.bat" "*.http"


@rem ======================================================================
@rem 3. 出力先ディレクトリのクリーンアップ
@rem ======================================================================
echo.
echo ==================================================
echo  - Cleaning up destination directory -
echo ==================================================

@rem 出力先ディレクトリが存在する場合、削除を実行
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
@rem ======================================================================
echo.
echo ==================================================
echo  - Copy the files to deploy -
echo ==================================================
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
  /NFL /NDL /NS /NC /NJH


@rem ----------------------------------------------------------------------
@rem 5. 処理結果の確認
@rem ----------------------------------------------------------------------
echo.
echo ==================================================
echo  - Results of extracting files to deploy -
echo ==================================================
if  %errorlevel% GEQ 8 (
  @rem 戻り値が 8以上 の場合に、ファイルがコピーされなかったなどの重大なエラー
  echo [FATAL] Fatal error during Robocopy operation. error_level: %errorlevel%
  echo.
) else (
  echo [SUCCESS] Extraction process completed for [%DEPLOY_ENV%].
  echo.
)
