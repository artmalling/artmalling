package esal.dao;

import java.util.List;
import ecom.util.Util;



import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

public class Esal112DAO extends AbstractDAO{
	
	
public String getMaster(ActionForm form)throws Exception {
		int i = 0;
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service  svc = null;
		String rtJson = null;
		Util util = new Util();
		List list = null;

		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			String strStrcd = String2.nvl(form.getParam("strcd"));
			String strVencd = String2.nvl(form.getParam("vencd"));
			String strPumbuncd = String2.nvl(form.getParam("pumbunCd"));
			String strCustName = String2.nvl(form.getParam("custname"));
			String strCardNo = String2.nvl(form.getParam("cardno"));
			String sDate = String2.nvl(form.getParam("em_S_Date"));
			String eDate = String2.nvl(form.getParam("em_E_Date"));
			String strSale_S = String2.nvl(form.getParam("strSale_S"));
			String strSale_E = String2.nvl(form.getParam("strSale_E"));
//			String strBirth_S = String2.nvl(form.getParam("strBirth_S"));
//			String strBirth_E = String2.nvl(form.getParam("strBirth_E"));
			String strHomeAddr1 = String2.nvl(form.getParam("strHomeAddr1"));
			String strAge = String2.nvl(form.getParam("strAge"));
			String sexcd = String2.nvl(form.getParam("sexcd"));
			String strPummokcd = String2.nvl(form.getParam("pummokcd"));
			connect("pot");
			
			sql.put(svc.getQuery("SEL_DAYMGPBN1"));
			
			sql.setString(++i, strStrcd);
			sql.setString(++i, strVencd);
			
			sql.setString(++i, sDate);
			sql.setString(++i, eDate);
		
			sql.setString(++i, strPumbuncd);

//			sql.setString(++i, strCustName);
//			sql.setString(++i, strCardNo);
			
			
			if(strCustName != null && !strCustName.equals("")){
				sql.put(svc.getQuery("SEL_DAYMGPBN2"));
				sql.setString(++i, strCustName);
			}
				
				
			//吏��뿭
			if(strCardNo != null && !strCardNo.equals("")){
				sql.put(svc.getQuery("SEL_DAYMGPBN3"));
				sql.setString(++i, strCardNo);				
			}
			
			sql.put(svc.getQuery("SEL_DAYMGPBN4"));
			sql.setString(++i, sexcd);
			
			
			if(strHomeAddr1 != null && !strHomeAddr1.equals("")){
				sql.put(svc.getQuery("SEL_DAYMGPBN5"));
				sql.setString(++i, strHomeAddr1);				
			}
			
			if(strPummokcd != null && !strPummokcd.equals("")){
				sql.put(svc.getQuery("SEL_DAYMGPBN6"));
				sql.setString(++i, strPummokcd);				
			}
			
			if(strSale_S != null && strSale_E != null && !strSale_S.equals("") && !strSale_E.equals("")){
				sql.put(svc.getQuery("SEL_DAYMGPBN7"));
				sql.setString(++i, strSale_S);
				sql.setString(++i, strSale_E);
			}
			
			//�뿰�졊���
			String age1 = "";
			String age2 = "";
			
			if(strAge != null && strAge.equals("01")){
				age1 = "0";
				age2 = "19";
			}else if(strAge != null && strAge.equals("02")){
				age1 = "20";
				age2 = "29";
			}else if(strAge != null && strAge.equals("03")){
				age1 = "30";
				age2 = "39";
			}else if(strAge != null && strAge.equals("04")){
				age1 = "40";
				age2 = "49";
			}else if(strAge != null && strAge.equals("05")){
				age1 = "50";
				age2 = "59";
			}else if(strAge != null && strAge.equals("06")){
				age1 = "60";
				age2 = "69";
			}else if(strAge != null && strAge.equals("07")){
				age1 = "60";
				age2 = "999";
			}else if(strAge != null && strAge.equals("00")){
				age1 = "0";
				age2 = "999";
			}
			if(strAge != null && !strAge.equals("")){
				sql.put(svc.getQuery("SEL_DAYMGPBN8"));
				sql.setString(++i, age1);
				sql.setString(++i, age2);
			}
			
			//�깮�썡	
/*			if(strBirth_S != null && strBirth_E != null && !strBirth_S.equals("00") && !strBirth_E.equals("00")){
				sql.put(svc.getQuery("SEL_DAYMGPBN4"));
				sql.setString(++i, strBirth_S);
				sql.setString(++i, strBirth_E);
			}else{
				sql.put(svc.getQuery("SEL_DAYMGPBN4"));
				sql.setString(++i, "01");
				sql.setString(++i, "12");
			}*/
			
			
			/*sql.put(svc.getQuery("SEL_DAYMGPBN7"));
			sql.setString(++i, sexcd);
			
			sql.put(svc.getQuery("SEL_DAYMGPBN6"));*/
			
			list = select2List(sql);
//			list = util.decryptedStr(list, 5);
//			list = util.decryptedStr(list, 7);
//			list = util.decryptedStr(list, 8);
//			list = util.decryptedStr(list, 9);
			

			String cols = "SALE_DT,CUST_NAME,CUST_AGE,CARDNO,AMT,HOME,SEX_CD,PUMMOK_CD,ITEM_NAME,SALE_QTY";
			rtJson = util.listToJsonOBJ(list, cols);
			}catch(Exception e){
			throw e;
		}return rtJson;
	}

