<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


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

<sql:transaction dataSource="jdbc/lut2">
    <sql:update var="count">
        INSERT INTO user_reviews VALUES (?, ?, ?)
        <sql:param value='${param.school_id}' />
        <sql:param value='<%=username%>' />
        <sql:param value='${param.review}' />
    </sql:update>
</sql:transaction>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
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
