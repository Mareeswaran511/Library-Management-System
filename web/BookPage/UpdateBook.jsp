<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Book</title>
<style>
        .btn{
    text-decoration:none;
    background:#1e3a8a;
    color:white;
    padding:10px 20px;
    border-radius:8px;
}
</style>
</head>

<body>

<%
try
{
    Class.forName("com.mysql.cj.jdbc.Driver");

    Connection con=DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/java",
    "root",
    "12345");

    int id=Integer.parseInt(
    request.getParameter("bookid"));

    String title=request.getParameter("title");
    String author=request.getParameter("author");
    String genre=request.getParameter("genre");
    String status=request.getParameter("status");

    PreparedStatement stmt=
    con.prepareStatement(
    "UPDATE books SET title=?,author=?,genre=?,status=? WHERE book_id=?"
    );

    stmt.setString(1,title);
    stmt.setString(2,author);
    stmt.setString(3,genre);
    stmt.setString(4,status);
    stmt.setInt(5,id);

    int rows=stmt.executeUpdate();

    if(rows>0)
    {
        out.println("<h2 style='color:green;text-align:center;'>Book Updated Successfully</h2>");
    }
    else
    {
        out.println("<h2 style='color:red;text-align:center;'>Book ID Not Found</h2>");
    }


    stmt.close();
    con.close();

}
catch(Exception e)
{
    out.println(e.getMessage());
}
%>

<br><br>

<center>
<a href="../BookPage.html" class="btn">Back</a>
<a href="../HomePage.html" class="btn">Back To Home</a>
</center>


</body>
</html>