package esal.dao;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

public class Esal105DAO extends AbstractDAO2 {
	public StringBuffer getMaster(ActionForm form ) throws Exception {
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service)form.getService();
			
			sb = new StringBuffer();
			
			String strStrcd = String2.nvl(form.getParam("strStrcd"));			//점코드
			String strVencd = String2.nvl(form.getParam("strVencd"));			//협력사코드
			String strPumbuncd = String2.nvl(form.getParam("strPumbuncd"));		//품번코드
			String strSdate = String2.nvl(form.getParam("sDate"));			    //일자
			String strBaseFlag = String2.nvl(form.getParam("baseFlag"));		//구분
			
			
			connect("pot");
			
			if( "1".equals(strBaseFlag) ){		//수량
				sql.put(svc.getQuery("SEL_BUY_QTY"));
			} else if( "2".equals(strBaseFlag) ){	//원가
				sql.put(svc.getQuery("SEL_COST"));
			} else if( "3".equals(strBaseFlag) ){	//매가
				sql.put(svc.getQuery("SEL_SALE"));
			}
			sql.setString(++i, strStrcd);
			sql.setString(++i, strStrcd);
			sql.setString(++i, strSdate);
			sql.setString(++i, strStrcd);
			sql.setString(++i, strSdate);
			sql.setString(++i, strSdate);
			sql.setString(++i, strPumbuncd);
			sql.setString(++i, strVencd); 
			
			sb= executeQueryByAjax(sql);
			
			
		}catch(Exception e){
			throw e;
		}
		
		
		return sb;
	}
}
