package com.auction.controller;

import com.auction.util.DBConnection;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // Input গুলো ফর্ম থেকে নিচ্ছি
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        try {
            // DB কানেকশন
            Connection conn = DBConnection.getConnection();

            // SQL Query
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO users(name, email, password, role, status) VALUES (?, ?, ?, ?, 'active')");
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, role);

            int i = ps.executeUpdate();

            if (i > 0) {
                res.sendRedirect("register.jsp?success=1");
            } else {
                res.sendRedirect("register.jsp?error=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("register.jsp?error=1");
        }
    }
}
