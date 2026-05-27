<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>

<%

String member_id=request.getParameter("member_id").trim();
String message=request.getParameter("message");

Connection con=null;
PreparedStatement check=null;
PreparedStatement ps=null;
ResultSet rs=null;

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/java",
"root",
"12345"
);

check=con.prepareStatement(
"SELECT * FROM member_list WHERE member_id=?"
);

check.setString(1,member_id);

rs=check.executeQuery();

if(!rs.next()){
%>

<script>

alert("Member ID does not exist");

window.location=
"AddFeedbackPage.html";

</script>

<%

}else{

ps=con.prepareStatement(
"INSERT INTO feedback(member_id,message) VALUES(?,?)",
Statement.RETURN_GENERATED_KEYS
);

ps.setString(1,member_id);
ps.setString(2,message);

int i=ps.executeUpdate();

if(i>0)
{

ResultSet generatedKeys=
ps.getGeneratedKeys();

int feedbackId=0;

if(generatedKeys.next())
{
feedbackId=
generatedKeys.getInt(1);
}

%>

<script>

alert(
"Feedback submitted successfully!\nFeedback ID : <%=feedbackId%>"
);

window.location=
"AddFeedbackPage.html";

</script>

<%

}
else
{
%>

<script>

alert("Failed to add feedback");

window.location=
"AddFeedbackPage.html";

</script>

<%
}

}

}catch(Exception e){

out.println(e);

}
finally{

try{if(rs!=null) rs.close();}catch(Exception e){}
try{if(check!=null) check.close();}catch(Exception e){}
try{if(ps!=null) ps.close();}catch(Exception e){}
try{if(con!=null) con.close();}catch(Exception e){}

}

%>