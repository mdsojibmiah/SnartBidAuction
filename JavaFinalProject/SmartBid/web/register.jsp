<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register - SmartBid</title>

    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- Poppins Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }
    </style>
</head>
<body class="bg-gradient-to-br from-blue-100 to-purple-200 min-h-screen flex items-center justify-center px-4 relative">
    <!-- Main Registration Card -->
    <div class="bg-white shadow-2xl rounded-2xl p-10 w-full max-w-lg fade-in-up relative z-10">

        <h2 class="text-3xl font-bold text-center text-purple-700 mb-6">Create Your Account</h2>
        <p class="text-center text-gray-500 mb-8">Join SmartBid Auction Hub and start bidding or selling today!</p>

        <form action="RegisterServlet" method="post" class="space-y-5">

            <!-- Full Name -->
            <div>
                <label for="name" class="block text-gray-700 font-medium mb-1">Full Name</label>
                <input type="text" id="name" name="name" required
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-400 focus:outline-none" />
            </div>

            <!-- Email -->
            <div>
                <label for="email" class="block text-gray-700 font-medium mb-1">Email</label>
                <input type="email" id="email" name="email" required
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-400 focus:outline-none" />
            </div>

            <!-- Password -->
            <div>
                <label for="password" class="block text-gray-700 font-medium mb-1">Password</label>
                <input type="password" id="password" name="password" required
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-400 focus:outline-none" />
            </div>

            <!-- Role Selection -->
            <div>
                <label for="role" class="block text-gray-700 font-medium mb-1">Select Role</label>
                <select name="role" id="role" required
                        class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-400 focus:outline-none">
                    <option value="" disabled selected>Choose your role</option>
                    <option value="buyer">Buyer</option>
                    <option value="seller">Seller</option>
                </select>
            </div>

            <!-- Submit Button -->
            <button type="submit"
                    class="w-full bg-purple-600 text-white font-semibold py-3 rounded-lg hover:bg-purple-700 transition duration-300">
                Register
            </button>
        </form>

        <!-- Redirect Link -->
        <p class="text-center text-sm text-gray-600 mt-6">
            Already have an account?
            <a href="login.jsp" class="text-purple-600 font-medium hover:underline">Login here</a>
        </p>
    </div>

    <!-- Success Card (conditionally shown) -->
<%
    String success = request.getParameter("success");
    if ("1".equals(success)) {
%>
<div id="successCard" class="absolute top-8 left-1/2 transform -translate-x-1/2 bg-white border border-purple-300 shadow-xl rounded-xl p-6 w-[90%] max-w-md text-center fade-in-up z-50">
    <h2 class="text-2xl font-bold text-purple-600 mb-2">Welcome to SmartBid!</h2>
    <p class="text-gray-700 mb-4">Your registration was successful.</p>
    <a href="login.jsp" class="inline-block px-6 py-2 bg-purple-600 text-white rounded-lg hover:bg-purple-700 transition duration-300">
        Go to Login
    </a>
</div>
<%
    }
%>




</body>
</html>
