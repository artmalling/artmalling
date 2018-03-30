
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
		GauceDataSet dSet1 = new GauceDataSet("ds_master");
		gos.fragment(dSet1, 40);
		dSet1.addDataColumn(new GauceDataColumn("DEPTCD", GauceDataColumn.TB_STRING, 10));
		dSet1.addDataColumn(new GauceDataColumn("DEPTNM", GauceDataColumn.TB_STRING, 20));
		dSet1.addDataColumn(new GauceDataColumn("EMPNUM", GauceDataColumn.TB_INT, 5));
		dSet1.addDataColumn(new GauceDataColumn("DESCRIPTION", GauceDataColumn.TB_STRING, 20));
	    String param_deptcd= request.getParameter("DEPTCD");
		int count = 5;
		for(int i=0; i<count; i++) {
			GauceDataRow row = dSet1.newDataRow();
		    row.addColumnValue("10000" + i);
		    row.addColumnValue("SHIFT");
		    row.addColumnValue(i);
		    row.addColumnValue("부서"+ i);
		    dSet1.addDataRow(row);	
		}
		gos.write(dSet1);				
		gResponse.addMessage(count + "건 조회 성공입니다!");
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
