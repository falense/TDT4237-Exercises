
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.math.*"%>

<% 
String username = request.getParameter("username");
if(username != null){
	username = username.replace('<', ' ').replace('>', ' ');	
}
%>

<% 
String encryption = request.getParameter("password");
 
    //Lage objet for MD5
    MessageDigest digest = MessageDigest.getInstance("MD5");
     
    //Oppdatere input
    digest.update(encryption.getBytes(), 0, encryption.length());

    //Konvertere strengen til Hex
    encryption = new BigInteger(1, digest.digest()).toString(16);

%>

<sql:query var="admin_users" dataSource="jdbc/lut2">
    SELECT uname FROM admin_users
    WHERE  uname = ? <sql:param value="<%=username%>" /> 
    AND pw = ?   <sql:param value="<%=encryption%>" />

</sql:query>

    
    
<c:set var="userDetails" value="${admin_users.rows[0]}"/>

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
                Login failed, check your username or password!
            </c:when>
            <c:otherwise>
                <h1>Login succeeded. Welcome <%=username%>!</h1>  
                <table border="0">
            		<thead>
                		<tr>
                    		<th>Manage users</th>
                		</tr>
            		</thead>
            		<tbody>
                		<tr>
                    		<td>Please select a user below to edit or delete:</td>
                		</tr>
                		<tr>
                    		<td><form name="form_users" action="schools.jsp"
                    			onSubmit="return validate_form()">
                            	<strong>Select a user:</strong>
                            	<select name= <c:out value="country"/>>
                                	<c:forEach var="row" items="${country.rowsByIndex}">
                                  	 	<c:forEach var="column" items="${row}">
                                  	    	 <option value="<c:out value="${column}"/>"><c:out value="${column}"/></option>
                                    	</c:forEach>
                               		</c:forEach>
                            	</select>
                            	<input type="submit" value="submit" />
                        	</form></td>
               			</tr>
            		</tbody>               
                </table>
                <% session.setAttribute("SessionName", username); %>
            </c:otherwise>
        </c:choose>
        </body>
    </html>
