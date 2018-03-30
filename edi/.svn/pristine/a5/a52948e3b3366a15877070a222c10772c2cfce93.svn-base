package epro.dao;

import java.util.List;

import ecom.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

public class EPro105DAO extends AbstractDAO2 {
	/**
	 * <p>약속분석 건수 현황 건수 조회</p>
	 * 
	 */
	public StringBuffer getDayPromiss(ActionForm form)throws Exception {
		
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strStrcd = String2.nvl(form.getParam("strcd"));				//점코드
			String strVencd = String2.nvl(form.getParam("vencd")); 				//협력사코드
			String strPumbuncd = String2.nvl(form.getParam("pumbuncd")); 		//품번코드
			String strYYYYMM = String2.nvl(form.getParam("strYYYYMM")); 		//년월 
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_PROMISS"));
			sql.setString(++i, strStrcd);
			sql.setString(++i, strPumbuncd);
			sql.setString(++i, strVencd);
			sql.setString(++i, strYYYYMM);
			sql.setString(++i, strStrcd);
			sql.setString(++i, strPumbuncd);
			sql.setString(++i, strVencd);
			sql.setString(++i, strYYYYMM);
			
			sb = executeQueryByAjax(sql);
			
			
		}catch(Exception e){
			throw e;
		}
		
		return sb;
	}
	
public String getPromissDetail(ActionForm form)throws Exception {
		
		
		//StringBuffer sb = null;
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 0;
		String rtJson = "";
		Util util = new Util();
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strStrcd   = String2.nvl(form.getParam("strcd"));				//점코드
			String strTakeDt  = String2.nvl(form.getParam("take_dt")); 				//접수일자
			String strTakeSeq = String2.nvl(form.getParam("takeSeq")); 				//접수순번
			
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_PROMISSDETAIL"));
			sql.setString(++i, strStrcd);
			sql.setString(++i, strTakeDt);
			sql.setString(++i, strTakeSeq);
			
			list = executeQueryByList(sql);
			
			list = util.decryptedStr(list,11);     //휴대폰 복호화.
			list = util.decryptedStr(list,12);     //휴대폰 복호화.
			list = util.decryptedStr(list,13);     //휴대폰 복호화.
			list = util.decryptedStr(list,14);     //집 전화번호 복호화.
			list = util.decryptedStr(list,15);     //집 전화번호 복호화.
			list = util.decryptedStr(list,16);     //집 전화번호 복호화.
			
			list = util.decryptedStr(list,39);        //택배휴대전화1
			list = util.decryptedStr(list,40);        //택배휴대전화2
			list = util.decryptedStr(list,41);        //택배휴대전화3
			list = util.decryptedStr(list,42);        //택배전화1
			list = util.decryptedStr(list,43);        //택배전화2
			list = util.decryptedStr(list,44);        //택배전화3
			
			String	cols  = "TAKE_DT,STR_CD,STR_NM,TAKE_SEQ,TAKE_USER_ID,TAKE_USER_NM,CUST_NM,POST_NO,CUST_POST_SEQ,ADDR";
            		cols += ",DTL_ADDR,MOBILE_PH1,MOBILE_PH2,MOBILE_PH3,HOME_PH1,HOME_PH2,HOME_PH3";
            		cols += ",FRST_PROM_DT,FRST_PROM_HH,FRST_PROM_MM,LAST_PROM_DT,LAST_PROM_HH,LAST_PROM_MM,PROM_TYPE,PROM_DTL,DELI_TYPE,DELI_STR";
            		cols += ",PUMBUN_CD,PUMBUN_NM,ORG_CD,ORG_NM,SKU_NM,IN_DELI_DT,SMS_YN,COUR_CUST_NM,COUR_POST_NO,COUR_POST_SEQ,COUR_ADDR,COUR_DTL_ADDR";
            		cols += ",COUR_MOBILE_PH1,COUR_MOBILE_PH2,COUR_MOBILE_PH3,COUR_HOME_PH1,COUR_HOME_PH2,COUR_HOME_PH3,COUR_COMP_NM,COUR_SEND_NO,PROC_STAT,PROC_STAT_NM,HAPPY_CALL_YN";

            rtJson = util.listToJsonOBJ(list, cols);
            
		}catch(Exception e){
			throw e;
		}
		
		return rtJson;
	}
	
	
/**
* <p>약속분석 현황 팝업 </p>
* 선택한 일자의 약속건수 상세보기 
 */	
public List listDtl(ActionForm form)throws Exception {
		
		
		StringBuffer sb = null;
		SqlWrapper sql = null;
		Service svc = null;
		List list = null;
		int i = 0;
		
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strStrcd = String2.nvl(form.getParam("strcd"));				//점코드
			String strVencd = String2.nvl(form.getParam("vencd")); 				//협력사코드
			String strPumbuncd = String2.nvl(form.getParam("pumbuncd")); 		//품번코드
			String strDate = String2.nvl(form.getParam("date")); 				//년월일 
			
			System.out.println("strStrcd : " + strStrcd);
			System.out.println("strVencd : " + strVencd);
			System.out.println("strPumbuncd : " + strPumbuncd);
			System.out.println("strDate : " + strDate);
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_PROMISSPOPUP"));
			sql.setString(++i, strStrcd);
			sql.setString(++i, strPumbuncd);
			sql.setString(++i, strVencd);
			sql.setString(++i, strDate);
			sql.setString(++i, strDate);
			
			list = executeQuery(sql);
			
			
		}catch(Exception e){
			throw e;
		}
		
		return list;
	}
	
	
}
