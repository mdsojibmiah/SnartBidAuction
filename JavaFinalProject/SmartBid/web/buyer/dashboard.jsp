<%@ page import="java.sql.*, com.auction.util.DBConnection" %>
<%@ page session="true" %>
<%
    String name = (String) session.getAttribute("name");
    int uid = (int) session.getAttribute("uid");

    Connection conn = DBConnection.getConnection();

    // Wallet info
    double wallet = 0.0;
    PreparedStatement psWallet = conn.prepareStatement("SELECT balance FROM buyer_wallet WHERE buyer_id = ?");
    psWallet.setInt(1, uid);
    ResultSet rsWallet = psWallet.executeQuery();
    if(rsWallet.next()) {
        wallet = rsWallet.getDouble("balance");
    }

    // Approved products
    PreparedStatement ps = conn.prepareStatement("SELECT id, name FROM products WHERE status='approved'");
    ResultSet rs = ps.executeQuery();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Buyer Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }
    </style>
</head>
<body class="bg-gray-100 min-h-screen py-8 px-4 md:px-12">
    <div class="max-w-7xl mx-auto bg-white p-8 rounded-xl shadow-xl space-y-10">
        <!-- Header Section -->
        <div class="flex flex-col md:flex-row justify-between items-center bg-gradient-to-r from-blue-100 to-purple-100 p-6 rounded-xl shadow mb-6">

            <!-- Left: Dashboard Title -->
            <div class="mb-4 md:mb-0 md:w-1/3">
                <div class="bg-white px-5 py-3 rounded-lg shadow text-left">
                    <h2 class="text-2xl font-bold text-gray-800 flex items-center gap-2">
                        <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" stroke-width="2"
                             viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path stroke-linecap="round" stroke-linejoin="round"
                                  d="M3 4a1 1 0 011-1h5.586a1 1 0 01.707.293l1.414 1.414a1 1 0 00.707.293H20a1 1 0 011 1v13a1 1 0 01-1 1H4a1 1 0 01-1-1V4z"/>
                        </svg>
                        Buyer Dashboard
                    </h2>
                </div>
            </div>

            <!-- Center: Welcome Message -->
            <div class="text-center md:w-1/2">
                <h1 class="text-3xl font-bold text-gray-900">
                    Welcome, <span class="text-blue-600"><%= name %></span>
                </h1>
                <p class="text-gray-600 text-sm">Your personalized auction dashboard</p>
            </div>
        </div>



        <!-- Top Info Cards -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <!-- Wallet -->
            <div class="bg-green-100 border-l-4 border-green-500 p-5 rounded-lg shadow flex flex-col">
                <h2 class="text-lg font-semibold text-green-800 mb-1">Wallet Balance</h2>
                <p class="text-2xl font-bold text-green-700"><%= String.format("%.2f", wallet) %></p>
            </div>

            <!-- Recharge -->
            <div class="bg-yellow-100 border-l-4 border-yellow-500 p-5 rounded-lg shadow flex flex-col">
                <h2 class="text-lg font-semibold text-yellow-800 mb-2">Add Money</h2>
                <a href="recharge.jsp"
                   class="inline-flex items-center gap-2 bg-yellow-500 hover:bg-yellow-600 text-white px-4 py-2 rounded shadow w-max">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2"
                         viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/></svg>
                    Recharge Wallet
                </a>
            </div>

            <!-- Logout -->
            <div class="bg-red-100 border-l-4 border-red-500 p-5 rounded-lg shadow flex flex-col">
                <h2 class="text-lg font-semibold text-red-800 mb-2">Exit Dashboard</h2>
                <a href="<%= request.getContextPath() %>/logout.jsp"
                   class="inline-flex items-center gap-2 bg-red-500 hover:bg-red-600 text-white px-4 py-2 rounded shadow w-max">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2"
                         viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M17 16l4-4m0 0l-4-4m4 4H7"/></svg>
                    Logout
                </a>
            </div>
        </div>

        <!-- Action Buttons -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <a href="<%= request.getContextPath() %>/MyBidsServlet"
               class="flex flex-col items-center justify-center bg-indigo-500 text-white rounded-xl py-6 shadow hover:bg-indigo-600 transition">
                <svg class="w-10 h-10 mb-3" fill="none" stroke="currentColor" stroke-width="2"
                     viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round"
                     d="M13 17h6m0 0l-3-3m3 3l-3 3M9 17v-2a4 4 0 014-4h4V7a2 2 0 00-2-2H7a2 2 0 00-2 2v6" /></svg>
                My Bids
            </a>

            <a href="viewProducts.jsp"
               class="flex flex-col items-center justify-center bg-green-500 text-white rounded-xl py-6 shadow hover:bg-green-600 transition">
                <svg class="w-10 h-10 mb-3" fill="none" stroke="currentColor" stroke-width="2"
                     viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round"
                     d="M3 3h18M9 3v18M15 3v18M3 9h18M3 15h18" /></svg>
                Browse Auctions
            </a>

            <a href="../admin/viewWinners.jsp"
               class="flex flex-col items-center justify-center bg-purple-500 text-white rounded-xl py-6 shadow hover:bg-purple-600 transition">
                <svg class="w-10 h-10 mb-3" fill="none" stroke="currentColor" stroke-width="2"
                     viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round"
                     d="M8 21h8M12 17v4M7 4h10l1 5a4 4 0 01-8 0L7 4z" /></svg>
                View Winners
            </a>
        </div>

        <!-- Approved Products -->
        <div>
            <h2 class="text-2xl font-semibold text-gray-800 mb-4">Live Bidding Products</h2>
            <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-5">
                <%
                    while(rs.next()) {
                        int pid = rs.getInt("id");
                        String pname = rs.getString("name");
                %>
                <div class="bg-gray-100 p-4 rounded-lg shadow hover:shadow-lg transition">
                    <h3 class="text-lg font-semibold text-gray-700 mb-2"><%= pname %></h3>
                    <a href="<%=request.getContextPath()%>/buyer/liveBids.jsp?product_id=<%= pid %>"
                       class="inline-flex items-center gap-2 text-sm font-semibold bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 transition">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2"
                             viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round"
                             d="M15 12H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
                        View Live Bids
                    </a>
                </div>
                <% } %>
            </div>
        </div>

    </div>

</body>
</html>
