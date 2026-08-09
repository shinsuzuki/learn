<%@ Language="VBScript" CODEPAGE="65001" %>
<%
    ' ASPはデフォルトでShift_JISなので、UTF-8を使う場合は明示的に指定する必要があります。
    Option Explicit
    Response.CharSet = "UTF-8"

    ' ADO 定数
    Const adVarChar = 200
    Const adInteger = 3
    Const adParamInput = 1

    Dim connStr, conn, cmd, rs
    Dim action, taskId, taskName, keyword

    connStr = "Provider=MSOLEDBSQL;Data Source=localhost;Initial Catalog=sampleDB;User ID=sa;Password=sasa;"

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
    ' --------------------------------------------------
    If action <> "" Then
        Set conn = Server.CreateObject("ADODB.Connection")
        conn.Open connStr

        ' 1. エラーを自動停止させず、スクリプトでハンドリングする設定
        On Error Resume Next

        ' 2. トランザクション開始
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
                Set cmd = Nothing
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
                Set cmd = Nothing
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
                Set cmd = Nothing
            End If
        End If

        ' 3. エラー判定とコミット / ロールバックの分岐
        If Err.Number <> 0 Then
            ' エラーが発生していれば変更をすべてロールバック
            conn.RollbackTrans

            ' セッションなどにエラーメッセージを保持（画面表示用）
            Session("ErrorMessage") = "処理中にエラーが発生しました: " & Err.Description
            Err.Clear
        Else
            ' 正常終了した場合はコミット
            conn.CommitTrans
        End If

        ' エラー制御を元に戻す
        On Error GoTo 0

        conn.Close()
        Set conn = Nothing

        ' 4. クリーンアップ
        SafeRedirect("")

        ' 5. PRGパターンによるリダイレクト
        Response.Redirect "step6.asp"
    End If

    ' --------------------------------------------------
    ' Read 処理 (検索・一覧取得)
    ' --------------------------------------------------
    Set conn = Server.CreateObject("ADODB.Connection")
    conn.Open connStr

    Set cmd = Server.CreateObject("ADODB.Command")
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
    <title>Step 6 - トランザクション対応CRUD</title>
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

    <h1>タスク管理（トランザクション対応）</h1>

    <!-- エラーメッセージの表示 -->
    <% If Session("ErrorMessage") <> "" Then %>
        <div class="error-msg">
            <%= Server.HTMLEncode(Session("ErrorMessage")) %>
        </div>
        <% Session("ErrorMessage") = "" ' 表示後にクリア %>
    <% End If %>

    <!-- 1. 新規登録フォーム -->
    <div class="card">
        <h2>新規タスクの追加</h2>
        <form action="step6.asp" method="post">
            <input type="hidden" name="action" value="add">
            <input type="text" name="txtTaskName" size="40" placeholder="新しいタスクを入力..." required>
            <input type="submit" value="追加">
        </form>
    </div>

    <!-- 2. 検索フォーム -->
    <div class="card">
        <h2>タスクの検索</h2>
        <form action="step6.asp" method="post">
            <input type="text" name="txtKeyword" value="<%= Server.HTMLEncode(keyword & "") %>" placeholder="キーワードを入力...">
            <input type="submit" value="絞り込み">
        </form>
    </div>

    <!-- 3. タスク一覧表示 -->
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
    // ' リソースの解放
    // If Not rs Is Nothing Then
    //     If rs.State = 1 Then rs.Close
    //     Set rs = Nothing
    // End If
    // Set cmd = Nothing
    // If Not conn Is Nothing Then
    //     If conn.State = 1 Then conn.Close
    //     Set conn = Nothing
    // End If
    SafeRedirect("")

    ' クリーンアップとリダイレクトをセットで行うサブルーチン
    Sub SafeRedirect(url)
        On Error Resume Next

        ' Recordsetの解放
        If IsObject(rs) Then
            If Not rs Is Nothing Then
                If rs.State = 1 Then rs.Close
                Set rs = Nothing
            End If
        End If

        ' Commandの解放
        If IsObject(cmd) Then
            If Not cmd Is Nothing Then Set cmd = Nothing
        End If

        ' Connectionの解放
        If IsObject(conn) Then
            If Not conn Is Nothing Then
                If conn.State = 1 Then conn.Close
                Set conn = Nothing
            End If
        End If

        On Error GoTo 0

        ' 安全に解放した上でリダイレクト
        If url <> "" Then
            Response.Redirect url
        End If
    End Sub
%>