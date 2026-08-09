<%@ Language="VBScript" CODEPAGE="65001" %>
<%
    ' Step 3: Webリクエストとレスポンス
    ' ASPはデフォルトでShift_JISなので、UTF-8を使う場合は明示的に指定する必要があります。
    Option Explicit
    Response.CharSet = "UTF-8"
%>

<%
    ' --------------------------------------------------
    ' 1. 変数の宣言
    ' --------------------------------------------------
    Dim reqMethod, userName, userComment, categoryId

    ' 実行されたHTTPメソッド（GET か POST か）を取得
    reqMethod = Request.ServerVariables("REQUEST_METHOD")

    ' --------------------------------------------------
    ' 2. リクエストデータの取得
    ' --------------------------------------------------
    ' POSTデータの取得（フォーム送信時）
    userName = Request.Form("txtName")
    userComment = Request.Form("txtComment")

    ' GETデータの取得（URLパラメータ送信時）
    categoryId = Request.QueryString("cat")
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Step 3 - リクエストとレスポンスの処理</title>
    <style>
        body { font-family: sans-serif; margin: 20px; }
        .result-box { background: #f0f4f8; padding: 15px; border-radius: 4px; margin-top: 15px; }
        .alert { color: #d9534f; }
    </style>
</head>
<body>

    <h1>Webリクエストとレスポンスの処理</h1>

    <!-- GETパラメータの動作確認用リンク -->
    <p>
        URLパラメータ（GET）のテスト:
        <a href="step3.asp?cat=101">カテゴリ101</a> |
        <a href="step3.asp?cat=202">カテゴリ202</a>
    </p>

    <hr>

    <!-- フォーム入力（POST） -->
    <h2>フォーム送信（POST）</h2>
    <form action="step3.asp" method="post">
        <p>
            お名前：<br>
            <input type="text" name="txtName" value="<%= Server.HTMLEncode(userName) %>" size="30">
        </p>
        <p>
            コメント：<br>
            <textarea name="txtComment" rows="4" cols="40"><%= Server.HTMLEncode(userComment) %></textarea>
        </p>
        <p>
            <input type="submit" value="送信する">
        </p>
    </form>

    <!-- -------------------------------------------------- -->
    <!-- 3. 受信結果の出力（Response）                      -->
    <!-- -------------------------------------------------- -->
    <% If reqMethod = "POST" Then %>
        <div class="result-box">
            <h3>POST送信を受信しました</h3>
            <% If Trim(userName) = "" Then %>
                <p class="alert">※お名前が入力されていません。</p>
            <% Else %>
                <p><strong>お名前：</strong> <%= Server.HTMLEncode(userName) %></p>
                <p><strong>コメント：</strong><br>
                <!-- 改行コード（vbCrLf）を <br> タグに変換して表示 -->
                <%= Replace(Server.HTMLEncode(userComment), vbCrLf, "<br>") %>

                <%= userName %>
                <%= userComment %>
                </p>
            <% End If %>
        </div>
    <% End If %>

    <% If categoryId <> "" Then %>
        <div class="result-box">
            <h3>GETパラメータを受信しました</h3>
            <p><strong>選択されたカテゴリID：</strong> <%= Server.HTMLEncode(categoryId) %></p>
        </div>
    <% End If %>

</body>
</html>