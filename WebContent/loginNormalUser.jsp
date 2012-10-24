

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="lutstyle.css">
        <title>LUT Log in page</title>
    </head>
    <body>
        <h1>Welcome to the LUT Log in page!</h1>
        <table border="0">
            <thead>
                <tr>
                    <th>Log in here to access the page</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><form method="post" action="loginNormal.jsp">

                            <p>
                                Username:</font><input type="text" name="username" size="20"></p>
                            <p>
                                Password:</font><input type="password" name="password" size="20"></p>
                            <p><input type="submit" value="submit" name="login"></p>
                        </form>
                        <br /><a href="forgot_password.jsp">Forgot your password?</a>
                        </td>
                </tr>
            </tbody>
        </table>
    </body>
</html>