public String getDetail(ActionForm form)throws Exception {
		int i = 0;
		StringBuffer sb = null;
		List list = null;
		Util util = new Util();
		SqlWrapper sql = null;
		Service  svc = null;
		String rtJson = null;
		
		try{
			sql = new SqlWrapper();
			svc = (Service)form.getService();
			
			String sDate = String2.nvl(form.getParam("sDate"));
			String eDate = String2.nvl(form.getParam("eDate"));
			String strStrcd = String2.nvl(form.getParam("strStrcd"));
			String strCustNo = String2.nvl(form.getParam("custno"));
			String strPumbuncd = String2.nvl(form.getParam("strPumbuncd"));
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_DETAIL"));
			
			sql.setString(++i, sDate);
			sql.setString(++i, eDate);
			sql.setString(++i, strStrcd);
			sql.setString(++i, strCustNo);
			sql.setString(++i, strPumbuncd);
			
			System.out.println(sql.toString());
			
			list = select2List(sql);
			
			String cols = "SALE_DT,PUMMOK_CD,PUMMOK_NAME,SALE_QTY,SALE_TOT_AMT";
			rtJson = util.listToJsonOBJ(list, cols);
		}catch(Exception e){
			throw e;
		}
		return rtJson;
	}

	public List getExcel(ActionForm form) throws Exception { 
		int i = 0;
		SqlWrapper sql = null;
		Service svc = null;
		List list = null;
		String rtJson = null;
		Util util = new Util();
		
		try{ 

			sql = new SqlWrapper();
			svc = (Service) form.getService(); 
		
			
			String strStrcd = String2.nvl(form.getParam("strcd"));
			String strVencd = String2.nvl(form.getParam("vencd"));
			String strPumbuncd = String2.nvl(form.getParam("pumbunCd"));
			String strCustName = String2.nvl(form.getParam("custname"));
			String strCardNo = String2.nvl(form.getParam("cardno"));
			String sDate = String2.nvl(form.getParam("em_S_Date"));
			String eDate = String2.nvl(form.getParam("em_E_Date"));
			String strSale_S = String2.nvl(form.getParam("strSale_S"));
			String strSale_E = String2.nvl(form.getParam("strSale_E"));
//			String strBirth_S = String2.nvl(form.getParam("strBirth_S"));
//			String strBirth_E = String2.nvl(form.getParam("strBirth_E"));
			String strHomeAddr1 = String2.nvl(form.getParam("strHomeAddr1"));
			String strAge = String2.nvl(form.getParam("strAge"));
			String sexcd = String2.nvl(form.getParam("sexcd"));
			String strPummokcd = String2.nvl(form.getParam("pummokcd"));
			
/*			String strcd 		= String2.nvl(form.getParam("strcd"));			//점코드
			String strVencd 	= String2.nvl(form.getParam("vencd"));		    //협력사코드
			String strPumbuncd 	= String2.nvl(form.getParam("strPumbuncd"));	//품번코드
			String sDate 		= String2.nvl(form.getParam("sDate"));			//기간FROM 
			String eDate 		= String2.nvl(form.getParam("eDate"));			//기간TO */
			
			connect("pot");
		
			sql.put(svc.getQuery("SEL_MASTER_EXCEL")); 
			sql.setString(++i, strStrcd);
			sql.setString(++i, strVencd);
			
			sql.setString(++i, sDate);
			sql.setString(++i, eDate);
		
			sql.setString(++i, strPumbuncd);
			if(strCustName != null && !strCustName.equals("")){
				sql.put(svc.getQuery("SEL_DAYMGPBN2"));
				sql.setString(++i, strCustName);
			}
			
			if(strCardNo != null && !strCardNo.equals("")){
				sql.put(svc.getQuery("SEL_DAYMGPBN3"));
				sql.setString(++i, strCardNo);				
			}
			
			sql.put(svc.getQuery("SEL_DAYMGPBN4"));
			sql.setString(++i, sexcd);
			
			
			if(strHomeAddr1 != null && !strHomeAddr1.equals("")){
				sql.put(svc.getQuery("SEL_DAYMGPBN5"));
				sql.setString(++i, strHomeAddr1);				
			}
			
			if(strPummokcd != null && !strPummokcd.equals("")){
				sql.put(svc.getQuery("SEL_DAYMGPBN6"));
				sql.setString(++i, strPummokcd);				
			}
			
			if(strSale_S != null && strSale_E != null && !strSale_S.equals("") && !strSale_E.equals("")){
				sql.put(svc.getQuery("SEL_DAYMGPBN7"));
				sql.setString(++i, strSale_S);
				sql.setString(++i, strSale_E);
			}
			String age1 = "";
			String age2 = "";
			
			if(strAge != null && strAge.equals("01")){
				age1 = "0";
				age2 = "19";
			}else if(strAge != null && strAge.equals("02")){
				age1 = "20";
				age2 = "29";
			}else if(strAge != null && strAge.equals("03")){
				age1 = "30";
				age2 = "39";
			}else if(strAge != null && strAge.equals("04")){
				age1 = "40";
				age2 = "49";
			}else if(strAge != null && strAge.equals("05")){
				age1 = "50";
				age2 = "59";
			}else if(strAge != null && strAge.equals("06")){
				age1 = "60";
				age2 = "69";
			}else if(strAge != null && strAge.equals("07")){
				age1 = "60";
				age2 = "999";
			}else if(strAge != null && strAge.equals("00")){
				age1 = "0";
				age2 = "999";
			}
			if(strAge != null && !strAge.equals("")){
				sql.put(svc.getQuery("SEL_DAYMGPBN8"));
				sql.setString(++i, age1);
				sql.setString(++i, age2);
			}
			
			
			/*sql.setString(++i, strcd);
			sql.setString(++i, sDate);
			sql.setString(++i, eDate);
			sql.setString(++i, strVencd);
			sql.setString(++i, strPumbuncd);*/
			list = select2List(sql);
		
		}catch(Exception e){
			throw e;
		}
	
		return list;
	}
}
