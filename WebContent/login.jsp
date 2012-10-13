
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.security.MessageDigest"%>

<% 
String username = request.getParameter("username");
if(username != null){
	username = username.replace('<', ' ').replace('>', ' ');	
}
%>

<% 

String encryption = request.getParameter("password");
MessageDigest mdAlgorithm = MessageDigest.getInstance("MD5");
mdAlgorithm.update(encryption.getBytes());

byte[] digest = mdAlgorithm.digest();
StringBuffer hexString = new StringBuffer();

for (int i = 0; i < digest.length; i++) {
   	encryption = Integer.toHexString(0xFF & digest[i]);

    if (encryption.length() < 2) {
        encryption = "0" + encryption;
    }

    hexString.append(encryption);
}

%> 

<sql:query var="users" dataSource="jdbc/lut2">
    SELECT * FROM admin_users
    WHERE  uname = ? <sql:param value="<%=username%>" /> 
    AND pw = ?   <sql:param value="<%=encryption%>" />

</sql:query>

    
    
<c:set var="userDetails" value="${users.rows[0]}"/>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="lutstyle.css">
        <title>LUT Admin pages</title>
    </head>
    <body>
        <c:choose>
            <c:when test="${ empty userDetails }">
                Login failed
            </c:when>
            <c:otherwise>
                <h1>Login succeeded</h1> 
                Welcome <%=username%>.<br> 
                Unfortunately, there is no admin functionality here. <br>
                You need to figure out how to tamper with the application some other way.
            </c:otherwise>
        </c:choose>
        </body>
    </html>
