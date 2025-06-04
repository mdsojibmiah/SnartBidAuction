<%@ page import="java.sql.*, com.auction.util.DBConnection" %>
<%
    int productId = Integer.parseInt(request.getParameter("product_id"));
    Integer buyerId = (Integer) session.getAttribute("uid");

    if (buyerId == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    Connection conn = DBConnection.getConnection();
    PreparedStatement ps = conn.prepareStatement("SELECT * FROM products WHERE id=?");
    ps.setInt(1, productId);
    ResultSet rs = ps.executeQuery();

    if (!rs.next()) {
        out.println("<h3>Product not found.</h3>");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Place Bid</title>
    <script src="https://cdn.tailwindcss.com"></script>
                <!-- Poppins Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }
    </style>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center p-6">

    <div class="bg-white shadow-md rounded-xl p-8 w-full max-w-xl">
        <h2 class="text-2xl font-bold text-blue-600 mb-4">
            Place Bid on: <span class="text-gray-800"><%= rs.getString("name") %></span>
        </h2>

        <div class="mb-6 space-y-2 text-gray-700">
            <p><strong>Description:</strong> <%= rs.getString("description") %></p>
            <p><strong>Start Price:</strong><%= rs.getDouble("start_price") %></p>
            <p><strong>Auction Ends At:</strong> <%= rs.getTimestamp("end_time") %></p>
        </div>

        <form action="<%= request.getContextPath() %>/PlaceBidServlet" method="post" class="space-y-4">
            <input type="hidden" name="product_id" value="<%= productId %>" />
            <input type="hidden" name="buyer_id" value="<%= buyerId %>" />

            <div>
                <label class="block text-gray-700 font-medium mb-1">Your Bid Amount ($)</label>
                <input type="number" name="bid_amount" step="0.01" required
                       class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400" />
            </div>

            <div class="text-center">
                <button type="submit"
                        class="bg-green-500 hover:bg-green-600 text-white px-6 py-2 rounded-lg shadow-md transition">
                    Submit Bid
                </button>
            </div>
        </form>
    </div>

</body>
</html>
