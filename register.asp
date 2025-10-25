<!-- #include file="dbconnect.asp" -->

<%
' Set database connection details
Dim db, username, email, user_password, role, sql

' Initialize database connection
Set db = OpenDatabaseConnection() ' This should connect to your database

' Get form values
username = Trim(Request.Form("username"))
email = Trim(Request.Form("email"))
user_password = Trim(Request.Form("password"))
role = Trim(Request.Form("role"))

' Validate inputs
If username = "" Or email = "" Or user_password = "" Or role = "" Then
    Response.Write("All fields are required.")
    Response.End
End If

' Check if the email already exists
Dim rs
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open "SELECT * FROM Users WHERE Email = '" & email & "'", db, 1, 3

If Not rs.EOF Then
    Response.Write("Email already registered. Please use a different email.")
    rs.Close
    Set rs = Nothing
    db.Close
    Set db = Nothing
    Response.End
End If

' Close recordset
rs.Close
Set rs = Nothing

' Use an SQL INSERT query to add the new user (brackets around [Password])
sql = "INSERT INTO Users (Username, Email, [Password], Role) " & _ 
      "VALUES ('" & username & "', '" & email & "', '" & user_password & "', '" & role & "')"

' Execute the SQL query
db.Execute sql, , 1 ' Using adCmdText (1) to ensure execution


' Set session variable to log the user in
Session("userEmail") = email
Session("userRole") = role

' Close database connection
db.Close
Set db = Nothing

' Redirect based on role
role = LCase(role)

If role = "student" Then
    Response.Redirect("student_dashboard.asp")
ElseIf role = "faculty" Then
    Response.Redirect("faculty_dashboard.asp")
ElseIf role = "admin" Then
    Response.Redirect("admin_dashboard.asp")
Else
    Response.Write("<p>Invalid role. Please contact the administrator.</p>")
End If
%>
