<%
Response.ContentType = "text/html"

' Connect to database  
Set db = Server.CreateObject("ADODB.Connection")  
db.Provider = "Microsoft.ACE.OLEDB.12.0"  
db.Open "C:\Users\sony\Documents\college_management_system.accdb"  

' Fetch staff who are eligible to be HOD  
Set rs = db.Execute("SELECT Staff_Id, Staff_Name FROM Staff_Table")  

' Generate options for the dropdown  
Do While Not rs.EOF  
    Response.Write "<option value='" & rs("Staff_Id") & "'>" & rs("Staff_Name") & " (" & rs("Staff_Id") & ")</option>"  
    rs.MoveNext  
Loop  

rs.Close  
db.Close  
%>
