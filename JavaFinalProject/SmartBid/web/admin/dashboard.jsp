<%@ page import="java.sql.*, com.auction.util.DBConnection" %>
<%
    Connection conn = DBConnection.getConnection();
    PreparedStatement psLive = conn.prepareStatement(
        "SELECT id, name FROM products WHERE status='approved'");
    ResultSet rsLive = psLive.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; }
    </style>
</head>
<body class="bg-gradient-to-r from-gray-100 to-blue-100 min-h-screen py-8 px-4 sm:px-10">
    <div class="max-w-7xl mx-auto bg-white rounded-2xl shadow-xl p-8">
        <!-- Header -->
        <div class="flex justify-between items-center mb-10">
            <h1 class="text-4xl font-bold text-slate-800">Admin Dashboard</h1>
            <a href="<%= request.getContextPath() %>/logout.jsp"
               class="inline-flex items-center gap-2 bg-red-500 text-white px-5 py-2 rounded-xl font-medium hover:bg-red-600 shadow">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" stroke-width="2"
                     viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                    <path stroke-linecap="round" stroke-linejoin="round"
                          d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a2 2 0 01-2 2H7a2 2 0 01-2-2V7a2 2 0 012-2h4a2 2 0 012 2v1"/>
                </svg>
                Logout
            </a>
        </div>

        <!-- Main Action Buttons -->
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            <%-- Reusable Card Template --%>
            <%
                String[][] actions = {
                    {"viewUsers.jsp", "All Users Management", "M17 20h5v-2a4 4 0 00-3-3.87M9 20H4v-2a4 4 0 013-3.87M16 7a4 4 0 11-8 0 4 4 0 018 0z", "bg-blue-600"},
                    {"viewPendingProducts.jsp", "Pending Product Approvals", "M5 13l4 4L19 7", "bg-yellow-500"},
                    {"viewAllProducts.jsp", "All Products", "M3 7h18M3 12h18M3 17h18", "bg-indigo-600"},
                    {"userRequest.jsp", "New User Requests", "M12 4v16m8-8H4", "bg-purple-600"},
                    {"transactions.jsp", "All Transactions", "M12 8c-1.657 0-3 1.343-3 3h6c0-1.657-1.343-3-3-3z", "bg-green-600"},
                    {"blockedUsers.jsp", "Blocked/Unblocked Users", "M18.364 5.636l-12.728 12.728M5.636 5.636l12.728 12.728", "bg-red-600"},
                    {"viewAllAuctions.jsp", "Declare Auction Winner", "M3 10h11M9 21V3", "bg-cyan-600"},
                };
                for (String[] action : actions) {
            %>
            <a href="<%= action[0] %>"
               class="flex items-center gap-4 p-6 <%= action[3] %> text-white rounded-xl shadow-md hover:opacity-90 transition">
                <svg class="w-7 h-7" fill="none" stroke="currentColor" stroke-width="2"
                     viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                    <path stroke-linecap="round" stroke-linejoin="round" d="<%= action[2] %>"></path>
                </svg>
                <span class="text-lg font-semibold"><%= action[1] %></span>
            </a>
            <% } %>

            <!-- View Winners (Full Width) -->
            <a href="viewWinners.jsp"
               class="col-span-full bg-green-500 hover:bg-green-600 text-white px-6 py-4 rounded-xl shadow text-xl font-semibold text-center transition flex items-center justify-center gap-3">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" stroke-width="2"
                     viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                    <path stroke-linecap="round" stroke-linejoin="round"
                          d="M8 21h8M12 17v4M7 4h10l1 5a4 4 0 01-8 0L7 4zm0 0H5a2 2 0 002 2m10-2h2a2 2 0 01-2 2" />
                </svg>
                <span>View Winners</span>
            </a>

        </div>

        <!-- Live Bidding Section -->
        <div class="mt-12 bg-white border border-green-200 p-6 rounded-xl shadow">
            <h2 class="text-2xl font-semibold text-green-700 text-center mb-4">Live Bidding Products</h2>
            <ul class="divide-y divide-gray-200">
                <%
                    while(rsLive.next()) {
                        int pid = rsLive.getInt("id");
                        String pname = rsLive.getString("name");
                %>
                <li class="flex justify-between items-center py-3">
                    <span class="text-gray-800 font-medium"><%= pname %></span>
                    <a href="<%=request.getContextPath()%>/buyer/liveBids.jsp?product_id=<%= pid %>"
                       class="bg-emerald-500 text-white px-4 py-2 rounded hover:bg-emerald-600 transition text-sm font-semibold shadow">
                       View Bids
                    </a>
                </li>
                <% } %>
            </ul>
        </div>
    </div>
</body>
</html>
