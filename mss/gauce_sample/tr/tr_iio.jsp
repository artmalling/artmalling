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
		StringBuffer sb = new StringBuffer("");
		
		GauceDataSet[] inSet = gis.readAll();
		for(int i=0; i<inSet.length; i++) {
			if((inSet[i].getName()).equals("USERLIST")) {
				GauceDataSet dSet1 = gis.read("USERLIST");
				gos.fragment(dSet1, 40);	
				dSet1.addDataColumn(new GauceDataColumn("empno",GauceDataColumn.TB_INT , 5));
				dSet1.addDataColumn(new GauceDataColumn("ename",GauceDataColumn.TB_STRING , 10));
				dSet1.addDataColumn(new GauceDataColumn("job",GauceDataColumn.TB_STRING , 20));
				dSet1.addDataColumn(new GauceDataColumn("mgr",GauceDataColumn.TB_INT , 5));
				dSet1.addDataColumn(new GauceDataColumn("sal",GauceDataColumn.TB_INT , 10));
				dSet1.addDataColumn(new GauceDataColumn("comm",GauceDataColumn.TB_DECIMAL , 10,3));
				dSet1.addDataColumn(new GauceDataColumn("deptno",GauceDataColumn.TB_INT , 10));
				java.util.Date d = new java.util.Date();
				int count = 10;
				for(int j=0; j<count; j++) {
					GauceDataRow row = dSet1.newDataRow();
					row.addColumnValue(i);
					row.addColumnValue("������");
					row.addColumnValue("DEVELOPER");
					row.addColumnValue(757 + i);
					row.addColumnValue(8462 + i);
					row.addColumnValue(100.3*i);
					row.addColumnValue(8512 - i);
					dSet1.addDataRow(row);	
				}
				gos.write(dSet1);						
			} else {
				sb.append("[INPUT GauceDataSet-name: " + inSet[i].getName() + "]\n");
				GauceDataRow[] rows = inSet[i].getDataRows();
				GauceDataColumn[] cols = inSet[i].getDataColumns();
				for (int j = 0; j < rows.length; j++) {
					if (rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT)
						sb.append("========== insert ==========\n");
					else if (rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE)
						sb.append("========== update ==========\n");
					else if (rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE)
						sb.append("========== delete ==========\n");					
					for (int k = 0; k < cols.length; k++) {
						sb.append("row[" + j + "]-> " + "col[" + k + "]-name:" + cols[k].getColName() + ", col[" + k + "]-value: " + rows[j].getColumnValue(k) + "\n");
					}
				}
			}
			sb.append("\n");
		}
		gResponse.addMessage(sb.toString());
		//gResponse.addMessage(count + "�� ��ȸ �����Դϴ�!");
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
