<%-- 
    Document   : SearchFeedbackPage
    Created on : 24 May 2026, 12:10:00 pm
    Author     : maree
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Feedback Result</title>

<style>
body{
    font-family: Arial;
    background: linear-gradient(to right,#dbeafe,#f3f4f6);
    margin:0;
}

.container{
    width:50%;
    margin:120px auto;
    background:white;
    padding:30px;
    border-radius:15px;
    box-shadow:0px 5px 15px rgba(0,0,0,0.2);
    text-align:center;
}

h2{
    color:#1e3a8a;
}

table{
    width:100%;
    border-collapse:collapse;
    margin-top:20px;
}

th{
    background:#1e3a8a;
    color:white;
    padding:12px;
}

td{
    padding:12px;
    border-bottom:1px solid #ddd;
}

.error{
    color:red;
    font-weight:bold;
}

.btn{
    display:inline-block;
    margin-top:20px;
    padding:12px 20px;
    background:#1e3a8a;
    color:white;
    text-decoration:none;
    border-radius:8px;
}

.btn:hover{
    background:#2563eb;
}
</style>
</head>

<body>

<div class="container">

<%
String feedback_id = request.getParameter("feedback_id").trim();

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/java",
"root",
"12345"
);

ps = con.prepareStatement(
"SELECT * FROM feedback WHERE feedback_id=?"
);

ps.setString(1, feedback_id);

rs = ps.executeQuery();

if(rs.next()){
%>

<h2>Feedback Details</h2>

<table>
<tr>
<th>Feedback ID</th>
<th>Member ID</th>
<th>Message</th>
</tr>

<tr>
<td><%=rs.getInt("feedback_id")%></td>
<td><%=rs.getString("member_id")%></td>
<td><%=rs.getString("message")%></td>
</tr>
</table>

<%
}else{
%>

<h2 class="error">Feedback ID not found</h2>

<%
}

}catch(Exception e){
%>

<h2 class="error">Error: <%=e.getMessage()%></h2>

<%
}finally{

try{ if(rs != null) rs.close(); }catch(Exception e){}
try{ if(ps != null) ps.close(); }catch(Exception e){}
try{ if(con != null) con.close(); }catch(Exception e){}

}
%>

<a href="SearchFeedbackPage.html" class="btn">Search Again</a>
<a href="../FeedbackPage.html" class="btn">Back</a>

</div>

</body>
</html>