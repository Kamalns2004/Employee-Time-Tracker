<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.IOException" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.annotation.WebServlet" %>
<%@ page import="javax.servlet.http.HttpServlet" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add New Employee</title>
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(to right, #74ebd5, #9face6);
        margin: 0;
        padding: 20px;
        display: flex;
        flex-direction: column;
        align-items: center;
        min-height: 100vh;
    }
    
    h2 {
        text-align: center;
        color: #343a40;
        margin-bottom: 20px;
    }
    
    hr {
        width: 100%;
        border: none;
        border-top: 1px solid #343a40;
        margin-bottom: 20px;
    }

    .container {
        background-color: #ffffff;
        padding: 30px;
        border-radius: 15px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        width: 100%;
        max-width: 600px;
    }
    
    .container form {
        display: flex;
        flex-direction: column;
    }
    
    .container label {
        margin-bottom: 10px;
        font-weight: bold;
        color: #555;
    }
    
    .container input[type="text"],
    .container input[type="email"],
    .container input[type="number"],
    .container input[type="password"],
    .container select,
    .container input[type="submit"] {
        padding: 12px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 8px;
        width: calc(100% - 24px);
        transition: border-color 0.3s ease;
    }
    
    .container input[type="text"]:focus,
    .container input[type="email"]:focus,
    .container input[type="number"]:focus,
    .container input[type="password"]:focus,
    .container select:focus {
        border-color: #007bff;
        outline: none;
    }
    
    .container input[type="submit"] {
        background-color: #007bff;
        color: white;
        border: none;
        cursor: pointer;
        font-size: 16px;
        transition: background-color 0.3s ease;
    }
    
    .container input[type="submit"]:hover {
        background-color: #0056b3;
    }
    
    .operation {
        margin: 20px 0;
        display: flex;
        justify-content: center;
        gap: 20px;
    }

    .operation a {
        background-color: #007bff;
        color: white;
        padding: 10px 20px;
        border-radius: 8px;
        text-decoration: none;
        transition: background-color 0.3s ease;
    }

    .operation a:hover {
        background-color: #0056b3;
    }

    .list-employees {
        width: 100%;
        max-width: 800px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
        background-color: #fff;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    th, td {
        border: 1px solid #dee2e6;
        padding: 12px;
        text-align: left;
    }

    th {
        background-color: #343a40;
        color: #ffffff;
    }

    tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    tr:hover {
        background-color: #e9ecef;
    }
</style>
</head>
<body>
<h2>Welcome Admin</h2>
<hr>
<div class="container">
    <h2>Add New Employee</h2>
    <form action="admin_add_emp" method="post">
        <label for="name">Employee Name</label>
        <input type="text" name="name" placeholder="Enter employee name" required/>
        
        <label for="age">Age</label>
        <input type="number" name="age" placeholder="Enter employee age" required/>
        
        <label for="role">Role</label>
        <input type="text" name="employee_role" placeholder="Enter employee role" required/>
        
        <label for="phone">Phone Number</label>
        <input type="text" name="phone_number" placeholder="Enter phone number" required/>
        
        <label for="email">Email</label>
        <input type="email" name="email" placeholder="Enter email" required/>
        
        <label for="password">Password</label>
        <input type="password" name="password" placeholder="Enter password" required/>
        
        <input type="submit" value="Add Employee"/>
    </form>
</div>
<div class="operation">
    <a href="admin_edit_employee.jsp">Edit Employee Details</a>
    <a href="admin_delete_employee.jsp">Delete Employee Details</a>
</div>
<h2>List of Employees</h2>
<div class="list-employees">
    <table>
        <tr>
            <th>Employee ID</th>
            <th>Name</th>
            <th>Age</th>
            <th>Role</th>
            <th>Phone Number</th>
            <th>Email</th>
        </tr>
        <%
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/time_tracker", "root", "1121");
            PreparedStatement pst = con.prepareStatement("SELECT emp_id, emp_name, age, role, phone_number, email FROM employee_table");
            ResultSet rs = pst.executeQuery();
            
            while(rs.next()){
                %>
                <tr>
                    <td><%=rs.getString("emp_id") %></td>
                    <td><%=rs.getString("emp_name") %></td>
                    <td><%=rs.getString("age") %></td>
                    <td><%=rs.getString("role") %></td>
                    <td><%=rs.getString("phone_number") %></td>
                    <td><%=rs.getString("email") %></td>
                </tr>
                <%
            }
            rs.close();
            pst.close();
            con.close();
        } catch(Exception e){
            e.printStackTrace();
        }
        %>
    </table>
</div>
</body>
</html>
