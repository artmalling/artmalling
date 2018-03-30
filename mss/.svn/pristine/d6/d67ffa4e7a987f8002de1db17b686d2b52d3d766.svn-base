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
 * <p>경영계획지침조회</p>
 * 
 * @created on 1.0, 2011/05/20
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MEis025DAO extends AbstractDAO {

	/**
	 * 경영실적항목마스터조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchBizMst(ActionForm form) throws Exception {

		List ret         = null;
		SqlWrapper sql   = null;
		Service svc      = null;
		String strLoc    = null;
		//파라미터 변수선언
		String strPlanYm = null;

		try {
			//파라미터 값 가져오기
			strPlanYm   = String2.trimToEmpty(form.getParam("strPlanYm"));

			strLoc = "SEL_BIZ_MST";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			sql.setString(1, strPlanYm);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 경영실적항목상세조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchBizDtl(ActionForm form) throws Exception {

		List ret         = null;
		SqlWrapper sql   = null;
		Service svc      = null;
		String strLoc    = null;
		int i            = 1;
		//파라미터 변수선언
		String strBizCd  = null;
		String strPlanYm = null;
		
		try {
			//파라미터 값 가져오기
			strBizCd  = String2.trimToEmpty(form.getParam("strBizCd")); //항목코드
			strPlanYm = String2.trimToEmpty(form.getParam("strPlanYm"));

			strLoc = "SEL_BIZ_DTL";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			sql.setString(i++, strPlanYm);
			sql.setString(i++, strBizCd);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 경영실적항목 엑셀데이타조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getExcelData(ActionForm form) throws Exception {

		List ret         = null;
		SqlWrapper sql   = null;
		Service svc      = null;
		String strLoc    = null;
		int i            = 1;
		//파라미터 변수선언
		String strPlanYm = null;

		try {
			//파라미터 값 가져오기
			strPlanYm   = String2.trimToEmpty(form.getParam("strPlanYm"));

			strLoc = "SEL_BIZ_EXCEL";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			sql.setString(i++, strPlanYm);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
}
