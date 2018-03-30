<%@ page
	import="java.io.*,
			com.gauce.*,
			com.gauce.io.*,
			com.gauce.http.*,
			com.gauce.common.*;" 
	pageEncoding="EUC-KR"
%>
<%	
	HttpGauceResponse gResponse = null;
	GauceOutputStream gos = null;
	try{
		gResponse = ((HttpGauceResponse) response);
		gos = gResponse.getGauceOutputStream();
		GauceDataSet dSet1 = new GauceDataSet("gauce");		
		gos.fragment(dSet1, 40);
		java.io.FileInputStream is = new java.io.FileInputStream(pageContext.getServletContext().getRealPath("gauce51/treeview.dat"));
    String[][] values = com.gauce.common.CommonUtil.loadCSV(is);
    int count = values.length;
		for(int i=0; i<count; i++) {
			dSet1.put("lev", values[i][0], 20);
			dSet1.put("root", values[i][1], 30);
			dSet1.put("text", values[i][2], 30);
			dSet1.put("type", values[i][3], 30);
			dSet1.put("seq", values[i][4], 5);
			dSet1.heap();		
		}
		gos.write(dSet1);
	} catch(Exception e) {
		if (gResponse != null && gos != null) {
			gResponse.addException(e);
		} else {
			e.printStackTrace();
		}
	} finally {
		if (gos != null) {
			try { 
				gos.close();
			} catch(IOException ioe) {
				gos = null;
			}
		}	
	}		
%>
