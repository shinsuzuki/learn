<%@ Language="VBScript" CODEPAGE="65001"%>
<%
    ' Step 4: 状態管理（Cookie & Session）
    ' ASPはデフォルトでShift_JISなので、UTF-8を使う場合は明示的に指定する必要があります。
    Option Explicit
    Response.CharSet = "UTF-8"
%>

<%
    Response.CharSet = "UTF-8"

    ' --------------------------------------------------
    ' 1. 変数の宣言と処理分岐
    ' --------------------------------------------------
    Dim action, inputUser, sessionUser, cookieUser, lastVisit

    action = Request.Form("action")

    ' --- A. ログイン処理（Session & Cookie のセット） ---
    If action = "login" Then
        inputUser = Request.Form("txtUser")

        If Trim(inputUser) <> "" Then
            ' 1. Sessionにログインユーザー名を保存（ブラウザを閉じるまで有効）
            Session("UserName") = inputUser

            ' 2. Cookieにユーザー名を30日間保存
            Response.Cookies("SavedUser") = inputUser
            Response.Cookies("SavedUser").Expires = DateAdd("d", 30, Now())
            ' HttpOnly は Classic ASP の Response.Cookies で未サポートのため
            ' AddHeader で付与する（必要に応じて）
            Response.AddHeader "Set-Cookie", "SavedUser=" & Server.URLEncode(inputUser) & "; path=/; HttpOnly"

            ' 3. Cookieに最終訪問日時を記録
            Response.Cookies("LastVisit") = Now()
            Response.Cookies("LastVisit").Expires = DateAdd("d", 30, Now())
        End If

    ' --- B. ログアウト処理（Sessionの破棄 & Cookieの削除） ---
    ElseIf action = "logout" Then
        ' Sessionを破棄（保持している全Session変数が消去される）
        Session.Abandon()

        ' Cookieを削除（有効期限を過去の日時に設定して上書き）
        Response.Cookies("SavedUser") = ""
        Response.Cookies("SavedUser").Expires = DateAdd("d", -1, Now())

        ' 処理後、画面を再読み込みして状態をクリア
        Response.Redirect("step4.asp")
    End If

    ' --------------------------------------------------
    ' 2. 現在の状態の読み込み
    ' --------------------------------------------------
    ' Sessionから値を取得
    sessionUser = Session("UserName")

    ' Cookieから値を取得
    cookieUser = Request.Cookies("SavedUser")
    lastVisit = Request.Cookies("LastVisit")
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Step 4 - CookieとSessionによる状態管理</title>
    <style>
        body { font-family: sans-serif; margin: 20px; }
        .box { background: #f9f9f9; border: 1px solid #ccc; padding: 15px; border-radius: 5px; margin-bottom: 20px; }
        .status { font-weight: bold; color: #0066cc; }
    </style>
</head>
<body>

    <h1>Step 4: 状態管理（Cookie & Session）</h1>

    <!-- 現在の状態表示 -->
    <div class="box">
        <h2>現在の状態</h2>
        <p>Session上のユーザー（ログイン状態）:
            <span class="status"><%= Server.HTMLEncode(sessionUser & "") %></span>
            <% If sessionUser = "" Then %>(未ログイン)<% End If %>
        </p>
        <p>Cookieに保存されているユーザー:
            <span class="status"><%= Server.HTMLEncode(cookieUser & "") %></span>
        </p>
        <p>前回の訪問日時（Cookie）:
            <span class="status"><%= Server.HTMLEncode(lastVisit & "") %></span>
        </p>
    </div>

    <!-- 操作フォーム -->
    <div class="box">
        <% If sessionUser = "" Then %>
            <h2>ログインフォーム</h2>
            <form action="step4.asp" method="post">
                <input type="hidden" name="action" value="login">
                <p>
                    ユーザー名：<br>
                    <!-- Cookieに保存された値があれば、初期値としてセット -->
                    <input type="text" name="txtUser" value="<%= Server.HTMLEncode(cookieUser & "") %>">
                </p>
                <p>
                    <input type="submit" value="ログインする">
                </p>
            </form>
        <% Else %>
            <h2>ログアウト</h2>
            <form action="step4.asp" method="post">
                <input type="hidden" name="action" value="logout">
                <p>
                    <input type="submit" value="ログアウトする（Session破棄 & Cookie削除）">
                </p>
            </form>
        <% End If %>
    </div>

</body>
</html>