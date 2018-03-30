<%@ page
	import="java.io.*,
			com.gauce.*,
			com.gauce.io.*,
			com.gauce.http.*,
			com.gauce.common.*;" 
	pageEncoding="euc-kr"
%>
<%	
	HttpGauceResponse iResponse = null;
	GauceOutputStream ios = null;
	try{
		iResponse = ((HttpGauceResponse) response);
		ios = iResponse.getGauceOutputStream();
		GauceDataSet dSet1 = new GauceDataSet("tbds_list");		
		ios.fragment(dSet1, 40);		
		dSet1.addDataColumn(new GauceDataColumn("data_name",GauceDataColumn.TB_STRING , 50));
		String dir = pageContext.getServletContext().getRealPath("gauce/blob.csv");
		FileInputStream is = new FileInputStream(dir);
		String[][] values = CommonUtil.loadCSV(is);
		for (int i = 0; i < values.length; i++) {
    	dSet1.put("data_name", values[i][0], 50); // data_name
    	dSet1.put("data_url", new java.net.URL(values[i][1]), 100); // data_url 
    	dSet1.heap();
		}
	
		ios.write(dSet1);				
		iResponse.addMessage("성공입니다!");
	} catch(Exception e) {
		if (iResponse != null && ios != null) {
			iResponse.addException(e);
		} else {
			e.printStackTrace();
		}
	} finally {
		if (ios != null) {
			try { 
				ios.close();
			} catch(IOException ioe) {
				ios = null;
			}
		}	
	}		
%>
