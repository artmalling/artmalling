<%@ page import=	"java.io.*,
					java.util.*,
					com.gauce.*,
					com.gauce.http.*,
					com.gauce.io.*;"
	contentType="text/html;charset=EUC-KR" 					
%><%	
	HttpGauceRequest gRequest = null;
	HttpGauceResponse gResponse = null;
	GauceInputStream gis = null;
	GauceOutputStream gos = null;
	try {
		gRequest = ((HttpGauceRequest) request);
		gResponse = ((HttpGauceResponse) response);
		StringBuffer sb = new StringBuffer("");
		sb.append("[Parameters]\n");
		Enumeration eParam = gRequest.getParameterNames();
		while (eParam.hasMoreElements()) {
			String key = (String) eParam.nextElement();
			sb.append("parameter-name: " + key + ", parameter-value: " + gRequest.getParameter(key) + "\n");
		}
		sb.append("\n");
		
		gis = gRequest.getGauceInputStream();
		gos = gResponse.getGauceOutputStream();
		
		GauceDataSet[] inSet = gis.readAll();
		for(int i=0; i<inSet.length; i++) {
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
			sb.append("\n");
		}		
		
		GauceDataSet[] outSet = gis.readAllOutput();
		for(int i=0; i<outSet.length; i++) {
			sb.append("[OUTPUT GauceDataSet-name: " + outSet[i].getName() + "]\n");
			GauceDataColumn[] cols = outSet[i].getDataColumns();
			for (int k = 0; k < cols.length; k++) {
				sb.append("col[" + k + "]-name: " + cols[k].getColName() + ", col[" + k + "]-type: " + cols[k].getColType() + "\n");
			}
			sb.append("\n");
		}		
		gResponse.addMessage(sb.toString());
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