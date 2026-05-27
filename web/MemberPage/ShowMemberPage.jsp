<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Show Members</title>

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

.error{
    color:red;
    text-align:center;
    font-weight:bold;
}

</style>

</head>

<body>

<div class="header">
Library Management System
</div>

<div class="container">

<h2>Member Records</h2>

<table>

<tr>
<th>Member ID</th>
<th>Member Name</th>
<th>Email ID</th>
<th>Phone No</th>
</tr>

<%
try{

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con=
DriverManager.getConnection(
"jdbc:mysql://localhost:3306/java",
"root",
"12345");

PreparedStatement stmt=
con.prepareStatement(
"SELECT * FROM member_list");

ResultSet rs=stmt.executeQuery();

while(rs.next()){
%>

<tr>

<td><%=rs.getInt("member_id")%></td>
<td><%=rs.getString("member_name")%></td>
<td><%=rs.getString("email")%></td>
<td><%=rs.getString("phone")%></td>

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
<td colspan="4" class="error">
Error : <%=e.getMessage()%>
</td>
</tr>

<%
}
%>

</table>

<center>
<a href="../MemberPage.html" class="btn">Back</a>
<a href="../HomePage.html" class="btn">Back To Home</a>
</center>

</div>

</body>
</html>