<%@ page language="java" import="java.util.*,java.sql.*" 
         contentType="text/html; charset=utf-8"
%>
<%
String msg="";
String connectString = "jdbc:mysql://172.18.187.234:53306/15352347_blog"
		+ "?autoReconnect=true&useUnicode=true"
		+ "&characterEncoding=UTF-8"; 
String user="user"; String pwd="123";
String username="";
String ii=request.getParameter("pid");
int id=0;
boolean equal=false;
id=Integer.valueOf(ii);
username = (String)session.getAttribute("username");
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(connectString,user, pwd);
Statement stmt = con.createStatement();
String fmtt="select * from article where art_id=%d";
String sqll = String.format(fmtt,id);
ResultSet rs=null;
rs=stmt.executeQuery(sqll);
String title="";
String author="";
while(rs.next()){
	title=rs.getString("article_title");
	author=rs.getString("article_author");
}
try
{
	String fmt1="delete from favorite where liker='%s' and id=%d";
	String sql1=String.format(fmt1,username,id);
	ResultSet rs1=null;
	stmt.execute(sql1);
	response.sendRedirect("favo_list.jsp");
	stmt.close(); con.close();
	
}
catch(Exception e){
msg = e.getMessage();
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%=msg %>
</body>
</html>