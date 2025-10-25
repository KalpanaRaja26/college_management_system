<%
' Database connection
Dim db, rs, sql, staffId, newId, staffName, designation, email, mobile, deptId, deptName, collegeId

' Get form data
staffName = Request.Form("staff_name")
designation = Request.Form("designation")
email = Request.Form("email")
mobile = Request.Form("mobile")
deptId = Request.Form("dept_id")

' Validate required fields
If staffName = "" Or designation = "" Or email = "" Or mobile = "" Or deptId = "" Then
    Response.Write "<h3>All required fields must be filled!</h3>"
    Response.End
End If

' Connect to database
Set db = Server.CreateObject("ADODB.Connection")
db.Provider = "Microsoft.ACE.OLEDB.12.0"
db.Open "C:\Users\sony\Documents\college_management_system.accdb"

' Get Department Name
Set rs = db.Execute("SELECT Dept_Name FROM Dept_Table WHERE Dept_Id = " & deptId)
If Not rs.EOF Then
    deptName = rs("Dept_Name")
Else
    deptName = "Unknown"
End If
rs.Close

' Generate Staff_Id
Set rs = db.Execute("SELECT MAX(Staff_Id) AS MaxId FROM Staff_Table")
If Not rs.EOF And Not IsNull(rs("MaxId")) Then
    Dim maxIdStr
    maxIdStr = rs("MaxId")
    If IsNumeric(Mid(maxIdStr, 3)) Then
        newId = CInt(Mid(maxIdStr, 3)) + 1
    Else
        newId = 1
    End If
Else
    newId = 1
End If
rs.Close

staffId = "ST" & Right("0000" & newId, 4)

' Insert into Staff_Table
sql = "INSERT INTO Staff_Table (Staff_Id, Staff_Name, Designation, [Email-Id], Mobile_No, Dept_Name, Dept_Id) " & _
      "VALUES ('" & staffId & "', '" & staffName & "', '" & designation & "', '" & email & "', '" & mobile & "', '" & deptName & "', " & deptId & ")"
db.Execute sql

' If Principal, update College_Table
If UCase(designation) = "PRINCIPAL" Then
    Set rs = db.Execute("SELECT TOP 1 College_Id FROM College_Table ORDER BY College_Id ASC")
    If Not rs.EOF Then
        collegeId = rs("College_Id")
        db.Execute "UPDATE College_Table SET Principal_Staff_Id = '" & staffId & "' WHERE College_Id = '" & collegeId & "'"
    End If
    rs.Close
End If

' Output styled HTML
Response.Write "<!DOCTYPE html>"
Response.Write "<html lang='en'>"
Response.Write "<head>"
Response.Write "<meta charset='UTF-8'>"
Response.Write "<title>Staff Added</title>"
Response.Write "<style>"
Response.Write "body{font-family:Segoe UI,Tahoma,Geneva,Verdana,sans-serif;background-color:#f0f2f5;color:#333;margin:0;padding:0;}"
Response.Write ".container{max-width:600px;margin:100px auto;background:#fff;padding:30px;border-radius:12px;box-shadow:0 4px 12px rgba(0,0,0,0.1);text-align:center;}"
Response.Write "h2{color:#1b263b;}"
Response.Write ".button-container{display:flex;justify-content:center;gap:20px;flex-wrap:wrap;margin-top:20px;}"
Response.Write "a.button{display:inline-block;padding:10px 20px;background:#415a77;color:#fff;text-decoration:none;border-radius:6px;font-weight:bold;transition:background-color 0.3s ease;}"
Response.Write "a.button:hover{background:#778da9;}"
Response.Write "</style>"
Response.Write "</head>"
Response.Write "<body>"
Response.Write "<div class='container'>"
Response.Write "<h2>Staff details added successfully!</h2>"
Response.Write "<p>Generated Staff ID: <strong>" & staffId & "</strong></p>"

If UCase(designation) = "PRINCIPAL" Then
    Response.Write "<p>Updated Principal in College ID: <strong>" & collegeId & "</strong></p>"
End If

Response.Write "<div class='button-container'>"
Response.Write "<a href='staff_form.html' class='button'>Add Another</a>"
Response.Write "<a href='admin_dashboard.asp' class='button'>Back to Dashboard</a>"
Response.Write "</div>"
Response.Write "</div>"
Response.Write "</body>"
Response.Write "</html>"

' Close DB
db.Close
Set db = Nothing
%>
