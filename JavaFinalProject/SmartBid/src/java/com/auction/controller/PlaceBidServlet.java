package com.auction.controller;

import com.auction.util.DBConnection;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class PlaceBidServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
        throws ServletException, IOException {

        try {
            int productId = Integer.parseInt(req.getParameter("product_id"));
            int buyerId = Integer.parseInt(req.getParameter("buyer_id"));
            double bidAmount = Double.parseDouble(req.getParameter("bid_amount"));

            Connection conn = DBConnection.getConnection();

            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO bids(product_id, buyer_id, bid_amount) VALUES (?, ?, ?)");
            ps.setInt(1, productId);
            ps.setInt(2, buyerId);
            ps.setDouble(3, bidAmount);

            int i = ps.executeUpdate();

            if (i > 0) {
                res.sendRedirect(req.getContextPath() + "/buyer/dashboard.jsp?msg=bid_success");
            } else {
                res.sendRedirect(req.getContextPath() + "/buyer/placeBid.jsp?error=insert_failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect(req.getContextPath() + "/buyer/placeBid.jsp?error=exception");
        }
    }
}
