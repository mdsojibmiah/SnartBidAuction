package com.auction.controller;

import com.auction.util.DBConnection;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class AddProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        int sellerId = Integer.parseInt(req.getParameter("seller_id"));
        String name = req.getParameter("name");
        String desc = req.getParameter("description");
        double price = Double.parseDouble(req.getParameter("start_price"));
        String endTime = req.getParameter("end_time");

        try {
            Connection conn = DBConnection.getConnection();

            // ✅ status field যোগ করে pending করে দেওয়া হয়েছে
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO products(seller_id, name, description, start_price, end_time, status) VALUES (?, ?, ?, ?, ?, ?)"
            );
            ps.setInt(1, sellerId);
            ps.setString(2, name);
            ps.setString(3, desc);
            ps.setDouble(4, price);
            ps.setString(5, endTime);
            ps.setString(6, "pending");  // 👈 এই লাইনেই মূল fix

            int i = ps.executeUpdate();
            if (i > 0) {
                res.sendRedirect("seller/dashboard.jsp?msg=success");
            } else {
                res.sendRedirect("seller/addProduct.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
