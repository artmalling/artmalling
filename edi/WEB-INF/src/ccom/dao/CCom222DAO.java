package ccom.dao;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

public class CCom222DAO extends AbstractDAO2{
	      
public StringBuffer getPmkSrtBlur(ActionForm form) throws Exception {
	
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
		//String strPummokCd = String2.nvl(form.getParam("strPummokCd"));
		String strPmkSrtcd       = String2.nvl(form.getParam("strPmkSrtcd"));
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_PMKSRT_SALE_PRC"));
		sql.setString(1, strPumbuncd);
		
		if( !"".equals(strPmkSrtcd) ){
			sql.put(svc.getQuery("SEL_PBNPMKSRT_WHERE_PMKSRT_CD"));
			sql.setString(2, strPmkSrtcd);
		}
		sql.put(svc.getQuery("SEL_PBNPMKSRT_ORDER"));
		
		sb = executeQueryByAjax(sql);
		
	}catch(Exception e){
		throw e;
	}
	
	return sb;
}
 
public StringBuffer getPmkSrt(ActionForm form) throws Exception {
	
	StringBuffer sb = null;
	SqlWrapper sql = null;
	Service svc = null;
	String query = "";
	int i = 0;
	
	try{
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		sb = new StringBuffer();
		
		String strPumbunCd       = String2.nvl(form.getParam("pumbunCd"));
		String strPmkSrtcd       = String2.nvl(form.getParam("strPmkSrtcd"));
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_PBNPMKSRT"));
		sql.setString(++i,strPumbunCd);
		
		if( !"".equals(strPmkSrtcd) ){
			sql.put(svc.getQuery("SEL_PBNPMKSRT_WHERE_PMKSRT_CD"));
			sql.setString(++i, strPmkSrtcd);
		}
		
		sql.put(svc.getQuery("SEL_PBNPMKSRT_ORDER"));		
		
		
		sb = executeQueryByAjax(sql);
		
	}catch(Exception e){
		throw e;
	}
	
	return sb;
}

}

