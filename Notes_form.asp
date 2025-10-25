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

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload Notes</title>
    <style>
        /* Same CSS as before */
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

        nav {
            display: flex;
            flex-wrap: wrap;
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

        /* Uniform Input Box Style */
        input[type="text"],
        input[type="number"],
        input[type="email"],
        select,
        textarea {
            width: 100%;
            padding: 8px;
            margin-top: 4px;
            border: 1px solid #ccc;
            border-radius: 6px;
            background-color: #f8f9fa;
            font-size: 16px;
        }

        button[type="submit"] {
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

        button[type="submit"]:hover {
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

<div class="container">
    <h1><center>Upload Notes</center></h1>
    <form action="upload_notes_process.asp" method="post" enctype="multipart/form-data">
        <label for="note_file">Upload Note File:</label>
        <input type="file" id="note_file" name="note_file" accept=".pdf, .docx, .pptx" required>

        <label for="note_desc">Note Description:</label>
        <textarea id="note_desc" name="note_desc" rows="4" required></textarea>

        <label for="academic_year">Academic Year:</label>
        <input type="text" id="academic_year" name="academic_year" required>

        <label for="semester">Semester:</label>
        <select id="semester" name="semester" required>
            <option value="1">1st Semester</option>
            <option value="2">2nd Semester</option>
            <option value="3">3rd Semester</option>
            <option value="4">4th Semester</option>
            <option value="5">5th Semester</option>
            <option value="6">6th Semester</option>
        </select>

        <label for="enable_notes">Enable Notes:</label>
        <select id="enable_notes" name="enable_notes" required>
            <option value="1">Enable</option>
            <option value="0">Disable</option>
        </select>

        <button type="submit" class="submit-btn">Upload Notes</button>
    </form>
</div>

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
