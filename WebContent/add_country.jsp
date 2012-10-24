<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<%
	String shortname;
	if (request.getParameter("shortNameInput") != null) {
		if (request.getParameter("shortNameInput").length() > 20) {
	shortname = request.getParameter("shortNameInput")
			.substring(0, 20).replace('<', ' ')
			.replace('>', ' ');
		} else {
	shortname = request.getParameter("shortNameInput")
			.replace('<', ' ').replace('>', ' ');
		}

	}
	else shortname="";

	String fullname;
	if (request.getParameter("fullNameInput") != null){
		if (request.getParameter("fullNameInput").length() > 20) {
			fullname = request.getParameter("fullNameInput")
					.substring(0, 20).replace('<', ' ')
					.replace('>', ' ');
		} else {
			fullname = request.getParameter("fullNameInput")
					.replace('<', ' ').replace('>', ' ');
		}

	}
	else
		fullname="";
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<% Object username = session.getAttribute("AdminUsername");
   			if(username == null){
       			out.print("<meta http-equiv=\"refresh\" content=\"1;url=./lutadmin.jsp\"> ");
       			return;
   			}
		%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="refresh" content="3;url=admin_countries.jsp">
<link rel="stylesheet" type="text/css" href="lutstyle.css">
<title>Country added NOW!</title>
</head>
<body>
	Country has been added.
	<br> You will be redirected back to the previous page in a few
	seconds.
	</tr>
</body>
</html>
<
<c:choose>
	<c:when
		test="${ ! empty param.fullNameInput || !empty param.shortNameInput }">
		<sql:transaction dataSource="jdbc/lut2">
			<sql:update var="count">
        INSERT INTO country VALUES (?, ?)
        	<sql:param value='<%=shortname%>' />
			<sql:param value='<%=fullname%>' />
			</sql:update>
		</sql:transaction>
	</c:when>
</c:choose>