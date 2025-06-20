

#
$errorActionPreference = "Stop"

# 変数定義
$taskName = "MyTestTask"
$scriptFile = ".\test.ps1"

# タスクのアクションを定義
$action = New-ScheduledTaskAction `
    -Execute "%Systemroot%\System32\WindowsPowerShell\v1.0\powershell.exe" `
    -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$scriptFile`"" `
    -WorkingDirectory "C:\Users\shins\mydev\learn\ps\tasksche"

# タスクのトリガーを定義
$trigger = New-ScheduledTaskTrigger `
    -RepetitionInterval (New-TimeSpan -Minutes 1) `
    -At (Get-Date) `
    -Once

#
#$settings = New-ScheduledTaskSettingsSet `
#     -

# userinfo
# $user = "shins" # ユーザー名を指定
# $password = "Omoipass1972"

# principalを定義
$principal = New-ScheduledTaskPrincipal `
    -UserId "shins" `
    -LogonType S4U `
    -RunLevel Highest

# 登録されるが、タスクスケジューラから起動しない
# ユーザーがログオンしているかどうかに関わらず、タスクを実行する、にしていると起動しない

try {
    # use user
    # Register-ScheduledTask `
    #     -TaskName $taskName `
    #     -Description "This task runs a PowerShell script at startup and every minute thereafter." `
    #     -Action $action `
    #     -Trigger $trigger `
    #     -User $user `
    #     -Password $password `
    #     -RunLevel Highest `
    #     -Force

    # use principal
    Register-ScheduledTask `
        -TaskName $taskName `
        -Description "This task runs a PowerShell script at startup and every minute thereafter." `
        -Action $action `
        -Trigger $trigger `
        -Principal $principal `
        -Force

    Write-Host "Scheduled task ${taskName} registered successfully."
}
catch {
    Write-Error "Failed to register scheduled task: $_"
    exit 1
}

# (オプション) 登録されたタスクのプロパティを確認
Get-ScheduledTask -TaskName $taskName | Format-List *
exit 0
