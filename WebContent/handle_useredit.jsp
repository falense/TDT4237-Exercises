<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
	<c:when test="${param.submit == \"Save\"}">
		The user is updated. You will be redirected in 3 seconds.
    	<sql:transaction dataSource="jdbc/lut2">
    		<sql:update var="count">
        		UPDATE normal_users SET uname=?, email=? WHERE user_id=?
        		<sql:param value='${param.username}' />
        		<sql:param value='${param.email}' />
        		<sql:param value="<%=session.getAttribute("user_id") %>" />        				
    		</sql:update>
		</sql:transaction>
	</c:when>
	<c:otherwise>	
	The user is now deleted. You will be redirected in 3 seconds.	
		<sql:transaction dataSource="jdbc/lut2">
			<sql:update var="count">
        	DELETE FROM normal_users WHERE user_id=?
        	<sql:param value="<%=session.getAttribute("user_id") %>" />        				
    		</sql:update>
		</sql:transaction>
	</c:otherwise>
</c:choose>			


<meta http-equiv="Refresh" content="3; url=login.jsp">
<html>
<head>
    	<% Object username = session.getAttribute("AdminUsername");
   			if(username == null){
       			out.print("<meta http-equiv=\"refresh\" content=\"1;url=./lutadmin.jsp\"> ");
       			return;
   			}
		%>
</head>
<body>
</body>
</html>