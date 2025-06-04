package com.auction.controller;

import com.auction.util.DBConnection;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class UpdateUserStatusServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int userId = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("status");

            System.out.println("Updating user id: " + userId + " to status: " + status);

            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement("UPDATE users SET status=? WHERE id=?");
            ps.setString(1, status);
            ps.setInt(2, userId);
            int i = ps.executeUpdate();

            if (i > 0) {
                response.sendRedirect("admin/blockedUsers.jsp?success=true");
            } else {
                response.sendRedirect("admin/blockedUsers.jsp?error=updatefail");
            }

        } catch (Exception e) {
            e.printStackTrace(); // 🔍 Console এ Error দেখাবে
            response.sendRedirect("admin/blockedUsers.jsp?error=exception");
        }
    }
}
