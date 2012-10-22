<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<sql:query var="school" dataSource="jdbc/lut2">
    SELECT * FROM country, school
    WHERE school.country = country.short_name
    AND country.full_name = ? <sql:param value="${param.country}"/>
</sql:query>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
        <title>LUT 2.0 - <c:out value="${param.country}"/></title>
    </head>
    <body>
        <h1>Approved schools in <c:out value="${param.country}"/></h1>
        <br><br>
        <c:forEach var="schoolDetails" items="${school.rowsByIndex}">

            <table border="0">
                <thead>
                    <tr>
                        <th colspan="2"><c:out value="${schoolDetails[3]}"/></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><strong>Nickname: </strong></td>
                        <td><span style="font-size:smaller; font-style:italic;"><c:out value="${schoolDetails[4]}"/></span></td>
                    </tr>
                    <tr>
                        <td><strong>Address: </strong></td>
                        <td><c:out value="${schoolDetails[5]}"/>
                            <br>
                            <span style="font-size:smaller; font-style:italic;">
                                zip: <c:out value="${schoolDetails[6]}"/></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <form action="school_reviews.jsp">
                                <input type="hidden" name="school_id" value="<c:out value="${schoolDetails[2]}"/>" />
                                <input type="hidden" name="school_fullname" value="<c:out value="${schoolDetails[3]}"/>" />
                                <input type="hidden" name="school_shortname" value="<c:out value="${schoolDetails[4]}"/>" />
                                <input type="submit" value="Read reviews" />
                            </form>
                        </td>
                    </tr>
                </tbody>
            </table>
        </c:forEach>
    </body>
</html>
