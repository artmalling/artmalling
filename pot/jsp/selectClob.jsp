<%@ page language="java" contentType="text/html;charset=utf-8" 
    import="java.sql.*,java.io.*,oracle.sql.*,oracle.jdbc.driver.*"   %>
<%
	request.setCharacterEncoding("utf-8");
	//response.setContentType("text/html; charset=utf-8");

	CLOB clob = null;
	StringBuffer buf = new StringBuffer();
	
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	try {
		
		//데이터베이스 연결
		Class.forName("jeus.jdbc.pool.Driver");
		con = DriverManager.getConnection("jdbc:jeus:pool:pot");
		
		con.setAutoCommit(false);
		
		String iSelColumn = request.getParameter("iSelColumn"); 
		String iSelId 	  = request.getParameter("iSelId"); 
		String iTable 	  = request.getParameter("iTable");
		String iColumn    = request.getParameter("iColumn");
		
		
		//System.out.println("iPid ========================>" + iPid ); 
		//System.out.println("iTable =====================>" + iTable );
		//System.out.println("iColumn ====================>" + iColumn );
		
		 
		ps = con.prepareStatement("SELECT " + iColumn +" FROM " + iTable + " WHERE " + iSelColumn + "= '" + iSelId + "'");
		
		//System.out.println("iColumn ====================>" + "SELECT " + iColumn +" FROM " + iTable + " WHERE " + iSelColumn + "= '" + iSelId + "'");
		
		rs = ps.executeQuery();
		if(rs.next())
		{
		    clob = (oracle.sql.CLOB)rs.getClob(1);
		    if(clob != null) {
			    Reader is = clob.getCharacterStream();
			    //System.out.println("************** : " + is);
			    int c =0;
			    while ((c = is.read()) != -1){
			        buf.append((char)c);
			    }
		    } else {
		    	buf.append("<br>내용이 존재하지 않습니다.");
		    }
		}
		//System.out.println("buf ====================>" + buf.toString() );
	} catch(Exception e) {
		e.printStackTrace();
		//System.out.println("selectClob.jsp Exception : " + e.toString());
	} finally {
		if(rs != null) rs.close();
		if(ps != null) ps.close();
		if(con != null) con.close();
	}
%>
<%=buf.toString()%>
