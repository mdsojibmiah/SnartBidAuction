<%@ page import="java.sql.*, com.auction.util.DBConnection" %>
<%
    int productId = Integer.parseInt(request.getParameter("product_id"));
    Connection conn = DBConnection.getConnection();
    PreparedStatement ps = conn.prepareStatement(
        "SELECT b.bid_amount, b.bid_time, u.name AS buyer_name FROM bids b JOIN users u ON b.buyer_id=u.id WHERE b.product_id=? ORDER BY b.bid_amount DESC");
    ps.setInt(1, productId);
    ResultSet rs = ps.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="refresh" content="5">
    <title>Live Bids</title>
    <script src="https://cdn.tailwindcss.com"></script>
            <!-- Poppins Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }
    </style>
</head>
<body class="bg-gray-100 p-6 min-h-screen">
    <div class="max-w-4xl mx-auto bg-white p-6 rounded-xl shadow-md">
        <h2 class="text-2xl font-bold text-blue-600 mb-6">Live Bidding Status</h2>

        <table class="w-full table-auto border border-gray-300">
            <thead class="bg-blue-100">
                <tr>
                    <th class="px-4 py-2 text-left">Buyer</th>
                    <th class="px-4 py-2 text-left">Bid Amount ($)</th>
                    <th class="px-4 py-2 text-left">Time</th>
                </tr>
            </thead>
            <tbody class="text-gray-800">
                <%
                    boolean hasBid = false;
                    while (rs.next()) {
                        hasBid = true;
                %>
                <tr class="border-t">
                    <td class="px-4 py-2"><%= rs.getString("buyer_name") %></td>
                    <td class="px-4 py-2">$<%= rs.getDouble("bid_amount") %></td>
                    <td class="px-4 py-2"><%= rs.getTimestamp("bid_time") %></td>
                </tr>
                <% } %>
                <% if (!hasBid) { %>
                <tr>
                    <td class="px-4 py-4 text-center text-red-500" colspan="3">No bids yet.</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>
