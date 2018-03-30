/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package psal.dao;

import java.util.List;
//import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.Date2;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>영업관리 > 매출관리 > 도면매출 > 도면매출</p>
 * 
 * @created  on 1.0, 2010/06/27
 * @created  by 정진영(FKSS)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PSal432DAO extends AbstractDAO {

	/**
	 * 마스터 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form) throws Exception {

		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		int i 			= 1;

		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strFloorCd 		= String2.nvl(form.getParam("strFloorCd"));
		String strDt            = Date2.getThisDay("YYYYMMDD");
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_MASTER"));

		sql.setString(i++, strDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strFloorCd);
		

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 도면을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchFloorPlan(ActionForm form) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		int i 			= 1;		

		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strFloorCd 		= String2.nvl(form.getParam("strFloorCd"));
		
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_FLOOR_PLAN"));

		sql.setString(i++, strStrCd);
		sql.setString(i++, strFloorCd);
		

		ret = select2List(sql);

		return ret;
	}


	/**
	 * 브랜드매출정보을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchBrand(ActionForm form) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		int i 			= 1;		

		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strPumbunCd 		= String2.nvl(form.getParam("strPumbunCd"));
		String strDt     		= String2.nvl(form.getParam("strDt"));
		
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_BRAND_INFO"));

		// 협력사정보
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		// 당일내역
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strDt);
		// 월간내역
		sql.setString(i++, strDt);
		sql.setString(i++, strDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strDt);
		sql.setString(i++, strDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strDt);
		sql.setString(i++, strDt);
		// 년간내역
		sql.setString(i++, strDt);
		sql.setString(i++, strDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strDt);
		sql.setString(i++, strDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strDt);
		sql.setString(i++, strDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strDt);
		sql.setString(i++, strDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strDt);
		sql.setString(i++, strDt);
		

		ret = select2List(sql);

		return ret;
	}


	/**
	 * 일별매출정보을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDay(ActionForm form) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		int i 			= 1;		

		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strPumbunCd 		= String2.nvl(form.getParam("strPumbunCd"));
		String strFromDt  		= String2.nvl(form.getParam("strFromDt"));
		String strToDt  		= String2.nvl(form.getParam("strToDt"));
		
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_DAY_INFO"));

		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strFromDt);
		sql.setString(i++, strToDt);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 월별매출정보을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMonth(ActionForm form) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		int i 			= 1;		

		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strPumbunCd 		= String2.nvl(form.getParam("strPumbunCd"));
		String strFromDt  		= String2.nvl(form.getParam("strFromDt"));
		String strToDt  		= String2.nvl(form.getParam("strToDt"));
		
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_MONTH_INFO"));

		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strFromDt);
		sql.setString(i++, strToDt);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 시간별매출정보을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchTime(ActionForm form) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		int i 			= 1;		

		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strPumbunCd 		= String2.nvl(form.getParam("strPumbunCd"));
		String strFromDt  		= String2.nvl(form.getParam("strFromDt"));
		String strToDt  		= String2.nvl(form.getParam("strToDt"));
		
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_TIME_INFO"));

		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strFromDt);
		sql.setString(i++, strToDt);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 고객매출정보(등급)을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchCust_01(ActionForm form) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		int i 			= 1;		

		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strPumbunCd 		= String2.nvl(form.getParam("strPumbunCd"));
		String strFromDt  		= String2.nvl(form.getParam("strFromDt"));
		String strToDt  		= String2.nvl(form.getParam("strToDt"));
		
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_CUST_INFO_01"));

		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strFromDt);
		sql.setString(i++, strToDt);

		ret = select2List(sql);

		return ret;
	}
	/**
	 * 고객매출정보(성별)을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchCust_02(ActionForm form) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		int i 			= 1;		

		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strPumbunCd 		= String2.nvl(form.getParam("strPumbunCd"));
		String strFromDt  		= String2.nvl(form.getParam("strFromDt"));
		String strToDt  		= String2.nvl(form.getParam("strToDt"));
		
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_CUST_INFO_02"));

		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strFromDt);
		sql.setString(i++, strToDt);

		ret = select2List(sql);

		return ret;
	}
	/**
	 * 고객매출정보(연령)을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchCust_03(ActionForm form) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		int i 			= 1;		

		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strPumbunCd 		= String2.nvl(form.getParam("strPumbunCd"));
		String strFromDt  		= String2.nvl(form.getParam("strFromDt"));
		String strToDt  		= String2.nvl(form.getParam("strToDt"));
		
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_CUST_INFO_03"));

		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strFromDt);
		sql.setString(i++, strToDt);

		ret = select2List(sql);

		return ret;
	}
}
