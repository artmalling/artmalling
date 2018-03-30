package epro.dao;

import java.util.List;

import ecom.util.Util;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;


public class EPro102DAO extends AbstractDAO {
	
	// MASTER조회	
    public String getMaster(ActionForm form) throws Exception {
		int i = 0;
		SqlWrapper sql = null;
		Service svc = null;
		List list = null;
		String rtJson = null;
		String strQuery = "";
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strStrcd 	= String2.nvl(form.getParam("strStrcd"));
			String strPumbun 	= String2.nvl(form.getParam("strPumbun"));
			String strGbn 		= String2.nvl(form.getParam("strGbn"));
			String sDate 		= String2.nvl(form.getParam("sDate"));
			String eDate 		= String2.nvl(form.getParam("eDate"));
			String strcustomnm 	= String2.nvl(form.getParam("strcustomnm"));
			String strpromise 	= String2.nvl(form.getParam("strpromise")); 
			String vencd 	= String2.nvl(form.getParam("vencd")); 
			
			connect("pot");
			sql.setString(++i, strStrcd);
			sql.setString(++i, strStrcd);
			sql.setString(++i, vencd);
			sql.setString(++i, strPumbun);
			sql.setString(++i, strcustomnm);
			sql.setString(++i, strpromise);
			 
			strQuery = svc.getQuery("SEL_MASTER") + "\n"; 
			sql.put(strQuery);
			
			if(strGbn.equals("01")) { 
				strQuery = svc.getQuery("SEL_MASTER_DT_01") + "\n";
				sql.put(strQuery);
				sql.setString(++i, sDate);
				sql.setString(++i, eDate);
			}
			else if(strGbn.equals("02")) {
				strQuery = svc.getQuery("SEL_MASTER_DT_02") + "\n";
				sql.put(strQuery); 
				sql.setString(++i, sDate);
				sql.setString(++i, eDate); 
			}
			else { 
				strQuery = svc.getQuery("SEL_MASTER_DT_03") + "\n";
				sql.put(strQuery);
				sql.setString(++i, sDate);
				sql.setString(++i, eDate); 
			} 
			
			strQuery = svc.getQuery("SEL_ORDERBY") + "\n";
			sql.put(strQuery);
			
			list = select2List(sql);
			
			Util util = new Util(); 
			
			String	cols= "STR_CD,STR_NM,TAKE_DT,TAKE_SEQ,PROM_TYPE,CUST_NM"; 
			rtJson = util.listToJsonOBJ(list, cols);
			System.out.println(">>>>>>>>>>rtJson  :" + rtJson);
		}catch(Exception e){
			throw e;
		}
		
		return rtJson;
	}

	// DETAIL조회	
    public String getDetail(ActionForm form) throws Exception {
		int i = 0;
		SqlWrapper sql = null;
		Service svc = null;
		List list = null;
		String rtJson = null;
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService(); 
 
			String strStrCd 	= String2.nvl(form.getParam("strStrCd"));
			String strTakeDt 	= String2.nvl(form.getParam("strTakeDt"));
			String strTakeSeq 	= String2.nvl(form.getParam("strTakeSeq")); 
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_DETAIL"));
			sql.setString(++i, strStrCd);
			sql.setString(++i, strTakeDt);
			sql.setString(++i, strTakeSeq); 
			list = select2List(sql);
			
			Util util = new Util(); 
			String	cols= "MOD_LISE,ORG_PROM,MOD_PROM,MOD_REASON,MOD_TAKE_DT,SEQ_NO"; 
			rtJson = util.listToJsonOBJ(list, cols);
			System.out.println(">>>>>>>>>>rtJson  :" + rtJson);
		}catch(Exception e){
			throw e;
		}
		
		return rtJson;
	}
}
