           <%--   <sql:transaction dataSource="jdbc/lut2">
    				<sql:update var="count">
        				UPDATE normal_users SET uname=?, email=? WHERE uname=?
        				<sql:param value='${username}' />
        				<sql:param value='${email}' />
        				<sql:param value='${param.normal_users}' />        				
    				</sql:update>
			</sql:transaction> --%>
			
			<%--   <sql:transaction dataSource="jdbc/lut2">
        				DELETE FROM normal_users WHERE uname=?
        				<sql:param value='${param.normal_users}' />        				
			</sql:transaction> --%>