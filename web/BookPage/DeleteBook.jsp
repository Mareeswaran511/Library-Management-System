<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Book</title>

<style>

body{
    font-family:Arial,sans-serif;
    background:linear-gradient(to right,#dbeafe,#f3f4f6);
}

.container{
    width:500px;
    margin:100px auto;
    background:white;
    padding:30px;
    border-radius:15px;
    text-align:center;
    box-shadow:0px 5px 15px rgba(0,0,0,0.2);
}

.success{
    color:green;
    font-size:22px;
}

.error{
    color:red;
    font-size:22px;
}

.btn{
    display:inline-block;
    margin-top:20px;
    background:#1e3a8a;
    color:white;
    text-decoration:none;
    padding:10px 20px;
    border-radius:8px;
}

</style>

</head>

<body>

<div class="container">

<%
try{

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/java",
"root",
"12345");

int id=Integer.parseInt(
request.getParameter("bookid"));

PreparedStatement stmt=
con.prepareStatement(
"DELETE FROM books WHERE book_id=?");

stmt.setInt(1,id);

int rows=stmt.executeUpdate();

if(rows>0){
%>

<div class="success">
Book Deleted Successfully
</div>

<%
}
else{
%>

<div class="error">
Book ID Not Found
</div>

<%
}

stmt.close();
con.close();

}
catch(Exception e){
%>

<div class="error">
<%=e.getMessage()%>
</div>

<%
}
%>

<br>
<center>
<a href="../BookPage.html" class="btn">Back</a>
<a href="../HomePage.html" class="btn">Back To Home</a>
</center>
</div>

</body>
</html>