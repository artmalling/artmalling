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

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>항목별비용계획조회</p>
 * 
 * @created on 1.0, 2011/05/30
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MEis028DAO extends AbstractDAO {

	/**
	 * 계정별 비용계획조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchBiz(ActionForm form) throws Exception {

		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strLoc   = null;
		int i           = 1;
		//파라미터 변수선언
		String strStrCd = null;
		String strPlanY = null;

		try {
			//파라미터 값 가져오기
			strStrCd = String2.trimToEmpty(form.getParam("strStrCd")); //점코드
			strPlanY = String2.trimToEmpty(form.getParam("strPlanY")); //경영계획년도

			strLoc = "SEL_BIZ";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strPlanY);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 조직별 비용계획조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchOrg(ActionForm form) throws Exception {
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strLoc   = null;
		int i           = 1;
		//파라미터 변수선언
		String strStrCd = null;
		String strPlanY = null;
		String strBizCd = null;

		try {
			//파라미터 값 가져오기
			strStrCd = String2.trimToEmpty(form.getParam("strStrCd")); //점코드
			strPlanY = String2.trimToEmpty(form.getParam("strPlanY")); //경영계획년도
			strBizCd = String2.trimToEmpty(form.getParam("strBizCd")); //실적항목코드

			strLoc = "SEL_ORG";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strPlanY);
			sql.setString(i++, strBizCd);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return ret;
		
	}
	
	/**
	 * 월별 비용계획조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMonth(ActionForm form) throws Exception {
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strLoc   = null;
		int i           = 1;
		//파라미터 변수선언
		String strStrCd = null;
		String strPlanY = null;
		String strBizCd = null;
		String strOrgCd = null;

		try {
			//파라미터 값 가져오기
			strStrCd = String2.trimToEmpty(form.getParam("strStrCd")); //점코드
			strPlanY = String2.trimToEmpty(form.getParam("strPlanY")); //경영계획년도
			strBizCd = String2.trimToEmpty(form.getParam("strBizCd")); //실적항목코드
			strOrgCd = String2.trimToEmpty(form.getParam("strOrgCd")); //조직코드

			strLoc = "SEL_MONTH";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strPlanY);
			sql.setString(i++, strBizCd);
			sql.setString(i++, strOrgCd);
			for(int y = 1 ; y <=12 ; y++) sql.setString(i++, strPlanY);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strPlanY);
			sql.setString(i++, strBizCd);
			sql.setString(i++, strOrgCd);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return ret;

	}
	
	/**
	 * 엑셀 데이터 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getExcelData(ActionForm form) throws Exception {

		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strLoc   = null;
		int i           = 1;
		//파라미터 변수선언
		String strStrCd = null;
		String strPlanY = null;

		try {
			//파라미터 값 가져오기
			strStrCd = String2.trimToEmpty(form.getParam("strStrCd")); //점코드
			strPlanY = String2.trimToEmpty(form.getParam("strPlanY")); //경영계획년도

			strLoc = "SEL_EXCEL";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strPlanY);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
}
