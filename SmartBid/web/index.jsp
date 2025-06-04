<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>SmartBid: Welcome</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Google Font: Poppins -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
                font-family: 'Poppins', sans-serif;
            }

        @keyframes fadeInUp {
            0% { opacity: 0; transform: translateY(40px); }
            100% { opacity: 1; transform: translateY(0); }
        }
        .fade-in-up {
            animation: fadeInUp 1s ease-out forwards;
        }
    </style>
</head>
<body class="bg-gradient-to-br from-indigo-100 to-purple-200 min-h-screen flex items-center justify-center p-6">

<div class="bg-white p-10 rounded-2xl shadow-2xl max-w-xl w-full fade-in-up space-y-6 text-center">
    <!-- Title -->
    <h1 class="text-4xl font-bold text-purple-700">Welcome to</h1>
    <h2 class="text-4xl font-extrabold text-blue-600">SmartBid Auction Hub</h2>

    <!-- Subtitle -->
    <p class="text-lg text-gray-600 mt-2">Your Trusted Online Auction Platform</p>

    <!-- Buttons -->
    <div class="flex justify-center gap-6 mt-8">
        <a href="register.jsp"
           class="bg-green-500 hover:bg-green-600 text-white px-6 py-3 rounded-lg shadow text-lg font-medium transition">
            Create Account
        </a>
        <a href="login.jsp"
           class="bg-blue-500 hover:bg-blue-600 text-white px-6 py-3 rounded-lg shadow text-lg font-medium transition">
            Login
        </a>
    </div>

    <!-- Footer -->
    <p class="text-sm text-gray-400 mt-6">
        © <%= java.time.Year.now() %> SmartBid@sojiberror | All Rights Reserved.
    </p>
</div>

</body>
</html>
