<%@ page language="java" import="java.util.Date,java.sql.*,java.text.SimpleDateFormat" 
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
String article="";
String time="";
String id= "";
String title="";
try {
	id = request.getParameter("pid");
}catch (Exception e){
}

username = (String)session.getAttribute("username");
StringBuilder table=new StringBuilder("");

	out.print(username);
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(connectString,user, pwd);
	Statement stmt = con.createStatement();
	String sqll="select * from article where art_id = "+id+";";
	ResultSet rss=null;
	rss=stmt.executeQuery(sqll);
	while(rss.next()){
		title=rss.getString("article_title");
		article=rss.getString("article");
	}
	rss.close();
	
	
	if(request.getParameter("save")!=null) {
		try{
			id = request.getParameter("id");
			title = request.getParameter("title");
			article = request.getParameter("article");
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			time = df.format(new Date());
			stmt.executeUpdate(String.format("update article set article_title='%s',article = '%s',create_time = '%s' where art_id = '%s'",title,article,time,id));
			stmt.close();
			con.close();
			response.sendRedirect("mainpage.jsp?pauthor="+username);
		}
		catch (Exception e){
			msg = e.getMessage();
		}
	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style>
	body {	font-family:宋体;
			min-height:1000px;
			background: linear-gradient(to bottom,#808080 0% ,#202020 50%,#808080 100%);
			color:#FFF;}
	#main {	width:900px;
			min-height:1000px;
			text-align:center;
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
	textarea {	color:#FFF; 
				background:transparent;
				border:2px solid #FFF;
				border-radius:20px;
				font-size:15px;
				width:800px;
				padding:10px;}
	#form {		margin:20px auto;
				width:800px;
				text-align:right;
				}
	input {	color:#FFF; 
			background:transparent;
			border:0px solid #FFF;}
	[name="title"] { 	border:2px solid #FFF;
						border-radius:5px;}
	#select:hover {	cursor:pointer;}
</style>
<title>
编辑<%=title%>
</title>
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
</span>
</div>
<div id="main">
<form action="edit.jsp" method="post">
	<input type="hidden" name="id" value="<%=id%>">
	title:<input type="text" name="title" size = 80 value="<%=title%>"><br><br>
	<textarea rows="50" cols="50" name="article"><%=article%></textarea><br><br>
	<input id="select" type="submit" value="保存" name="save">
</form>
<input id="select" type="button" value="取消" onClick="window.location.href='mainpage.jsp?pauthor=<%=username%>'">
</div>
</body>
</html>







