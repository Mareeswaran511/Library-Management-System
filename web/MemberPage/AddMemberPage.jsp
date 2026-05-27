<%-- 
    Document   : AddMemberPage
    Created on : 23 May 2026, 10:44:56 pm
    Author     : maree
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Add Member Result</title>

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
padding:20px;
text-align:center;
font-size:30px;
font-weight:bold;
}

.container{
width:450px;
margin:80px auto;
background:white;
padding:35px;
border-radius:15px;
box-shadow:0px 5px 15px rgba(0,0,0,.2);
text-align:center;
}

h2{
color:#1e3a8a;
margin-bottom:20px;
}

.message{
font-size:18px;
margin:20px 0;
font-weight:bold;
color:green;
}

.btn{
display:inline-block;
padding:12px 25px;
background:#1e3a8a;
color:white;
text-decoration:none;
border-radius:8px;
font-weight:bold;
}

.btn:hover{
background:#2563eb;
}

.error{
color:red;
}

</style>

</head>

<body>

<div class="header">
Library Management System
</div>

<div class="container">

<h2>Member Registration</h2>

<%

String membername=request.getParameter("membername");
String email=request.getParameter("email");
String phone=request.getParameter("phone");

try{

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con=
DriverManager.getConnection(
"jdbc:mysql://localhost:3306/java",
"root",
"12345");

PreparedStatement stmt=
con.prepareStatement(
"INSERT INTO member_list(member_name,email,phone) VALUES(?,?,?)");

stmt.setString(1,membername);
stmt.setString(2,email);
stmt.setString(3,phone);

int result=stmt.executeUpdate();

if(result>0){
%>

<div class="message">
Member Added Successfully
</div>

<%
}
else{
%>

<div class="message error">
Failed to Add Member
</div>

<%
}

stmt.close();
con.close();

}
catch(Exception e){
%>

<div class="message error">

Error :
<%=e.getMessage()%>

</div>

<%
}
%>

<br><br>

<a href="../MemberPage.html" class="btn">
Back
</a>

</div>

</body>
</html>
