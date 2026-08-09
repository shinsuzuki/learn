<%@ Language="VBScript" CODEPAGE="65001" %>
<%
    ' Step 5: データベース連携（ADO）
    ' ASPはデフォルトでShift_JISなので、UTF-8を使う場合は明示的に指定する必要があります。
    Option Explicit
    Response.CharSet = "UTF-8"
%>

<%
    ' --------------------------------------------------
    ' ADO 定数の定義（通常は adovbs.inc を include するか数値で直接指定）
    ' --------------------------------------------------
    Const adVarChar = 200
    Const adParamInput = 1

    ' --------------------------------------------------
    ' 1. 変数の宣言
    ' --------------------------------------------------
    Dim conn, cmd, rs
    Dim connStr, searchRole, reqMethod

    reqMethod = Request.ServerVariables("REQUEST_METHOD")
    searchRole = Request.Form("txtRole")
    If searchRole = "" Then searchRole = "User" ' デフォルト検索値

    ' データベース接続文字列（環境に合わせて調整してください）
    ' 例: SQL Server 認証の例
    connStr = "Provider=MSOLEDBSQL;Data Source=localhost;Initial Catalog=sampleDB;User ID=sa;Password=sasa;"


    ' --------------------------------------------------
    ' 2. データベース接続とパラメータ化クエリの実行
    ' --------------------------------------------------
    ' On Error Resume Next ' エラーハンドリングを行う場合は有効化

    ' Connectionオブジェクト作成・接続オープン
    Set conn = Server.CreateObject("ADODB.Connection")
    conn.Open connStr

    ' Commandオブジェクト作成
    Set cmd = Server.CreateObject("ADODB.Command")
    Set cmd.ActiveConnection = conn

    ' プレースホルダー（?）を使ったSQL構文の設定
    cmd.CommandText = "SELECT UserId, UserName, UserRole FROM Users WHERE UserRole = ?"

    ' パラメータの追加: CreateParameter(名前, 型, 方向, サイズ, 値)
    cmd.Parameters.Append cmd.CreateParameter("@UserRole", adVarChar, adParamInput, 20, searchRole)

    ' クエリ実行と Recordset の取得
    Set rs = cmd.Execute()
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Step 5 - データベース連携（ADO）</title>
    <style>
        body { font-family: sans-serif; margin: 20px; }
        table { border-collapse: collapse; width: 100%; max-width: 600px; margin-top: 15px; }
        th, td { border: 1px solid #ccc; padding: 8px 12px; text-align: left; }
        th { background: #f2f2f2; }
    </style>
</head>
<body>

    <h1>Step 5: データベース連携（ADO）</h1>

    <!-- 検索フォーム -->
    <form action="step5.asp" method="post">
        <label>ロールで検索: </label>
        <select name="txtRole">
            <option value="User" <% If searchRole = "User" Then Response.Write "selected" %>>User</option>
            <option value="Admin" <% If searchRole = "Admin" Then Response.Write "selected" %>>Admin</option>
        </select>
        <input type="submit" value="検索">
    </form>

    <hr>

    <h2>検索結果（ロール: <%= Server.HTMLEncode(searchRole) %>）</h2>

    <!-- レコードセットのループ処理と表示 -->
    <% If rs.EOF Then %>
        <p>該当するユーザーが見つかりませんでした。</p>
    <% Else %>
        <table>
            <thead>
                <tr>
                    <th>ユーザーID</th>
                    <th>ユーザー名</th>
                    <th>ロール</th>
                </tr>
            </thead>
            <tbody>
                <%
                    ' EOF（ファイル末尾 / レコード末尾）に達するまでループ
                    Do Until rs.EOF
                %>
                    <tr>
                        <td><%= Server.HTMLEncode(rs("UserId") & "") %></td>
                        <td><%= Server.HTMLEncode(rs("UserName") & "") %></td>
                        <td><%= Server.HTMLEncode(rs("UserRole") & "") %></td>
                    </tr>
                <%
                        ' 次のレコードへ移動（これを忘れると無限ループになります！）
                        rs.MoveNext
                    Loop
                %>
            </tbody>
        </table>
    <% End If %>

</body>
</html>
<%
    ' --------------------------------------------------
    ' 3. リソースの解散・破棄（必須）
    ' --------------------------------------------------
    ' 生成した逆順で Close および Nothing 代入を行うのが標準的
    If Not rs Is Nothing Then
        If rs.State = 1 Then rs.Close ' 1 = adStateOpen
        Set rs = Nothing
    End If

    Set cmd = Nothing

    If Not conn Is Nothing Then
        If conn.State = 1 Then conn.Close
        Set conn = Nothing
    End If
%>