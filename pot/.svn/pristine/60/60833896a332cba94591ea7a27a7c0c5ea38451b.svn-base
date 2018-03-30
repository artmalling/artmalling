/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package common.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>
 * 경영지원 - 경영실적조회 - 경영실적항목 분류조회
 * </p>
 * 
 * @created on 1.0, 2010/05/03
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class CCom221DAO extends AbstractDAO {
    
	/**
	 * 경영실적항목코드 분류콤보조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getBizCdCombo(ActionForm form) throws Exception {

		List ret          = null;
		SqlWrapper sql    = null;
		Service svc       = null;
		int i             = 1;
		//파라미터 변수선언
		String strLvl     = null;
		String strViewYn  = null;
		String strBizLCd  = null;
		String strBizMCd  = null;

		try {
			//파라미터 값 가져오기
			strLvl    = String2.trimToEmpty(form.getParam("strLvl"));    //분류레벨
			strViewYn = String2.trimToEmpty(form.getParam("strViewYn")); //전체여부
			strBizLCd = String2.trimToEmpty(form.getParam("strBizLCd")); //대분류코드
			strBizMCd = String2.trimToEmpty(form.getParam("strBizMCd")); //중분류코드

			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			
			sql.put(svc.getQuery("SEL_BIZ_CODE_LVL"));
			
			sql.setString(i++, strLvl);
			
			if(!"1".equals(strLvl)){
				sql.put(svc.getQuery("SEL_BIZ_CODE_LVL_WHERE_LCD"));
				sql.setString(i++, strBizLCd);
			}
			
			if("3".equals(strLvl)){
				sql.put(svc.getQuery("SEL_BIZ_CODE_LVL_WHERE_MCD"));
				sql.setString(i++, strBizMCd);
			}
			
			if("Y".equals(strViewYn)){
				sql.put(svc.getQuery("SEL_ALL"));
			}
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 실적항목리스트조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getBizList(ActionForm form) throws Exception {

		List ret          = null;
		SqlWrapper sql    = null;
		Service svc       = null;
		int i             = 1;
		//파라미터 변수선언
		String strCode    = null;
		String strName    = null;
		String strBizLvl  = null;
		String strPBizCd  = null;

		try {
			//파라미터 값 가져오기
			strCode   = String2.trimToEmpty(form.getParam("strCode"));   //코드
			strName   = String2.trimToEmpty(form.getParam("strName"));   //명
			strBizLvl = String2.trimToEmpty(form.getParam("strBizLvl")); //항목레벨
			strPBizCd = String2.trimToEmpty(form.getParam("strPBizCd")); //상위항목코드

			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			
			sql.put(svc.getQuery("SEL_BIZ_LIST"));
			
			if(!"".equals(strCode)){
				sql.put(svc.getQuery("SEL_BIZ_LIST_WHERE_CD"));
				sql.setString(i++, strCode);
			}
			
			if(!"".equals(strName)){
				sql.put(svc.getQuery("SEL_BIZ_LIST_WHERE_NM"));
				sql.setString(i++, strName);
			}
			
			if(!"".equals(strBizLvl)){
				sql.put(svc.getQuery("SEL_BIZ_LIST_WHERE_LVL"));
				sql.setString(i++, strBizLvl);
			}
			
			if(!"".equals(strPBizCd)){
				sql.put(svc.getQuery("SEL_BIZ_LIST_WHERE_PBIZ"));
				sql.setString(i++, strPBizCd);
			}
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 실적항목리스트조회-월별경영계획항목명세테이블
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getBizPlanList(ActionForm form) throws Exception {

		List ret          = null;
		SqlWrapper sql    = null;
		Service svc       = null;
		int i             = 1;
		//파라미터 변수선언
		String strCode    = null;
		String strName    = null;
		String strPlanYm  = null;
		String strType  = null;

		try {
			//파라미터 값 가져오기
			strCode   = String2.trimToEmpty(form.getParam("strCode"));   //코드
			strName   = String2.trimToEmpty(form.getParam("strName"));   //명
			strPlanYm = String2.trimToEmpty(form.getParam("strPlanYm")); //계획년월
			strType   = String2.trimToEmpty(form.getParam("strType"));

			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			
			if("1".equals(strType)) sql.put(svc.getQuery("SEL_BIZ_PLAN_LIST"));
			else sql.put(svc.getQuery("SEL_BIZ_RSLT_LIST"));
			sql.setString(i++, strPlanYm);
			
			if(!"".equals(strCode)){
				sql.put(svc.getQuery("SEL_BIZ_PLAN_LIST_WHERE_CD"));
				sql.setString(i++, strCode);
			}
			
			if(!"".equals(strName)){
				sql.put(svc.getQuery("SEL_BIZ_PLAN_LIST_WHERE_NM"));
				sql.setString(i++, strName);
			}
			
			sql.put(svc.getQuery("SEL_BIZ_PLAN_LIST_ORDER_BY"));
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 실적항목단건정보
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getBizCdNm(ActionForm form) throws Exception {

		List ret          = null;
		SqlWrapper sql    = null;
		Service svc       = null;
		int i             = 1;
		//파라미터 변수선언
		String strCode    = null;

		try {
			//파라미터 값 가져오기
			strCode = String2.trimToEmpty(form.getParam("strCode")); //코드

			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			
			sql.put(svc.getQuery("SEL_BIZ_CD_NM"));
			sql.setString(i++, strCode);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 실적항목단건정보-월별경영계획항목명세테이블
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getBizPlanCdNm(ActionForm form) throws Exception {

		List ret          = null;
		SqlWrapper sql    = null;
		Service svc       = null;
		int i             = 1;
		//파라미터 변수선언
		String strCode    = null;
		String strPlanYm  = null;
		String strType    = null;

		try {
			//파라미터 값 가져오기
			strCode   = String2.trimToEmpty(form.getParam("strCode")); //코드
			strPlanYm = String2.trimToEmpty(form.getParam("strPlanYm"));
			strType   = String2.trimToEmpty(form.getParam("strType"));
			

			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			
			if("1".equals(strType)) sql.put(svc.getQuery("SEL_BIZ_PLAN_CD_NM"));
			else sql.put(svc.getQuery("SEL_BIZ_RSLT_CD_NM"));
			sql.setString(i++, strPlanYm);
			sql.setString(i++, strCode);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 계정/예산항목리스트조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getAccList(ActionForm form) throws Exception {

		List ret       = null;
		SqlWrapper sql = null;
		Service svc    = null;
		int i          = 1;
		//파라미터 변수선언
		String strFlag = null;
		String strCode = null;
		String strName = null;
		String strCon1 = null;

		try {
			//파라미터 값 가져오기
			strFlag = String2.trimToEmpty(form.getParam("strFlag"));
			strCode = String2.trimToEmpty(form.getParam("strCode")); //코드
			strName = String2.trimToEmpty(form.getParam("strName")); //명
			strCon1 = String2.trimToEmpty(form.getParam("strCon1"));

			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			
			if("1".equals(strFlag)){
				sql.put(svc.getQuery("SEL_ACC_LIST"));
				sql.setString(i++, strCon1);
			} else if("2".equals(strFlag)){
				sql.put(svc.getQuery("SEL_ACC_LIST2"));
				sql.setString(i++, strCon1+"01");
				sql.setString(i++, strCon1+"12");
			} else if("3".equals(strFlag)){
				sql.put(svc.getQuery("SEL_ACC_LIST3"));
				sql.setString(i++, strCon1);
			}
			
			if(!"".equals(strCode)){
				sql.put(svc.getQuery("SEL_ACC_LIST_WHERE_CD"));
				sql.setString(i++, strCode);
			}
			
			if(!"".equals(strName)){
				sql.put(svc.getQuery("SEL_ACC_LIST_WHERE_NM"));
				sql.setString(i++, strName);
			}
			
			sql.put(svc.getQuery("SEL_ACC_ORDER_BY"));
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 계정/예산항목단건정보
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getAccCdNm(ActionForm form) throws Exception {

		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		int i           = 1;
		//파라미터 변수선언
		String strFlag  = null;
		String strCon1  = null;
		String strCon2   = null;
		String strAccCd = null;

		try {
			//파라미터 값 가져오기
			strFlag = String2.trimToEmpty(form.getParam("strFlag"));
			strCon1    = String2.trimToEmpty(form.getParam("strCon1"));
			strCon2    = String2.trimToEmpty(form.getParam("strCon2"));
			strAccCd   = String2.trimToEmpty(form.getParam("strAccCd"));

			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			
			if("1".equals(strFlag)){
				sql.put(svc.getQuery("SEL_ACC_CD_NM"));
				//sql.setString(i++, strCon1);
				sql.setString(i++, strCon2);
				sql.setString(i++, strAccCd);
			} else if("2".equals(strFlag)){
				sql.put(svc.getQuery("SEL_ACC_CD_NM2"));
				sql.setString(i++, strCon2+"01");
				sql.setString(i++, strCon2+"12");
				sql.setString(i++, strAccCd);
			} else if("2".equals(strFlag)){
				sql.put(svc.getQuery("SEL_ACC_CD_NM3"));
				sql.setString(i++, strCon2);
				sql.setString(i++, strAccCd);
			}
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 배부기준코드 콤보조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getDivCombo(ActionForm form) throws Exception {

		List ret          = null;
		SqlWrapper sql    = null;
		Service svc       = null;
		int i             = 1;
		//파라미터 변수선언
		String strDate    = null;
		String strSeq     = null;
		String strFlag    = null;
		String strViewYn  = null;
		String strStrCd   = null;
		String strOrgLvl  = null;

		try {
			//파라미터 값 가져오기
			strDate       = String2.trimToEmpty(form.getParam("strDate"));   //분류레벨
			strSeq        = String2.trimToEmpty(form.getParam("strSeq"));     
			strFlag       = String2.trimToEmpty(form.getParam("strFlag"));   
			strViewYn     = String2.trimToEmpty(form.getParam("strViewYn")); //전체여부
			strStrCd      = String2.trimToEmpty(form.getParam("strStrCd"));
			strOrgLvl     = String2.trimToEmpty(form.getParam("strOrgLvl"));

			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			
			sql.put(svc.getQuery("SEL_DIV"));
			
			sql.setString(i++, strDate);			
			sql.setString(i++, strSeq);
			sql.setString(i++, strFlag);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strOrgLvl);
			
			if("Y".equals(strViewYn)){
				sql.put(svc.getQuery("SEL_ALL2"));
			}
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 배부기준코드 마스터조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getDivMst(ActionForm form) throws Exception {

		List ret          = null;
		SqlWrapper sql    = null;
		Service svc       = null;
		int i             = 1;
		//파라미터 변수선언
		String strViewYn  = null;

		try {
			//파라미터 값 가져오기
			strViewYn     = String2.trimToEmpty(form.getParam("strViewYn")); //전체여부

			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			
			sql.put(svc.getQuery("SEL_DIV_MST"));
			
			if("Y".equals(strViewYn)){
				sql.put(svc.getQuery("SEL_ALL2"));
			}
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return ret;
	}
}
