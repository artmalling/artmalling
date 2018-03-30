package esal.dao;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

public class Esal102DAO extends AbstractDAO2 {
	/**
	 * <p>조회</p>
	 * 
	 */
	public StringBuffer getMaster(ActionForm form) throws Exception {
		
		SqlWrapper sql = null;
		Service svc = null;
		StringBuffer sb = null;
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			sb = new  StringBuffer();
			
			String strStrcd = String2.nvl(form.getParam("strStrcd"));			//점코드
			String strVencd = String2.nvl(form.getParam("strVencd"));			//협력사코드
			String strPumbuncd = String2.nvl(form.getParam("strPumbuncd"));		//품번코드
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_DAYPBN"));
			sql.setString(++i, strStrcd);
			sql.setString(++i, strVencd);
			sql.setString(++i, strPumbuncd);
			
			sb = executeQueryByAjax(sql);
			
			
		}catch(Exception e){
			throw e;
		}
		
		
		return sb;
	}
}
