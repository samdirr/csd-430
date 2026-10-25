<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CSD 430 - Assignment 1.3</title>
</head>
<body>
    <h1>Welcome to Server Side Development</h1>
    <%
        String studentName = "Sam Dirr";
        java.time.LocalDate today = java.time.LocalDate.now();
    %>
    <p>Student: <%= studentName %></p>
    <p>Server date: <%= today %></p>
    <p>My first JSP application is running successfully!</p>
</body>
</html>