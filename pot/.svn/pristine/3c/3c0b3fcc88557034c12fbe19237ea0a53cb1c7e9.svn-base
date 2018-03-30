
<%@ page
	import="java.io.*,
			com.gauce.*,
			com.gauce.io.*,
			com.gauce.http.*,
			com.gauce.common.*;" 
	pageEncoding="EUC-KR"
%>
<%	
	GauceOutputStream gos = ((HttpGauceResponse) response).getGauceOutputStream();
	GauceDataSet dSet1 = new GauceDataSet("detail_grid");		
	gos.fragment(dSet1, 40);
	dSet1.addDataColumn(new GauceDataColumn("DEPTCD", GauceDataColumn.TB_STRING, 10));
	dSet1.addDataColumn(new GauceDataColumn("EMPNO", GauceDataColumn.TB_STRING, 10));
	dSet1.addDataColumn(new GauceDataColumn("EMPNM", GauceDataColumn.TB_STRING, 10));
	dSet1.addDataColumn(new GauceDataColumn("POSITION", GauceDataColumn.TB_STRING, 20));
	dSet1.addDataColumn(new GauceDataColumn("TELNO", GauceDataColumn.TB_STRING, 10));
	dSet1.addDataColumn(new GauceDataColumn("EMAIL", GauceDataColumn.TB_STRING, 20));
	String DEPTCD = request.getParameter("DEPTCD");
		for(int i=0; i<5; i++) {
			GauceDataRow row = dSet1.newDataRow();
			row.setString(0, DEPTCD);
		    row.setString(1, "10000"+ i);
		    row.setString(2, "È«±æµ¿"+i);
		    row.setString(3, "»ç¿ø");
			row.setString(4, "123-1234");
			row.setString(5, "test@shift.com");
		    dSet1.addDataRow(row);		
		}
		gos.write(dSet1);				
		
%>
