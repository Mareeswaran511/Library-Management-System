<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Book</title>

<style>

body{
    font-family:Arial,sans-serif;
    background:linear-gradient(to right,#dbeafe,#f3f4f6);
}

.container{
    width:70%;
    margin:50px auto;
    background:white;
    padding:30px;
    border-radius:15px;
    box-shadow:0px 5px 15px rgba(0,0,0,0.2);
}

h2{
    text-align:center;
    color:#1e3a8a;
}

table{
    width:100%;
    border-collapse:collapse;
}

th{
    background:#1e3a8a;
    color:white;
    padding:12px;
}

td{
    padding:12px;
    text-align:center;
    border-bottom:1px solid #ddd;
}

.btn{
    display:inline-block;
    padding:10px 20px;
    background:#1e3a8a;
    color:white;
    text-decoration:none;
    border-radius:8px;
    margin-top:20px;
}

</style>

</head>

<body>

<div class="container">

<h2>Search Result</h2>

<table>

<tr>
<th>ID</th>
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

String title=request.getParameter("title");

PreparedStatement stmt=
con.prepareStatement(
"SELECT * FROM books WHERE title LIKE ?");

stmt.setString(1,"%"+title+"%");

ResultSet rs=stmt.executeQuery();

boolean found=false;

while(rs.next())
{
found=true;
%>

<tr>

<td><%=rs.getInt("book_id")%></td>
<td><%=rs.getString("title")%></td>
<td><%=rs.getString("author")%></td>
<td><%=rs.getString("genre")%></td>
<td><%=rs.getString("status")%></td>

</tr>

<%
}

if(!found){
%>

<tr>
<td colspan="5">
No Book Found
</td>
</tr>

<%
}

rs.close();
stmt.close();
con.close();

}
catch(Exception e){
out.println(e.getMessage());
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