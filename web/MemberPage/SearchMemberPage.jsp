<%-- 
    Document   : SearchMemberPage
    Created on : 24 May 2026
    Author     : maree
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Member Result</title>

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
    box-shadow:0px 5px 15px rgba(0,0,0,.2);
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
    margin-top:25px;
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

.no-records {
    font-weight: bold;
    color: #ef4444;
    padding: 20px;
}
</style>

</head>

<body>

<div class="header">
    Library Management System
</div>

<div class="container">

    <h2>Search Results</h2>

    <table>
        <tr>
            <th>Member ID</th>
            <th>Member Name</th>
            <th>Email</th>
            <th>Phone</th>
        </tr>

        <%
        // Captures the matching parameter from the HTML input field link
        String searchId = request.getParameter("searchId");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/java",
                "root",
                "12345"
            );

            // Filter configuration using a secure statement placeholder
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM member_list WHERE member_id = ?");
            stmt.setString(1, searchId);

            ResultSet rs = stmt.executeQuery();
            boolean recordFound = false;

            while(rs.next()){
                recordFound = true;
        %>
        <tr>
            <td><%=rs.getString("member_id")%></td>
            <td><%=rs.getString("member_name")%></td>
            <td><%=rs.getString("email")%></td>
            <td><%=rs.getString("phone")%></td>
        </tr>
        <%
            }

            if(!recordFound) {
        %>
        <tr>
            <td colspan="4" class="no-records">
                No member found with ID: <%= (searchId != null ? searchId : "") %>
            </td>
        </tr>
        <%
            }

            rs.close();
            stmt.close();
            con.close();

        } catch(Exception e) {
        %>
        <tr>
            <td colspan="4" style="color: red; font-weight: bold;">
                Error : <%=e.getMessage()%>
            </td>
        </tr>
        <%
        }
        %>
    </table>

    <center>
        <a href="../MemberPage.html" class="btn">Back</a>
    </center>

</div>

</body>
</html>