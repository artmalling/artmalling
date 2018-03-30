package epro.dao;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

public class EPro106DAO extends AbstractDAO2 {
	/**
	 * <p>약속일자별  조회</p>
	 * 
	 */
	public StringBuffer getMaster(ActionForm form)throws Exception {
		
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strCd		    = String2.nvl(form.getParam("strCd"));	//점코드
            String em_sDate         = String2.nvl(form.getParam("em_sDate"));	//기간 시작일
            String em_eDate	        = String2.nvl(form.getParam("em_eDate"));	//기간 종료일
            String userid			= String2.nvl(form.getParam("userid"));	//사용자
            String strPumbunCd 	    = String2.nvl(form.getParam("strPumbunCd"));	//품번코드 
            String vencd 	    	= String2.nvl(form.getParam("vencd"));	//협력사코드
            
            
            connect("pot");
            
            sql.put(svc.getQuery("SEL_DAY_PROMISS"));
            sql.setString(++i, strCd);   
            sql.setString(++i, em_sDate);
            sql.setString(++i, em_eDate);
            sql.setString(++i, strCd); 
            sql.setString(++i, vencd); 
            sql.setString(++i, strPumbunCd); 
            sql.setString(++i, strCd);   
            sql.setString(++i, em_sDate);
            sql.setString(++i, em_eDate);
            sql.setString(++i, strCd); 
            sql.setString(++i, vencd); 
            sql.setString(++i, strPumbunCd); 
			
			sb = executeQueryByAjax(sql);
			
			
		}catch(Exception e){
			throw e;
		}
		
		return sb;
	}
	
}
