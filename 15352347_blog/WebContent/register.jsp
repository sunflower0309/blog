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
String passwordcon = request.getParameter("passwordcon");
if(request.getMethod().equalsIgnoreCase("post")){
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(connectString,user, pwd);
Statement stmt = con.createStatement();
if(password.equals(passwordcon)){
	try
	{
		String fmt="insert into userinfo(username,password) values('%s', '%s')";
	String sql = String.format(fmt,username,password);
	int cnt = stmt.executeUpdate(sql);
	if(cnt>0)msg = "注册成功!";
	stmt.close(); con.close();
	}
	catch(Exception e){
	msg = "用户名已存在！";
	}
}
else msg="两次输入密码不匹配，请重新检查后输入！";
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
<head>

<title>Insert title here</title>
</head>
<body>
<div>
<form action="register.jsp"method="post"name="f">
用户名:&nbsp;&nbsp;<input id="username"name="username"type="text"><br><br>
密码:   &nbsp; &nbsp;<input id="password"type="password"name="password"><br><br>
确认密码:&nbsp;<input id="passwordcon"type="password"name="passwordcon"><br><br>
<input type="submit"name="sub"value="注册" class="b"> 
<input type="button" value="返回登陆" onClick="window.location.href='login.jsp'" class="b"> 
</form><br><br>
<%=msg %>
</div>
</body>
</html>