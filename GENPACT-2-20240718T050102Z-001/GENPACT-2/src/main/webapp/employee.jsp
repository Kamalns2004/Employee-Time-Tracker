<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign up</title>
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(to right, #74ebd5, #9face6);
        margin: 0;
        padding: 0;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        height: 100vh;
        color: #333;
    }
    .header {
        display: flex;
        justify-content: space-evenly;
        width: 100%;
        margin-bottom: 20px;
    }
    h2 {
        font-size: 2em;
        margin-bottom: 20px;
    }
    h2 a {
        text-decoration: none;
        color: #007BFF;
        transition: color 0.3s ease;
    }
    h2 a:hover {
        color: #0056b3;
    }
    form {
        background-color: #ffffff;
        padding: 30px;
        border-radius: 15px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        width: 80%;
        max-width: 400px;
        text-align: left;
    }
    form label {
        display: block;
        margin-bottom: 8px;
        font-weight: bold;
        color: #555;
    }
    form input[type="text"],
    form input[type="email"],
    form input[type="password"] {
        width: calc(100% - 20px);
        padding: 12px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 8px;
        transition: border-color 0.3s ease;
    }
    form input[type="text"]:focus,
    form input[type="email"]:focus,
    form input[type="password"]:focus {
        border-color: #007BFF;
        outline: none;
    }
    form input[type="submit"] {
        width: 100%;
        background-color: #007BFF;
        color: white;
        border: none;
        padding: 12px;
        border-radius: 8px;
        cursor: pointer;
        font-size: 1em;
        transition: background-color 0.3s ease;
    }
    form input[type="submit"]:hover {
        background-color: #0056b3;
    }
</style>
</head>
<body>
    <div class="header">
        <h2>Sign Up</h2>
        <h2><a href="login.jsp">Login</a></h2>
    </div>
    <form action="register" method="post">
        <label>Name</label>
        <input type="text" name="name" placeholder="Enter your name" required/><br><br>
        
        <label>Age</label>
        <input type="text" name="age" placeholder="Enter your age" required/><br><br>
        
        <label>Role</label>
        <input type="text" name="employee_role" placeholder="Enter your role" required/><br><br>
        
        <label>Phone Number</label>
        <input type="text" name="phone_number" placeholder="Enter your phone number" required/><br><br>
        
        <label>Email</label>
        <input type="email" name="email" placeholder="Enter your email" required/><br><br>
        
        <label>Temporary Password</label>
        <input type="password" name="password" placeholder="Enter a temporary password" required/><br><br>
        
        <input type="submit" value="Register"/>
    </form>
</body>
</html>
