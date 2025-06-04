<%@ page import="java.sql.*, com.auction.util.DBConnection" %>
<%@ page session="true" %>
<%
    Connection conn = DBConnection.getConnection();
    PreparedStatement ps = conn.prepareStatement(
        "SELECT p.id, p.name, p.description, p.status, u.name as seller_name " +
        "FROM products p INNER JOIN users u ON p.seller_id = u.id"
    );
    ResultSet rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Products (Admin)</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }
    </style>
</head>
<body class="bg-gray-100 min-h-screen p-6">

<div class="max-w-6xl mx-auto bg-white p-8 rounded-xl shadow">

    <h1 class="text-3xl font-bold text-center text-blue-600 mb-6">
        All Products Overview (Admin Panel)
    </h1>

    <table class="w-full table-auto border border-gray-300 rounded-lg overflow-hidden shadow">
        <thead class="bg-gray-200 text-gray-700 font-semibold">
            <tr>
                <th class="px-4 py-2 text-left">ID</th>
                <th class="px-4 py-2 text-left">Product Name</th>
                <th class="px-4 py-2 text-left">Description</th>
                <th class="px-4 py-2 text-left">Seller</th>
                <th class="px-4 py-2 text-left">Status</th>
            </tr>
        </thead>
        <tbody class="text-gray-800">
        <%
            while(rs.next()) {
                String status = rs.getString("status");
                String badgeColor = "gray";
                if ("approved".equals(status)) {
                    badgeColor = "green";
                } else if ("pending".equals(status)) {
                    badgeColor = "yellow";
                } else if ("rejected".equals(status)) {
                    badgeColor = "red";
                }
        %>
            <tr class="border-b">
                <td class="px-4 py-2"><%= rs.getInt("id") %></td>
                <td class="px-4 py-2 font-semibold"><%= rs.getString("name") %></td>
                <td class="px-4 py-2"><%= rs.getString("description") %></td>
                <td class="px-4 py-2"><%= rs.getString("seller_name") %></td>
                <td class="px-4 py-2">
                    <span class="inline-block px-3 py-1 rounded-full text-white bg-<%= badgeColor %>-500 text-sm capitalize shadow-sm">
                        <%= status %>
                    </span>
                </td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>

</div>

</body>
</html>
