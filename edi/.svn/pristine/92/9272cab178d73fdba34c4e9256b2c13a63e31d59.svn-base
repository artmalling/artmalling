package esal.dao;

import java.util.List;

import ecom.util.Util;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;


public class Esal108DAO extends AbstractDAO{
	public String getMaster(ActionForm form) throws Exception { 
		int i = 0;
		SqlWrapper sql = null;
		Service svc = null;
		List list = null;
		String rtJson = null;
		
		try{ 
			sql = new SqlWrapper();
			svc = (Service) form.getService(); 
  
			String strcd 		= String2.nvl(form.getParam("strcd"));			//점코드
			String strVencd 	= String2.nvl(form.getParam("vencd"));		//협력사코드
			String strPumbuncd 	= String2.nvl(form.getParam("strPumbuncd"));	//품번코드
			String sDate 		= String2.nvl(form.getParam("sDate"));			//기간FROM 
			String eDate 		= String2.nvl(form.getParam("eDate"));			//기간TO

			connect("pot");
			
			sql.put(svc.getQuery("SEL_MASTER")); 
			sql.setString(++i, sDate);
			sql.setString(++i, eDate);
			sql.setString(++i, strcd);
			sql.setString(++i, strPumbuncd);
			sql.setString(++i, strVencd);
			list = select2List(sql);
			
			Util util = new Util(); 
			String	cols= "SALE_DT,POS_NAME,TRAN_CD,SALE_TIME,TRAN_MODE,TRAN_FLAG,AMT,O_POS_NO,O_SALE_DT,O_TRAN_NO";
			rtJson = util.listToJsonOBJ(list, cols);
			System.out.println(">>>>>>>>>>rtJson  :" + rtJson);
			
		}catch(Exception e){
			throw e;
		}
		
		return rtJson;
	}
}
