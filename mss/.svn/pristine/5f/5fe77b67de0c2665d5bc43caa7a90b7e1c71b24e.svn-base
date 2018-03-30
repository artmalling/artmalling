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
 * <p>고객 현황</p>
 * 
 * @created on 1.0, 2011/06/30
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MEis083DAO extends AbstractDAO {

	/**
	 * 고객등급현황조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchCustInfo(ActionForm form, String strUserId, String strLoc) throws Exception {

		List ret             = null;
		SqlWrapper sql       = null;
		Service svc          = null;
		int i                = 1;
		//파라미터 변수선언
		String strStrCd      = null;
		String strSaleYm     = null;
		
		try {
			//파라미터 값 가져오기
			strStrCd   = String2.trimToEmpty(form.getParam("strStrCd"));  //점코드
			if("%".equals(strStrCd)){
				strStrCd = "";
			}
			strSaleYm  = String2.trimToEmpty(form.getParam("strSaleYm")); //일자

			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strSaleYm);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleYm+"01");
			sql.setString(i++, strSaleYm+"31");
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleYm+"01");
			sql.setString(i++, strSaleYm+"31");
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleYm+"01");
			sql.setString(i++, strSaleYm+"31");
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleYm+"01");
			sql.setString(i++, strSaleYm+"31");
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleYm+"01");
			sql.setString(i++, strSaleYm+"31");
			
			connect("pot");
			ret = select2List(sql);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return ret;
	}
	
	/**
	 * 등급별 고객현황 차트 로딩
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public String searchCustPie(ActionForm form, String strUserId) throws Exception {

		List list        = null;
		Map  map         = null;
		SqlWrapper sql   = null;
		Service svc      = null;
		String strLoc    = null;
		int i            = 1;
		//파라미터 변수선언
		String strStrCd  = null;
		String strSaleYm = null;
		String strRtn    = null;
		String tabFlag   = null;
		
		try {
			strRtn = "";
			//파라미터 값 가져오기
			strStrCd   = String2.trimToEmpty(form.getParam("strStrCd"));  //점코드
			strSaleYm  = String2.trimToEmpty(form.getParam("strSaleYm")); //일자
			tabFlag    = String2.trimToEmpty(form.getParam("tabFlag"));

			strLoc = "SEL_CUST_PIE";
			if(!"1".equals(tabFlag)) strLoc = "SEL_CUST_PIE2";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleYm+"01");
			sql.setString(i++, strSaleYm+"31");
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleYm+"01");
			sql.setString(i++, strSaleYm+"31");
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleYm+"01");
			sql.setString(i++, strSaleYm+"31");
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleYm+"01");
			sql.setString(i++, strSaleYm+"31");			
			
			connect("pot");
			list = select(sql);
			
			strRtn += "<?xml version=\"1.0\" encoding=\"euc-kr\"?>\n";
			strRtn += "  <CHARTFX>\n";
			
			for(int x=0; x < list.size() ; x++){
				map = (Map) list.get(x);
				if(x==0){
					strRtn += "    <COLUMNS>\n";
					strRtn += "      <COLUMN NAME=\"GRADE\"  TYPE=\"String\"/>\n";
					strRtn += "      <COLUMN NAME=\"VALUE\"  TYPE=\"Integer\" />\n";
					strRtn += "    </COLUMNS>\n";
				}
				strRtn += "    <ROW GRADE=\"블랙 : " + map.get("BLACK").toString() + "\" VALUE=\"" + map.get("BLACK").toString() +"\"/>\n";
				strRtn += "    <ROW GRADE=\"골드 : " + map.get("GOLD").toString() + "\" VALUE=\"" + map.get("GOLD").toString()  +"\"/>\n";
				strRtn += "    <ROW GRADE=\"블루 : " + map.get("BLUE").toString() + "\" VALUE=\"" + map.get("BLUE").toString()  +"\"/>\n";
				strRtn += "    <ROW GRADE=\"그린 : " + map.get("GREEN").toString() + "\" VALUE=\"" + map.get("GREEN").toString() +"\"/>\n";
			}
			strRtn += "  </CHARTFX>";
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return strRtn;
	}
	
	/**
	 * 고객 등급 현황월별 추이 차트 로딩
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public String searchCustGrid(ActionForm form, String strUserId) throws Exception {

		List list         = null;
		Map  map          = null;
		SqlWrapper sql    = null;
		Service svc       = null;
		String strLoc     = null;
		int i             = 1;
		//파라미터 변수선언
		String strStrCd   = null;
		String strSaleYm  = null;
		String strStartYm = null;
		String strRtn     = null;
		String tabFlag    = null;
		
		try {
			strRtn = "";
			//파라미터 값 가져오기
			strStrCd   = String2.trimToEmpty(form.getParam("strStrCd"));  //점코드
			strSaleYm  = String2.trimToEmpty(form.getParam("strSaleYm")); //일자
			tabFlag    = String2.trimToEmpty(form.getParam("tabFlag"));
			
			strStartYm = Util.addMonth(strSaleYm+"01", -11, "yyyyMM");

			strLoc = "SEL_CUST_GRID";
			if(!"1".equals(tabFlag)) strLoc = "SEL_CUST_GRID2";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strStartYm+"01");
			sql.setString(i++, strSaleYm+"01");
			sql.setString(i++, strStartYm+"01");
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strStartYm+"01");
			sql.setString(i++, strSaleYm+"31");
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strStartYm+"01");
			sql.setString(i++, strSaleYm+"31");
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strStartYm+"01");
			sql.setString(i++, strSaleYm+"31");
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strStartYm+"01");
			sql.setString(i++, strSaleYm+"31");
			
			connect("pot");
			list = select(sql);
			
			strRtn += "<?xml version=\"1.0\" encoding=\"euc-kr\"?>\n";
			strRtn += "  <CHARTFX>\n";
			
			for(int x=0; x < list.size() ; x++){
				map = (Map) list.get(x);
				if(x==0){
					strRtn += "    <COLUMNS>\n";
					strRtn += "      <COLUMN NAME=\"SALE_YM\" TYPE=\"String\"/>\n";
					strRtn += "      <COLUMN NAME=\"BLACK\"   TYPE=\"Integer\" DESCRIPTION=\"블랙\"/>\n";
					strRtn += "      <COLUMN NAME=\"GOLD\"    TYPE=\"Integer\" DESCRIPTION=\"골드\"/>\n";
					strRtn += "      <COLUMN NAME=\"BLUE\"    TYPE=\"Integer\" DESCRIPTION=\"블루\"/>\n";
					strRtn += "      <COLUMN NAME=\"GREEN\"   TYPE=\"Integer\" DESCRIPTION=\"그린\"/>\n";
					strRtn += "    </COLUMNS>\n";
				}
				strRtn += "    <ROW SALE_YM=\""+ map.get("SALE_YM").toString() 
				                               + "\" BLACK=\"" + map.get("BLACK").toString() 
				                               + "\" GOLD=\""  + map.get("GOLD").toString()
				                               + "\" BLUE=\""  + map.get("BLUE").toString()
				                               + "\" GREEN=\"" + map.get("GREEN").toString() +"\"/>\n";
			}
			strRtn += "  </CHARTFX>";
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return strRtn;
	}
	
	/**
	 * 엑셀데이터조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getExcelData(ActionForm form, String strUserId) throws Exception {

		List ret             = null;
		SqlWrapper sql       = null;
		Service svc          = null;
		int i                = 1;
		//파라미터 변수선언
		String strStrCd      = null;
		String strSaleYm     = null;
		String strLoc        = null;
		
		try {
			//파라미터 값 가져오기
			strStrCd   = String2.trimToEmpty(form.getParam("strStrCd"));  //점코드
			if("%".equals(strStrCd)){
				strStrCd = "";
			}
			strSaleYm  = String2.trimToEmpty(form.getParam("strSaleYm")); //일자

			strLoc = "SEL_EXCEL";
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleYm+"01");
			sql.setString(i++, strSaleYm+"31");
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleYm+"01");
			sql.setString(i++, strSaleYm+"31");
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleYm+"01");
			sql.setString(i++, strSaleYm+"31");
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleYm+"01");
			sql.setString(i++, strSaleYm+"31");
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleYm+"01");
			sql.setString(i++, strSaleYm+"31");
			
			connect("pot");
			ret = select2List(sql);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return ret;
	}
}
