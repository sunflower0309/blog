<%@ page language="java" import="java.util.Date,java.sql.*,java.text.SimpleDateFormat"
         contentType="text/html; charset=utf-8"
%>
<%	request.setCharacterEncoding("utf-8");
String msg="";
String connectString = "jdbc:mysql://172.18.187.234:53306/15352347_blog"
		+ "?autoReconnect=true&useUnicode=true"
		+ "&characterEncoding=UTF-8"; 
String user="user"; String pwd="123";
String username="";
String comment="";
String id = "";
String time = "";
comment = request.getParameter("comment");
id =  request.getParameter("pid");
username = (String)session.getAttribute("username");
if(username==null || username.equals("")) {
	username = "匿名";
}
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(connectString,user, pwd);
Statement stmt = con.createStatement();
try
{
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	time = df.format(new Date());
	String fmt1="insert into comment(comment,author,art_id,time) values('%s','%s','%s','%s')";
	String sql1=String.format(fmt1,comment,username,id,time);
	stmt.executeUpdate(sql1);
	stmt.close();
	con.close();
	response.sendRedirect("article.jsp?pid="+id);
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