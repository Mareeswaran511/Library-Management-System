<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert Feedback</title>

<style>
body{
    font-family: Arial;
    background: linear-gradient(to right,#dbeafe,#f3f4f6);
    margin:0;
}

.container{
    width:40%;
    margin:120px auto;
    background:white;
    padding:30px;
    border-radius:15px;
    box-shadow:0px 5px 15px rgba(0,0,0,0.2);
    text-align:center;
}

h2{
    color:#1e3a8a;
}

.success{
    color:green;
    font-weight:bold;
}

.error{
    color:red;
    font-weight:bold;
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
</style>
</head>

<body>

<div class="container">

<%
String member_id = request.getParameter("member_id").trim();
String message = request.getParameter("message");

Connection con = null;
PreparedStatement check = null;
PreparedStatement ps = null;
ResultSet rs = null;

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/java",
"root",
"12345"
);

/// STEP 1: CHECK MEMBER EXISTS
check = con.prepareStatement(
"SELECT * FROM member_list WHERE member_id=?"
);
check.setString(1, member_id);

rs = check.executeQuery();

if(!rs.next()){
%>

<h2 class="error">Member ID does not exist. Please enter a valid Member ID.</h2>

<%
}else{

/// STEP 2: INSERT FEEDBACK
ps = con.prepareStatement(
"INSERT INTO feedback(member_id, message) VALUES (?,?)"
);

ps.setString(1, member_id);
ps.setString(2, message);

int i = ps.executeUpdate();

if(i > 0){
%>

<h2 class="success">Feedback Added Successfully</h2>

<%
}else{
%>

<h2 class="error">Failed to Add Feedback</h2>

<%
}

}

}catch(Exception e){
%>

<h2 class="error">Error: <%=e.getMessage()%></h2>

<%
}finally{

try{ if(rs != null) rs.close(); }catch(Exception e){}
try{ if(check != null) check.close(); }catch(Exception e){}
try{ if(ps != null) ps.close(); }catch(Exception e){}
try{ if(con != null) con.close(); }catch(Exception e){}

}
%>

<a href="AddFeedbackPage.html" class="btn">Add More</a>
<a href="../FeedbackPage.html" class="btn">Back</a>

</div>

</body>
</html>