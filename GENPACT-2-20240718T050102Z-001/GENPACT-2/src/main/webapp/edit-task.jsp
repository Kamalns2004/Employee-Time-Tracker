<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Task</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 20px;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            width: 100%;
        }
        form {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 80%;
            margin: 20px auto;
            max-width: 600px;
        }
        form label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }
        form input[type="text"],
        form input[type="date"],
        form input[type="time"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        form input[type="submit"] {
            background-color: #4CAF50; /* Green */
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        form input[type="submit"]:hover {
            background-color: #45a049;
        }
        table {
            width: 90%;
            border-collapse: collapse;
            margin: 20px;
            background-color: #f9f9f9;
            text-align: center;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ccc;
        }
        th {
            background-color: #1e1f21;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .action-button {
            background-color: #007BFF;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            text-align: center;
            margin-bottom: 20px;
        }
        .action-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Edit Today's Task</h2>
        <form method="post" action="edit-task.jsp">
            <input type="submit" name="getTasks" value="Get Today's Tasks" class="action-button"/>
        </form>

        <% 
        if (request.getParameter("getTasks") != null) {
            try {
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/time_tracker", "root", "1121");

                String currentDate = java.time.LocalDate.now().toString();
                PreparedStatement pst = con.prepareStatement("SELECT * FROM task_table WHERE task_date = ?");
                pst.setString(1, currentDate);

                ResultSet rs = pst.executeQuery();
        %>

        <table>
            <thead>
                <tr>
                    <th>Employee ID</th>
                    <th>Employee Name</th>
                    <th>Task ID</th>
                    <th>Project Name</th>
                    <th>Task Role</th>
                    <th>Task Date</th>
                    <th>Start Time</th>
                    <th>End Time</th>
                    <th>Task Category</th>
                    <th>Task Description</th>
                </tr>
            </thead>
            <tbody>
                <% while (rs.next()) { %>
                <tr>
                    <td><%= rs.getString("emp_id") %></td>
                    <td><%= rs.getString("emp_name") %></td>
                    <td><%= rs.getInt("task_id") %></td>
                    <td><%= rs.getString("project_name") %></td>
                    <td><%= rs.getString("task_role") %></td>
                    <td><%= rs.getString("task_date") %></td>
                    <td><%= rs.getString("start_time") %></td>
                    <td><%= rs.getString("end_time") %></td>
                    <td><%= rs.getString("task_category") %></td>
                    <td><%= rs.getString("task_description") %></td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <% 
                rs.close();
                pst.close();
                con.close();
            } catch (SQLException e) {
                out.println("Exception: " + e.getMessage());
            }
        }
        %>

        <!-- Form to get specific task by task_id -->
        <h2>Get Specific Task</h2>
        <form method="post" action="edit-task.jsp">
            <label for="task_id">Enter Task ID:</label>
            <input type="text" id="task_id" name="task_id" required/>
            <input type="submit" name="getTaskById" value="Get Task" class="action-button"/>
        </form>

        <% 
        if (request.getParameter("getTaskById") != null) {
            String taskId = request.getParameter("task_id");
            if (taskId != null && !taskId.isEmpty()) {
                try {
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/time_tracker", "root", "1121");

                    PreparedStatement pst = con.prepareStatement("SELECT * FROM task_table WHERE task_id = ?");
                    pst.setString(1, taskId);

                    ResultSet rs = pst.executeQuery();
                    if (rs.next()) {
        %>

        <h2>Update Task</h2>
        <form method="post" action="update_task">
            <input type="hidden" name="task_id" value="<%= rs.getInt("task_id") %>" required/>
            <label for="emp_id">Employee ID:</label>
            <input type="text" name="emp_id" value="<%= rs.getString("emp_id") %>" required/><br/><br/>
            
            <label for="emp_name">Employee Name:</label>
            <input type="text" name="emp_name" value="<%= rs.getString("emp_name") %>" required/><br/><br/>
            
            <label for="project_name">Project Name:</label>
            <input type="text" name="project_name" value="<%= rs.getString("project_name") %>" required/><br/><br/>
            
            <label for="task_role">Task Role:</label>
            <input type="text" name="task_role" value="<%= rs.getString("task_role") %>" required/><br/><br/>
            
            <label for="task_date">Task Date:</label>
            <input type="date" name="task_date" value="<%= rs.getString("task_date") %>" required/><br/><br/>
            
            <label for="start_time">Start Time:</label>
            <input type="time" name="start_time" value="<%= rs.getString("start_time") %>" required/><br/><br/>
            
            <label for="end_time">End Time:</label>
            <input type="time" name="end_time" value="<%= rs.getString("end_time") %>" required/><br/><br/>
            
            <label for="task_category">Task Category:</label>
            <input type="text" name="task_category" value="<%= rs.getString("task_category") %>" required/><br/><br/>
            
            <label for="task_description">Task Description:</label>
            <input type="text" name="task_description" value="<%= rs.getString("task_description") %>" required/><br/><br/>
            
            <input type="submit" name="updateTask" value="Update Task" class="action-button"/>
        </form>
        <% 
                    }
                    rs.close();
                    pst.close();
                    con.close();
                } catch (SQLException e) {
                    out.println("Exception: " + e.getMessage());
                }
            }
        }
        %>
    </div>
</body>
</html>
