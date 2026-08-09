<%@ Language="VBScript" CODEPAGE="65001" %>
<% Option Explicit %>
<%
    ' ASPはデフォルトでShift_JISなので、UTF-8を使う場合は明示的に指定する必要があります。
    Response.CharSet = "UTF-8"
%>

<html>
    <body>
        <div>
            <h1>Classic ASP Example</h1>
            <% Response.Write("Hello from Classic ASP! " & Now()) %>
        </div>

        <%
            If Request.Form("action") = "bunpou" Then

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
            End If
        %>

        <!-- Response.Writeの短縮  -->
        <%= "<br>文字列結合: " & "Hello" & " " & "World!" %>

        <!-- 通常のASPコード実行 -->
        <%
            Dim currentTime
            currentTime = Now()
            Response.Write("<br>現在の日時: " & currentTime)
        %>

        <!-- If 展開 -->
        <div>
            <% dim attackPoint: attackPoint = 100 %>

            <% If attackPoint >= 100 Then %>
                <p>攻撃力が100以上 (<%= attackPoint %>)</p>
            <% ElseIf attackPoint >= 50 Then %>
                <p>攻撃力が50以上 :(<%= attackPoint %>)</p>
            <% Else %>
                <p>攻撃力が50未満 :(<%= attackPoint %>)</p>
            <% End If %>
        </div>

        <!-- For 展開 -->
        <div>
            <% dim loopCount: loopCount = 3 %>
            <% For i = 1 To loopCount %>
                <span>ループ回数: <%= i %></span><br>
            <% Next %>
        </div>

        <!-- For Each 展開 -->
        <%
            Dim fruits
            fruits = Array("Apple", "Banana", "Cherry")
        %>
        <div>
            <% For Each fruit In fruits %>
                <span>果物: <%= fruit %></span><br>
            <% Next %>
        </div>

        <!-- 配列動的-->
        <%
            ' Dimから作成した配列は、ReDimでサイズを変更可能
            Dim dynamicArray()
            ReDim dynamicArray(2)
            dynamicArray(0) = "Red"
            dynamicArray(1) = "Green"
            dynamicArray(2) = "Blue"

            ' 配列のサイズを変更
            ReDim Preserve dynamicArray(4)
            dynamicArray(3) = "Yellow"
            dynamicArray(4) = "Purple"


        %>
        <div>
            <% Dim color: For Each color In dynamicArray %>
                <span>色: <%= color %></span><br>
            <% Next %>
        </div>

        <!-- 辞書 -->
        <%
            Dim dict_1
            Set dict_1 = Server.CreateObject("Scripting.Dictionary")
            dict_1.Add "Name", "Taro"
            dict_1.Add "Age", 30
            dict_1.Add "Country", "Japan"
        %>
        <div>
            <% For Each key In dict_1.Keys %>
                <span><%= key %>: <%= dict_1(key) %></span><br>
            <% Next %>
        </div>

        <!-- 関数 -->
        <%
            ' 関数の定義
            Function GreetUser(userName)
                GreetUser = "Hello, " & userName & "! Welcome to Classic ASP."
            End Function

            dim message: message = GreetUser("Taro")
            Response.Write("<br>" & message)

            ' 関数の戻り値が「配列」や「オブジェクト」の場合は、代入時にSetが必須
            dim userInfo: Set userInfo = CreateObject("Scripting.Dictionary")
            userInfo.Add "Name", "Taro"
            userInfo.Add "Age", 30

            Function GetUserInfo()
                Set GetUserInfo = userInfo
            End Function

            dim info: Set info = GetUserInfo()
            Response.Write("<br>User Info: Name=" & info("Name") & ", Age=" & info("Age"))

            ' Subの定義
            Sub ShowMessage(message)
                Response.Write("<br>" & message)
            End Sub
            ShowMessage("This is a subroutine in Classic ASP.")

        %>

    </body>
</html>