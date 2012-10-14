<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ page import="sun.net.smtp.SmtpClient, java.io.*" %>
<%@ page import="java.math.BigInteger, java.security.SecureRandom"%>


<%!
public String sendVerificationMail (String to, String token)
{
	String from="no-reply@stud.ntnu.no";
	String output;
	 try{
	     SmtpClient client = new SmtpClient("smtp.nteb.no");
	     client.from(from);
	     client.to(to);
	     PrintStream message = client.startMessage();
	     message.println("To: " + to);
	     message.println("Subject:  Registration verification");
	     message.println("Your verification code: " + token);
	     client.closeServer();
	     output = "A verification mail has been sent to the mail address you supplied.";
	  }
	  catch (IOException e){	
		
	     output = "Error while sending new password, contact support";
	     output = e.toString();
	  }
	 return output;
}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="lutstyle.css">
        <title>LUT 3.0 - Help Students Conquer the World</title>
    </head>
    <body>
        <h1>Hi student!</h1>
        <table border="0">
               <c:choose>
					<c:when test="${ ! empty param.token}">
						<c:choose>
							<c:when test="${token eq param.token}">
								<c:choose>
									<c:when test="${empty username or empty password or empty email}">
										<thead>
											<tr><th>
												Somewhere an error occurred, contact an administrator
											</th></tr>
										</thead>
									</c:when>
									<c:otherwise>
										<thead>
											<tr><th>
											Registration successful!
											</th></tr>
										</thead>
										<sql:transaction dataSource="jdbc/lut2">
									    	<sql:update var="count">
									        	INSERT INTO normal_users(uname,pw,email) VALUES (?,?,?);
									        	<sql:param value="${username}" />
									        	<sql:param value="${password}" />
									        	<sql:param value="${email}" />
									    	</sql:update>
										</sql:transaction>
										<c:remove var="username" scope="session"/>
										<c:remove var="password" scope="session"/>
										<c:remove var="email" scope="session"/>
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								<thead>
									<tr><th>
									Invalid token, try again
									</th></tr>
								</thead>
								<tbody>
									<form method="post" action="register.jsp">
										<tr><th colspan="2"><h3>Complete signup</h3></th></tr>
										<tr>
										<td>Verification code:</td>
										<td><input type="text" name="token"/></td>
										</tr><tr>
										<td colspan="2"><input type="submit" value="Verify"/></td>
										</tr>
									</form>
								</tbody>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:when test="${empty param.username or empty param.password or empty param.email}">
						
							<form method="post" action="register.jsp">
									<thead>
										<tr><th colspan="2"><h2>Please register</h2></th></tr>
									</thead>
									<tbody>
										<tr>
										<td>Username:</td>
										<td><input type="text" value="username" name="username"/></td>
										</tr><tr>
										<td>Password:</td>
										<td><input type="password" value="password" name="password"/></td>
										</tr><tr>
										<td>Email:</td>
										<td><input type="text" value="Email" name="email"/></td>
										</tr><tr>
										<td colspan="2"><input type="submit" value="Register"/></td>
										</tr>
									</tbody>
							</form>
					</c:when>
					
					<c:otherwise>
						<c:choose>
							<c:when test="${validate()}">
							</c:when>
							<c:otherwise>
								<c:set var="username" scope="session" value="${param.username }"/>
								<c:set var="password" scope="session" value="${param.password }"/>
								<c:set var="email" scope="session" value="${param.email }"/>
								
								<thead><tr><th>
								<%
									SecureRandom r = new SecureRandom();
									String token = new BigInteger(32, r).toString(40);
									out.print(sendVerificationMail(request.getParameter("email"),token));
									session.setAttribute("token", token);
								%>	
		
								</th></tr></thead>
								<form method="post" action="register.jsp">
									<tbody>
										<tr>
										<td>Verification code:</td>
										<td><input type="text" name="token"/></td>
										</tr><tr>
										<td colspan="2"><input type="submit" value="Verify"/></td>
										</tr>
									</tbody>
								</form>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
				<tr><td>
				Username: "<c:out value="${param.username}"/>"
				<br/>Password: "<c:out value="${param.password}"/>"
				<br/>Email: "<c:out value="${param.email}"/>"
				<br/>Token: "<c:out value="${param.token}"/>"
				<br/>
					
					
				Username: "<c:out value="${username}"/>"
				<br/>Password: "<c:out value="${password}"/>"
				<br/>Email: "<c:out value="${email}"/>"
				<br/>Token: "<c:out value="${token}"/>"
				<br/>	
				</td></tr>
        </table>

    </body>
</html>

