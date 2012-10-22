<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<sql:query var="user" dataSource="jdbc/lut2">
    SELECT * FROM normal_users
    WHERE user_id = ? <sql:param value="${param.normal_users}"/>
</sql:query>

<%session.setAttribute("user_id", request.getParameter("normal_users")); %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <% Object username = session.getAttribute("AdminUsername");
   			if(username == null){
       			out.print("<meta http-equiv=\"refresh\" content=\"1;url=./loginNormalUser.jsp\"> ");
       			return;
   			}
		%>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="lutstyle.css">
        <title>LUT 2.0 - <c:out value="${param.normal_users}"/></title>
        
    </head>
    <body>
        <c:forEach var="userDetails" items="${user.rowsByIndex}">
        <h1>Edit user</h1>
        <form name="userdata" action="handle_useredit.jsp">
        <table border="0">
        	<tbody>        	
            	<tr>
                	<td><strong>Username: </strong></td>
                	<td><input type="text" size="35" name="username" value="<c:out value="${userDetails[1]}"/>" /></td>
            	</tr>
            	<tr>
                	<td><strong>Email: </strong></td>
                	<td><input type="text" size="35" name="email" value="<c:out value="${userDetails[3]}"/>" />
                		<br>
                    </td>
                </tr>
                <tr>
                	<td><input type="submit" name="submit" value="Delete"/></td>
                	<td><input type="submit" name="submit" value="Save"/></td>
                </tr>
        	</tbody>        	
    	</table>
    	</form>  

    	</c:forEach> 
	</body>
</html>