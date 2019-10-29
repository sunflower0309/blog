<%@ page language="java" import="java.util.*,java.sql.*" 
         contentType="text/html; charset=utf-8"
%>

<% request.setCharacterEncoding("utf-8");
String msg = "";
String connectString = "jdbc:mysql://172.18.187.234:53306/15352347_blog"
		+ "?autoReconnect=true&useUnicode=true"
		+ "&characterEncoding=UTF-8"; 
String user="user"; String pwd="123";
String username="";
String author="";
boolean equal=false;
author=request.getParameter("pauthor");	
username = (String)session.getAttribute("username");

StringBuilder table=new StringBuilder("");

	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(connectString,user, pwd);
	Statement stmt = con.createStatement();
	String fmt="select * from favorite where liker='%s'";
	String str=String.format(fmt,username);
	ResultSet rs=null;
	rs=stmt.executeQuery(str);
	table.append("<table><tr><th>文章标题</th><th>作者</th></tr>");
	while(rs.next()) {
		
	    table.append(String.format(
	   		 "<tr><td><a href='article.jsp?pid="+rs.getInt("id")+"'>%s</a></td><td><a href='mainpage.jsp?pauthor="+rs.getString("author")+"'>%s</a></td><td><a href='check4.jsp?pid="+rs.getInt("id")+"'>取消收藏</a></td></tr>",
	   		 rs.getString("article_title"),rs.getString("author")
	   		 
	   		 )
	   		 );
	}
	table.append("</table>");
	


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style>
	body {	color:#FFF; font-family:宋体; background: linear-gradient(to bottom,#808080 0% ,#202020 50%,#808080 100%);}
	#main {	width:800px;
			min-height:700px;
			border:2px solid #ccc;
			border-radius:20px;
			padding-top:6px;
			margin:50px auto;}
	#header {	position:fixed;
				z-index:1;
				width:100%;
				top:0;
				left:0;
				height:30px;
				text-align:right;
				padding-top:6px;
				background-color:#333;}
	input {	color:#FFF; 
			background:transparent;
			border:0px solid #FFF;
			}
	input:hover {	cursor:pointer;}
	table { color:#FFF;
			text-align:center;}
	td:first-child {	width:300px;}
	td:nth-child(2) {	width:300px;}
	td:nth-child(3) {	width:100px;}
	th:first-child {	width:300px;}
	th:nth-child(2) {	width:300px;}
	th:nth-child(3) {	width:100px;}
	a:link,a:visited {	color:white;}
	a:hover {	color:yellow;}
</style>
</head>
<body>
<div id="header">
<span id="username">
<%
if(username==null || username.equals("")){
	out.print("请先登录！");
}
else{
	out.print("您好，"+username+"!");
}
%>
<input type="button" value="我的博客" onClick="window.location.href='mainpage.jsp?pauthor=<%=username%>'">
</span>
</div>
<div id="main">
<%=table %>
</div>
</body>
</html>


