<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String requestId = request.getParameter("request_id");

    Connection conn = null;
    PreparedStatement ps = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/java",
            "root",
            "12345"
        );

        String sql = "DELETE FROM book_request WHERE request_id = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, requestId);

        int result = ps.executeUpdate();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Result</title>

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
    text-align:center;
    box-shadow:0px 5px 15px rgba(0,0,0,0.2);
}

.message{
    font-size:18px;
    font-weight:bold;
    margin-bottom:20px;
}

.success{ color:green; }
.error{ color:red; }

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
    if(result > 0){
%>
    <div class="message success">
        Book request deleted successfully
    </div>
<%
    } else {
%>
    <div class="message error">
        Request ID not found. Deletion failed.
    </div>
<%
    }
%>

<hr style="margin:20px 0;">

<a href="DeleteBookRequest.html" class="btn">Delete Again</a>
<a href="ShowBookRequest.jsp" class="btn">View All</a>
<a href="HomePage.jsp" class="btn">Home</a>

</div>

</body>
</html>

<%
    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if(ps != null) ps.close();
        if(conn != null) conn.close();
    }
%>