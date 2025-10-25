<%
Function OpenDatabaseConnection()
    Dim conn
    Set conn = Server.CreateObject("ADODB.Connection")
    conn.Provider = "Microsoft.ACE.OLEDB.12.0"
    conn.Open "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\Users\sony\Documents\college_management_system.accdb;Persist Security Info=False;"
    Set OpenDatabaseConnection = conn
End Function

%>
