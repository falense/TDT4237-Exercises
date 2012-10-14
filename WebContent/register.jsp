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
	     SmtpClient client = new SmtpClient("smtp.ntebb.no");
	     client.from(from);
	     client.to(to);
	     PrintStream message = client.startMessage();
	     message.println("To: " + to);
	     message.println("Subject:  Registration verification");
	     message.println("Your verification code: " + token);
	     message.println();     
	     message.println();
	     client.closeServer();
	     output = "Your new password has been sent to your registered email address";
	  }
	  catch (IOException e){	
		
	     output = "Error while sending new password, contact support";
	     output = e.toString();
	  }
	 return output;
}
%>

<c:choose>

	<c:when test="${ ! empty token and token eq param.token }">
		Registrated successfully!
		<sql:transaction dataSource="jdbc/lut2">
	    	<sql:update var="count">
	        	INSERT INTO normal_users(uname,pw,email) VALUES (?,?,?);
	        	<sql:param value="${username}" />
	        	<sql:param value="${password}" />
	        	<sql:param value="${email}" />
	    	</sql:update>
		</sql:transaction>
		
		
	</c:when>
	<c:when test="${empty param.username or empty param.password or empty param.email}">
		Please register
		<form method="post" action="register.jsp">
			<input type="text" value="Email" name="email"/>
			<input type="text" value="username" name="username"/>
			<input type="password" value="password" name="password"/>
			<input type="submit"/>
		</form>
	</c:when>
	
	<c:otherwise>
		<c:set var="username" scope="session" value="${param.username }"/>
		<c:set var="password" scope="session" value="${param.password }"/>
		<c:set var="email" scope="session" value="${param.email }"/>
	
		<%
			SecureRandom r = new SecureRandom();
			String token = new BigInteger(32, r).toString(40);
			out.print(sendVerificationMail(request.getParameter("email"),token));
			session.setAttribute("token", token);
		%>
		<c:out value="${token}"/>
		Verification email sent!		
	</c:otherwise>
</c:choose>
