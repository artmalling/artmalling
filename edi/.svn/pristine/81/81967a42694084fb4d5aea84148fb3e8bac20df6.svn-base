package esal.dao;

import java.net.URLDecoder;
import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

public class Esal101DAO extends AbstractDAO2{
	
	
public StringBuffer getMaster(ActionForm form)throws Exception {
		
		List list = null;
		StringBuffer sb = new StringBuffer();
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service)form.getService();
		
			String strcd = String2.nvl(form.getParam("strcd"));
			String vencd = String2.nvl(form.getParam("vencd"));
			String pumben = String2.nvl(form.getParam("strPumbuncd"));
			String sDate = String2.nvl(form.getParam("sDate"));
			String eDate = String2.nvl(form.getParam("eDate"));
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_DAYMGPBN"));
			
			sql.setString(++i, strcd);
			sql.setString(++i, vencd);
			sql.setString(++i, pumben);
			sql.setString(++i, sDate);
			sql.setString(++i, eDate);
			
			sb = executeQueryByAjax(sql);
			
		}catch(Exception e){
			throw e;
		}
		
		
		return sb;
	}

public StringBuffer getDetail(ActionForm form)throws Exception {
		
		List list = null;
		StringBuffer sb = new StringBuffer();
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service)form.getService();
		
			String strcd = String2.nvl(form.getParam("strcd"));					//점코드
			String strSaleDt = String2.nvl(form.getParam("strSaleDt"));			//매출일자
			String strPumbuncd = String2.nvl(form.getParam("strPumbuncd"));     //품번코드
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_DETAIL"));
			
			sql.setString(++i, strcd);
			sql.setString(++i, strPumbuncd);
			sql.setString(++i, strSaleDt);
			
			sb = executeQueryByAjax(sql);
			
		}catch(Exception e){
			throw e;
		}
		
		return sb;
}
	
	
	
	
}
