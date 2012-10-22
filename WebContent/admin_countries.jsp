<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="admin_country" dataSource="jdbc/lut2">
    SELECT * FROM country
</sql:query>

<sql:query var="admin_delCountry" dataSource="jdbc/lut2">
    SELECT full_name FROM country
</sql:query>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    	<% Object username = session.getAttribute("Username");
   			if(username == null){
       			out.print("<meta http-equiv=\"refresh\" content=\"1;url=./loginNormalUser.jsp\"> ");
       			return;
   			}
		%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="lutstyle.css">
        <title>LUT 2.0 - Help Students Conquer the World</title>
<body>
	<h1>Hello admin!</h1>
	<p>Here you can administrate the countries</p>
	<table border="1" width="100%">
		<tr>
			<th>Short name</th>
			<th>Full Name</th>
		</tr>
		<c:forEach var="row" items="${admin_country.rows}">
			<tr>
				<td><c:out value="${row.short_name}" /></td>
				<td><c:out value="${row.full_name}" /></td>
			</tr> 
		</c:forEach>
		
		<form action="add_country.jsp"  method="post">
		<tr>
			<td><input type="text" maxLength=3 value="XXX" name="shortNameInput"></td>
			<td><input type="text" maxLength=50 size=50 value="Add a new full name" name="fullNameInput"><input type="submit" name="newCountry" value="Submit"/></td>
		</tr>
		</form>
	</table>
	<tr>
		<td><form name="admin_delCountry" action="admin_delCountry.jsp">
				<strong>Select a country:</strong> 
				<select	name=<c:out value="admin_delCountry"/>>
					<c:forEach var="row" items="${admin_delCountry.rowsByIndex}">
						<c:forEach var="column" items="${row}">
							<option value="<c:out value="${column}"/>">
								<c:out value="${column}" />
							</option>
						</c:forEach>
					</c:forEach>
				</select> <input type="submit" value="Delete" />
			</form>
		</td>
	</tr>
</body>
</html>