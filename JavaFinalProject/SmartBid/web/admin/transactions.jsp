<%@ page import="java.sql.*, java.text.SimpleDateFormat, com.auction.util.DBConnection" %>
<%
    Connection conn = DBConnection.getConnection();
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM transactions ORDER BY transaction_time DESC");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Transactions - SmartBid Admin</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }
    </style>
</head>
<body class="bg-gradient-to-br from-gray-100 to-gray-200 p-6 min-h-screen">

    <!-- Header with Back Button -->
    <div class="flex justify-between items-center mb-6">
        <div class="flex items-center gap-3">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-blue-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c1.104 0 2-.672 2-1.5S13.104 5 12 5s-2 .672-2 1.5S10.896 8 12 8zm0 2c-2.209 0-4 1.791-4 4h2a2 2 0 114 0h2c0-2.209-1.791-4-4-4z" />
            </svg>
            <h1 class="text-3xl font-bold text-gray-800">All Transactions</h1>
        </div>
        <a href="dashboard.jsp" class="inline-flex items-center bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded transition">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
            </svg>
            Back to Dashboard
        </a>
    </div>

    <!-- Highlighted Info -->
    <div class="bg-yellow-100 border-l-4 border-yellow-500 text-yellow-700 p-4 rounded mb-6">
        <div class="flex items-center gap-2">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-yellow-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M12 20h.01M4 4l16 16" />
            </svg>
            <p class="text-sm font-medium">
                This feature is currently <strong>under development</strong>. Check back later or contact admin if urgent.
            </p>
        </div>
    </div>

    <!-- Summary Cards -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-6">
        <div class="bg-white p-5 shadow rounded-lg flex items-center gap-4">
            <div class="bg-blue-100 p-3 rounded-full">
                <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6 text-blue-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h2l1 2h13l1-2h2M5 10h14M8 16h8m-4-6v6" />
                </svg>
            </div>
            <div>
                <p class="text-gray-600 text-sm">Total Transactions</p>
                <p class="text-2xl font-bold text-blue-600">123</p>
            </div>
        </div>
        <div class="bg-white p-5 shadow rounded-lg flex items-center gap-4">
            <div class="bg-green-100 p-3 rounded-full">
                <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6 text-green-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.333 0-2 .667-2 2s.667 2 2 2 2-.667 2-2-.667-2-2-2zM12 12v1m0 0v1m0-2a4 4 0 110 8 4 4 0 010-8z" />
                </svg>
            </div>
            <div>
                <p class="text-gray-600 text-sm">Total Earnings</p>
                <p class="text-2xl font-bold text-green-600">1,05,000</p>
            </div>
        </div>
        <div class="bg-white p-5 shadow rounded-lg flex items-center gap-4">
            <div class="bg-purple-100 p-3 rounded-full">
                <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6 text-purple-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h2l1 2h13l1-2h2M5 10h14M8 16h8m-4-6v6" />
                </svg>
            </div>
            <div>
                <p class="text-gray-600 text-sm">Last 24 Hours</p>
                <p class="text-2xl font-bold text-purple-600">15,000</p>
            </div>
        </div>
    </div>

    <!-- Transactions Table -->
    <div class="bg-white shadow-md rounded-lg overflow-x-auto">
        <table class="min-w-full text-sm text-left">
            <thead class="bg-blue-100 text-gray-700 uppercase">
                <tr>
                    <th class="px-4 py-3">Txn ID</th>
                    <th class="px-4 py-3">Product ID</th>
                    <th class="px-4 py-3">Buyer</th>
                    <th class="px-4 py-3">Seller</th>
                    <th class="px-4 py-3">Amount</th>
                    <th class="px-4 py-3">Time</th>
                    <th class="px-4 py-3">Status</th>
                </tr>
            </thead>
            <tbody class="text-gray-800 bg-white">
                <%
                    while(rs.next()) {
                        int txnId = rs.getInt("id");
                        int productId = rs.getInt("product_id");
                        int buyerId = rs.getInt("buyer_id");
                        int sellerId = rs.getInt("seller_id");
                        double amount = rs.getDouble("amount");
                        Timestamp txnTime = rs.getTimestamp("transaction_time");
                        String status = rs.getString("status");
                        String colorClass = status.equalsIgnoreCase("success") ? "text-green-600" :
                                            status.equalsIgnoreCase("failed") ? "text-red-600" : "text-yellow-600";
                %>
                <tr class="border-t hover:bg-gray-50 transition">
                    <td class="px-4 py-2"><%= txnId %></td>
                    <td class="px-4 py-2"><%= productId %></td>
                    <td class="px-4 py-2">Buyer#<%= buyerId %></td>
                    <td class="px-4 py-2">Seller#<%= sellerId %></td>
                    <td class="px-4 py-2 font-medium text-blue-700"><%= amount %></td>
                    <td class="px-4 py-2"><%= new SimpleDateFormat("dd MMM yyyy, hh:mm a").format(txnTime) %></td>
                    <td class="px-4 py-2 font-semibold <%= colorClass %>"><%= status %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

</body>
</html>
