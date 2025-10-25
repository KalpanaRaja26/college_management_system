<!-- #include file="dbconnect.asp" -->

<%
On Error Resume Next

' Check if the user is logged in
Dim userEmail
userEmail = Session("userEmail")

' Destroy the session
Session.Abandon()

' Redirect to login page
Response.Redirect("login.html")
Response.End
%>
