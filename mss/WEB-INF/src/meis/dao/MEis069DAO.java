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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import meis.action.MEis028Action;

import org.apache.log4j.Logger;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>경영마감실적조회</p>
 * 
 * @created on 1.0, 2011/07/06
 * @created by 최재형
 * 
 * @modified on
 * @modified by
 * @caused by
 */
public class MEis069DAO extends AbstractDAO {

	/**
	 * 실적항목별 경영마감실적조회
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
		String strRsltYm = null;

		try {
			//파라미터 값 가져오기
			strStrCd = String2.trimToEmpty(form.getParam("strStrCd")); //점코드
			strRsltYm = String2.trimToEmpty(form.getParam("strRsltYm")); //경영실적년도

			strLoc = "SEL_BIZ";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strRsltYm);
			
			this.connect("pot");

			ret = this.select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		
		return ret;
	}
	
	/**
	 * 조직별 경영마감실적조회
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
		String strRsltYm = null;
		String strBizCd = null;

		try {
			//파라미터 값 가져오기
			strStrCd = String2.trimToEmpty(form.getParam("strStrCd")); //점코드
			strRsltYm = String2.trimToEmpty(form.getParam("strRsltYm")); //경영실적년도
			strBizCd = String2.trimToEmpty(form.getParam("strBizCd")); //실적항목코드

			strLoc = "SEL_ORG";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strRsltYm);
			sql.setString(i++, strBizCd);
			
			this.connect("pot");

			ret = this.select2List(sql);
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
		String strRsltYm = null;

		try {
			//파라미터 값 가져오기
			strStrCd = String2.trimToEmpty(form.getParam("strStrCd")); //점코드
			strRsltYm = String2.trimToEmpty(form.getParam("strRsltYm")); //경영실적년월

			strLoc = "SEL_EXCEL";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strRsltYm);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
}
