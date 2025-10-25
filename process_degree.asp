<%
Dim conn, sql, rs, degreeName, specialization, numYears, syllabusReg, startingYear, deptID, newDegID

Set conn = Server.CreateObject("ADODB.Connection")
conn.Open "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\Users\sony\Documents\college_management_system.accdb;Persist Security Info=False;"

degreeName = Trim(Request.Form("degree_name"))
specialization = Trim(Request.Form("specialization"))
numYears = Trim(Request.Form("num_years"))
syllabusReg = Trim(Request.Form("syllabus_reg"))
startingYear = Trim(Request.Form("starting_year"))

If degreeName = "" Or numYears = "" Or syllabusReg = "" Or startingYear = "" Then
    Response.Write "<h3>Error: All required fields must be filled.</h3>"
    Response.End
End If

If Not IsNumeric(numYears) Or Not IsNumeric(startingYear) Then
    Response.Write "<h3>Error: Number of Years and Starting Year must be numeric values.</h3>"
    Response.End
End If

numYears = CInt(numYears)
startingYear = CInt(startingYear)

sql = "SELECT TOP 1 Deg_Id FROM degree_course_table ORDER BY Deg_Id DESC"
Set rs = conn.Execute(sql)

If Not rs.EOF Then
    newDegID = Mid(rs("Deg_Id"), 4) + 1
    newDegID = "DEG" & Right("0000" & newDegID, 4)
Else
    newDegID = "DEG0001"
End If
rs.Close

sql = "SELECT Dept_Id FROM Dept_table WHERE Dept_Name = '" & degreeName & "'"
Set rs = conn.Execute(sql)

If Not rs.EOF Then
    deptID = rs("Dept_Id")
Else
    Response.Write "<h3>Error: Department name '" & degreeName & "' not found in Dept_table.</h3>"
    Response.End
End If
rs.Close

sql = "INSERT INTO degree_course_table (Deg_Id, Dept_Id, Deg_Name, Deg_Specialization, No_of_years, Syllabus_Regulation, Deg_Starting_year) " & _
      "VALUES ('" & newDegID & "', " & deptID & ", '" & degreeName & "', '" & specialization & "', " & numYears & ", '" & syllabusReg & "', " & startingYear & ")"

conn.Execute sql

conn.Close
Set conn = Nothing

' Final HTML success message
Response.Write "<!DOCTYPE html>"
Response.Write "<html lang='en'>"
Response.Write "<head>"
Response.Write "<meta charset='UTF-8'>"
Response.Write "<title>Degree Added</title>"
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
Response.Write "<h2>Degree course details added successfully!</h2>"
Response.Write "<p>Generated Degree ID: <strong>" & newDegID & "</strong></p>"
Response.Write "<div class='button-container'>"
Response.Write "<a href='degree_form.html' class='button'>Add Another</a>"
Response.Write "<a href='admin_dashboard.asp' class='button'>Back to Dashboard</a>"
Response.Write "</div>"
Response.Write "</div>"
Response.Write "</body>"
Response.Write "</html>"
%>
