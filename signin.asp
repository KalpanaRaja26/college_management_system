<!--#include file="dbconnect.asp" -->

<%
' Get form values
Dim email, password, role
email = Request.Form("email")
password = Request.Form("password")
role = Request.Form("role")

' Validate form inputs
If email = "" Or password = "" Or role = "" Then
    Response.Write("All fields are required.")
    Response.End
End If

' Initialize database connection
Set db = OpenDatabaseConnection()

' Query to check if the user exists in Users table
Dim rs, sql
sql = "SELECT * FROM Users WHERE email = '" & email & "' AND password = '" & password & "' AND role = '" & role & "'"

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, db

' Check if user exists
If rs.EOF Then
    Response.Write("Invalid email, password, or role.")
    rs.Close
    Set rs = Nothing
    db.Close
    Set db = Nothing
    Response.End
Else
    ' User exists - store basic session values
    Session("userEmail") = email
    Session("userRole") = role

    ' Fetch designation from Staff_table
    Dim rsStaff, sqlStaff
    Set rsStaff = Server.CreateObject("ADODB.Recordset")
    
    ' Make sure column names are correct based on your table definition
    sqlStaff = "SELECT Designation FROM Staff_table WHERE [Email-Id] = '" & email & "'"
    rsStaff.Open sqlStaff, db
    
    If Not rsStaff.EOF Then
        Session("designation") = Trim(rsStaff("Designation"))
    Else
        Session("designation") = ""
    End If
    
    rsStaff.Close
    Set rsStaff = Nothing
    


    ' Redirect to dashboard based on role
    If role = "Student" Then
        Response.Redirect("student_dashboard.asp")
    ElseIf role = "Faculty" Then
        Response.Redirect("faculty_dashboard.asp")
    ElseIf role = "Admin" Then
        Response.Redirect("admin_dashboard.asp")
    End If
End If

' Clean up
rs.Close
Set rs = Nothing
db.Close
Set db = Nothing
%>
