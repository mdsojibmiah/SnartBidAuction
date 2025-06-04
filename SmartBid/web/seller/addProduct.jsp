<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
    int sellerId = (int) session.getAttribute("uid");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Product</title>
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

    <div class="bg-white shadow-2xl rounded-2xl p-10 w-full max-w-2xl">
        <!-- Header -->
        <div class="mb-8 text-center">
            <h2 class="text-3xl font-extrabold text-green-600">Add New Auction Product</h2>
            <p class="text-gray-500 mt-2 text-sm">Fill out the form below to submit a product for auction approval.</p>
        </div>

        <!-- Form -->
        <form action="<%=request.getContextPath()%>/AddProductServlet" method="post" class="space-y-6">
            <input type="hidden" name="seller_id" value="<%= sellerId %>" />

            <!-- Product Name -->
            <div>
                <label class="block text-gray-700 font-semibold mb-1">Product Name</label>
                <input type="text" name="name" required
                       class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-400 shadow-sm" />
            </div>

            <!-- Description -->
            <div>
                <label class="block text-gray-700 font-semibold mb-1">Description</label>
                <textarea name="description" required rows="4"
                          class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-400 shadow-sm resize-none"
                          placeholder="Write a short description..."></textarea>
            </div>

            <!-- Start Price -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <label class="block text-gray-700 font-semibold mb-1">Start Price ($)</label>
                    <input type="number" name="start_price" step="0.01" required
                           class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-400 shadow-sm" />
                </div>

                <!-- End Time -->
                <div>
                    <label class="block text-gray-700 font-semibold mb-1">Auction End Time</label>
                    <input type="datetime-local" name="end_time" required
                           class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-400 shadow-sm" />
                </div>
            </div>

            <!-- Submit Button -->
            <div class="text-center mt-6">
                <button type="submit"
                        class="bg-green-600 hover:bg-green-700 text-white text-lg px-8 py-3 rounded-xl shadow-lg transition">
                    Submit Product
                </button>
            </div>
        </form>
    </div>

</body>
</html>
