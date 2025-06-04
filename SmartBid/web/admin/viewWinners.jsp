<%@ page import="java.sql.*, com.auction.util.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Connection conn = DBConnection.getConnection();
    PreparedStatement ps = conn.prepareStatement(
        "SELECT aw.id, aw.product_id, aw.buyer_id, aw.winning_amount, aw.winning_time, " +
        "       p.name AS product_name, u.name AS buyer_name " +
        "FROM auction_winners aw " +
        "JOIN products p ON aw.product_id = p.id " +
        "JOIN users u ON aw.buyer_id = u.id"
    );
    ResultSet rs = ps.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Winners</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 p-6">
    <div class="max-w-6xl mx-auto bg-white p-6 rounded shadow">
        <h2 class="text-3xl font-semibold mb-4 text-center text-blue-700">Auction Winners</h2>
        <table class="table-auto w-full border border-gray-300">
            <thead>
                <tr class="bg-gray-200 text-left">
                    <th class="px-4 py-2 border">#</th>
                    <th class="px-4 py-2 border">Product</th>
                    <th class="px-4 py-2 border">Winner Name</th>
                    <th class="px-4 py-2 border">Winning Amount</th>
                    <th class="px-4 py-2 border">Winning Time</th>
                </tr>
            </thead>
            <tbody>
            <%
                int count = 1;
                while (rs.next()) {
            %>
                <tr class="border-b">
                    <td class="px-4 py-2 border"><%= count++ %></td>
                    <td class="px-4 py-2 border"><%= rs.getString("product_name") %></td>
                    <td class="px-4 py-2 border"><%= rs.getString("buyer_name") %></td>
                    <td class="px-4 py-2 border text-green-700 font-semibold">৳<%= rs.getInt("winning_amount") %></td>
                    <td class="px-4 py-2 border"><%= rs.getString("winning_time") %></td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</body>
</html>
