<%@ page import="java.sql.*, com.auction.util.DBConnection" %>
<%
    // Session ???? seller_id ????? ? null check
    HttpSession sess = request.getSession(false);
    if (sess == null || sess.getAttribute("uid") == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    int sellerId = (Integer) sess.getAttribute("uid");

    // ??????? ???? seller ?? approved products load ???
    Connection conn = DBConnection.getConnection();
    PreparedStatement ps = conn.prepareStatement(
        "SELECT * FROM products WHERE status='approved' AND seller_id=?"
    );
    ps.setInt(1, sellerId);
    ResultSet rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Approved Products</title>
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
        <h2 class="text-2xl font-bold text-green-700 mb-6">My Approved Auction Products</h2>

        <div class="overflow-x-auto">
            <table class="min-w-full border border-gray-300 rounded-lg overflow-hidden">
                <thead class="bg-green-100 text-gray-700">
                    <tr>
                        <th class="px-4 py-2 text-left">Name</th>
                        <th class="px-4 py-2 text-left">Description</th>
                        <th class="px-4 py-2 text-left">Start Price</th>
                        <th class="px-4 py-2 text-left">End Time</th>
                        <th class="px-4 py-2 text-left">Status</th>
                    </tr>
                </thead>
                <tbody class="text-gray-700">
                    <%
                        boolean hasData = false;
                        while (rs.next()) {
                            hasData = true;
                    %>
                    <tr class="border-t border-gray-200 hover:bg-gray-50">
                        <td class="px-4 py-2 font-medium"><%= rs.getString("name") %></td>
                        <td class="px-4 py-2"><%= rs.getString("description") %></td>
                        <td class="px-4 py-2">$<%= rs.getDouble("start_price") %></td>
                        <td class="px-4 py-2"><%= rs.getTimestamp("end_time") %></td>
                        <td class="px-4 py-2 text-green-600 font-semibold">Approved</td>
                    </tr>
                    <%
                        }
                        if (!hasData) {
                    %>
                    <tr>
                        <td colspan="5" class="text-center py-4 text-red-500">No approved products uploaded by you yet.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>
