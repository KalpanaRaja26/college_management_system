<%
Dim conn, sql, rs, subjectName, theoryHours, labHours, labMarks, theoryMarks, degID, newSubID, newComponentID, degName

' Create connection
Set conn = Server.CreateObject("ADODB.Connection")
conn.Open "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\Users\sony\Documents\college_management_system.accdb;Persist Security Info=False;"

' Retrieve form values
subjectName = Request.Form("subject_name")
theoryHours = Request.Form("theory_hours")
labHours = Request.Form("lab_hours")
labMarks = Request.Form("lab_marks")
theoryMarks = Request.Form("theory_marks")
degName = Request.Form("degree_name")

' Validate required fields
If subjectName = "" Or degName = "" Then
    Response.Write "<script>alert('Subject Name and Degree Name are required!');history.back();</script>"
    Response.End
End If

' Fetch Deg_Id from degree_course_table
sql = "SELECT Deg_Id FROM degree_course_table WHERE Deg_Name = '" & degName & "'"
Set rs = conn.Execute(sql)
If Not rs.EOF Then
    degID = rs("Deg_Id")
Else
    Response.Write "<script>alert('Degree not found! Please check the Degree Name.');history.back();</script>"
    Response.End
End If
rs.Close

' Generate new Sub_Id
sql = "SELECT TOP 1 Sub_Id FROM Degree_subject_table ORDER BY Sub_Id DESC"
Set rs = conn.Execute(sql)
If Not rs.EOF Then
    newSubID = Mid(rs("Sub_Id"), 4) + 1
    newSubID = "SUB" & Right("0000" & newSubID, 4)
Else
    newSubID = "SUB0001"
End If
rs.Close

' Generate new Component_Id
sql = "SELECT TOP 1 Component_Id FROM Degree_subject_table ORDER BY Component_Id DESC"
Set rs = conn.Execute(sql)
If Not rs.EOF Then
    newComponentID = Mid(rs("Component_Id"), 4) + 1
    newComponentID = "CMP" & Right("0000" & newComponentID, 4)
Else
    newComponentID = "CMP0001"
End If
rs.Close

' Insert into Degree_subject_table
sql = "INSERT INTO Degree_subject_table (Sub_Id, Deg_Id, Sub_Name, Component_Id, Th_Hrs, Th_Marks, Lab_Hrs, Lab_Marks) " & _
      "VALUES ('" & newSubID & "', '" & degID & "', '" & subjectName & "', '" & newComponentID & "', " & theoryHours & ", " & theoryMarks & ", " & labHours & ", " & labMarks & ")"
conn.Execute sql

' Close connection
conn.Close
Set conn = Nothing

' Styled Success Message
Response.Write "<!DOCTYPE html>"
Response.Write "<html lang='en'>"
Response.Write "<head>"
Response.Write "<meta charset='UTF-8'>"
Response.Write "<title>Subject Added</title>"
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
Response.Write "<h2>Subject details added successfully!</h2>"
Response.Write "<p>Generated Subject ID: <strong>" & newSubID & "</strong></p>"
Response.Write "<div class='button-container'>"
Response.Write "<a href='subject_form.html' class='button'>Add Another</a>"
Response.Write "<a href='admin_dashboard.asp' class='button'>Back to Dashboard</a>"
Response.Write "</div>"
Response.Write "</div>"
Response.Write "</body>"
Response.Write "</html>"
%>
