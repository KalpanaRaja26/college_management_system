<%
' Database connection
Dim db, rs, sql, collegeId, newId, collegeName, principalStaffId, noOfCourses, noOfStaff, collegeEmail

' Get form data
collegeName = Trim(Request.Form("college_name"))
noOfCourses = Trim(Request.Form("no_of_courses"))
noOfStaff = Trim(Request.Form("no_of_staff"))
collegeEmail = Trim(Request.Form("college_email"))

' Validate required fields
If collegeName = "" Or noOfCourses = "" Or noOfStaff = "" Or collegeEmail = "" Then
    Response.Write "<h3>All fields are required. Please fill in the missing details.</h3>"
    Response.End
End If

' Connect to database
Set db = Server.CreateObject("ADODB.Connection")
db.Provider = "Microsoft.ACE.OLEDB.12.0"
db.Open "C:\Users\sony\Documents\college_management_system.accdb"

' Generate new College_Id in "CL0001" format
Set rs = db.Execute("SELECT MAX(College_Id) AS MaxId FROM College_Table")

' Check if MaxId is valid
If Not rs.EOF And Not IsNull(rs("MaxId")) Then
    Dim maxIdStr
    maxIdStr = rs("MaxId") ' Store the max College_Id as a string
    
    ' Extract numeric part from "CL0001"
    If IsNumeric(Mid(maxIdStr, 3)) Then
        newId = CInt(Mid(maxIdStr, 3)) + 1 ' Convert to number and increment
    Else
        newId = 1 ' Default to 1 if extraction fails
    End If
Else
    newId = 1 ' Start from CL0001 if no records exist
End If
rs.Close

' Format new College_Id as "CL0001"
collegeId = "CL" & Right("0000" & newId, 4)

' Try fetching Principal_Staff_Id from Staff Table
Set rs = db.Execute("SELECT TOP 1 Staff_Id FROM Staff_Table WHERE UCASE(Designation) = 'PRINCIPAL' ORDER BY Staff_Id ASC")
If Not rs.EOF Then
    principalStaffId = rs("Staff_Id") ' Use the found Staff ID
    principalStaffIdSQL = "'" & principalStaffId & "'" ' Enclose in quotes for SQL
Else
    principalStaffId = "NULL" ' Store NULL if no staff is available
    principalStaffIdSQL = "NULL" ' Use NULL in SQL
End If
rs.Close

' Insert data into College_Table
sql = "INSERT INTO College_Table (College_Id, College_Name, Principal_Staff_Id, No_of_Courses, No_of_Staff, College_Email_ID) " & _
      "VALUES ('" & collegeId & "', '" & collegeName & "', " & principalStaffIdSQL & ", " & noOfCourses & ", " & noOfStaff & ", '" & collegeEmail & "')"

' Debugging: Print the SQL Query
' Response.Write "<p>SQL Query: " & sql & "</p>"

db.Execute sql

Response.Write "<!DOCTYPE html>"
Response.Write "<html lang='en'>"
Response.Write "<head>"
Response.Write "<meta charset='UTF-8'>"
Response.Write "<title>College Added</title>"
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
Response.Write "<h2>College details added successfully!</h2>"
Response.Write "<p>Generated College ID: <strong>" & collegeId & "</strong></p>"
Response.Write "<div class='button-container'>"
Response.Write "<a href='college_form.html' class='button'>Add Another</a>"
Response.Write "<a href='admin_dashboard.asp' class='button'>Back to Dashboard</a>"
Response.Write "</div>"
Response.Write "</div>"
Response.Write "</body>"
Response.Write "</html>"



' Close connection
db.Close
Set db = Nothing
%>

