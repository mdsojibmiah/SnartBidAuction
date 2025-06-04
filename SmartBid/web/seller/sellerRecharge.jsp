<%@ page session="true" %>
<%
    String name = (String) session.getAttribute("name");
    int uid = (int) session.getAttribute("uid");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Recharge Wallet</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; }
    </style>
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen">

    <div class="bg-white p-8 rounded-lg shadow-md w-full max-w-md">
        <h2 class="text-2xl font-bold text-center text-blue-600 mb-6">
            Hello <%= name %>, Recharge Your Wallet
        </h2>

        <form action="<%= request.getContextPath() %>/RechargeWalletServlet" method="post" class="space-y-4">
            <input type="hidden" name="uid" value="<%= uid %>" />
            <input type="hidden" name="role" value="seller" /> <!--? Added role -->

            <div>
                <label class="block text-gray-700 mb-1 font-medium">Amount to Add ($)</label>
                <input type="number" name="amount" step="0.01" required
                       class="w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400" />
            </div>

            <div class="text-center">
                <button type="submit"
                        class="bg-green-500 text-white px-6 py-2 rounded-lg hover:bg-green-600 transition">
                     Add Money
                </button>
            </div>
        </form>
    </div>

</body>
</html>
