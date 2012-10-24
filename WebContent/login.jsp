
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.math.*"%>
<%@page import="enc.*"%>

<% 
String admin_username = request.getParameter("username");
if(admin_username != null){
	admin_username = admin_username.replace('<', ' ').replace('>', ' ');	
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

<sql:query var="admin_users" dataSource="jdbc/lut2">
    SELECT uname FROM admin_users
    WHERE  uname = ? <sql:param value="<%=admin_username%>" /> 
    AND pw = ?   <sql:param value="<%=encryption%>" />
</sql:query>

<c:set var="userDetails" value="${admin_users.rows[0]}" />
<sql:query var="normal_users" dataSource="jdbc/lut2">
    SELECT user_id, uname FROM normal_users
</sql:query>

<c:set var="userDetails" value="${admin_users.rows[0]}" />

<script type="text/javascript">
<!--
var countryNames = new Array();

<c:forEach var="row" items="${country.rowsByIndex}">
	<c:forEach var="column" items="${row}">
    	countryNames.push(value="${column}");
	</c:forEach>
</c:forEach>

function validate_form ( )
{
	valid = false;
	for(var i=0; i< countryNames.length; i++){
		if ( countryNames[i] == document.form_country.country.value )
		{
	        valid = true;
	        return valid;
	    }
	}
	if(valid = false){
		alert( "Please stop tampering with the web parameters." );
	}
	
    return valid;
}

//-->
</script>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<% Object username = session.getAttribute("AdminUsername");
   			if(username == null){
       			
   			}
   			else
   				pageContext.setAttribute("userDetails", 1234);
   				
		%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="lutstyle.css">
<title>LUT Admin pages</title>
</head>
<body>
	<c:choose>
		<c:when test="${ empty userDetails }">
                Login failed, check your username or password!
                <meta http-equiv="Refresh" content="3; url=lutadmin.jsp">
            </c:when>
            <c:otherwise>
                <h1>Login succeeded. Welcome <%=admin_username%>!</h1>  
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
                    		<td><form name="form_users" action="userdata.jsp" onSubmit="">
                            	<strong>Select a user:</strong>
                            	<select name= <c:out value="normal_users"/>>
                                	<c:forEach var="row" items="${normal_users.rowsByIndex}">
                                  		<option value="<c:out value="${row[0]}"/>"> <c:out value="${row[1]}"/></option>
                               		</c:forEach>
                            	</select>
                            	<input type="submit" value="Edit" />
                        	</form></td>
               			</tr>
            		</tbody>               
                </table>
                <% session.setAttribute("AdminUsername", admin_username); %>
            </c:otherwise>
        </c:choose>
        </body>
    </html>
