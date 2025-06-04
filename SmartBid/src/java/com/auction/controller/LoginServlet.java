package com.auction.controller;

import com.auction.util.DBConnection;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try {
            Connection conn = DBConnection.getConnection();

            // Step 1: First check in users table
            PreparedStatement psUser = conn.prepareStatement(
                "SELECT * FROM users WHERE email=? AND password=?"
            );
            psUser.setString(1, email);
            psUser.setString(2, password);
            ResultSet rsUser = psUser.executeQuery();

            if (rsUser.next()) {
                String status = rsUser.getString("status");

                if ("pending".equalsIgnoreCase(status)) {
                    res.sendRedirect("login.jsp?error=pending");
                    return;
                } else if ("blocked".equalsIgnoreCase(status)) {
                    res.sendRedirect("login.jsp?error=blocked");
                    return;
                }

                HttpSession session = req.getSession();
                session.setAttribute("uid", rsUser.getInt("id"));
                session.setAttribute("role", rsUser.getString("role"));
                session.setAttribute("name", rsUser.getString("name"));

                String role = rsUser.getString("role");
                if (role.equalsIgnoreCase("buyer")) {
                    res.sendRedirect("buyer/dashboard.jsp");
                } else if (role.equalsIgnoreCase("seller")) {
                    res.sendRedirect("seller/dashboard.jsp");
                } else {
                    // Just in case any other role found
                    res.sendRedirect("login.jsp?error=unauthorized");
                }

            } else {
                // Step 2: If not found in users, check in admins table
                PreparedStatement psAdmin = conn.prepareStatement(
                    "SELECT * FROM admins WHERE email=? AND password=? AND status='active'"
                );
                psAdmin.setString(1, email);
                psAdmin.setString(2, password);
                ResultSet rsAdmin = psAdmin.executeQuery();

                if (rsAdmin.next()) {
                    HttpSession session = req.getSession();
                    session.setAttribute("admin_id", rsAdmin.getInt("id"));
                    session.setAttribute("admin_name", rsAdmin.getString("name"));
                    res.sendRedirect("admin/dashboard.jsp");
                } else {
                    res.sendRedirect("login.jsp?error=invalid");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("login.jsp?error=server");
        }
    }
}
