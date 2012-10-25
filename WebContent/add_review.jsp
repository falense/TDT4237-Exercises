<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" import="captchas.CaptchasDotNet" %>

<% 
String username;
if (request.getParameter("name").length() > 20)
{
	username = request.getParameter("name").substring(0, 20).replace('<', ' ').replace('>', ' ');
}
else
{
	username = request.getParameter("name").replace('<', ' ').replace('>', ' ');
}

%>
<%
boolean captchaGood = false;
CaptchasDotNet captchas = new captchas.CaptchasDotNet(
   request.getSession(true),     // Ensure session
  "progsikgr7",                       // client
  "NY0lOO3AAiKZpv1U8cSjEageoQSJoxioVUYOro1e"                      // secret
  );
String password;
if(request.getParameter("password") == null)
{ 
	password = " "; 
}
else
{
	password = request.getParameter("password");
}
String body;
switch (captchas.check(password)) {
   case 's':
     body = "Session seems to be timed out or broken. ";
     body += "Please try again or report error to administrator.";
     break;
   case 'm':
     body = "Every CAPTCHA can only be used once. ";
     body += "The current CAPTCHA has already been used. ";
     body += "Please use back button and reload";
     break;
   case 'w':
     body = "You entered the wrong password. ";
     body += "Please use back button and try again. ";
     break;
   default:
     body = "";
	 captchaGood = true;
     break;
 }
if(captchaGood == false)
{
	out.print(body);
	return;
}
 %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <% Object sUsername = session.getAttribute("Username");
   			if(sUsername == null){
       			out.print("<meta http-equiv=\"refresh\" content=\"1;url=./loginNormalUser.jsp\"> ");
       			return;
   			}
		%>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="5;url=index.jsp"> 
        <link rel="stylesheet" type="text/css" href="lutstyle.css">
        <title>Review added NOW2!</title>
    </head>
    <body>
        <h1>Thanks <%=username%>!</h1>
        Your contribution is appreciated.<br>
        You will be redirected to the LUT2.0 main page in a few seconds.
    </tr>
</body>
</html>
<%
boolean captchaGood = false;
CaptchasDotNet captchas = new captchas.CaptchasDotNet(
   request.getSession(true),     // Ensure session
  "progsikgr7",                       // client
  "NY0lOO3AAiKZpv1U8cSjEageoQSJoxioVUYOro1e"                      // secret
  );
String password;
if(request.getParameter("password") == null)
{ 
	password = " "; 
}
else
{
	password = request.getParameter("password");
}
String body;
switch (captchas.check(password)) {
   case 's':
     body = "Session seems to be timed out or broken. ";
     body += "Please try again or report error to administrator.";
     break;
   case 'm':
     body = "Every CAPTCHA can only be used once. ";
     body += "The current CAPTCHA has already been used. ";
     body += "Please use back button and reload";
     break;
   case 'w':
     body = "You entered the wrong password. ";
     body += "Please use back button and try again. ";
     break;
   default:
     body = "";
	 captchaGood = true;
     break;
 }
if(captchaGood == false)
{
	out.print(body);
	return;
}
 %>



<sql:transaction dataSource="jdbc/lut2">
    <sql:update var="count">
        INSERT INTO user_reviews VALUES (?, ?, ?)
        <sql:param value='${param.school_id}' />
        <sql:param value='<%=username%>' />
        <sql:param value='${param.review}' />
    </sql:update>
</sql:transaction>

