<!-- #include file="db_connection.asp" -->
<!-- #include file="log_activity.asp" -->

<%
' Enable error handling
On Error Resume Next

' Check if the user is logged in
If Session("userEmail") = "" Then
    Response.Redirect("signin.asp")
    Response.End
End If

' Set user details from session
Dim userEmail, userRole
userEmail = Session("userEmail")
userRole = Session("userRole")

' Check if the user is an admin
If userRole <> "Admin" Then
    Response.Redirect("signin.asp")
    Response.End
End If

' Log that the admin accessed the Manage Users page
Call LogActivity(userEmail, "Accessed Manage Users Page")

' Initialize database connection
Dim db, rs
Set db = OpenDatabaseConnection()

' Query to fetch users
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open "SELECT ID, username, email, role FROM Users", db, 1, 3

' If there are no users, display a message
If rs.EOF Then
    Response.Write("<p style='color: red;'>No users found in the database.</p>")
Else
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users</title>
    <style>
        /* General Styles */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
}

body {
    background: linear-gradient(135deg, #6e39f5, #f5608e);
    color: #333;
    line-height: 1.6;
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
}

/* Container */
.container {
    width: 90%;
    max-width: 900px;
    background: white;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.2);
    text-align: center;
}

/* Header */
h1 {
    font-size: 28px;
    margin-bottom: 20px;
    color: #6e39f5;
}

/* Table */
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    background: white;
    border-radius: 10px;
    overflow: hidden;
}

th, td {
    border: 1px solid #ddd;
    padding: 12px;
    text-align: center;
}

th {
    background-color: #6e39f5;
    color: white;
}

td {
    background: #fafafa;
}

/* Delete Button */
a {
    text-decoration: none;
    padding: 8px 15px;
    background: #ff4d4d;
    color: white;
    font-weight: bold;
    border-radius: 5px;
    transition: all 0.3s ease;
}

a:hover {
    background: #cc0000;
    transform: scale(1.05);
}

/* Back Button */
.back-btn {
    display: inline-block;
    margin-top: 20px;
    padding: 12px 25px;
    background: #6e39f5;
    color: white;
    font-weight: bold;
    border-radius: 30px;
    font-size: 16px;
    transition: all 0.3s ease;
}

.back-btn:hover {
    background: #f5608e;
    transform: translateY(-3px);
}

/* Responsive Design */
@media (max-width: 768px) {
    .container {
        width: 95%;
        padding: 20px;
    }
    
    table {
        display: block;
        overflow-x: auto;
        white-space: nowrap;
    }
}
    </style>
</head>
<body>
    <div class="container">
        <h1>Manage Users</h1>
        <table>
            <tr>
                <th>Username</th>
                <th>Email</th>
                <th>Role</th>
                <th>Action</th>
            </tr>
            <%
            ' Loop through the records and display the users
            Do While Not rs.EOF
            %>
                <tr>
                    <td><%= Server.HTMLEncode(rs("username")) %></td>
                    <td><%= Server.HTMLEncode(rs("email")) %></td>
                    <td><%= Server.HTMLEncode(rs("role")) %></td>
                    <td>
                        <a href="delete_user.asp?id=<%= rs("ID") %>">Delete</a>
                    </td>
                </tr>
            <%
                rs.MoveNext
            Loop
            %>
        </table>
        <br>
        <a href="admin_dashboard.asp">Back to Dashboard</a>
    </div>
</body>
</html>

<%
End If

' Clean up
rs.Close
Set rs = Nothing
db.Close
Set db = Nothing
On Error GoTo 0
%>
