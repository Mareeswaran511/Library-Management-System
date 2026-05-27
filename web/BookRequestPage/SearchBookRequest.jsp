<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String requestId = request.getParameter("request_id");

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/java",
            "root",
            "12345"
        );

        String sql = "SELECT * FROM book_request WHERE request_id = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, requestId);

        rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Result</title>

<style>
body{
    font-family:Arial,sans-serif;
    background:linear-gradient(to right,#dbeafe,#f3f4f6);
    margin:0;
}

.header{
    background:#1e3a8a;
    color:white;
    text-align:center;
    padding:20px;
    font-size:30px;
    font-weight:bold;
}

.container{
    width:50%;
    margin:50px auto;
    background:white;
    padding:30px;
    border-radius:15px;
    box-shadow:0px 5px 15px rgba(0,0,0,0.2);
    text-align:center;
}

.message{
    font-size:18px;
    margin-bottom:20px;
    font-weight:bold;
}

.error{ color:#dc2626; }

table{
    width:100%;
    border-collapse:collapse;
    margin-top:20px;
}

th,td{
    border:1px solid #ddd;
    padding:10px;
    text-align:center;
}

th{
    background:#1e3a8a;
    color:white;
}

.btn{
    display:inline-block;
    padding:12px 20px;
    background:#1e3a8a;
    color:white;
    text-decoration:none;
    border-radius:8px;
    margin:5px;
}

.btn:hover{
    background:#2563eb;
}
</style>
</head>

<body>

<div class="header">Library Management System</div>

<div class="container">

<%
    if(rs.next()){
%>

<table>
    <tr>
        <th>Request ID</th>
        <th>Book Title</th>
        <th>Member ID</th>
        <th>Request Date</th>
    </tr>

    <tr>
        <td><%= rs.getInt("request_id") %></td>
        <td><%= rs.getString("book_title") %></td>
        <td><%= rs.getString("member_id") %></td>
        <td><%= rs.getDate("request_date") %></td>
    </tr>
</table>

<%
    } else {
%>

<div class="message error">
    No record found for Request ID: <%= requestId %>
</div>

<%
    }
%>

<hr style="margin:20px 0;">

<a href="SearchBookRequest.html" class="btn">Search Again</a>
<a href="ShowBookRequest.jsp" class="btn">View All</a>
<a href="../HomePage.html" class="btn">Home</a>

</div>

</body>
</html>

<%
    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if(rs != null) rs.close();
        if(ps != null) ps.close();
        if(conn != null) conn.close();
    }
%>