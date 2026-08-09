<%@ Language="VBScript" %>
<html>
    <body>
        <% Response.Write("Hello from Classic ASP! " & Now()) %>

        <%
            '---------- 変数
            Dim name
            name = "Taro"
            Response.Write("<br>Hello, " & name & "! Welcome to Classic ASP.")

            '---------- IF
            if name = "Taro" Then
                Response.Write("<br>You are a valued user.")
            Else
                Response.Write("<br>Hello, guest!")
            End If

            '---------- For Loop
            for i = 1 to 5
                Response.Write("<br>Count: " & i)
            next

            '---------- Do While
            Response.Write("<br>")
            dim i: i = 0
            Do While i < 3
                Response.Write("<br>i is now: " & i)
                i = i + 1
            Loop

            i = 0
            Do
                Response.Write("<br>i is now: " & i)
                i = i + 1
            Loop While i < 2

            '---------- 関数
            Function GreetUser(userName)
                '  関数名に値を設定すると戻り値になる
                GreetUser = "Hello, " & userName & "! This is a function in Classic ASP."
            End Function
            Response.Write("<br>" & GreetUser(name))

            '---------- Sub(値を返さない)
            Sub ShowMessage(message)
                Response.Write("<br>" & message)
            End Sub
            ShowMessage("This is a subroutine in Classic ASP.")


            '---------- 配列
            Dim arr
            arr = Array("Apple", "Banana", "Cherry")
            Response.Write("<br>Fruits in the array:")

            Dim fruit
            For Each fruit In arr
                Response.Write("<br>" & fruit)
            Next

            ' 中身を保持したままサイズを変える(Redim Preserve)
            ' Ubound関数は配列の最大インデックスを返す
            Redim Preserve arr(Ubound(arr) + 2)
            arr(3) = "Date"
            arr(4) = "Elderberry"
            Response.Write("<br>Updated Fruits in the array:")
            For Each fruit In arr
                If Not IsEmpty(fruit) Then
                    Response.Write("<br>" & fruit)
                End If
            Next

            '---------- 辞書
            Dim dict
            Set dict = Server.CreateObject("Scripting.Dictionary")
            dict.Add "Name", "Taro"
            dict.Add "Age", 30
            Response.Write("<br>User Info from Dictionary:")
            Dim key
            For Each key In dict.Keys
                Response.Write("<br>" & key & ": " & dict(key))
            Next

            ' キーチェック
            if dict.Exists("Age") Then
                Response.Write("<br>Age exists in the dictionary.")
            Else
                Response.Write("<br>Age does not exist in the dictionary.")
            End If

            ' ---------- select case
            Dim dayOfWeek
            dayOfWeek = Weekday(Now())
            Select Case dayOfWeek
                Case 1
                    Response.Write("<br>Today is Sunday.")
                Case 2
                    Response.Write("<br>Today is Monday.")
                Case 3
                    Response.Write("<br>Today is Tuesday.")
                Case 4
                    Response.Write("<br>Today is Wednesday.")
                Case 5
                    Response.Write("<br>Today is Thursday.")
                Case 6
                    Response.Write("<br>Today is Friday.")
                Case 7
                    Response.Write("<br>Today is Saturday.")
                Case Else
                    Response.Write("<br>Unknown day.")
            End Select

            ' ----------



        %>
    </body>
</html>