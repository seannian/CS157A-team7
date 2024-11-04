<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <!-- Link to External CSS -->
    <link rel="stylesheet" type="text/css" href="./css/style.css">
</head>
<body>
    <div class="header">
        <h1>Welcome to myFlorabase!</h1>
    </div>

    <div class="content">
        <p>This is a simple JSP page connected to an external CSS file for styling.</p>
    </div>

    <!-- Start User Session -->
    <% 
        HttpSession userSession = request.getSession();
        String username = (String) userSession.getAttribute("username");
        if (username == null) {
            username = "Guest";
            userSession.setAttribute("username", username);
        }
    %>
    <div class="message">
        <p>Hello, <%= username %>!</p>
    </div>
</body>
</html>
