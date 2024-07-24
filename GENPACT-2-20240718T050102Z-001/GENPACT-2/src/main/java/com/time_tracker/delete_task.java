package com.time_tracker;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/delete-task")
public class delete_task extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String taskId = request.getParameter("task_id");

        if (taskId != null && !taskId.isEmpty()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/time_tracker", "root", "1121");
                
                String query = "DELETE FROM task_table WHERE task_id = ? AND task_date = CURDATE()";
                PreparedStatement pst = con.prepareStatement(query);
                pst.setString(1, taskId);

                int rowsAffected = pst.executeUpdate();
                pst.close();
                con.close();

                if (rowsAffected > 0) {
                    response.sendRedirect("home.jsp");
                } else {
                    response.getWriter().println("No task found with the provided task ID for today.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().println("Error occurred: " + e.getMessage());
            }
        } else {
            response.getWriter().println("Task ID is required.");
        }
    }
}