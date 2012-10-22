
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.math.*"%>
<%@page import="enc.*"%>

<% 
String username = request.getParameter("username");
if(username != null){
	username = username.replace('<', ' ').replace('>', ' ');	
}
%>

<% 
String encryption = request.getParameter("password");
if(encryption == null){
	encryption = " ";
}
else
	encryption = MD5.hash(encryption);

%>

<sql:query var="normal_users" dataSource="jdbc/lut2">
    SELECT user_id FROM normal_users
    WHERE  uname = ? <sql:param value="<%=username%>" /> 
    AND pw = ?   <sql:param value="<%=encryption%>" />
</sql:query>

<c:set var="userDetails" value="${normal_users.rows[0]}" />

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="refresh" content="2;url=./index.jsp"> 
<link rel="stylesheet" type="text/css" href="lutstyle.css">
<title>LUT Log in pages</title>
</head>
<body>
	<c:choose>
		<c:when test="${ empty userDetails }">
			<h1>Login failed, check your username or password!</h1> 
		</c:when>
		<c:otherwise>
			<h1>Login succeeded</h1> 
                Welcome <%=username%>.<br>
               
                <% session.setAttribute("Username", username); %>
		</c:otherwise>
	</c:choose>
</body>
</html>
