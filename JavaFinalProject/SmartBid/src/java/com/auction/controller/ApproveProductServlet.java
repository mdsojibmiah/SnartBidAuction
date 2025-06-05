package com.auction.controller;

import com.auction.util.DBConnection;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class ApproveProductServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String idParam = req.getParameter("id");
        String action = req.getParameter("action");

        String referer = req.getHeader("Referer");
        if (referer == null) {
            referer = "admin/dashboard.jsp"; // fallback URL
        }

        if (idParam == null || action == null) {
            res.sendRedirect(addMsgToUrl(referer, "msg=invalid_input"));
            return;
        }

        int id = Integer.parseInt(idParam);
        String status;

        if ("approve".equalsIgnoreCase(action)) {
            status = "approved";
        } else if ("reject".equalsIgnoreCase(action)) {
            status = "rejected";
        } else {
            res.sendRedirect(addMsgToUrl(referer, "msg=invalid_action"));
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("UPDATE products SET status=? WHERE id=?");
            ps.setString(1, status);
            ps.setInt(2, id);
            int updated = ps.executeUpdate();

            if (updated > 0) {
                res.sendRedirect(addMsgToUrl(referer, "msg=" + status));
            } else {
                res.sendRedirect(addMsgToUrl(referer, "msg=update_failed"));
            }

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect(addMsgToUrl(referer, "msg=exception"));
        }
    }

    // ✅ Helper method to safely append query parameter
    private String addMsgToUrl(String url, String param) {
        if (url.contains("?")) {
            return url + "&" + param;
        } else {
            return url + "?" + param;
        }
    }
}
