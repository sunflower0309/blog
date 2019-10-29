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
	String fmt1="select * from follow where followed_author='%s' and follower='%s'";
	String sql1=String.format(fmt1,author,username);
	ResultSet rs1=null;
	rs1=stmt.executeQuery(sql1);
	if(rs1.next()){
		
		response.sendRedirect("mainpage.jsp?pauthor="+author+"");
		stmt.close(); con.close();
	}
	else{
		String fmt="insert into follow(follower,followed_author) values('%s', '%s')";
		String sql = String.format(fmt,username,author);
		int cnt = stmt.executeUpdate(sql);
		if(cnt>0)msg = "成功!";
		stmt.close(); con.close();
		response.sendRedirect("mainpage.jsp?pauthor="+author+"");
	}
	
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