<%@ page import="java.sql.*, com.auction.util.DBConnection" %>
<%
    Connection conn = DBConnection.getConnection();
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM users WHERE status = 'pending'");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Requests - Admin Panel</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; }
    </style>
</head>
<body class="bg-gray-100 p-6 min-h-screen">

    <!-- Header with Back Button -->
    <div class="flex justify-between items-center mb-6">
        <div class="flex items-center gap-3">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-blue-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c1.104 0 2-.672 2-1.5S13.104 5 12 5s-2 .672-2 1.5S10.896 8 12 8zm0 2c-2.209 0-4 1.791-4 4h2a2 2 0 114 0h2c0-2.209-1.791-4-4-4z" />
            </svg>
            <h1 class="text-3xl font-bold text-gray-800">Pending User Request</h1>
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

    <!-- Requests Table -->
    <div class="bg-white p-4 shadow-xl rounded-lg">
        <table class="min-w-full text-sm text-left">
            <thead class="bg-indigo-100 text-gray-700 uppercase">
                <tr>
                    <th class="px-4 py-2">ID</th>
                    <th class="px-4 py-2">Name</th>
                    <th class="px-4 py-2">Email</th>
                    <th class="px-4 py-2">Role</th>
                    <th class="px-4 py-2">Wallet</th>
                    <th class="px-4 py-2">Action</th>
                </tr>
            </thead>
            <tbody class="bg-white text-gray-800">
                <%
                    while(rs.next()) {
                        int id = rs.getInt("id");
                        String name = rs.getString("name");
                        String email = rs.getString("email");
                        String role = rs.getString("role");
                        double wallet = rs.getDouble("wallet");

                        String badgeColor = role.equals("seller") ? "bg-red-200 text-red-800" : "bg-green-200 text-green-800";
                %>
                <tr class="border-t hover:bg-gray-50 transition">
                    <td class="px-4 py-2"><%= id %></td>
                    <td class="px-4 py-2"><%= name %></td>
                    <td class="px-4 py-2"><%= email %></td>
                    <td class="px-4 py-2">
                        <span class="px-2 py-1 rounded text-xs font-semibold <%= badgeColor %>"><%= role %></span>
                    </td>
                    <td class="px-4 py-2"><%= wallet %></td>
                    <td class="px-4 py-2 flex gap-2">

                        <!-- Approve Button -->
                        <form action="UpdateUserStatusServlet" method="post">
                            <input type="hidden" name="id" value="<%= id %>">
                            <input type="hidden" name="status" value="active">
                            <button type="submit" class="flex items-center gap-1 bg-green-500 text-white px-3 py-1 rounded hover:bg-green-600 transition">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                                </svg>
                                Approve
                            </button>
                        </form>

                        <!-- Reject Button -->
                        <form action="UpdateUserStatusServlet" method="post">
                            <input type="hidden" name="id" value="<%= id %>">
                            <input type="hidden" name="status" value="blocked">
                            <button type="submit" class="flex items-center gap-1 bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600 transition">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                                </svg>
                                Reject
                            </button>
                        </form>

                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

</body>
</html>
