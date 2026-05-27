<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<title>Registration Process</title>
</head>

<body>

<%

String username=request.getParameter("username");
String email=request.getParameter("email");
String password=request.getParameter("password");
String role=request.getParameter("role");

try{

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con=
DriverManager.getConnection(
"jdbc:mysql://localhost:3306/java",
"root",
"12345");

PreparedStatement ps=
con.prepareStatement(
"insert into users(username,email,password,role) values(?,?,?,?)");

ps.setString(1,username);
ps.setString(2,email);
ps.setString(3,password);
ps.setString(4,role);

int i=ps.executeUpdate();

if(i>0)
{
%>

<script>
alert("Registration Successful! Please login.");
window.location="index.html";
</script>

<%
}
else
{
%>

<script>
alert("Registration Failed");
window.location="Register.html";
</script>

<%
}

con.close();

}
catch(Exception e)
{
%>

<script>
alert("Error occurred: <%=e.getMessage()%>");
window.location="Register.html";
</script>

<%
}

%>

</body>
</html>