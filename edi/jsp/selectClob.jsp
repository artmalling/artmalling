<%@ page language="java" contentType="text/html;charset=utf-8" 
    import="java.sql.*,java.io.*,oracle.sql.*,oracle.jdbc.driver.*"   %>
<%
	request.setCharacterEncoding("utf-8");
	//response.setContentType("text/html; charset=utf-8");
	CLOB clob = null;
	//데이터베이스 연결
	Class.forName("jeus.jdbc.pool.Driver");
	Connection con = DriverManager.getConnection("jdbc:jeus:pool:pot");
	
	con.setAutoCommit(false);
	
	PreparedStatement ps;
	ResultSet rs;
	
	StringBuffer buf = new StringBuffer();
	
	String iSelColumn = request.getParameter("iSelColumn"); 
	String iSelId 	  = request.getParameter("iSelId"); 
	String iTable 	  = request.getParameter("iTable");
	String iColumn    = request.getParameter("iColumn");
	
	/*
	System.out.println("iPid ========================>" + iPid ); 
	System.out.println("iTable =====================>" + iTable );
	System.out.println("iColumn ====================>" + iColumn );
	*/
	 
	ps = con.prepareStatement("SELECT " + iColumn +" FROM " + iTable + " WHERE " + iSelColumn + "= '" + iSelId + "'");
	
	//System.out.println("iColumn ====================>" + "SELECT " + iColumn +" FROM " + iTable + " WHERE PID = " + iPid );
	
	rs = ps.executeQuery();
	if(rs.next())
	{
	    clob = (oracle.sql.CLOB)rs.getClob(1);
	    Reader is = clob.getCharacterStream();
	    System.out.println(is);
	    int c =0;
	    while ((c = is.read()) != -1){
	        buf.append((char)c);
	    }   
	}
	rs.close();
	ps.close();
	con.close();
	//System.out.println("buf ====================>" + buf.toString() );
%>
<%=buf.toString()%>
