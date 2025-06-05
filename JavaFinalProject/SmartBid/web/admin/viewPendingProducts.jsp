<%@ page import="java.sql.*, com.auction.util.DBConnection" %>
<%
    Connection conn = DBConnection.getConnection();
    PreparedStatement ps = conn.prepareStatement(
        "SELECT p.*, u.name AS seller_name FROM products p JOIN users u ON p.seller_id=u.id WHERE p.status='pending'");
    ResultSet rs = ps.executeQuery();
    String msg = request.getParameter("msg");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Pending Product Approvals</title>
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
    <div class="max-w-7xl mx-auto bg-white p-6 rounded-xl shadow-lg">

        <h2 class="text-3xl font-bold text-yellow-700 mb-6 text-center">
            Pending Product Approvals
        </h2>

        <% if (msg != null) { %>
            <div class="mb-4 p-4 rounded-lg shadow 
                <%= msg.equals("approved") ? "bg-green-100 text-green-700" :
                     msg.equals("rejected") ? "bg-yellow-100 text-yellow-700" :
                     "bg-red-100 text-red-700" %>">
                <% if (msg.equals("approved")) { %>
                    Product approved successfully!
                <% } else if (msg.equals("rejected")) { %>
                    Product rejected!
                <% } else { %>
                    Something went wrong: <%= msg %>
                <% } %>
            </div>
        <% } %>

        <div class="overflow-x-auto">
            <table class="min-w-full table-auto border border-gray-200 rounded-lg overflow-hidden shadow-sm">
                <thead class="bg-yellow-100 text-gray-800">
                    <tr>
                        <th class="px-4 py-3 text-left">Product</th>
                        <th class="px-4 py-3 text-left">Description</th>
                        <th class="px-4 py-3 text-left">Start Price</th>
                        <th class="px-4 py-3 text-left">Seller</th>
                        <th class="px-4 py-3 text-left">End Time</th>
                        <th class="px-4 py-3 text-left">Action</th>
                    </tr>
                </thead>
                <tbody class="text-gray-700 divide-y divide-gray-200">
                    <%
                        while (rs.next()) {
                    %>
                    <tr class="hover:bg-gray-50">
                        <td class="px-4 py-3 font-semibold"><%= rs.getString("name") %></td>
                        <td class="px-4 py-3"><%= rs.getString("description") %></td>
                        <td class="px-4 py-3"><%= rs.getDouble("start_price") %>$</td>
                        <td class="px-4 py-3"><%= rs.getString("seller_name") %></td>
                        <td class="px-4 py-3"><%= rs.getTimestamp("end_time") %></td>
                        <td class="px-4 py-3">
                            <div class="flex flex-col sm:flex-row sm:items-center sm:space-x-2 space-y-2 sm:space-y-0">
                                <a href="<%= request.getContextPath() %>/ApproveProductServlet?id=<%= rs.getInt("id") %>&action=approve"
                                   class="bg-green-500 hover:bg-green-600 text-white px-4 py-2 rounded-lg text-sm text-center transition">
                                   Approve
                                </a>
                                <a href="<%= request.getContextPath() %>/ApproveProductServlet?id=<%= rs.getInt("id") %>&action=reject"
                                   class="bg-red-500 hover:bg-red-600 text-white px-4 py-2 rounded-lg text-sm text-center transition">
                                   Reject
                                </a>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
