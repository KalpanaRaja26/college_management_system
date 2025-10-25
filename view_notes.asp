<!-- #include file="dbconnect.asp" -->
<%
' Check if user is logged in
If Session("userEmail") = "" Then
    Response.Redirect("signin.asp") ' Redirect to signin page if not logged in
    Response.End
End If

' Get user email from session
Dim userEmail
userEmail = Session("userEmail")

' Open connection to the database
Dim db, rsNotes, sqlNotes
Set db = OpenDatabaseConnection()

' Query to get all the notes uploaded by the faculty (filtering by enabled notes)
sqlNotes = "SELECT Note_Id, NoteDesc, NoteFile FROM Notes_table WHERE EnableNotes = True"
Set rsNotes = db.Execute(sqlNotes)

' Check if there are notes available
If rsNotes.EOF Then
    noNotesAvailable = True
Else
    noNotesAvailable = False
End If
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Notes</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 0;
            color: #333;
        }
        .container {
            max-width: 900px;
            margin: 50px auto;
            padding: 30px;
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        h1 {
            color: #1b263b;
        }
        .note-list {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }
        .note-card {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 6px;
            width: 250px;
            padding: 15px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .note-card h2 {
            font-size: 18px;
            color: #2d3e50;
            margin-bottom: 10px;
        }
        .note-card p {
            font-size: 14px;
            color: #6c757d;
            margin-bottom: 15px;
        }
        .note-card a {
            display: inline-block;
            padding: 10px 20px;
            background-color: #415a77;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }
        .note-card a:hover {
            background-color: #778da9;
        }
        .button-container {
            margin-top: 20px;
        }
        .button-container a {
            display: inline-block;
            padding: 10px 20px;
            background-color: #415a77;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }
        .button-container a:hover {
            background-color: #778da9;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>View Notes</h1>
        
        <% If noNotesAvailable Then %>
            <h3>No notes available.</h3>
        <% Else %>
            <div class="note-list">
                <% 
                ' Loop through the notes and display them
                Do While Not rsNotes.EOF
                %>
                    <div class="note-card">
                        <h2><%= rsNotes("Note_Id") %></h2> <!-- Display the unique Note ID -->
                        <p><%= rsNotes("NoteDesc") %></p> <!-- Description of the note -->
                        <a href="<%= rsNotes("NoteFile") %>" download>Download Note</a>
                    </div>
                <% 
                rsNotes.MoveNext
                Loop
                %>
            </div>
        <% End If %>
        
        <div class="button-container">
            <a href="student_dashboard.asp">Back to Dashboard</a>
        </div>
    </div>
</body>
</html>

<%
' Clean up database connection
rsNotes.Close
Set rsNotes = Nothing
db.Close
Set db = Nothing
%>
