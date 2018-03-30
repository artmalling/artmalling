package ccom.dao;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import kr.fujitsu.ffw.control.cfg.svc.Service;

public class CCom002DAO extends AbstractDAO2{
	
	public StringBuffer getOldAddr(ActionForm form) throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		String query = "";
		int i = 0;
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			sb = new StringBuffer();
			connect("pot");
			sql.put(svc.getQuery("SEL_OLD_ADDR"));
			sql.setString(++i, form.getParam("search"));
			sb = executeQueryByAjax(sql);
		}catch(Exception e){
			throw e;
		}
		return sb;
	}
	
}

