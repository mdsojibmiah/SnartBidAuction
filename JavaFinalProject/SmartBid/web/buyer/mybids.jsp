<%@ page import="java.sql.*" %>
<%
    ResultSet rs = (ResultSet) request.getAttribute("bidList");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Bids</title>
    <script src="https://cdn.tailwindcss.com"></script>
                <!-- Poppins Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }
    </style>
</head>
<body class="bg-gray-100 p-6">

    <div class="max-w-5xl mx-auto bg-white p-6 rounded-lg shadow">
        <h2 class="text-2xl font-bold text-blue-600 mb-4">My Bids</h2>

        <table class="min-w-full table-auto border">
            <thead class="bg-blue-100 text-gray-800">
                <tr>
                    <th class="px-4 py-2">Product</th>
                    <th class="px-4 py-2">Bid Amount</th>
                    <th class="px-4 py-2">Start Price</th>
                    <th class="px-4 py-2">Bid Time</th>
                    <th class="px-4 py-2">Ends At</th>
                </tr>
            </thead>
            <tbody>
            <% while(rs != null && rs.next()) { %>
                <tr class="border-t hover:bg-gray-50">
                    <td class="px-4 py-2"><%= rs.getString("product_name") %></td>
                    <td class="px-4 py-2 text-green-600 font-semibold">$<%= rs.getDouble("bid_amount") %></td>
                    <td class="px-4 py-2 text-gray-700">$<%= rs.getDouble("start_price") %></td>
                    <td class="px-4 py-2"><%= rs.getTimestamp("bid_time") %></td>
                    <td class="px-4 py-2"><%= rs.getTimestamp("end_time") %></td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>

</body>
</html>
