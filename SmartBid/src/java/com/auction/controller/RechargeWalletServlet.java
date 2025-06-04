package com.auction.controller;

import com.auction.util.DBConnection;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class RechargeWalletServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int uid = Integer.parseInt(request.getParameter("uid"));
            double amount = Double.parseDouble(request.getParameter("amount"));
            String role = request.getParameter("role");

            // Validation fallback
            if (role == null || (!role.equalsIgnoreCase("buyer") && !role.equalsIgnoreCase("seller"))) {
                response.sendRedirect("index.jsp?error=Invalid+Role");
                return;
            }

            String tableName = role.equalsIgnoreCase("seller") ? "seller_wallet" : "buyer_wallet";
            String columnName = role.equalsIgnoreCase("seller") ? "seller_id" : "buyer_id";
            String redirectSuccess = role.equalsIgnoreCase("seller") ? "seller/dashboard.jsp" : "buyer/dashboard.jsp";
            String redirectFail = role.equalsIgnoreCase("seller") ? "seller/recharge.jsp" : "buyer/recharge.jsp";

            try (Connection conn = DBConnection.getConnection()) {

                // First check if wallet entry exists
                String checkSql = "SELECT * FROM " + tableName + " WHERE " + columnName + " = ?";
                PreparedStatement checkStmt = conn.prepareStatement(checkSql);
                checkStmt.setInt(1, uid);
                ResultSet rs = checkStmt.executeQuery();

                if (!rs.next()) {
                    // Insert if not exists
                    String insertSql = "INSERT INTO " + tableName + " (" + columnName + ", balance) VALUES (?, ?)";
                    PreparedStatement insertStmt = conn.prepareStatement(insertSql);
                    insertStmt.setInt(1, uid);
                    insertStmt.setDouble(2, amount);
                    insertStmt.executeUpdate();
                } else {
                    // Update balance
                    String updateSql = "UPDATE " + tableName + " SET balance = balance + ? WHERE " + columnName + " = ?";
                    PreparedStatement updateStmt = conn.prepareStatement(updateSql);
                    updateStmt.setDouble(1, amount);
                    updateStmt.setInt(2, uid);
                    updateStmt.executeUpdate();
                }

                response.sendRedirect(redirectSuccess + "?msg=Wallet+recharged+successfully");
            }

        } catch (Exception e) {
            e.printStackTrace();
            // If anything fails
            String role = request.getParameter("role");
            String redirectFail = "index.jsp";
            if ("seller".equalsIgnoreCase(role)) {
                redirectFail = "seller/sellerRecharge.jsp";
            } else if ("buyer".equalsIgnoreCase(role)) {
                redirectFail = "buyer/recharge.jsp";
            }
            response.sendRedirect(redirectFail + "?error=Exception+Occurred");
        }
    }
}
