package eren.dao;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

public class Eren102DAO extends AbstractDAO2{
	public StringBuffer getMaster(ActionForm form) throws Exception {
		StringBuffer sb = null;
		int i = 0;
		SqlWrapper sql = null;
		Service svc = null;
		
		try{
			sb = new StringBuffer();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strStrcd = String2.nvl(form.getParam("strcd"));
			String strVencd = String2.nvl(form.getParam("vencd"));
			String sDate = String2.nvl(form.getParam("sDate"));
			String eDate = String2.nvl(form.getParam("eDate"));
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_PAY"));
			sql.setString(++i, strStrcd);
			sql.setString(++i, strVencd);
			sql.setString(++i, sDate);
			sql.setString(++i, eDate);
			
			sb = executeQueryByAjax(sql);
			
		}catch(Exception e){
			throw e;
		}
		
		return sb;
	}
}
