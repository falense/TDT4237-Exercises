<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<% 
String delUni = request.getParameter("admin_delUni");
if(delUni != null){
	delUni = delUni.replace('<', ' ').replace('>', ' ').replace(';', ' ').replace(')',' ');	
}
%>

<sql:update var="school" dataSource="jdbc/lut2">
  		DELETE FROM school WHERE full_name = ?
  	<sql:param value='<%=delUni%>' />
</sql:update>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="refresh" content="3;url=admin_unis.jsp"> 
        <link rel="stylesheet" type="text/css" href="lutstyle.css">
        <title>LUT 2.0 - Help Students Conquer the World</title>
</head>
<body>
	School has been deleted.<br>
	You will be redirected back to the previous page in a few seconds.
</body>
</html>