<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ page import="sun.net.smtp.SmtpClient, java.io.*" %>
<%@ page import="java.math.BigInteger, java.security.SecureRandom"%>
<%@ page import="enc.*" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import ="javax.mail.internet.AddressException" %>
<%@ page language="java" import="captchas.CaptchasDotNet" %>
<%
         CaptchasDotNet captchas = new captchas.CaptchasDotNet(
		   request.getSession(true),     // Ensure session
		  "progsikgr7",                       // client
		  "NY0lOO3AAiKZpv1U8cSjEageoQSJoxioVUYOro1e",
		  "0123456789",
		  3
		  );
		%>
<%!

public boolean validateEmail(String email){
   boolean result = true;
   try {
      InternetAddress emailAddr = new InternetAddress(email);
      emailAddr.validate();
   } catch (AddressException ex) {
      result = false;
   }
	return result;
}
public boolean validateUsername(String username){
	if (username.equals("Luka"))
		return false;
	else
		return true;
	
}
public boolean validatePasswordLength(String password){
	if (password.length() > 8)
		return true;
	else
		return false;
}
public boolean validatePasswordContent(String password){
	return true;
}
public boolean validatePassword(String password){
	return validatePasswordLength(password) && validatePasswordContent(password);
}
public boolean validate(String username, String password, String email){
	boolean a = validateEmail(email);
	boolean b = validateUsername(username);
	boolean c = validatePassword(password);
	return a && b && c;
}
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
		
	     output = "Error while sending verification mail, double check your email, contact support if the problem persists";
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
    	<table border="0">
       		<%
       		 String captchaToken = request.getParameter("captchaToken");
       		pageContext.setAttribute("captchaValid",false);//false);
       		if (captchaToken != null &&  captchaToken != "" && captchas.check(captchaToken) =='t') {
       			pageContext.setAttribute("captchaValid",true);
       		}
       		%>
            <c:choose>
				<c:when test="${ ! empty param.token}">
					<c:choose>
						<c:when test="${token eq param.token}">
							<c:choose>
								<c:when test="${empty username or empty password or empty email }">
									<thead>
										<tr><th>
											Somewhere an error occurred, contact an administrator
										</th></tr>
									</thead>
								</c:when>
								<c:otherwise>
									<c:catch var="sql_exception">
										<sql:transaction dataSource="jdbc/lut2">
									    	<sql:update var="count">
									        	INSERT INTO normal_users(uname,pw,email) VALUES (?,?,?);
									        	<sql:param value="${username}" />
									        	<sql:param value="${password}" />
									        	<sql:param value="${email}" />
									    	</sql:update>
										</sql:transaction>
										
										<thead>
											<tr><th>
											Registration successful!
											</th></tr>
										</thead>
										<tbody>
											<tr><td>You have been registered</td></tr>
											<tr><td>Your username: <c:out value="${username }"/></td></tr>
										</tbody>
										<c:remove var="username" scope="session"/>
										<c:remove var="password" scope="session"/>
										<c:remove var="email" scope="session"/>
										
									</c:catch>
												
									<c:if test="${sql_exception != null }">
										<thead><tr><th>Error: Registering your user</th></tr></thead>
										<tbody>
											<tr><td>Somewhere something went terribly wrong (most likely your username or email is in use).</td></tr>
										</tbody>
									</c:if>			
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<thead>
								<tr><th>
								Error: Token
								</th></tr>
							</thead>
							<tbody>
								<tr><td>Invalid token, try again</td></tr>
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
				<c:when test="${empty param.username or empty param.password or empty param.email or !captchaValid}">
						<c:remove var="username"/>
						<c:remove var="password"/>
						<c:remove var="email"/>
						<c:remove var="token"/>
						<form method="post" action="register.jsp">
								<thead>
									<c:choose>
										<c:when test="${!captchaValid and not empty param.captchaToken}"><tr><th colspan="2"><h2>Captcha incorrect, try again!</h2></th></tr></c:when>
										<c:otherwise>
											<tr><th colspan="2"><h2>Please register</h2></th></tr>	
										</c:otherwise>
									</c:choose>
									
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
									<td><%= captchas.image() %></td><td><input name="captchaToken" type="text"/></td>
									</tr><tr>
									
									<td colspan="2"><input type="submit" value="Register"/></td>
									</tr>
								</tbody>
						</form>
					</c:when>
				<c:otherwise>
					<c:set var="username" scope="session" value="${param.username }"/>
					<c:set var="password" scope="session" value="${param.password }"/>
					<c:set var="email" scope="session" value="${param.email }"/>
								
					<%
						boolean validate = validate((String)session.getAttribute("username"),(String)session.getAttribute("password"),(String)session.getAttribute("email"));
						pageContext.setAttribute("validated",validate);
					%>
					<c:choose>
						<c:when test="${!validated}">
							
							<thead><tr><th>Error: Username/password/email input</th></tr></thead>
							<tbody>
								<tr><td>Username:</td><td>Cannot be Luka</td></tr>
								<tr><td>Password:</td><td>Minimum length 8</td></tr>
								<tr><td>Email:</td><td>Has to be a valid email.</td></tr>
							</tbody>
						</c:when>
						<c:otherwise>
					
							<thead><tr><th>
							<%
								SecureRandom r = new SecureRandom();
								String token = new BigInteger(32, r).toString(40);
								out.print(sendVerificationMail(request.getParameter("email"),token));
								session.setAttribute("token", token);
								session.setAttribute("password",(String)MD5.hash((String)session.getAttribute("password")));
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
			<% //<tr><td>
				//Username: "<c:out value="${param.username}"/>"
				//<br/>Password: "<c:out value="${param.password}"/>"
				//<br/>Email: "<c:out value="${param.email}"/>"
				//<br/>Token: "<c:out value="${param.token}"/>"
				//<br/>
					
				//Username: "<c:out value="${username}"/>"
				//<br/>Password: "<c:out value="${password}"/>"
				//<br/>Email: "<c:out value="${email}"/>"
				//<br/>Token: "<c:out value="${token}"/>"
				//<br/>	
			//</td></tr>
			%>
        </table>
    </body>
</html>