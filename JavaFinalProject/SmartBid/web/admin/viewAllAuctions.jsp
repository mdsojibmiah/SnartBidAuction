<%@ page import="java.sql.*, com.auction.util.DBConnection" %>
<%@ page session="true" %>
<%
    Connection conn = DBConnection.getConnection();
    PreparedStatement ps = conn.prepareStatement("SELECT p.id, p.name, p.status FROM products p WHERE p.status = 'approved'");
    ResultSet rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View All Auctions - Admin</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen p-8">

    <div class="max-w-5xl mx-auto bg-white p-8 rounded shadow-lg">
        <h1 class="text-3xl font-bold text-center mb-6 text-blue-700">Approved Auction Products</h1>

        <!-- Show messages -->
        <%
            String msg = request.getParameter("msg");
            String error = request.getParameter("error");
            if (msg != null) {
        %>
            <div class="bg-green-100 text-green-800 p-3 rounded mb-4"><%= msg %></div>
        <%
            } else if (error != null) {
        %>
            <div class="bg-red-100 text-red-800 p-3 rounded mb-4"><%= error %></div>
        <%
            }
        %>

        <table class="min-w-full bg-white border border-gray-200">
            <thead>
                <tr class="bg-gray-200 text-gray-700">
                    <th class="py-3 px-4 text-left">Product ID</th>
                    <th class="py-3 px-4 text-left">Product Name</th>
                    <th class="py-3 px-4 text-left">Status</th>
                    <th class="py-3 px-4 text-left">Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    boolean hasData = false;
                    while (rs.next()) {
                        hasData = true;
                        int pid = rs.getInt("id");
                        String pname = rs.getString("name");
                        String status = rs.getString("status");
                %>
                <tr class="border-t">
                    <td class="py-3 px-4"><%= pid %></td>
                    <td class="py-3 px-4"><%= pname %></td>
                    <td class="py-3 px-4 capitalize"><%= status %></td>
                    <td class="py-3 px-4">
                        <a href="<%=request.getContextPath()%>/WinnerDeclareServlet?product_id=<%= pid %>"
                           class="bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded transition text-sm font-semibold">
                            Declare Winner
                        </a>
                    </td>
                </tr>
                <% } %>

                <% if (!hasData) { %>
                <tr>
                    <td colspan="4" class="text-center text-gray-500 py-5">No approved auction products found.</td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <!-- Back Button -->
        <div class="mt-6 text-center">
            <a href="dashboard.jsp"
               class="inline-block bg-gray-500 hover:bg-gray-600 text-white px-5 py-2 rounded transition text-sm font-medium">
                ? Back to Admin Dashboard
            </a>
        </div>

    </div>

</body>
</html>
