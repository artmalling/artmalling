package ccom.dao;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

public class CCom010DAO extends AbstractDAO2{
	      
public StringBuffer getPummokBlur(ActionForm form) throws Exception {
	
	StringBuffer sb = null;
	SqlWrapper sql = null;
	Service svc = null;
	String query = "";
	int i = 0;
	
	try{
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		sb = new StringBuffer();
		
		String strPumbuncd = String2.nvl(form.getParam("strPumbuncd"));
		String strPummokCd = String2.nvl(form.getParam("strPummokCd"));
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_SKU_SALE_PRC"));
		sql.setString(1, strPumbuncd);
		sql.setString(2, strPummokCd);
		
		sb = executeQueryByAjax(sql);
		
	}catch(Exception e){
		throw e;
	}
	
	return sb;
}
 
public StringBuffer getPummok(ActionForm form) throws Exception {
	
	StringBuffer sb = null;
	SqlWrapper sql = null;
	Service svc = null;
	String query = "";
	int i = 0;
	
	try{
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		sb = new StringBuffer();
		
		String strPummokcd          = String2.nvl(form.getParam("strPummokcd"));
		String strPumbunCd       = String2.nvl(form.getParam("pumbunCd"));
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_PBNPMK"));
		sql.setString(++i,strPumbunCd);
		
		if( !"".equals(strPummokcd) ){
			sql.put(svc.getQuery("SEL_PBNPMK_WHERE_PUMMOK_CD"));
			sql.setString(++i, strPummokcd);
		}
		
		sql.put(svc.getQuery("SEL_PBNPMK_ORDER"));		
		
		
		sb = executeQueryByAjax(sql);
		
	}catch(Exception e){
		throw e;
	}
	
	return sb;
}
 
}

