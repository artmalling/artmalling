/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package meis.dao;

import java.util.List;
import java.util.Map;

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>주간 TREND 현황</p>
 * 
 * @created on 1.0, 2011/06/21
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MEis081DAO extends AbstractDAO {

	/**
	 * 주간 매출정보조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchWeeklyTrend(ActionForm form, String strUserId) throws Exception {

		List ret             = null;
		SqlWrapper sql       = null;
		Service svc          = null;
		String strLoc        = null;
		int i                = 1;
		//파라미터 변수선언
		String strStrCd      = null;
		String strSaleDt     = null;
		String strStartDt    = null;
		String strSaleMon    = null;
		String strLstDt      = null;
		String strLstStartDt = null;
		String strLstMon     = null;
		
		try {
			//파라미터 값 가져오기
			strStrCd   = String2.trimToEmpty(form.getParam("strStrCd"));  //점코드
			if("%".equals(strStrCd)){
				strStrCd = "";
			}
			strSaleDt  = String2.trimToEmpty(form.getParam("strSaleDt")); //일자
			strSaleMon = strSaleDt.substring(0, 6);
			strLstMon  = Util.addYear(strSaleMon+"01", -1, "yyyyMM");
			strStartDt = Util.addDay(strSaleDt, -6, "yyyyMMdd");
			if(!strSaleMon.equals(strStartDt.substring(0, 6))){
				strStartDt = strSaleMon +"01";
			}
			strLstDt      = Util.addYear(strSaleDt, -1, "yyyyMMdd");
			strLstStartDt = Util.addYear(strStartDt, -1, "yyyyMMdd");

			strLoc = "SEL_WEEKLY_TREND";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strSaleDt);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strStartDt);
			sql.setString(i++, strSaleDt);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strStartDt);
			sql.setString(i++, strSaleDt);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strLstStartDt);
			sql.setString(i++, strLstDt);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strStartDt);
			sql.setString(i++, strSaleDt);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleMon+"01");
			//sql.setString(i++, strSaleMon+"31");
			sql.setString(i++, strSaleDt);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleMon+"01");
			//sql.setString(i++, strSaleMon+"31");
			sql.setString(i++, strSaleDt);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strLstMon+"01");
			sql.setString(i++, strLstMon+strSaleDt.substring(6, 8));
			//sql.setString(i++, strSaleDt);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleMon+"01");
			//sql.setString(i++, strSaleMon+"31");
			sql.setString(i++, strSaleDt);
			
			connect("pot");
			ret = select2List(sql);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return ret;
	}
	
	/**
	 * 주간 매출정보조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public String searchWeeklySaleTrend(ActionForm form, String strUserId) throws Exception {

		List list            = null;
		Map  map             = null;
		SqlWrapper sql       = null;
		Service svc          = null;
		String strLoc        = null;
		int i                = 1;
		//파라미터 변수선언
		String strStrCd      = null;
		String strSaleDt     = null;
		String strStartDt    = null;
		String strSaleMon    = null;
		String strLstDt      = null;
		String strLstStartDt = null;
		String strRtn        = null;
		
		try {
			strRtn = "";
			//파라미터 값 가져오기
			strStrCd   = String2.trimToEmpty(form.getParam("strStrCd"));  //점코드
			strSaleDt  = String2.trimToEmpty(form.getParam("strSaleDt")); //일자
			strSaleMon = strSaleDt.substring(0, 6);
			strStartDt = Util.addDay(strSaleDt, -6, "yyyyMMdd");
			if(!strSaleMon.equals(strStartDt.substring(0, 6))){
				strStartDt = strSaleMon +"01";
			}
			strLstDt      = Util.addYear(strSaleDt, -1, "yyyyMMdd");
			strLstStartDt = Util.addYear(strStartDt, -1, "yyyyMMdd");

			strLoc = "SEL_WEEKLY_SALE_TREND";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strStartDt);
			sql.setString(i++, strSaleDt);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strStartDt);
			sql.setString(i++, strSaleDt);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strStartDt);
			sql.setString(i++, strSaleDt);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strLstStartDt);
			sql.setString(i++, strLstDt);
			
			connect("pot");
			list = select(sql);
			
			strRtn += "<?xml version=\"1.0\" encoding=\"euc-kr\"?>\n";
			strRtn += "  <CHARTFX>\n";
			
			for(int x=0; x < list.size() ; x++){
				map = (Map) list.get(x);
				if(x==0){
					strRtn += "    <COLUMNS>\n";
					strRtn += "      <COLUMN NAME=\"SALE_DT\"          TYPE=\"String\"/>\n";
					strRtn += "      <COLUMN NAME=\"TOT_SALE_AMT\"     TYPE=\"Integer\" DESCRIPTION=\"실적\"/>\n";
					strRtn += "      <COLUMN NAME=\"ORIGIN_SALE_TAMT\" TYPE=\"Integer\" DESCRIPTION=\"계획\"/>\n";
					strRtn += "      <COLUMN NAME=\"LST_SALE_AMT\"     TYPE=\"Integer\" DESCRIPTION=\"전년실적\"/>\n";
					strRtn += "    </COLUMNS>\n";
				}
				strRtn += "    <ROW SALE_DT=\""+ map.get("SALE_DT").toString() 
				                               + "\" TOT_SALE_AMT=\"" + map.get("TOT_SALE_AMT").toString() 
				                               + "\" ORIGIN_SALE_TAMT=\"" + map.get("ORIGIN_SALE_TAMT").toString() 
				                               + "\" LST_SALE_AMT=\"" + map.get("LST_SALE_AMT").toString() +"\"/>\n";
			}
			strRtn += "  </CHARTFX>";
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return strRtn;
	}
	
	/**
	 * 객수/객단가추이
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public String searchWeeklyCustomInfo(ActionForm form, String strUserId) throws Exception {

		List list            = null;
		Map  map             = null;
		SqlWrapper sql       = null;
		Service svc          = null;
		String strLoc        = null;
		int i                = 1;
		//파라미터 변수선언
		String strStrCd      = null;
		String strSaleDt     = null;
		String strStartDt    = null;
		String strSaleMon    = null;
		String strRtn        = null;
		
		try {
			strRtn = "";
			//파라미터 값 가져오기
			strStrCd   = String2.trimToEmpty(form.getParam("strStrCd"));  //점코드
			strSaleDt  = String2.trimToEmpty(form.getParam("strSaleDt")); //일자
			strSaleMon = strSaleDt.substring(0, 6);
			strStartDt = Util.addDay(strSaleDt, -6, "yyyyMMdd");
			if(!strSaleMon.equals(strStartDt.substring(0, 6))){
				strStartDt = strSaleMon +"01";
			}

			strLoc = "SEL_WEEKLY_CUSTOM_INFO";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strStartDt);
			sql.setString(i++, strSaleDt);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strStartDt);
			sql.setString(i++, strSaleDt);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strStartDt);
			sql.setString(i++, strSaleDt);
			
			connect("pot");
			list = select(sql);
			
			strRtn += "<?xml version=\"1.0\" encoding=\"euc-kr\"?>\n";
			strRtn += "  <CHARTFX>\n";
			
			for(int x=0; x < list.size() ; x++){
				map = (Map) list.get(x);
				if(x==0){
					strRtn += "    <COLUMNS>\n";
					strRtn += "      <COLUMN NAME=\"SALE_DT\"    TYPE=\"String\"/>\n";
					strRtn += "      <COLUMN NAME=\"CNT\"        TYPE=\"Integer\" DESCRIPTION=\"객수\"/>\n";
					strRtn += "      <COLUMN NAME=\"SALE_PRICE\" TYPE=\"Integer\" DESCRIPTION=\"객단가\"/>\n";
					strRtn += "    </COLUMNS>\n";
				}
				strRtn += "    <ROW SALE_DT=\""+ map.get("SALE_DT").toString() 
				                               + "\" CNT=\"" + map.get("CNT").toString() 
				                               + "\" SALE_PRICE=\"" + map.get("SALE_PRICE").toString() +"\"/>\n";
			}
			strRtn += "  </CHARTFX>";
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return strRtn;
	}
}
