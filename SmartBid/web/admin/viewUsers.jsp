<%@ page import="java.sql.*, com.auction.util.DBConnection" %>
<%
    Connection conn = DBConnection.getConnection();
    PreparedStatement ps = conn.prepareStatement("SELECT * FROM users WHERE role != 'admin'");
    ResultSet rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Users</title>
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
    <div class="max-w-6xl mx-auto bg-white p-6 rounded shadow">
        <h2 class="text-2xl font-bold text-blue-700 mb-4">All Users Management</h2>
        <table class="min-w-full border">
            <thead class="bg-blue-100 text-left">
                <tr>
                    <th class="px-4 py-2">ID</th>
                    <th class="px-4 py-2">Name</th>
                    <th class="px-4 py-2">Email</th>
                    <th class="px-4 py-2">Role</th>
                    <th class="px-4 py-2">Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    while (rs.next()) {
                %>
                <tr class="border-t hover:bg-gray-50">
                    <td class="px-4 py-2"><%= rs.getInt("id") %></td>
                    <td class="px-4 py-2"><%= rs.getString("name") %></td>
                    <td class="px-4 py-2"><%= rs.getString("email") %></td>
                    <td class="px-4 py-2 capitalize"><%= rs.getString("role") %></td>
                    <td class="px-4 py-2 text-<%= rs.getString("status").equals("active") ? "green" : "red" %>-600 font-semibold">
                        <%= rs.getString("status") %>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>
