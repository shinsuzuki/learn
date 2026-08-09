<%

' --------------------------------------------------
' ADO 定義
' --------------------------------------------------
Const adVarChar   = 200
Const adInteger  = 3
Const adBoolean  = 11
Const adParamInput = 1

' --------------------------------------------------
' DB接続文字列
' --------------------------------------------------
Function GetConnectionString()
    GetConnectionString = "Provider=MSOLEDBSQL;Data Source=localhost;Initial Catalog=sampleDB;User ID=sa;Password=sasa;"
End Function

' --------------------------------------------------
' DB接続を開く
' --------------------------------------------------
Function OpenDBConnection()
    Dim conn
    Set conn = Server.CreateObject("ADODB.Connection")
    conn.Open GetConnectionString()
    Set OpenDBConnection = conn
End Function

' --------------------------------------------------
' ADOオブジェクトのリソース解放
' --------------------------------------------------
Sub CloseDB(ByRef pConn, ByRef pCmd, ByRef pRs)
    On Error Resume Next

    ' Recordset 解放
    If IsObject(pRs) Then
        If Not pRs Is Nothing Then
            If pRs.State = 1 Then pRs.Close
            Set pRs = Nothing
        End If
    End If

    ' Command 解放
    If IsObject(pCmd) Then
        If Not pCmd Is Nothing Then Set pCmd = Nothing
    End If

    ' Connection 解放
    If IsObject(pConn) Then
        If Not pConn Is Nothing Then
            If pConn.State = 1 Then pConn.Close
            Set pConn = Nothing
        End If
    End If

    On Error GoTo 0
End Sub

' --------------------------------------------------
' 安全なリダイレクト（リソース解放を行ってから遷移）
' --------------------------------------------------
Sub SafeRedirect(url, ByRef pConn, ByRef pCmd, ByRef pRs)
    ' リダイレクト直前に確実にクリーンアップを実行
    Call CloseDB(pConn, pCmd, pRs)
    Response.Redirect url
End Sub

%>