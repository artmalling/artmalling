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
		dSet1.addDataColumn(new GauceDataColumn("zip_code", GauceDataColumn.TB_INT, 8));
		dSet1.addDataColumn(new GauceDataColumn("province", GauceDataColumn.TB_STRING, 15));
		dSet1.addDataColumn(new GauceDataColumn("city", GauceDataColumn.TB_STRING, 10));
		dSet1.addDataColumn(new GauceDataColumn("town", GauceDataColumn.TB_STRING, 50));
		dSet1.addDataColumn(new GauceDataColumn("numtest", GauceDataColumn.TB_INT, 5));
		dSet1.addDataColumn(new GauceDataColumn("dec", GauceDataColumn.TB_DECIMAL, 10,3));
		int count = 2000;
		for(int i=0; i<count; i++) {
			GauceDataRow row = dSet1.newDataRow();
			row.addColumnValue((1000 + i));
			row.addColumnValue("가우스");
			row.addColumnValue("shift");
			row.addColumnValue("Town");
			row.addColumnValue(i);
			row.addColumnValue(0.11 * i);
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
