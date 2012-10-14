<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ page import="sun.net.smtp.SmtpClient, java.io.*" %>
<%@ page import="java.math.BigInteger, java.security.SecureRandom"%>
<%
//session.setAttribute("theName",name);
%>
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

<c:choose>

	<c:when test="${ ! empty token}">
		<c:choose>
			<c:when test="${token eq param.token}">
				<center>
				<h2>Registrated successfully!</h2>
				</center>
				<sql:transaction dataSource="jdbc/lut2">
			    	<sql:update var="count">
			        	INSERT INTO normal_users(uname,pw,email) VALUES (?,?,?);
			        	<sql:param value="${username}" />
			        	<sql:param value="${password}" />
			        	<sql:param value="${email}" />
			    	</sql:update>
				</sql:transaction>
				<c:set var="username" scope="session" value="${param.username }"/>
				<c:set var="password" scope="session" value="${param.password }"/>
				<c:set var="email" scope="session" value="${param.email }"/>
			</c:when>
			<c:otherwise>
				
				<center>
					<h2>Invalid token, try again</h2>
					<form method="post" action="register.jsp">
						<table>
							<tr><th colspan="2"><h3>Complete signup</h3></th></tr>
							<tr>
							<td>Verification code:</td>
							<td><input type="text" name="token"/></td>
							</tr><tr>
							<td colspan="2"><input type="submit" value="Verify"/></td>
							</tr>
						</table>
					</form>
				</center>
				
			</c:otherwise>
			
		</c:choose>
		
	</c:when>
	<c:when test="${empty param.username or empty param.password or empty param.email}">
		<center>
			<form method="post" action="register.jsp">
				<table>
					<tr><th colspan="2"><h2>Please register</h2></th></tr>
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
				</table>
			</form>
		</center>
	</c:when>
	
	<c:otherwise>
		<c:set var="username" scope="session" value="${param.username }"/>
		<c:set var="password" scope="session" value="${param.password }"/>
		<c:set var="email" scope="session" value="${param.email }"/>
		
		<center>
			<h2>
			<%
				SecureRandom r = new SecureRandom();
				String token = new BigInteger(32, r).toString(40);
				out.print(sendVerificationMail(request.getParameter("email"),token));
				session.setAttribute("token", token);
			%>	
			</h2>
			<form method="post" action="register.jsp">
				<table>
					<tr><th colspan="2"><h2>Complete signup</h2></th></tr>
					<tr>
					<td>Verification code:</td>
					<td><input type="text" name="token"/></td>
					</tr><tr>
					<td colspan="2"><input type="submit" value="Verify"/></td>
					</tr>
				</table>
			</form>
		</center>
		
	</c:otherwise>
</c:choose>
