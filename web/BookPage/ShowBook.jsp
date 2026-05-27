<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Show Books</title>

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
    width:90%;
    margin:50px auto;
    background:white;
    padding:30px;
    border-radius:15px;
    box-shadow:0px 5px 15px rgba(0,0,0,0.2);
}

h2{
    text-align:center;
    color:#1e3a8a;
    margin-bottom:20px;
}

table{
    width:100%;
    border-collapse:collapse;
}

th{
    background:#1e3a8a;
    color:white;
    padding:15px;
}

td{
    padding:12px;
    text-align:center;
    border-bottom:1px solid #ddd;
}

tr:hover{
    background:#f1f5f9;
}

.available{
    color:green;
    font-weight:bold;
}

.issued{
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

<div class="header">
Library Management System
</div>

<div class="container">

<h2>Book Records</h2>

<table>

<tr>
<th>Book ID</th>
<th>Title</th>
<th>Author</th>
<th>Genre</th>
<th>Status</th>
</tr>

<%
try{

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/java",
"root",
"12345");

PreparedStatement stmt=
con.prepareStatement("SELECT * FROM books");

ResultSet rs=stmt.executeQuery();

while(rs.next()){
%>

<tr>

<td><%=rs.getInt("book_id")%></td>
<td><%=rs.getString("title")%></td>
<td><%=rs.getString("author")%></td>
<td><%=rs.getString("genre")%></td>

<td>

<%
String status=rs.getString("status");

if(status.equalsIgnoreCase("Available")){
%>

<span class="available">
<%=status%>
</span>

<%
}else{
%>

<span class="issued">
<%=status%>
</span>

<%
}
%>

</td>

</tr>

<%
}

rs.close();
stmt.close();
con.close();

}
catch(Exception e){
%>

<tr>
<td colspan="5">
Error : <%=e.getMessage()%>
</td>
</tr>

<%
}
%>

</table>

<center>
<a href="../BookPage.html" class="btn">Back</a>
<a href="../HomePage.html" class="btn">Back To Home</a>

</center>

</div>

</body>
</html>