<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Feedback</title>

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
String feedback_id = request.getParameter("feedback_id").trim();
String member_id = request.getParameter("member_id").trim();
String message = request.getParameter("message");

Connection con = null;
PreparedStatement checkFeedback = null;
PreparedStatement checkMember = null;
PreparedStatement ps = null;
ResultSet rs1 = null;
ResultSet rs2 = null;

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/java",
"root",
"12345"
);

/// STEP 1: CHECK FEEDBACK EXISTS
checkFeedback = con.prepareStatement(
"SELECT * FROM feedback WHERE feedback_id=?"
);
checkFeedback.setString(1, feedback_id);

rs1 = checkFeedback.executeQuery();

if(!rs1.next()){
%>

<h2 class="error">Feedback ID does not exist</h2>

<%
}else{

/// STEP 2: CHECK MEMBER EXISTS
checkMember = con.prepareStatement(
"SELECT * FROM member_list WHERE member_id=?"
);
checkMember.setString(1, member_id);

rs2 = checkMember.executeQuery();

if(!rs2.next()){
%>

<h2 class="error">Member ID does not exist</h2>

<%
}else{

/// STEP 3: UPDATE FEEDBACK
ps = con.prepareStatement(
"UPDATE feedback SET member_id=?, message=? WHERE feedback_id=?"
);

ps.setString(1, member_id);
ps.setString(2, message);
ps.setString(3, feedback_id);

int i = ps.executeUpdate();

if(i > 0){
%>

<h2 class="success">Feedback Updated Successfully</h2>

<%
}else{
%>

<h2 class="error">Failed to Update Feedback</h2>

<%
}

}

}

}catch(Exception e){
%>

<h2 class="error">Error: <%=e.getMessage()%></h2>

<%
}finally{

try{ if(rs1 != null) rs1.close(); }catch(Exception e){}
try{ if(rs2 != null) rs2.close(); }catch(Exception e){}
try{ if(checkFeedback != null) checkFeedback.close(); }catch(Exception e){}
try{ if(checkMember != null) checkMember.close(); }catch(Exception e){}
try{ if(ps != null) ps.close(); }catch(Exception e){}
try{ if(con != null) con.close(); }catch(Exception e){}

}
%>

<a href="UpdateFeedbackPage.html" class="btn">Update More</a>
<a href="../FeedbackPage.html" class="btn">Back</a>

</div>

</body>
</html>