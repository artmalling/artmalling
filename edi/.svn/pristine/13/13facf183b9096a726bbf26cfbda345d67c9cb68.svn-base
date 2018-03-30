package ccom.dao;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import kr.fujitsu.ffw.control.cfg.svc.Service;

public class CCom003DAO extends AbstractDAO2{ 
	
	public StringBuffer getHelpMsg(ActionForm form) throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		String 	strPid 	= null;
		int i = 0;
		try{

			strPid = String2.nvl(form.getParam("strPid"));
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			sb = new StringBuffer();
			 
			connect("pot");
			sql.put(svc.getQuery("SEL_HELPMSG"));

            sql.setString(++i, "jsp/selectClob.jsp?iSelId="+strPid+"&iTable=COM.TC_HELPMSG&iColumn=HELP_MSG&iSelColumn=PID");
			sql.setString(++i, strPid);
			
			sb = executeQueryByAjax(sql);
		}catch(Exception e){
			throw e;
		}
		return sb;
	}
	
}

