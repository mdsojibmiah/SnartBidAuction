<%@ page import="java.sql.*, com.auction.util.DBConnection" %>
<%@ page session="true" %>
<%
    Connection conn = DBConnection.getConnection();
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM users WHERE role IN ('buyer', 'seller')");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Users - SmartBid Admin</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }
    </style>
</head>
<body class="bg-gradient-to-br from-blue-100 to-purple-100 min-h-screen p-6">

    <div class="max-w-6xl mx-auto bg-white shadow-2xl rounded-xl p-8">
        <div class="flex items-center justify-between mb-6">
            <h2 class="text-3xl font-bold text-blue-700">
                <svg xmlns="http://www.w3.org/2000/svg" class="inline w-6 h-6 text-blue-600 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5.121 17.804A8.96 8.96 0 0112 15c2.136 0 4.09.747 5.607 1.99M15 11a3 3 0 11-6 0 3 3 0 016 0zm2.93 6.588a2 2 0 012.828 2.829l-.586.586a2 2 0 01-2.828-2.829l.586-.586z" />
                </svg>
                Manage Users (Block/Unblock)
            </h2>

            <a href="dashboard.jsp" class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition duration-300 text-sm flex items-center gap-1 shadow">
                <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h11M9 21V3m0 0L5 7m4-4l4 4" />
                </svg>
                Dashboard
            </a>
        </div>



        <div class="overflow-x-auto">
            <table class="min-w-full border border-gray-200 rounded-lg overflow-hidden shadow-sm">
                <thead class="bg-blue-100 text-gray-800 text-sm font-semibold">
                    <tr>
                        <th class="px-4 py-3 text-left">#ID</th>
                        <th class="px-4 py-3 text-left">Name</th>
                        <th class="px-4 py-3 text-left">Email</th>
                        <th class="px-4 py-3 text-left">Role</th>
                        <th class="px-4 py-3 text-left">Status</th>
                        <th class="px-4 py-3 text-left">Action</th>
                    </tr>
                </thead>
                <tbody class="text-sm text-gray-700 bg-white">
                    <%
                        while(rs.next()) {
                            int id = rs.getInt("id");
                            String name = rs.getString("name");
                            String email = rs.getString("email");
                            String role = rs.getString("role");
                            String status = rs.getString("status");
                    %>
                    <tr class="border-t border-gray-200 hover:bg-gray-50 transition">
                        <td class="px-4 py-2"><%= id %></td>
                        <td class="px-4 py-2"><%= name %></td>
                        <td class="px-4 py-2"><%= email %></td>
                        <td class="px-4 py-2 capitalize"><%= role %></td>
                        <td class="px-4 py-2 font-medium">
                            <span class="<%= status.equals("active") ? "text-green-600" : "text-red-600" %>">
                                <%= status %>
                            </span>
                        </td>
                        <td class="px-4 py-2">
                            <form action="<%=request.getContextPath()%>/UpdateUserStatusServlet" method="post">
                                <input type="hidden" name="id" value="<%= id %>" />
                                <input type="hidden" name="status" value="<%= status.equals("active") ? "blocked" : "active" %>" />
                                <button type="submit" class="flex items-center gap-1 bg-blue-500 text-white px-3 py-1 rounded hover:bg-blue-600 transition duration-300 text-sm">
                                    <%= status.equals("active") ? "Block" : "Unblock" %>
                                    <% if(status.equals("active")) { %>
                                        <!-- Block icon -->
                                        <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18.364 5.636a9 9 0 010 12.728M5.636 18.364a9 9 0 0112.728-12.728M9 15l6-6"/>
                                        </svg>
                                    <% } else { %>
                                        <!-- Unblock icon -->
                                        <svg xmlns="http://www.w3.org/2000/svg" class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                                        </svg>
                                    <% } %>
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
