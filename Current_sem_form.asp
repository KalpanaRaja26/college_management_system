<%
If Session("userEmail") = "" Then
    Response.Redirect("signin.asp")
    Response.End
End If

Dim userEmail, userRole
userEmail = Session("userEmail")
userRole = Session("userRole")

If userRole <> "Faculty" Then
    Response.Redirect("signin.asp")
    Response.End
End If
%>

<!-- #include file="dbconnect.asp" -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Allocate Current Semester</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            color: #333;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        header {
            background-color: #1b263b;
            color: #fff;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 30px;
            flex-wrap: wrap;
        }

        .logo-title {
            display: flex;
            align-items: center;
        }

        .logo-title img {
            height: 50px;
            margin-right: 10px;
        }

        .logo-title h1 {
            font-size: 18px;
            margin: 0;
        }

        nav a {
            color: white;
            text-decoration: none;
            padding: 8px 16px;
            font-weight: 500;
            transition: background-color 0.3s ease;
        }

        nav a:hover {
            background-color: #778da9;
            border-radius: 5px;
        }

        form {
            background-color: #ffffff;
            padding: 20px 30px;
            max-width: 800px;
            margin: 20px auto;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        form h2 {
            text-align: center;
            color: #1b263b;
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-top: 10px;
            font-weight: 500;
            color: #1b263b;
        }

        input[type="text"],
        select {
            width: 100%;
            padding: 8px;
            margin-top: 4px;
            border: 1px solid #ccc;
            border-radius: 6px;
            background-color: #f8f9fa;
            font-size: 16px;
        }

        input[type="submit"] {
            background-color: #415a77;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            margin-top: 20px;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #778da9;
        }

        footer {
            background-color: #1b263b;
            color: #fff;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            padding: 20px 15px;
            font-size: 13px;
            margin-top: auto;
        }

        footer div {
            margin: 10px;
            min-width: 180px;
        }

        footer h3 {
            color: #adbfd4;
            margin-bottom: 8px;
        }

        footer a {
            color: #fff;
            text-decoration: none;
            display: block;
            margin: 3px 0;
        }

        footer a:hover {
            text-decoration: underline;
        }

        .copyright {
            text-align: center;
            width: 100%;
            margin-top: 15px;
            border-top: 1px solid #444;
            padding-top: 8px;
            font-size: 12px;
        }
    </style>
</head>
<body>

<header>
    <div class="logo-title">
        <img src="college.png" alt="College Logo">
        <h1>INDIRA GANDHI COLLEGE OF ARTS AND SCIENCE</h1>
    </div>
    <nav>
        <a href="main.html">Home</a>
        <a href="about.html">About</a>
        <a href="Contact.html">Contact</a>
        <a href="faculty_dashboard.asp">Back to Dashboard</a>
    </nav>
</header>

<form action="process_current_sem.asp" method="post">
    <h2>Current Semester Allocation</h2>

    <label for="academic_year">Academic Year:</label>
    <input type="text" name="academic_year" id="academic_year" required>

    <label for="semester">Semester:</label>
    <select name="semester" id="semester" required>
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>
        <option value="5">5</option>
        <option value="6">6</option>
    </select>

    <label for="sub_id">Select Subject:</label>
    <select name="sub_id" id="sub_id" required>
        <% 
        Dim db, rsSub, sqlSub
        Set db = OpenDatabaseConnection()
        sqlSub = "SELECT Sub_Id, Sub_Name FROM Degree_Subject_table"
        Set rsSub = db.Execute(sqlSub)
        Do While Not rsSub.EOF
        %>
            <option value="<%= rsSub("Sub_Id") %>"><%= rsSub("Sub_Name") %></option>
        <%
        rsSub.MoveNext
        Loop
        rsSub.Close
        Set rsSub = Nothing
        %>
    </select>

    <label for="staff_id">Select Staff:</label>
    <select name="staff_id" id="staff_id" required>
        <% 
        sqlStaff = "SELECT Staff_Id, Staff_Name FROM Staff_table"
        Set rsStaff = db.Execute(sqlStaff)
        Do While Not rsStaff.EOF
        %>
            <option value="<%= rsStaff("Staff_Id") %>"><%= rsStaff("Staff_Name") %></option>
        <%
        rsStaff.MoveNext
        Loop
        rsStaff.Close
        Set rsStaff = Nothing
        db.Close
        Set db = Nothing
        %>
    </select>

    <label for="allocation_type">Allocation Type:</label>
    <select name="allocation_type" id="allocation_type" required>
        <option value="Full-Time">Full-Time</option>
        <option value="Part-Time">Part-Time</option>
    </select>

    <input type="submit" value="Submit">
</form>

<footer>
    <div>
        <h3>Quick Links</h3>
        <a href="main.html">Home</a>
        <a href="about.html">About</a>
        <a href="Contact.html">Contact</a>
        <a href="faculty_dashboard.asp">Back to Dashboard</a>
    </div>
    
    <div>
        <h3>Contact Us</h3>
        <p>INDIRA GANDHI COLLEGE OF ARTS AND SCIENCE, PUDUCHERRY – 605 006</p>
        <p>Email: igcas2001@gmail.com</p>
        <p>Phone: 0413-2275510, 2277868</p>
    </div>
    
    <div class="copyright">
        &copy; 2025 igcas. All rights reserved.
    </div>
</footer>

</body>
</html>
