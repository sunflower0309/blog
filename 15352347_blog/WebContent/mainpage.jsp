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
boolean login=false;
author=request.getParameter("pauthor");	
username = (String)session.getAttribute("username");
if(username.equals(author)) equal=true;
else equal=false;

StringBuilder table=new StringBuilder("");

	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(connectString,user, pwd);
	Statement stmt = con.createStatement();
	String fmt="select article_title,create_time,art_id from article where article_author='%s'";
	String str=String.format(fmt,author);
	ResultSet rs=null;
	rs=stmt.executeQuery(str);
	table.append("<table><tr><th>标题</th><th>时间</th></tr>");
	while(rs.next()) {
		String time=(String)rs.getString("create_time");
	    table.append(String.format(
	   		 "<tr><td><a href='article.jsp?pid="+rs.getInt("art_id")+"&pauthor="+author+"'>%s</a></td><td>%s</td></tr>",
	   		 rs.getString("article_title"),time
	   		 
	   		 )
	   		 );
	}
	table.append("</table>");

if(request.getMethod().equalsIgnoreCase("post")){
	session.setAttribute("username","");
    pageContext.forward("blogmainpage.jsp");
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
</script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>我的博客</title>
<style>
	body {	font-family:宋体;
			width:1200px;
			margin:0 auto;
			background: linear-gradient(to bottom,#808080 0% ,#202020 50%,#808080 100%);}
	#left {		width:200px;
				float:right;
				margin-top:20px;
				margin-right:20px;}
	
	#right {	width:800px;
			min-height:700px;
			float:right;
			border:2px solid #ccc;
			border-radius:20px;
			margin-top:50px;
			margin-bottom:50px;
			margin-right:150px;}
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
	table tr { height:50px;}
	td:first-child {	width:500px;}
	td:nth-child(2) {	width:200px;}
	th:first-child {	width:500px;}
	th:nth-child(2) {	width:200px;}
	a:link,a:visited {	color:white;}
	a:hover {	color:yellow;}
	#username {	color:#FFF;}
	#name {	color:#FFF;
			width:200px;
			text-align:center;
			margin-top:60px;
			float:right;
			margin-right:20px;}
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
	login=true;
	out.print("您好，"+username+"!");
}
%>
</span>
<input type="button" value="博客园" onClick="window.location.href='blogmainpage.jsp'">
<%if(login==true){ %>
<input type="submit" value="注销" onClick="window.location.href='check.jsp'">
<%} %>

</div>
		<div id="right">
			<%=table%>
		</div>
		<p id="name"><%
			if(author==null || author.equals("")){}else{
			out.print(author+"的博客");
			}
		%></p>
		<%if(equal==true){ %>
		
			<p><input id="left" type="button" value="收藏夹" id="follow" onClick="window.location.href='favo_list.jsp?pauthor=<%=author%>'"></p>
			<p><input id="left" type="button" value="关注列表" id="follow" onClick="window.location.href='follow_list.jsp?pauthor=<%=author%>'"></p>
			<p><input id="left" type="button" value="添加" id="add" onClick="window.location.href='add.jsp'"></p>

		<%} %>
		<%if(equal==false){ %>
			<p><input id="left" type="button" value="关注" id="follow" onClick="window.location.href='check1.jsp?pauthor=<%=author%>'"></p>
		<%} %>
		
</body>
</html>