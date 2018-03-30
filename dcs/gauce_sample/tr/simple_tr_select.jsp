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
		dSet1.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING , 10));
		dSet1.addDataColumn(new GauceDataColumn("emp_id",GauceDataColumn.TB_INT , 5));
		dSet1.addDataColumn(new GauceDataColumn("emp_code",GauceDataColumn.TB_INT , 5));
		dSet1.addDataColumn(new GauceDataColumn("emp_hiredate",GauceDataColumn.TB_STRING , 8));
		dSet1.addDataColumn(new GauceDataColumn("emp_age",GauceDataColumn.TB_INT , 2));
		dSet1.addDataColumn(new GauceDataColumn("emp_pay",GauceDataColumn.TB_DECIMAL , 10,3));
		java.util.Date d = new java.util.Date();
		int count = 10;
		for(int i=0; i<count; i++) {
			GauceDataRow row = dSet1.newDataRow();
			row.addColumnValue("김지영");
			row.addColumnValue(1000 + i);
			row.addColumnValue(i);
			row.addColumnValue(d);
			row.addColumnValue(27);
			row.addColumnValue(1000.32 * i);
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
