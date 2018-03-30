<%@ page contentType="text/html;encoding=euc-kr"%>
<%@ page import="java.sql.*"%>
<%
            DatabaseMetaData meta = null;
            Connection con = null;

            DriverManager.registerDriver(new oracle.jdbc.OracleDriver());

            try {
                //con = WasDBCP.getConnection("g2gdb");

                 //Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@jijung:1522:ora10","danpum","danpum");
                 Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.123.246:1521:ora10g","com","com");
                 meta = conn.getMetaData();
%>
<html>
<body>
<table border="1">
	<tr>
		<td>JDBC Driver Name</td>
		<td><%=meta.getDriverName()%></td>
	</tr>
	<tr>
		<td>JDBC Driver Version</td>
		<td><%=meta.getDriverVersion()%></td>
	</tr>
	<tr>
		<td>JDBC Driver Major Version</td>
		<td><%=meta.getDriverMajorVersion()%></td>
	</tr>
	<tr>
		<td>JDBC Driver Minor Version</td>
		<td><%=meta.getDriverMinorVersion()%></td>
	</tr>
	<tr>
		<td>Database Name</td>
		<td><%=meta.getDatabaseProductName()%></td>
	</tr>
	<tr>
		<td>Database Version</td>
		<td><%=meta.getDatabaseProductVersion()%></td>
	<tr>
</table>
</body>
<%} catch (SQLException e) {
                e.printStackTrace();
            } finally {
                if (con != null) {
                    try {
                        con.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }

        %>
