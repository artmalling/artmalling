
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
		String[] names = {"김형준", "이장환", "이진호", "최형준", "김경식", "김영훈", "이미숙", "이선미", "정민기", "정병호"};
		dSet1.addDataColumn(new GauceDataColumn("sabun",GauceDataColumn.TB_STRING , 10));
		dSet1.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING , 20));
		dSet1.addDataColumn(new GauceDataColumn("amt1",GauceDataColumn.TB_INT , 15));
		dSet1.addDataColumn(new GauceDataColumn("amt2",GauceDataColumn.TB_INT , 15));
		dSet1.addDataColumn(new GauceDataColumn("chk",GauceDataColumn.TB_STRING , 15));
		dSet1.addDataColumn(new GauceDataColumn("gubun",GauceDataColumn.TB_STRING , 15));
		
		int count = names.length;
		for(int i=0; i<count; i++) {
			GauceDataRow row = dSet1.newDataRow();
	        row.addColumnValue("1000"+ i);
	        row.addColumnValue(names[i]);
	        row.addColumnValue(100000 + (i * 100));
	        row.addColumnValue(300000 + (i * 10));
			String check_value = "F";
			int gubun_value = i % 2;
			if(gubun_value == 0) check_value = "T";
			row.addColumnValue(check_value);
		    row.addColumnValue("Korea");
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
