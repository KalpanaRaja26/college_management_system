<%
If Session("userEmail") = "" Then
    Response.Redirect("signin.asp")
    Response.End
End If

Dim userEmail, userRole
userEmail = Session("userEmail")
userRole = Session("userRole")

If userRole <> "Student" Then
    Response.Redirect("signin.asp")
    Response.End
End If
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard</title>
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

        .container {
            background-color: #ffffff;
            padding: 30px;
            max-width: 800px;
            margin: 30px auto;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .container h1 {
            color: #1b263b;
            margin-bottom: 25px;
        }

        .nav-links {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 15px;
            margin-bottom: 20px;
        }

        .nav-links a {
            text-decoration: none;
            padding: 10px 20px;
            background-color: #415a77;
            color: white;
            border-radius: 6px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .nav-links a:hover {
            background-color: #778da9;
        }

        .container p {
            font-size: 16px;
            color: #1b263b;
            margin-top: 15px;
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

        @media (max-width: 768px) {
            .nav-links {
                flex-direction: column;
                align-items: center;
            }

            .nav-links a {
                width: 100%;
                text-align: center;
            }
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
        <a href="contact.html">Contact</a>
        <a href="logout.asp">Logout</a>
    </nav>
</header>

<div class="container">
    <h1>Welcome, Student!</h1>
    <div class="nav-links">
        <a href="view_notes.asp">📚 View Notes</a>

    </div>
    <p>Hello, <%= userEmail %>! You can view your course materials and Download notes here.</p>
</div>

<footer>
    <div>
        <h3>Quick Links</h3>
        <a href="main.html">Home</a>
        <a href="view_notes.asp">View Notes</a>
     
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
