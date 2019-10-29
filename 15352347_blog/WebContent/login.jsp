<%@ page language="java" import="java.util.*,java.sql.*" 
         contentType="text/html; charset=utf-8"
%>
<% request.setCharacterEncoding("utf-8");
String msg = "";
String connectString = "jdbc:mysql://172.18.187.234:53306/15352347_blog"
		+ "?autoReconnect=true&useUnicode=true"
		+ "&characterEncoding=UTF-8"; 
String user="user"; String pwd="123";
String username = request.getParameter("username");
String password = request.getParameter("password");
//out.print(password);
if(request.getMethod().equalsIgnoreCase("post")){
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(connectString,user, pwd);
Statement stmt = con.createStatement();
String fmt="select password from userinfo where username='%s'";
String str=String.format(fmt,username);
ResultSet rs=null;
rs=stmt.executeQuery(str);
if(rs.next()==false){
	msg="用户名不存在！";
}

else if(rs.getString("password").equals(password)){
	
	
	session.setAttribute("username",username);
    
    response.sendRedirect("mainpage.jsp?pauthor="+username+"");
    con.close();
}
else msg="用户名与密码不匹配，请重新输入";
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>登陆</title>
<style>
	body {	background: linear-gradient(to bottom,#808080 0% ,#202020 50%,#808080 100%);}
	div {	font-family:宋体;
			margin:200px auto;
			text-align:center;
			padding-top:50px;
			border-radius:20px;
			width:300px;
			height:200px;
			color:white;
	}
	form {	color:white;}
	input {	color:#FFF; 
			background:transparent;
			border:1px solid #FFF;
			}
	.b {	border:0px solid #000000;}
	.b:hover {	cursor:pointer;}
</style>		
</head>
<body> 
<div id="login">
<form action="login.jsp"method="post"name="f">
<p>用户名  <input id="username"name="username"type="text"></P>
<p>密码 &nbsp;<input id="password"type="password"name="password"></p>

<input type="submit"name="sub"value="登陆" class="b">
<input type="button" value="注册" onClick="window.location.href='register.jsp'" class="b">
</form><br><br>
<input type="button" value="直接进入博客园" onClick="window.location.href='blogmainpage.jsp'" class="b">
<br><br>
<%=msg %>
</div>
</body>
</html>