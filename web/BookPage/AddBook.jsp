<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Book</title>
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
try{
    Class.forName("com.mysql.cj.jdbc.Driver");

    Connection con=DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/java",
    "root",
    "12345");

    String title=request.getParameter("text1");
    String author=request.getParameter("text2");
    String genre=request.getParameter("text3");
    String status=request.getParameter("text4");

    // Check existing book
    PreparedStatement checkStmt=
    con.prepareStatement(
    "SELECT * FROM books WHERE title=? AND author=? AND genre=?"
    );

    checkStmt.setString(1,title);
    checkStmt.setString(2,author);
    checkStmt.setString(3,genre);

    ResultSet rs=checkStmt.executeQuery();

    if(rs.next())
    {
        out.println("<h2 style='color:red;text-align:center;'>Book already exists in library</h2>");
    }
    else
    {
        PreparedStatement stmt=con.prepareStatement(
        "INSERT INTO books(title,author,genre,status) VALUES(?,?,?,?)"
        );

        stmt.setString(1,title);
        stmt.setString(2,author);
        stmt.setString(3,genre);
        stmt.setString(4,status);

        stmt.executeUpdate();

        out.println("<h2 style='color:green;text-align:center;'>Book Added Successfully</h2>");

        stmt.close();
    }

    rs.close();
    checkStmt.close();
    con.close();

}
catch(Exception e){
    out.println(e.getMessage());
}
%>

<br><br>

<center>
<a href="../BookPage.html" class="btn">Back</a>
<a href="../HomePage.html" class="btn">Back To Home</a>
</a>
</center>

</body>
</html>