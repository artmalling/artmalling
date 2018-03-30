
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
		GauceDataSet dSet1 = new GauceDataSet("tbds_list");		
		gos.fragment(dSet1, 40);
		dSet1.addDataColumn(new GauceDataColumn("deptnm", GauceDataColumn.TB_STRING, 20));
		dSet1.addDataColumn(new GauceDataColumn("year", GauceDataColumn.TB_STRING, 8));
		dSet1.addDataColumn(new GauceDataColumn("amt1", GauceDataColumn.TB_INT, 15));
		dSet1.addDataColumn(new GauceDataColumn("amt2", GauceDataColumn.TB_INT, 15));
		java.util.Date d = new java.util.Date();
		int count = 5;
		for(int i=0; i<count; i++) {
			GauceDataRow row = dSet1.newDataRow();
			row.addColumnValue("솔루션개발팀");
			row.addColumnValue(d);
			row.addColumnValue(100000 + (i * 100));
			row.addColumnValue(300000 + (i * 10));
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
