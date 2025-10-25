<%
' Database connection
Dim db, rs, sql, deptId, deptName, hodStaffId, studentsYear1, studentsYear2, studentsYear3

' Get form data
deptName = Trim(Request.Form("dept_name"))
studentsYear1 = Trim(Request.Form("students_year1"))
studentsYear2 = Trim(Request.Form("students_year2"))
studentsYear3 = Trim(Request.Form("students_year3"))

' Validate required fields
If deptName = "" Then
    Response.Write "<h3>Department Name is required!</h3>"
    Response.End
End If

' Convert empty student values to 0
If studentsYear1 = "" Then studentsYear1 = 0
If studentsYear2 = "" Then studentsYear2 = 0
If studentsYear3 = "" Then studentsYear3 = 0

' Connect to database
Set db = Server.CreateObject("ADODB.Connection")
db.Provider = "Microsoft.ACE.OLEDB.12.0"
db.Open "C:\Users\sony\Documents\college_management_system.accdb"

' Generate new Dept_Id
Set rs = db.Execute("SELECT MAX(Dept_Id) AS LastDeptId FROM Dept_Table")
If Not rs.EOF And Not IsNull(rs("LastDeptId")) Then
    deptId = rs("LastDeptId") + 1
Else
    deptId = 1
End If
rs.Close

' Fetch HOD Staff_Id
Set rs = db.Execute("SELECT TOP 1 Staff_Id FROM Staff_Table WHERE Designation = 'HOD' ORDER BY Staff_Id ASC")
If Not rs.EOF Then
    hodStaffId = "'" & rs("Staff_Id") & "'"
Else
    hodStaffId = "NULL"
End If
rs.Close

' Insert into Dept_Table
sql = "INSERT INTO Dept_Table (Dept_Id, Dept_Name, HOD_Staff_ID, No_of_Students_I, No_of_Students_II, No_of_Students_III) " & _
      "VALUES (" & deptId & ", '" & deptName & "', " & hodStaffId & ", " & studentsYear1 & ", " & studentsYear2 & ", " & studentsYear3 & ")"
db.Execute sql

' Update Staff_Table if HOD assigned
If hodStaffId <> "NULL" Then
    sql = "UPDATE Staff_Table SET Dept_Id = " & deptId & ", Dept_Name = '" & deptName & "' WHERE Staff_Id = " & hodStaffId
    db.Execute sql
End If

' Success message with HTML + CSS
Response.Write "<!DOCTYPE html>"
Response.Write "<html lang='en'>"
Response.Write "<head>"
Response.Write "<meta charset='UTF-8'>"
Response.Write "<title>Department Added</title>"
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
Response.Write "<h2>Department added successfully!</h2>"
Response.Write "<p>Generated Department ID: <strong>" & deptId & "</strong></p>"
Response.Write "<div class='button-container'>"
Response.Write "<a href='department_form.html' class='button'>Add Another</a>"
Response.Write "<a href='admin_dashboard.asp' class='button'>Back to Dashboard</a>"
Response.Write "</div>"
Response.Write "</div>"
Response.Write "</body>"
Response.Write "</html>"

' Cleanup
db.Close
Set db = Nothing
%>
