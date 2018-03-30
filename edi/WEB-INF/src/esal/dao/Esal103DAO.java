package esal.dao;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

public class Esal103DAO extends AbstractDAO2{
	
	public StringBuffer getMaster(ActionForm form) throws Exception{
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			sb = new  StringBuffer();
			
			String strStrcd = String2.nvl(form.getParam("strcd"));				//점코드
			String strVencd = String2.nvl(form.getParam("vencd"));				//협력사코드
			String strPumbun = String2.nvl(form.getParam("pumben"));			//품번코드
			String sDate = String2.nvl(form.getParam("sDate"));					//시작일
			String eDate = String2.nvl(form.getParam("eDate"));					//종료일
			String strHsgbn = String2.nvl(form.getParam("strHsgbn"));	//품번코드
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_DAYMGPBN"));
			sql.setString(++i, strStrcd);
			sql.setString(++i, strPumbun);
			sql.setString(++i, strVencd);
			sql.setString(++i, sDate);
			sql.setString(++i, eDate);
			sql.setString(++i, strHsgbn);
			
			sb = executeQueryByAjax(sql);
			
			
			
		}catch(Exception e){
			throw e;
		}
		
		return sb;
	}
	
	public StringBuffer getMarginFlag(ActionForm form) throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;		
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			sb = new StringBuffer();
			
			String strcd = String2.nvl(form.getParam("strcd"));		//점코드
			String pumbuncd = String2.nvl(form.getParam("pumbuncd"));	//품번코드
			String strMarginSdt = String2.nvl(form.getParam("strMarginSdt")).trim().replaceAll("/", "");	//기간FROM
			String strMarginEdt = String2.nvl(form.getParam("strMarginEdt")).trim().replaceAll("/", "");	//기간TO
			
			
			System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
			connect("pot"); 
			
			sql.put(svc.getQuery("SEL_MARGIN_FLAG"));
			sql.setString(++i, strcd);
			sql.setString(++i, pumbuncd);
			sql.setString(++i, strMarginSdt);
			sql.setString(++i, strMarginEdt);
			
			sb = executeQueryByAjax(sql);
			
		}catch(Exception e){
			throw e;
		}
		return sb;
	}
}
