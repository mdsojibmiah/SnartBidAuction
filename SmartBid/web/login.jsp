<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - SmartBid</title>

    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- Poppins Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .fade-in-up {
            animation: fadeInUp 0.8s ease-out;
        }
    </style>
</head>
<body class="bg-gradient-to-br from-purple-100 to-blue-200 min-h-screen flex items-center justify-center px-4">

    <div class="bg-white shadow-2xl rounded-2xl p-10 w-full max-w-lg fade-in-up">

        <h2 class="text-3xl font-bold text-center text-blue-600 mb-6">Login to Your Account</h2>
        <p class="text-center text-gray-500 mb-8">Access SmartBid and start exploring auctions.</p>

        <!-- Error Alert -->
        <%
            String error = request.getParameter("error");
            if ("invalid".equals(error)) {
        %>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-6 text-sm fade-in-up" role="alert">
                <strong class="font-semibold">Invalid!</strong> Email or password is incorrect.
            </div>
        <%
            } else if ("blocked".equals(error)) {
        %>
            <div class="bg-orange-100 border border-orange-400 text-orange-700 px-4 py-3 rounded mb-6 text-sm fade-in-up" role="alert">
                <strong class="font-semibold">Blocked!</strong> Your account has been blocked by admin.
            </div>
        <%
            } else if ("pending".equals(error)) {
        %>
            <div class="bg-yellow-100 border border-yellow-400 text-yellow-700 px-4 py-3 rounded mb-6 text-sm fade-in-up" role="alert">
                <strong class="font-semibold">Pending!</strong> Your account is pending approval by admin.
            </div>
        <%
            } else if ("server".equals(error)) {
        %>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-6 text-sm fade-in-up" role="alert">
                <strong class="font-semibold">Server Error!</strong> Something went wrong. Please try again later.
            </div>
        <%
            }
        %>

        <form action="LoginServlet" method="post" class="space-y-5">

            <!-- Email -->
            <div>
                <label for="email" class="block text-gray-700 font-medium mb-1">Email</label>
                <input type="email" id="email" name="email" required
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400" />
            </div>

            <!-- Password -->
            <div>
                <label for="password" class="block text-gray-700 font-medium mb-1">Password</label>
                <input type="password" id="password" name="password" required
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400" />
            </div>

            <!-- Login Button -->
            <button type="submit"
                    class="w-full bg-blue-600 text-white font-semibold py-3 rounded-lg hover:bg-blue-700 transition duration-300">
                Login
            </button>
        </form>

        <!-- Register Link -->
        <p class="text-center text-sm text-gray-600 mt-6">
            Don’t have an account?
            <a href="register.jsp" class="text-blue-600 font-medium hover:underline">Register here</a>
        </p>
    </div>

</body>
</html>
