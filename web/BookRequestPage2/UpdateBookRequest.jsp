<%-- 
    Document   : UpdateBookRequest
    Created on : 23 May 2026, 11:31:48 pm
    Author     : maree
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Processing Update...</title>

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
    String requestIdStr = request.getParameter("request_id");
    String title = request.getParameter("book_title");
    String memberId = request.getParameter("member_id");
    String reqDate = request.getParameter("request_date");

    Connection con = null;
    PreparedStatement stmt = null;

    try {
        int requestId = Integer.parseInt(requestIdStr);

        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/java", 
            "root", 
            "12345"
        );

        // SQL update statement targeting a single Request ID
        String query = "UPDATE book_request SET book_title = ?, member_id = ?, request_date = ? WHERE request_id = ?";
        stmt = con.prepareStatement(query);
        
        stmt.setString(1, title);
        stmt.setString(2, memberId);
        stmt.setString(3, reqDate);
        stmt.setInt(4, requestId);

        int rowsUpdated = stmt.executeUpdate();

        if (rowsUpdated > 0) {
%>
            <div class="message success">✏️ Request ID <%=requestId%> updated successfully!</div>
<%
        } else {
%>
            <div class="message error">⚠️ No record found with Request ID "<%=requestId%>". Nothing was modified.</div>
<%
        }
    } 
    catch (NumberFormatException nfe) {
%>
        <div class="message error">❌ Error: Invalid Request ID formatting.</div>
<%
    }
    catch (SQLException se) {
        // Intercepts foreign key failures if the assigned member string doesn't match an existing library user
        if (se.getErrorCode() == 1452) {
%>
            <div class="message error">❌ Update Failed: The Member ID "<%=memberId%>" does not exist in our library records.</div>
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

<a href="UpdateBookRequest.html" class="btn">Try Another Update</a>
<a href="../HomePage2.html" class="btn">Back</a>

</div>

</body>
</html>