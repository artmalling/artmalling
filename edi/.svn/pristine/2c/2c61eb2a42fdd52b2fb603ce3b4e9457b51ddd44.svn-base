package eord.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

public class EOrd104DAO extends AbstractDAO2{
public StringBuffer getMaster(ActionForm form) throws Exception {
		
		List list = null;
		StringBuffer sb = new StringBuffer();
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		String query = "";
		
		try{
			sql = new SqlWrapper();
			svc = (Service)form.getService();
			
			String strStrcd = String2.nvl(form.getParam("strStrcd"));					//점코드
			String strVencd = String2.nvl(form.getParam("strVencd"));				//협력사코드
			String strPumbuncd = String2.nvl(form.getParam("strPumbuncd"));			//품번코드
			String strSlipFlag = String2.nvl(form.getParam("strSlipFlag"));		//전표구분
			String strShGb = String2.nvl(form.getParam("strShGb"));				//조회구분
			String sDate = String2.nvl(form.getParam("sDate"));					//시작일
			String eDate = String2.nvl(form.getParam("eDate"));					//종료일
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_MASTER"));
			sql.setString(++i, strStrcd);
			sql.setString(++i, strVencd);
			sql.setString(++i, strPumbuncd);
			sql.setString(++i, strSlipFlag);
			
			if( "1".equals(strShGb)) {			//발주확정일
				sql.put(svc.getQuery("SEL_ORD_DT"));
				sql.setString(++i, sDate);
				sql.setString(++i, eDate);
			} else if( "2".equals(strShGb) ) {	//검품확정일
				sql.put(svc.getQuery("SEL_CHK_DT"));
				sql.setString(++i, sDate);
				sql.setString(++i, eDate);
			}
			sql.put(svc.getQuery("SEL_ORDERBY"));
			
			
			sb = executeQueryByAjax(sql);
			
		}catch(Exception e){
			throw e;
		}
		
		
		return sb;
	} 



public StringBuffer getDetail(ActionForm form) throws Exception {
	
	List list = null;
	StringBuffer sb = new StringBuffer();
	SqlWrapper sql = null;
	Service svc = null;
	int i = 0;
	String query = "";
	
	try{
		sql = new SqlWrapper();
		svc = (Service)form.getService();
		
		String strStrcd = String2.nvl(form.getParam("strcd"));					//점코드
		String strSlipNo = String2.nvl(form.getParam("slipNo"));				//전표번호
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_DETAIL"));
		sql.setString(++i, strStrcd);
		sql.setString(++i, strSlipNo);
		
		
		sb = executeQueryByAjax(sql);
		
	}catch(Exception e){
		throw e;
	}
	
	return sb;
} 


}
