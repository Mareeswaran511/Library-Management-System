<%@page contentType="text/html"
pageEncoding="UTF-8"
import="java.sql.*"%>

<%

String feedback_id=
request.getParameter("feedback_id");

Connection con=null;
PreparedStatement check=null;
PreparedStatement ps=null;
ResultSet rs=null;

try{

if(feedback_id==null ||
feedback_id.trim().equals(""))
{
%>

<script>

alert("Please enter Feedback ID");

history.back();

</script>

<%
return;
}

Class.forName(
"com.mysql.cj.jdbc.Driver");

con=
DriverManager.getConnection(
"jdbc:mysql://localhost:3306/java",
"root",
"12345"
);

check=
con.prepareStatement(
"SELECT * FROM feedback WHERE feedback_id=?"
);

check.setInt(
1,
Integer.parseInt(feedback_id)
);

rs=
check.executeQuery();

if(rs.next())
{

ps=
con.prepareStatement(
"DELETE FROM feedback WHERE feedback_id=?"
);

ps.setInt(
1,
Integer.parseInt(feedback_id)
);

int i=
ps.executeUpdate();

if(i>0)
{
%>

<script>

alert(
"Feedback deleted successfully"
);

window.location=
"DeleteFeedbackPage.html";

</script>

<%
}
else
{
%>

<script>

alert(
"Deletion failed"
);

history.back();

</script>

<%
}

}
else
{
%>

<script>

alert(
"Feedback ID not found"
);

history.back();

</script>

<%
}

}
catch(Exception e)
{
out.println(e);
}
finally{

try{
if(rs!=null)
rs.close();
}catch(Exception e){}

try{
if(check!=null)
check.close();
}catch(Exception e){}

try{
if(ps!=null)
ps.close();
}catch(Exception e){}

try{
if(con!=null)
con.close();
}catch(Exception e){}

}

%>