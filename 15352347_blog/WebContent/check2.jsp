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
	String fmt1="select liker,id from favorite where liker='%s' and id=%d";
	String sql1=String.format(fmt1,username,id);
	ResultSet rs1=null;
	rs1=stmt.executeQuery(sql1);
	if(rs1.next()){
		
		response.sendRedirect("article.jsp?pid="+ii+"");
		stmt.close(); con.close();
	}
	else{
		String fmt="replace into favorite(liker,article_title,id,author) values('%s', '%s',%d,'%s')";
		String sql = String.format(fmt,username,title,id,author);
		int cnt = stmt.executeUpdate(sql);
		if(cnt>0)msg = "成功!";
		stmt.close(); con.close();
		response.sendRedirect("article.jsp?pid="+ii+"");
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