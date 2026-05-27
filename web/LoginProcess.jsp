<%@page contentType="text/html"
pageEncoding="UTF-8"
import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<title>Login Process</title>
</head>

<body>

<%

String username=request.getParameter("username");
String password=request.getParameter("password");
String userType=request.getParameter("role"); // radio button value

try{

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con=
DriverManager.getConnection(
"jdbc:mysql://localhost:3306/java",
"root",
"12345");

PreparedStatement ps=
con.prepareStatement(
"select * from users where username=? and password=?");

ps.setString(1,username);
ps.setString(2,password);

ResultSet rs=ps.executeQuery();

if(rs.next())
{
    String dbRole=rs.getString("role");

    // check selected radio with DB role
    if(!dbRole.equalsIgnoreCase(userType))
    {
%>

<script>
alert("Invalid User Type Selected");
window.location="index.html";
</script>

<%
    }
    else
    {
        if(dbRole.equalsIgnoreCase("Admin"))
        {
            response.sendRedirect("HomePage.html");
        }
        else if(dbRole.equalsIgnoreCase("User"))
        {
            response.sendRedirect("HomePage2.html");
        }
    }
}
else
{
%>

<script>
alert("Invalid Username or Password");
window.location="index.html";
</script>

<%
}

con.close();

}
catch(Exception e)
{
    out.println("Error : "+e);
}

%>

</body>
</html>