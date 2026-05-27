<%-- 
    Document   : AddBookRequest
    Created on : 23 May 2026, 11:26:52 pm
    Author     : maree
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Processing Request...</title>

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial,sans-serif;
}

body{
    background:linear-gradient(to right,#dbeafe,#f3f4f6);
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
    text-align: center;
}

.message {
    font-size: 20px;
    margin-bottom: 25px;
    font-weight: bold;
}

.success {
    color: #16a34a;
}

.error {
    color: #dc2626;
}

.btn {
    display:inline-block;
    padding:12px 20px;
    background:#1e3a8a;
    color:white;
    text-decoration:none;
    border-radius:8px;
    margin: 5px;
}

.btn:hover{
    background:#2563eb;
}
</style>
</head>

<body>

<div class="header">
Library Management System
</div>

<div class="container">

<%
    String title = request.getParameter("book_title");
    String memberId = request.getParameter("member_id");
    String reqDate = request.getParameter("request_date");

    Connection con = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/java", 
            "root", 
            "12345"
        );

        // Note: request_id handles itself since it is AUTO_INCREMENT
        String query = "INSERT INTO book_request (book_title, member_id, request_date) VALUES (?, ?, ?)";
        stmt = con.prepareStatement(query);
        
        stmt.setString(1, title);
        stmt.setString(2, memberId);
        stmt.setString(3, reqDate);

        int rowsInserted = stmt.executeUpdate();

        if (rowsInserted > 0) {
%>
            <div class="message success">🎉 Book request submitted successfully!</div>
<%
        } else {
%>
            <div class="message error">⚠️ The request could not be processed. Please try again.</div>
<%
        }
    } 
    catch (SQLException se) {
        // This catches Foreign Key failures specifically if the Member ID doesn't exist
        if (se.getErrorCode() == 1452) {
%>
            <div class="message error">❌ Error: The Member ID "<%=memberId%>" does not exist in our library records.</div>
<%
        } else {
%>
            <div class="message error">Database Error: <%=se.getMessage()%></div>
<%
        }
    } 
    catch (Exception e) {
%>
        <div class="message error">Error: <%=e.getMessage()%></div>
<%
    } 
    finally {
        if(stmt != null) try { stmt.close(); } catch(SQLException e){}
        if(con != null) try { con.close(); } catch(SQLException e){}
    }
%>

<hr style="border: 0; border-top: 1px solid #ddd; margin: 20px 0;">

<a href="AddBookRequest.html" class="btn">Add Another</a>
<a href="ShowBookRequest.jsp" class="btn">View All Requests</a>
<a href="../HomePage.html" class="btn">Home</a>

</div>

</body>
</html>
