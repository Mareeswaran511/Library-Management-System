<%@page import="java.sql.*"%>

<%

String bookTitle=request.getParameter("book_title");
String memberId=request.getParameter("member_id");
String requestDate=request.getParameter("request_date");

try{

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con=
DriverManager.getConnection(
"jdbc:mysql://localhost:3306/java",
"root",
"12345");

PreparedStatement ps=
con.prepareStatement(
"insert into book_request(book_title,member_id,request_date) values(?,?,?)",
Statement.RETURN_GENERATED_KEYS);

ps.setString(1,bookTitle);
ps.setString(2,memberId);
ps.setString(3,requestDate);

ps.executeUpdate();

ResultSet rs=
ps.getGeneratedKeys();

int requestId=0;

if(rs.next())
{
requestId=rs.getInt(1);
}

%>

<script>

alert("Request submitted successfully!\nRequest ID: <%=requestId%>");

window.location="AddBookRequest.html";

</script>

<%

con.close();

}catch(Exception e){

out.println(e);

}

%>