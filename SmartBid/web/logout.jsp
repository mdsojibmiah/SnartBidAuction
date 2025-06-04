<%-- 
    Document   : logout
    Created on : Jun 3, 2025, 3:02:00 PM
    Author     : IT BD
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
        <%@ page language="java" session="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

<%
    session.invalidate(); // ইউজারের session শেষ করে দিচ্ছে
    response.sendRedirect("login.jsp"); // login.jsp তে পাঠিয়ে দিচ্ছে
%>

    </body>
</html>
