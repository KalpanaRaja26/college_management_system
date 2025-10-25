<%
' Enable error handling
On Error Resume Next

' Read the uploaded binary content
Dim binData, stream, fileName, filePath
binData = Request.BinaryRead(Request.TotalBytes)

Set stream = Server.CreateObject("ADODB.Stream")
stream.Type = 1 ' Binary
stream.Open
stream.Write binData
stream.Position = 0

' Generate a unique filename
fileName = "uploaded_" & Replace(Replace(Now(), ":", "-"), " ", "_") & ".pdf"
filePath = Server.MapPath("uploads/" & fileName)

stream.SaveToFile filePath, 2
stream.Close
Set stream = Nothing

' Get form fields
Dim note_desc, academic_year, semester, enable_notes
note_desc = Request.Form("note_desc")
academic_year = Request.Form("academic_year")
semester = Request.Form("semester")
enable_notes = Request.Form("enable_notes")

' Save to database
Dim conn, sql
Set conn = Server.CreateObject("ADODB.Connection")
conn.Open "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" & Server.MapPath("your_db.accdb")

sql = "INSERT INTO Notes (FilePath, NoteDesc, AcademicYear, Semester, EnableNotes) " & _
      "VALUES ('" & fileName & "', '" & note_desc & "', '" & academic_year & "', " & semester & ", " & enable_notes & ")"
conn.Execute sql
conn.Close
Set conn = Nothing

' Output styled HTML response
Response.Write "<!DOCTYPE html>"
Response.Write "<html lang='en'>"
Response.Write "<head>"
Response.Write "<meta charset='UTF-8'>"
Response.Write "<title>Note Uploaded</title>"
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
Response.Write "<h2>Note uploaded successfully!</h2>"
Response.Write "<div class='button-container'>"
Response.Write "<a href='Notes_form.asp' class='button'>Upload Another</a>"
Response.Write "<a href='faculty_dashboard.asp' class='button'>Back to Dashboard</a>"
Response.Write "</div>"
Response.Write "</div>"
Response.Write "</body>"
Response.Write "</html>"
%>
