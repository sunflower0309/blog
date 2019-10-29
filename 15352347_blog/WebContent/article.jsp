<%@ page language="java" import="java.util.*,java.sql.*" 
         contentType="text/html; charset=utf-8"
%>

<% request.setCharacterEncoding("utf-8");
String msg = "";
String connectString = "jdbc:mysql://172.18.187.234:53306/15352347_blog"
		+ "?autoReconnect=true&useUnicode=true"
		+ "&characterEncoding=gb2312"; 
String user="user"; String pwd="123";
String username="";
String author="";
String article="";
String time="";
String comment="";
String ii=request.getParameter("pid");
int id=0;
boolean equal=false;
boolean login=false;
id=Integer.valueOf(ii);
username = (String)session.getAttribute("username");
if(!username.equals("")){
	login=true;
}
if(username.equals(author)) equal=true;
else equal=false;
StringBuilder table=new StringBuilder("");
StringBuilder commenttable=new StringBuilder("");

	//out.print(username);
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(connectString,user, pwd);
	Statement stmt = con.createStatement();
	String fmtt="select * from article where art_id=%d";
	String sqll = String.format(fmtt,id);
	ResultSet rss=null;
	rss=stmt.executeQuery(sqll);
	String title="";
	
	while(rss.next()){
		title=rss.getString("article_title");
		author=rss.getString("article_author");
		article=rss.getString("article");
		time = rss.getString("create_time");
	}
	rss.close();
	article = article.replace("[img]","<img src='");
	article = article.replace("[/img]","'>");
	try{
	  String sql=String.format("select * from comment where art_id = '%s'",ii);
	  ResultSet rs=stmt.executeQuery(sql);
	  while(rs.next()) {
				commenttable.append(String.format("<p>%s</p><p>%s</p><p>%s</p>",
						rs.getString("author"),rs.getString("comment"),rs.getString("time"))
	     		);
	  }
	  rs.close();
	  stmt.close();
	  con.close();
	}
	catch (Exception e){
	  msg = e.getMessage();
	}

if(request.getMethod().equalsIgnoreCase("post")){
	session.setAttribute("username","");
    pageContext.forward("blogmainpage.jsp");
}
%>
<%	if(title==null || title.equals("")) {
		out.print("该文章已不存在！");
	}else{
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
	function Hint() {
		alert("该用户没有操作权限！");
	}

</script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>
<%=title%>
</title>
<style>
	body {	font-family:宋体;
			color:#FFF;
			min-width:900px; background: linear-gradient(to bottom,#808080 0% ,#202020 50%,#808080 100%);}
	#main {	width:800px;
			min-height:700px;
			border:2px solid #ccc;
			border-radius:20px;
			color:#FFF;
			font-family:宋体;
			margin:50px auto;}
	h2,h4 	{	text-align:center;}
	h2	{	font-size:30px;;}
	#header {	position:fixed;
				z-index:1;
				width:100%;
				top:0;
				left:0;
				height:30px;
				text-align:right;
				padding-top:6px;
				background-color:#333;}
	#article {	margin:20px 40px;}
	#time {	text-align:right;
			margin-right:20px;}
	input {	color:#FFF; 
			background:transparent;
			border:0px solid #FFF;}
	input:hover {	cursor:pointer;}
	#opera {	text-align:right;
				margin:10px auto;
				width:800px;
				position:relative;
				top:-30px;}
	textarea {	color:#FFF; 
				background:transparent;
				border:1px solid #FFF;
				font-size:15px;
				width:800px;}
	#form {		margin:20px auto;
				width:800px;
				text-align:right;
				}
	#comment {	margin:20px auto;
				width:800px;
				color:white;}
	#comment>p:nth-child(3n+4) {	text-align:right;
									margin-bottom:10px;
									padding-bottom:5px;
									border-bottom:solid 1px #FFF;}
	#comment>p:nth-child(1) {	border-bottom:solid 1px #FFF;}
	#line {	box-sizing:border;
			width:900px;
			margin:0 auto;
			border-bottom:solid 1px #FFF;}
</style>
</head>
<body>
<br><br>
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
</span>
	<input type="button" value="博客园" onClick="window.location.href='blogmainpage.jsp'">
	<%if(login==true){ %>
<input type="button" value="我的博客" onClick="window.location.href='mainpage.jsp?pauthor=<%=username%>'">
<input type="button" value="注销" onClick="window.location.href='check.jsp'">
<%} %>
</div>
<div id="main">
<h2><%=title %></h2>
<h4><%=author %></h4>
<p id="article"><%=article %></p>
<p id="time"><%=time %></p>
</div>
<div id="opera">
<%if(equal==false){ %>
<input type="button" value="收藏" id="follow" onClick="window.location.href='check2.jsp?pid=<%=ii%>'">
<%} %>
<input type="button" value="编辑" onClick="<%
	if(username.equals(author)) {
		out.print("window.location.href='edit.jsp?pid="+ii+"'");
	}
	else {
		out.print("Hint()");
	}
%>">
<input type="button" value="删除" onClick="<%
	if(username.equals(author)) {
		//删除数据库博客的操作
		out.print("window.location.href='delete.jsp?pid="+ii+"'");
	}
	else {
		out.print("Hint()");
	}
%>">
</div>
<div id="line"></div>
<div id="form">
<form action="comment.jsp?pid=<%=ii%>" method="post">
	<textarea rows="15" cols="50" name="comment">撰写评论...</textarea><br><br>
	<input type="submit" value="发表评论" name="save"><br><br>
</form>
</div>
<div id="comment">
<p>评论</p>
<%=commenttable%>
</div>
</body>
</html>
	<%}%>


