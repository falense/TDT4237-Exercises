
<%@ page language="java" import="captchas.CaptchasDotNet" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
// Construct the captchas object (Default Values)
CaptchasDotNet captchas = new captchas.CaptchasDotNet(
   request.getSession(true),     // Ensure session
  "progsikgr7",                       // client
  "NY0lOO3AAiKZpv1U8cSjEageoQSJoxioVUYOro1e"                      // secret
  );
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="lutstyle.css">
        <title>Forgot password</title>
    </head>
    <body>
        <h1>Forgot password</h1>
        <table border="0">
            <thead>
                <tr>
                    <th>Enter your email here to reset your password</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><form method="post" action="reset_password.jsp">

                            <p>
                                Email:</font><input type="text" name="email" size="20"></p>
                            
                            <p>
                            	<%= captchas.image() %><br>
           						<a href="<%= captchas.audioUrl() %>">Phonetic spelling (mp3)</a><br />
                                Message:</font><input type="text" name="password" size="20"></p>
                            <p><input type="submit" value="submit" name="login"></p>
                            
                        </form></td>
                </tr>
            </tbody>
        </table>
    </body>
</html>
