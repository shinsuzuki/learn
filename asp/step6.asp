<%@ Language="VBScript" CODEPAGE="65001" %>
<% Option Explicit %>
<!-- #include file="includes/db_utils.asp" -->
<%
    ' ASPはデフォルトでShift_JISなので、UTF-8を使う場合は明示的に指定する必要があります。
    Response.CharSet = "UTF-8"

    ' --------------------------------------------------
    ' 変数宣言
    ' --------------------------------------------------
    Dim conn, cmd, rs
    Dim action, taskId, taskName, keyword

    action  = Request.Form("action")
    keyword = Request.Form("txtKeyword")

    ' --- 検索キーワードのCookie保持 ---
    If Request.ServerVariables("REQUEST_METHOD") = "GET" Then
        keyword = Request.Cookies("TaskSearchKeyword")
    Else
        Response.Cookies("TaskSearchKeyword") = keyword
        Response.Cookies("TaskSearchKeyword").Expires = DateAdd("d", 7, Now())
    End If

    ' --------------------------------------------------
    ' DB更新処理（C / U / D）+ トランザクション処理
    '
    ' 「?」は完全に無名の位置指定プレースホルダーなので、名前という概念自体がありません。
    ' Parametersコレクションに追加した順番がそのまま「?」の出現順に対応します。
    ' --------------------------------------------------
    If action <> "" Then
        ' 共通関数でDBオープン
        Set conn = OpenDBConnection()

        On Error Resume Next
        conn.BeginTrans

        ' --- Create (新規登録) ---
        If action = "add" Then
            taskName = Trim(Request.Form("txtTaskName"))
            If taskName <> "" Then
                Set cmd = Server.CreateObject("ADODB.Command")
                Set cmd.ActiveConnection = conn
                cmd.CommandText = "INSERT INTO Tasks (TaskName, IsCompleted) VALUES (?, 0)"
                cmd.Parameters.Append cmd.CreateParameter("@TaskName", adVarChar, adParamInput, 100, taskName)
                cmd.Execute()
            End If

        ' --- Update (状態切り替え) ---
        ElseIf action = "toggle" Then
            taskId = Request.Form("taskId")
            If IsNumeric(taskId) Then
                Set cmd = Server.CreateObject("ADODB.Command")
                Set cmd.ActiveConnection = conn
                cmd.CommandText = "UPDATE Tasks SET IsCompleted = CASE WHEN IsCompleted = 1 THEN 0 ELSE 1 END WHERE TaskId = ?"
                cmd.Parameters.Append cmd.CreateParameter("@TaskId", adInteger, adParamInput, 4, CLng(taskId))
                cmd.Execute()
            End If

        ' --- Delete (削除) ---
        ElseIf action = "delete" Then
            taskId = Request.Form("taskId")
            If IsNumeric(taskId) Then
                Set cmd = Server.CreateObject("ADODB.Command")
                Set cmd.ActiveConnection = conn
                cmd.CommandText = "DELETE FROM Tasks WHERE TaskId = ?"
                cmd.Parameters.Append cmd.CreateParameter("@TaskId", adInteger, adParamInput, 4, CLng(taskId))
                cmd.Execute()
            End If
        End If

        ' トランザクションの判定
        If Err.Number <> 0 Then
            conn.RollbackTrans
            Session("ErrorMessage") = "処理中にエラーが発生しました: " & Err.Description
            Err.Clear
        Else
            conn.CommitTrans
        End If

        On Error GoTo 0

        ' 安全なリダイレクト（接続・オブジェクトの解放を自動実行）
        Call SafeRedirect("step6.asp", conn, cmd, Nothing)
    End If

    ' --------------------------------------------------
    ' Read 処理 (検索・一覧取得)
    ' --------------------------------------------------
    Set conn = OpenDBConnection()
    Set cmd  = Server.CreateObject("ADODB.Command")
    Set cmd.ActiveConnection = conn

    If Trim(keyword) <> "" Then
        cmd.CommandText = "SELECT TaskId, TaskName, IsCompleted, CreatedAt FROM Tasks WHERE TaskName LIKE ? ORDER BY TaskId DESC"
        cmd.Parameters.Append cmd.CreateParameter("@Keyword", adVarChar, adParamInput, 102, "%" & keyword & "%")
    Else
        cmd.CommandText = "SELECT TaskId, TaskName, IsCompleted, CreatedAt FROM Tasks ORDER BY TaskId DESC"
    End If

    Set rs = cmd.Execute()
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Step 6 - モジュール化CRUD</title>
    <style>
        body { font-family: "Segoe UI", sans-serif; margin: 30px; max-width: 800px; }
        h1 { color: #333; border-bottom: 2px solid #0066cc; padding-bottom: 8px; }
        .card { background: #f9f9f9; border: 1px solid #ddd; padding: 15px; border-radius: 6px; margin-bottom: 20px; }
        .error-msg { background: #f2dede; color: #a94442; padding: 10px; border-radius: 4px; margin-bottom: 15px; }
        table { border-collapse: collapse; width: 100%; margin-top: 10px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background: #0066cc; color: white; }
        .completed { text-decoration: line-through; color: #888; }
        .btn-inline { display: inline-block; margin: 0; }
    </style>
</head>
<body>

    <h1>タスク管理（モジュール化版）</h1>

    <% If Session("ErrorMessage") <> "" Then %>
        <div class="error-msg">
            <%= Server.HTMLEncode(Session("ErrorMessage")) %>
        </div>
        <% Session("ErrorMessage") = "" %>
    <% End If %>

    <div class="card">
        <h2>新規タスクの追加</h2>
        <form action="step6.asp" method="post">
            <input type="hidden" name="action" value="add">
            <input type="text" name="txtTaskName" size="40" placeholder="新しいタスクを入力..." required>
            <input type="submit" value="追加">
        </form>
    </div>

    <div class="card">
        <h2>タスクの検索</h2>
        <form action="step6.asp" method="post">
            <input type="text" name="txtKeyword" value="<%= Server.HTMLEncode(keyword & "") %>" placeholder="キーワードを入力...">
            <input type="submit" value="絞り込み">
        </form>
    </div>

    <h2>タスク一覧</h2>
    <% If rs.EOF Then %>
        <p>該当するタスクはありません。</p>
    <% Else %>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>タスク名</th>
                    <th>登録日時</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Do Until rs.EOF
                        Dim currentId, currentName, isDone, createdAt
                        currentId   = rs("TaskId")
                        currentName = rs("TaskName")
                        isDone      = CBool(rs("IsCompleted"))
                        createdAt   = rs("CreatedAt")
                %>
                    <tr>
                        <td><%= currentId %></td>
                        <td class="<% If isDone Then Response.Write "completed" %>">
                            <%= Server.HTMLEncode(currentName & "") %>
                        </td>
                        <td><%= FormatDateTime(createdAt, 2) %></td>
                        <td>
                            <form action="step6.asp" method="post" class="btn-inline">
                                <input type="hidden" name="action" value="toggle">
                                <input type="hidden" name="taskId" value="<%= currentId %>">
                                <input type="submit" value="<% If isDone Then Response.Write "未完に戻す" Else Response.Write "完了にする" %>">
                            </form>
                            <form action="step6.asp" method="post" class="btn-inline" onsubmit="return confirm('本当に削除しますか？');">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="taskId" value="<%= currentId %>">
                                <input type="submit" value="削除">
                            </form>
                        </td>
                    </tr>
                <%
                        rs.MoveNext
                    Loop
                %>
            </tbody>
        </table>
    <% End If %>

</body>
</html>
<%
    ' ファイル末尾での最終クリーンアップ（1行で完結）
    Call CloseDB(conn, cmd, rs)
%>