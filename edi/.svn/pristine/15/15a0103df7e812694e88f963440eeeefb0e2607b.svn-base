package epay.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

public class Epay103DAO extends AbstractDAO2{
	public StringBuffer getMaster(ActionForm form) throws Exception {
		StringBuffer sb = null;
		int i = 0;
		SqlWrapper sql = null;
		Service svc = null;
		
		try{
			sb = new StringBuffer();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strStrcd = String2.nvl(form.getParam("strcd"));   			//점코드
			String strVencd = String2.nvl(form.getParam("vencd"));				//협력사코드
			String strBizType = String2.nvl(form.getParam("bizType"));			//거래형태 
			String sDate = String2.nvl(form.getParam("sDate"));					//시작월
			connect("pot");
			if( "0".equals(strBizType) || "1".equals(strBizType) ||  "4".equals(strBizType) || "5".equals(strBizType) ){			//거래형태 1,4,5 (직매입)
		        sql.put(svc.getQuery("SEL_BILL1"));
			} else if( "2".equals(strBizType) ){					//특정매입(2)
				sql.put(svc.getQuery("SEL_BILL2"));
			} else if( "3".equals(strBizType) ){					//임대을(3)
				sql.put(svc.getQuery("SEL_BILL3"));
			}
			sql.setString(++i, strStrcd);
			sql.setString(++i, sDate);
			sql.setString(++i, strVencd);
			
			sb = executeQueryByAjax(sql);
			
		}catch(Exception e){
			throw e;
		}
		
		return sb;
	}
}
