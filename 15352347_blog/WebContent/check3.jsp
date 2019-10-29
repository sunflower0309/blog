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
String author="";
boolean equal=false;
author=request.getParameter("pauthor");	
username = (String)session.getAttribute("username");
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(connectString,user, pwd);
Statement stmt = con.createStatement();
try
{
	String fmt1="delete from follow where followed_author='%s' and follower='%s'";
	String sql1=String.format(fmt1,author,username);
	ResultSet rs1=null;
	stmt.execute(sql1);
	response.sendRedirect("follow_list.jsp");
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