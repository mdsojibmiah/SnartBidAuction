<%@ page import="java.sql.*, com.auction.util.DBConnection" %>
<%
    Connection conn = DBConnection.getConnection();
    PreparedStatement ps = conn.prepareStatement("SELECT * FROM products WHERE status='approved'");
    ResultSet rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Approved Auction Products</title>
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

    <div class="max-w-6xl mx-auto bg-white shadow-md rounded-xl p-6">
        <h2 class="text-2xl font-bold text-blue-700 mb-6">Approved Auction Products</h2>

        <div class="overflow-x-auto">
            <table class="min-w-full border border-gray-300 rounded-lg overflow-hidden">
                <thead class="bg-blue-100 text-gray-700">
                    <tr>
                        <th class="px-4 py-2 text-left">Name</th>
                        <th class="px-4 py-2 text-left">Description</th>
                        <th class="px-4 py-2 text-left">Start Price</th>
                        <th class="px-4 py-2 text-left">End Time</th>
                        <th class="px-4 py-2 text-left">Action</th>
                    </tr>
                </thead>
                <tbody class="text-gray-700">
                    <%
                        while (rs.next()) {
                    %>
                    <tr class="border-t border-gray-200 hover:bg-gray-50">
                        <td class="px-4 py-2 font-medium"><%= rs.getString("name") %></td>
                        <td class="px-4 py-2"><%= rs.getString("description") %></td>
                        <td class="px-4 py-2">$<%= rs.getDouble("start_price") %></td>
                        <td class="px-4 py-2"><%= rs.getTimestamp("end_time") %></td>
                        <td class="px-4 py-2">
                            <form action="placeBid.jsp" method="get">
                                <input type="hidden" name="product_id" value="<%= rs.getInt("id") %>">
                                <button type="submit" class="bg-green-500 text-white px-6 py-1 rounded hover:bg-green-600 transition">
                                Place Bid
                                </button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>
