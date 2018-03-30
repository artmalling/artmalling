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
	HttpGauceRequest gRequest = null;
	GauceOutputStream gos = null;
	GauceInputStream gis = null;
	try{
		gResponse = ((HttpGauceResponse) response);
		gRequest = ((HttpGauceRequest) request);
		gos = gResponse.getGauceOutputStream();
		gis = gRequest.getGauceInputStream();
		GauceDataSet dSet1 = gis.read("USER");				
		gos.fragment(dSet1, 40);
		dSet1.addDataColumn(new GauceDataColumn("empno",GauceDataColumn.TB_INT , 5));
		dSet1.addDataColumn(new GauceDataColumn("ename",GauceDataColumn.TB_STRING , 10));
		dSet1.addDataColumn(new GauceDataColumn("job",GauceDataColumn.TB_STRING , 20));
		dSet1.addDataColumn(new GauceDataColumn("mgr",GauceDataColumn.TB_INT , 5));
		dSet1.addDataColumn(new GauceDataColumn("sal",GauceDataColumn.TB_INT , 10));
		dSet1.addDataColumn(new GauceDataColumn("comm",GauceDataColumn.TB_DECIMAL , 10,3));
		dSet1.addDataColumn(new GauceDataColumn("deptno",GauceDataColumn.TB_INT , 10));
		int count = 10;
		for(int i=0; i<count; i++) {
			GauceDataRow row = dSet1.newDataRow();
			row.addColumnValue(i);
			row.addColumnValue("지영");
			row.addColumnValue("DEVELOPER");
			row.addColumnValue(757 + i);
			row.addColumnValue(8462 + i);
			row.addColumnValue(100.3*i);
			row.addColumnValue(8512 - i);
			dSet1.addDataRow(row);
		}
		
		GauceDataSet dSet2 = gis.read("GROUP");		
		gos.fragment(dSet2, 40);
		dSet2.addDataColumn(new GauceDataColumn("deptno",GauceDataColumn.TB_INT , 5));
		dSet2.addDataColumn(new GauceDataColumn("dname",GauceDataColumn.TB_STRING , 10));
		dSet2.addDataColumn(new GauceDataColumn("loc",GauceDataColumn.TB_STRING , 20));
		for(int i=0; i<count; i++) {
			GauceDataRow  row = dSet2.newDataRow();
			row.addColumnValue(i);
			row.addColumnValue("김정훈");
			row.addColumnValue("DEVELOPER");
			dSet2.addDataRow(row);	
		}			
		gos.write(dSet1);	
		gos.write(dSet2);	
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
