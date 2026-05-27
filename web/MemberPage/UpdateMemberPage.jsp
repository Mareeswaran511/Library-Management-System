<%@page contentType="text/html"
pageEncoding="UTF-8"
import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Update Member</title>

<style>

body{
font-family:Arial,sans-serif;
background:linear-gradient(to right,#dbeafe,#f3f4f6);
margin:0;
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

.msg{
font-size:18px;
font-weight:bold;
margin:20px;
color:green;
}

.error{
color:red;
}

.btn{
display:inline-block;
padding:12px 25px;
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

<%

try{

String memberId=
request.getParameter("memberId");

String memberName=
request.getParameter("memberName");

String email=
request.getParameter("email");

String phone=
request.getParameter("phone");

if(memberId==null || memberId.trim().equals(""))
{
%>

<div class="msg error">
Member ID is required
</div>

<%
}
else{

int id=Integer.parseInt(memberId);

Class.forName(
"com.mysql.cj.jdbc.Driver");

Connection con=
DriverManager.getConnection(
"jdbc:mysql://localhost:3306/java",
"root",
"12345");

PreparedStatement stmt=
con.prepareStatement(
"UPDATE member_list SET member_name=?,email=?,phone=? WHERE member_id=?");

stmt.setString(1,memberName);
stmt.setString(2,email);
stmt.setString(3,phone);
stmt.setInt(4,id);

int result=
stmt.executeUpdate();

if(result>0){
%>

<div class="msg">
Member Updated Successfully
</div>

<%
}
else{
%>

<div class="msg error">
Member ID Not Found
</div>

<%
}

stmt.close();
con.close();

}

}
catch(Exception e){
%>

<div class="msg error">

Error:
<%=e.getMessage()%>

</div>

<%
}
%>

<br><br>

<a href="../MemberPage.html"
class="btn">

Back

</a>

</div>

</body>
</html>