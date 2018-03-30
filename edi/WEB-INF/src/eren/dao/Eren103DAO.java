package eren.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

public class Eren103DAO extends AbstractDAO2{
public StringBuffer getMaster(ActionForm form) throws Exception {
		
		StringBuffer sb = new StringBuffer();
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		try{
			sql = new SqlWrapper();
			svc = (Service)form.getService();
			
			String strStrcd = String2.nvl(form.getParam("strStrcd"));			//점코드
			String strVencd = String2.nvl(form.getParam("strVencd"));			//협력사코드
			String strGaugType = String2.nvl(form.getParam("strGaugType"));		//계량기 구분
			String sDate = String2.nvl(form.getParam("sDate"));					//시작일
			String eDate = String2.nvl(form.getParam("eDate"));					//종료일
			
			connect("pot");
			sql.put(svc.getQuery("SEL_MASTER"));
			sql.setString(++i, strStrcd);
			sql.setString(++i, sDate);
			sql.setString(++i, eDate);
			sql.setString(++i, strGaugType);
			sql.setString(++i, strVencd);
			sb = executeQueryByAjax(sql);
		}catch(Exception e){
			throw e;
		}
		
		
		return sb;
	} 



public StringBuffer getDetail(ActionForm form) throws Exception {
	
	StringBuffer sb = new StringBuffer();
	SqlWrapper sql = null;
	Service svc = null;
	int i = 0;
	try{
		sql = new SqlWrapper();
		svc = (Service)form.getService();
		
		String strStrcd = String2.nvl(form.getParam("strStrcd"));			//점코드
		String strVencd = String2.nvl(form.getParam("strVencd"));			//협력사코드
		String gaug_id = String2.nvl(form.getParam("gaug_id"));				//계량기 ID
		String sDate = String2.nvl(form.getParam("sDate"));					//시작일
		String eDate = String2.nvl(form.getParam("eDate"));					//종료일
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_DETAIL"));
		sql.setString(++i, strStrcd);
		sql.setString(++i, sDate);
		sql.setString(++i, eDate);
		sql.setString(++i, strVencd);
		sql.setString(++i, gaug_id);
		
		sb = executeQueryByAjax(sql);
	}catch(Exception e){
		throw e;
	}
	
	return sb;
} 


}
