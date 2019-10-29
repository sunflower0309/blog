<%@ page language="java" import="java.util.*,java.sql.*" 
         contentType="text/html; charset=utf-8"
%>
<%
	request.setCharacterEncoding("utf-8");
	String msg ="";
	int pgno=0;
	int pgcnt=10;
	boolean login=false;
	String param=request.getParameter("pgno");
	if(param!=null&&!param.isEmpty()){
		pgno=Integer.parseInt(param);
	}
	param=request.getParameter("pgcnt");
	if(param!=null&&!param.isEmpty()){
		pgcnt=Integer.parseInt(param);
	}
	int pgprev=(pgno>0)?pgno-1:0;
	int pgnext=pgno+1;
	int size=0;
	String connectString = "jdbc:mysql://172.18.187.234:53306/15352347_blog"
					+ "?autoReconnect=true&useUnicode=true"
					+ "&characterEncoding=UTF-8"; 
        StringBuilder table=new StringBuilder("");
        String username="";
        username=(String)session.getAttribute("username");
        if(!username.equals("")){
        	login=true;
        }
	try{
	  Class.forName("com.mysql.jdbc.Driver");
	  Connection con=DriverManager.getConnection(connectString, 
	                 "user", "123");
	  String sql=String.format("select * from article limit %d,%d",pgno*pgcnt,pgcnt);
	  Statement stmt=con.createStatement();
	  ResultSet rs=stmt.executeQuery(sql);
	  table.append("<table><tr><th>标题</th><th>时间</th><th>作者</th></tr>");
	  while(rs.next()) {
	  	String time=(String)rs.getString("create_time");
	      table.append(String.format(
	     		 "<tr><td><a href='article.jsp?pid="+rs.getInt("art_id")+"&pauthor="+rs.getString("article_author")+"'>%s</a></td><td>%s</td><td><a href='mainpage.jsp?pauthor="+rs.getString("article_author")+"'>%s</a></td></tr>",
	     		 rs.getString("article_title"),time,rs.getString("article_author")
	     		 
	     		 )
	     		 );
	  }
	  table.append("</table>");
	  rs.close();
	  stmt.close();
	  con.close();
	}
	catch (Exception e){
	  msg = e.getMessage();
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>博客园</title>
<style>
	body {	font-family:宋体; background: linear-gradient(to bottom,#808080 0% ,#202020 50%,#808080 100%);}
	#main {	width:800px;
			min-height:700px;
			border:2px solid #ccc;
			border-radius:20px;
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
	#next {	float:right;
			margin-top:40px;
			margin-right:20px;
			}
	table { color:#FFF;
			text-align:center;}
	table tr { height:50px;}
	td:first-child {	width:300px;}
	td:nth-child(2) {	width:300px;}
	td:nth-child(3) {	width:100px;}
	th:first-child {	width:300px;}
	th:nth-child(2) {	width:300px;}
	th:nth-child(3) {	width:100px;}
	a:link,a:visited {	color:white;}
	a:hover {	color:yellow;}
	#username {	color:#FFF;}
</style>
</head>
<body>
<div id="header">
<div>
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
<%if(login==false){ %>
<input type="button" value="注册" onClick="window.location.href='register.jsp'">
<input type="button" value="登陆" onClick="window.location.href='login.jsp'">
<%} %>

<%if(login==true){ %>
<input type="button" value="我的博客" onClick="window.location.href='mainpage.jsp?pauthor=<%=username%>'">
<input type="button" value="注销" onClick="window.location.href='check.jsp'">
<%} %>
</div>
</div>
<div id="main">
<%=table %>
<div id="next">
<a href="blogmainpage.jsp?pgno=<%=pgprev %>&pgcnt=<%=pgcnt %>">上一页</a>
<a href="blogmainpage.jsp?pgno=<%=pgnext %>&pgcnt=<%=pgcnt %>">下一页</a>
</div>
</div>
</body>
</html>