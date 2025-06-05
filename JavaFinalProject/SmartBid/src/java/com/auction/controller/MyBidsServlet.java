package com.auction.controller;

import com.auction.util.DBConnection;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.*;

public class MyBidsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        int buyerId = (int) session.getAttribute("uid");

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                "SELECT b.*, p.name AS product_name, p.end_time, p.start_price " +
                "FROM bids b JOIN products p ON b.product_id = p.id " +
                "WHERE b.buyer_id = ? ORDER BY b.bid_time DESC");
            ps.setInt(1, buyerId);
            ResultSet rs = ps.executeQuery();

            req.setAttribute("bidList", rs);
            RequestDispatcher rd = req.getRequestDispatcher("buyer/mybids.jsp");
            rd.forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("buyer/dashboard.jsp?msg=error");
        }
    }
}
