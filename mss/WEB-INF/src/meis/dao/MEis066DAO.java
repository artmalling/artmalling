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
 * <p>경영실적배부이력조회</p>
 * 
 * @created on 1.0, 2011/08/16
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MEis066DAO extends AbstractDAO {

	/**
	 * 년별항목별경영실적 조직조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchOrg(ActionForm form) throws Exception {

		List ret         = null;
		SqlWrapper sql   = null;
		Service svc      = null;
		String strLoc    = null;
		int i            = 1;
		//파라미터 변수선언
		String strRsltYm = null; 
		String strOrgLvl = null;
		String strStrCd  = null;
		String strDeptCd = null;
		String strTeamCd = null;
		String strPcCd   = null;

		try {
			//파라미터 값 가져오기
			strRsltYm = String2.trimToEmpty(form.getParam("strRsltYm"));
			strOrgLvl = String2.trimToEmpty(form.getParam("strOrgLvl"));
			strStrCd  = String2.trimToEmpty(form.getParam("strStrCd"));
			strDeptCd = String2.trimToEmpty(form.getParam("strDeptCd"));
			strTeamCd = String2.trimToEmpty(form.getParam("strTeamCd"));
			strPcCd   = String2.trimToEmpty(form.getParam("strPcCd"));

			strLoc = "SEL_ORG";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strRsltYm);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPcCd);
			sql.setString(i++, strOrgLvl);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 년별항목별경영실적 항목조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchBiz(ActionForm form) throws Exception {

		List ret         = null;
		SqlWrapper sql   = null;
		Service svc      = null;
		String strLoc    = null;
		int i            = 1;
		//파라미터 변수선언
		String strStrCd = null;
		String strRsltYm = null;
		String strOrgCd  = null;

		try {
			//파라미터 값 가져오기
			strStrCd  = String2.trimToEmpty(form.getParam("strStrCd"));
			strRsltYm = String2.trimToEmpty(form.getParam("strRsltYm"));
			strOrgCd  = String2.trimToEmpty(form.getParam("strOrgCd"));

			strLoc = "SEL_BIZ";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strRsltYm);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strOrgCd);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 년별항목별경영실적 항목조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchHis(ActionForm form) throws Exception {

		List ret         = null;
		SqlWrapper sql   = null;
		Service svc      = null;
		String strLoc    = null;
		int i            = 1;
		//파라미터 변수선언
		String strRsltYm = null;
		String strStrCd = null;
		String strOrgCd  = null;
		String strBizCd  = null;
		String strFlag  = null;

		try {
			//파라미터 값 가져오기
			strRsltYm = String2.trimToEmpty(form.getParam("strRsltYm"));
			strStrCd  = String2.trimToEmpty(form.getParam("strStrCd"));
			strOrgCd  = String2.trimToEmpty(form.getParam("strOrgCd"));
			strBizCd  = String2.trimToEmpty(form.getParam("strBizCd"));
			strFlag   = String2.trimToEmpty(form.getParam("strFlag"));

			if("1".equals(strFlag)) strLoc = "SEL_RECV";
			else if("2".equals(strFlag)) strLoc = "SEL_DIV";
			else if("3".equals(strFlag)) strLoc = "SEL_ADJ_RECV";
			else strLoc = "SEL_ADJ";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strRsltYm);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strOrgCd);
			sql.setString(i++, strBizCd);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 경영실적 조정이력 엑셀조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchAdjstHistExcel(ActionForm form) throws Exception {

		List ret         = null;
		SqlWrapper sql   = null;
		Service svc      = null;
		String strLoc    = null;
		int i            = 1;
		//파라미터 변수선언
		String strRsltYm = null; 
		String strOrgLvl = null;
		String strStrCd  = null;
		String strDeptCd = null;
		String strTeamCd = null;
		String strPcCd   = null;

		try {
			//파라미터 값 가져오기
			strRsltYm = String2.trimToEmpty(form.getParam("strRsltYm"));
			strOrgLvl = String2.trimToEmpty(form.getParam("strOrgLvl"));
			strStrCd  = String2.trimToEmpty(form.getParam("strStrCd"));
			strDeptCd = String2.trimToEmpty(form.getParam("strDeptCd"));
			strTeamCd = String2.trimToEmpty(form.getParam("strTeamCd"));
			strPcCd   = String2.trimToEmpty(form.getParam("strPcCd"));

			strLoc = "SEL_ADJST_HIST_EXCEL";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strRsltYm);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPcCd);
			sql.setString(i++, strOrgLvl);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
		
	}	
	
}
