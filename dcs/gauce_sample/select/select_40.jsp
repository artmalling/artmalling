<%@ page
	import= "com.gauce.*,
			com.gauce.io.*,
			com.gauce.log.*;" 
	pageEncoding="EUC-KR"
%>
<%	

ServiceLoader loader = new ServiceLoader(request, response);
GauceService service = loader.newService();
GauceContext context = service.getContext();
Logger logger = context.getLogger();
try {
    GauceResponse res = service.getGauceResponse();
    GauceRequest req = service.getGauceRequest();
    
    GauceDataSet dSet = new GauceDataSet();
    res.enableFirstRow(dSet);
    dSet.addDataColumn(new GauceDataColumn("zip_code", GauceDataColumn.TB_STRING, 6));
    dSet.addDataColumn(new GauceDataColumn("province", GauceDataColumn.TB_STRING, 10));
    dSet.addDataColumn(new GauceDataColumn("city", GauceDataColumn.TB_STRING, 10));
    dSet.addDataColumn(new GauceDataColumn("town", GauceDataColumn.TB_STRING, 10));
    dSet.addDataColumn(new GauceDataColumn("numtest", GauceDataColumn.TB_INT, 5));
    dSet.addDataColumn(new GauceDataColumn("dec", GauceDataColumn.TB_DECIMAL, 15,3));
		
		int count = 1000;
    for (int i = 1; i <= count; i++) {
        GauceDataRow row = dSet.newDataRow();
        row.addColumnValue("10000" + i);
        row.addColumnValue("GAUCE");
        row.addColumnValue("사용");
        row.addColumnValue("Town " + i*10);
        row.addColumnValue(i);
        row.addColumnValue(100.3*i);
        dSet.addDataRow(row);
    }

    dSet.flush();
    res.flush();
//    res.writeException("Native", "70000", "오류가 발생하였습니다.");
//    res.commit();
    res.commit(count + "건 조회 성공입니다");
    res.close();
} catch (Exception e) {
    logger.err.println(this, e);
    throw e;
} finally {
    loader.restoreService(service);
}
%>