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
String id="";
id = request.getParameter("pid");
username = (String)session.getAttribute("username");
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(connectString,user, pwd);
Statement stmt = con.createStatement();
		try{
			stmt.executeUpdate(String.format("delete from article where art_id = '%s'",id));
			stmt.executeUpdate(String.format("delete from comment where art_id = '%s'",id));
			stmt.close();
			con.close();
			response.sendRedirect("mainpage.jsp?pauthor="+username);
		}
		catch (Exception e){
			out.print("É¾³ıÊ§°Ü");
		}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html>