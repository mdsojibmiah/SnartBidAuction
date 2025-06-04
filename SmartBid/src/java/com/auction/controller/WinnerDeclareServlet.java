package com.auction.controller;

import com.auction.util.DBConnection;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class WinnerDeclareServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pidStr = request.getParameter("product_id");
        if (pidStr == null || pidStr.isEmpty()) {
            response.sendRedirect("admin/viewAllAuctions.jsp?error=Product+ID+missing");
            return;
        }

        int productId = Integer.parseInt(pidStr);

        try (Connection conn = DBConnection.getConnection()) {

            // 1. Get highest bidder
            String getBidSql = "SELECT buyer_id, bid_amount FROM bids WHERE product_id = ? ORDER BY bid_amount DESC LIMIT 1";
            PreparedStatement ps1 = conn.prepareStatement(getBidSql);
            ps1.setInt(1, productId);
            ResultSet rs1 = ps1.executeQuery();

            if (rs1.next()) {
                int buyerId = rs1.getInt("buyer_id");
                double amount = rs1.getDouble("bid_amount");

                // 2. Check winner already declared
                PreparedStatement checkWinner = conn.prepareStatement("SELECT * FROM auction_winners WHERE product_id = ?");
                checkWinner.setInt(1, productId);
                ResultSet rsCheck = checkWinner.executeQuery();
                if (rsCheck.next()) {
                    response.sendRedirect("admin/viewAllAuctions.jsp?error=Winner+already+declared");
                    return;
                }

                // 3. Check buyer wallet exists & has enough balance
                PreparedStatement checkBalance = conn.prepareStatement("SELECT balance FROM buyer_wallet WHERE buyer_id = ?");
                checkBalance.setInt(1, buyerId);
                ResultSet rsBalance = checkBalance.executeQuery();

                double balance = -1;
                if (rsBalance.next()) {
                    balance = rsBalance.getDouble("balance");
                } else {
                    response.sendRedirect("admin/viewAllAuctions.jsp?error=Buyer+wallet+not+found");
                    return;
                }

                if (balance < amount) {
                    response.sendRedirect("admin/viewAllAuctions.jsp?error=Insufficient+balance+in+buyer+wallet");
                    return;
                }

                // 4. Get seller ID
                int sellerId = 0;
                PreparedStatement ps3 = conn.prepareStatement("SELECT seller_id FROM products WHERE id = ?");
                ps3.setInt(1, productId);
                ResultSet rs3 = ps3.executeQuery();
                if (rs3.next()) {
                    sellerId = rs3.getInt("seller_id");
                } else {
                    response.sendRedirect("admin/viewAllAuctions.jsp?error=Product+not+found");
                    return;
                }

                // 5. Ensure seller_wallet exists
                PreparedStatement checkSeller = conn.prepareStatement("SELECT * FROM seller_wallet WHERE seller_id = ?");
                checkSeller.setInt(1, sellerId);
                ResultSet rsSeller = checkSeller.executeQuery();
                if (!rsSeller.next()) {
                    PreparedStatement createSellerWallet = conn.prepareStatement("INSERT INTO seller_wallet (seller_id, balance) VALUES (?, 0.0)");
                    createSellerWallet.setInt(1, sellerId);
                    createSellerWallet.executeUpdate();
                }

                // 6. Insert into auction_winners
                PreparedStatement insertWinner = conn.prepareStatement(
                    "INSERT INTO auction_winners (product_id, buyer_id, winning_amount, winning_time) VALUES (?, ?, ?, ?)"
                );
                insertWinner.setInt(1, productId);
                insertWinner.setInt(2, buyerId);
                insertWinner.setDouble(3, amount);
                insertWinner.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
                int inserted = insertWinner.executeUpdate();

                // 7. Deduct buyer
                PreparedStatement ps2 = conn.prepareStatement("UPDATE buyer_wallet SET balance = balance - ? WHERE buyer_id = ?");
                ps2.setDouble(1, amount);
                ps2.setInt(2, buyerId);
                int updatedBuyer = ps2.executeUpdate();

                // 8. Add seller
                PreparedStatement ps4 = conn.prepareStatement("UPDATE seller_wallet SET balance = balance + ? WHERE seller_id = ?");
                ps4.setDouble(1, amount);
                ps4.setInt(2, sellerId);
                int updatedSeller = ps4.executeUpdate();

                // 9. Mark product as sold
                PreparedStatement ps5 = conn.prepareStatement("UPDATE products SET status = 'sold' WHERE id = ?");
                ps5.setInt(1, productId);
                int updatedProduct = ps5.executeUpdate();

                if (inserted > 0 && updatedBuyer > 0 && updatedSeller > 0 && updatedProduct > 0) {
                    response.sendRedirect("admin/viewAllAuctions.jsp?msg=Winner+Declared+Successfully");
                } else {
                    response.sendRedirect("admin/viewAllAuctions.jsp?error=Transaction+failed");
                }

            } else {
                response.sendRedirect("admin/viewAllAuctions.jsp?error=No+bids+found+for+this+product");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin/viewAllAuctions.jsp?error=Exception+" + e.getMessage());
        }
    }
}
