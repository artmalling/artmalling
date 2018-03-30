package esal.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

public class Esal104DAO extends AbstractDAO2 {
	
	
	public List getPumbunCombo(ActionForm form, String strcd, String vencd) throws Exception {
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		String query = "";
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			
			
			connect("pot");
			
			query = svc.getQuery("SEL_PUMBUNCOMBO") + "\n";
			
			
			
			sql.setString(++i, strcd);
			sql.setString(++i, vencd);
			
						
			sql.put(query);
			
			
			list = executeQuery(sql);
			
		}catch(Exception e){
			throw e;
		}
		
		
		
		return list;
	}
	
	
	public StringBuffer getDaynorevt(ActionForm form) throws Exception {
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		String query = "";
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strStrcd = String2.nvl(form.getParam("strcd"));				//점코드
			String strVencd = String2.nvl(form.getParam("vencd"));				//협력사코드
			String strPumbuncd = String2.nvl(form.getParam("pumbuncd"));		//품번코드
			String selDate = String2.nvl(form.getParam("selDate"));				//조회월
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_DAYNOREVT"));
			sql.setString(++i, strStrcd);
			sql.setString(++i, strVencd);
			sql.setString(++i, strPumbuncd);
			sql.setString(++i, selDate);
			
			sb = executeQueryByAjax(sql);
			
			
			
			
		}catch(Exception e){
			throw e;
		}
		
		return sb;
	}
	
}
