package epay.dao;

import java.util.List;

import ecom.util.Util;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;


public class Epay104DAO extends AbstractDAO{
	public String getMaster(ActionForm form) throws Exception { 
		int i = 0;
		SqlWrapper sql = null;
		Service svc = null;
		List list = null;
		String rtJson = null;
		
		try{ 
			sql = new SqlWrapper();
			svc = (Service) form.getService(); 
			
			String strStrcd = String2.nvl(form.getParam("strStrcd"));   			//점코드
			String strVencd = String2.nvl(form.getParam("strVencd"));				//협력사코드
			String sDate = String2.nvl(form.getParam("sDate"));						//기간FROM 
			String eDate = String2.nvl(form.getParam("eDate"));						//기간TO

			connect("pot");
			
			sql.put(svc.getQuery("SEL_MASTER")); 
			sql.setString(++i, strStrcd);
			sql.setString(++i, strVencd);
			sql.setString(++i, sDate);
			sql.setString(++i, eDate);
			list = select2List(sql);
			
			Util util = new Util(); 
			String	cols= "STR_CD,STR_NM,TAX_ISSUE_DT,TAX_ISSUE_SEQ_NO,TAX_INV_FLAG,ETAX_NO,TAX_STAT";
            		cols += ",TAX_INV_TYPE,SUP_AMT,VAT_AMT,TOT_AMT"; 
			rtJson = util.listToJsonOBJ(list, cols);
			System.out.println(">>>>>>>>>>rtJson  :" + rtJson);
			
		}catch(Exception e){
			throw e;
		}
		
		return rtJson;
	}
}
