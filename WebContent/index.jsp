<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="country" dataSource="jdbc/lut2">
    SELECT full_name FROM country
</sql:query>

<<script type="text/javascript">
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

        <meta http-equiv="Content-Type" content="text/html"> 
        <link rel="stylesheet" type="text/css" href="lutstyle.css">
        <title>LUT 2.0 - Help Students Conquer the World</title>
    </head>
    <body>
        <h1>Hi student!</h1>
        <table border="0">
            <thead>
                <tr>
                    <th>LUT 2.0 provides information about approved international schools</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>To view information about schools in a country, please select a country below:</td>
                </tr>
                <tr>
                    <td><form name="form_country" action="schools.jsp"
                    	onSubmit="return validate_form()">
                            <strong>Select a country:</strong>
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

    </body>
</html>
