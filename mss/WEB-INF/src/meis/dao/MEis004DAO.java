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
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import common.util.Util;

/**
 * <p>경영계획 배부 기준안 관리</p>
 * 
 * @created on 1.0, 2011/05/12
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MEis004DAO extends AbstractDAO {

	/**
	 * 배부기준코드 리스트조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDivCdList(ActionForm form) throws Exception {

		List ret         = null;
		SqlWrapper sql   = null;
		Service svc      = null;
		String strLoc    = null;
		int i            = 1;
		//파라미터 변수선언
		String strDivYM  = null;

		try {
			//파라미터 값 가져오기
			strDivYM   = String2.trimToEmpty(form.getParam("strDivYM"));   //배부기준년월

			strLoc = "SEL_DIV_CD_LIST";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			sql.setString(i++, strDivYM);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 1차배분기준안 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDiv1(ActionForm form) throws Exception {

		List ret         = null;
		SqlWrapper sql   = null;
		Service svc      = null;
		String strLoc    = null;
		int i            = 1;
		//파라미터 변수선언
		String strDivYM  = null;
		String strDivCd  = null;
		String strPreYM  = null;

		try {
			//파라미터 값 가져오기
			strDivCd = String2.trimToEmpty(form.getParam("strDivCd")); //배부기준코드
			strDivYM = String2.trimToEmpty(form.getParam("strDivYM")); //배부기준년월
			strPreYM = Util.addYear(strDivYM+"01", -1 , "yyyyMM");

			strLoc = "SEL_DIV1";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			sql.setString(i++, strDivYM);
			sql.setString(i++, strDivCd);
			sql.setString(i++, "1");
			sql.setString(i++, "1");
			sql.setString(i++, strPreYM);
			sql.setString(i++, strPreYM);
			sql.setString(i++, strPreYM);
			sql.setString(i++, strDivYM);
			sql.setString(i++, strDivCd);
			sql.setString(i++, strPreYM);
			sql.setString(i++, strDivCd);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 2차배분기준안 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDiv2(ActionForm form) throws Exception {

		List ret         = null;
		SqlWrapper sql   = null;
		Service svc      = null;
		String strLoc    = null;
		int i            = 1;
		//파라미터 변수선언
		String strDivYM  = null;
		String strDivCd  = null;
		String strStrCd  = null;
		String strLvl    = null;
		String strPreYM  = null;

		try {
			//파라미터 값 가져오기
			strDivCd = String2.trimToEmpty(form.getParam("strDivCd")); //배부기준코드
			strDivYM = String2.trimToEmpty(form.getParam("strDivYM")); //배부기준년월
			strStrCd = String2.trimToEmpty(form.getParam("strStrCd")); //점코드
			strLvl   = "3";
			strPreYM = Util.addYear(strDivYM+"01", -1 , "yyyyMM");

			strLoc = "SEL_DIV2";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			sql.setString(i++, strDivYM);
			sql.setString(i++, strDivCd);
			sql.setString(i++, "2");
			sql.setString(i++, strLvl);
			sql.setString(i++, strLvl);
			sql.setString(i++, strPreYM);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strPreYM);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strPreYM);
			sql.setString(i++, strStrCd);			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strLvl);
			sql.setString(i++, strDivYM);
			sql.setString(i++, strDivCd);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strPreYM);
			sql.setString(i++, strDivCd);
			sql.setString(i++, strStrCd);

			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 3차배분기준안 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDiv3(ActionForm form) throws Exception {

		List ret         = null;
		SqlWrapper sql   = null;
		Service svc      = null;
		String strLoc    = null;
		int i            = 1;
		//파라미터 변수선언
		String strDivYM  = null;
		String strDivCd  = null;
		String strOrgCd  = null;
		String strLvl    = null;
		String strPreYM  = null;

		try {
			//파라미터 값 가져오기
			strDivCd  = String2.trimToEmpty(form.getParam("strDivCd")); //배부기준코드
			strDivYM  = String2.trimToEmpty(form.getParam("strDivYM")); //배부기준년월
			strOrgCd  = String2.trimToEmpty(form.getParam("strOrgCd"));
			strLvl   = "4";
			strPreYM = Util.addYear(strDivYM+"01", -1 , "yyyyMM");

			strLoc = "SEL_DIV3";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			sql.setString(i++, strDivYM);
			sql.setString(i++, strDivCd);
			sql.setString(i++, "2");
			sql.setString(i++, strLvl);
			sql.setString(i++, strLvl);
			sql.setString(i++, strPreYM);
			sql.setString(i++, strOrgCd.substring(0, 2));
			sql.setString(i++, strPreYM);
			sql.setString(i++, strOrgCd.substring(0, 2));
			sql.setString(i++, strPreYM);
			sql.setString(i++, strOrgCd.substring(0, 2));			
			sql.setString(i++, strOrgCd.substring(0, 2));
			sql.setString(i++, strLvl);
			sql.setString(i++, strOrgCd);
			sql.setString(i++, strDivYM);
			sql.setString(i++, strDivCd);
			sql.setString(i++, strOrgCd);
			sql.setString(i++, strPreYM);
			sql.setString(i++, strDivCd);
			sql.setString(i++, strOrgCd);

			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 배분기준안 변경 및 신규 처리
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi[], String strUserId)
			throws Exception {
		int ret        = 0;
		int i          = 0;
		Service svc    = null;
		try {
			begin();
			connect("pot");
			
			svc = (Service) form.getService();
			
			//3차배부기준안 처리
			while(mi[2].next()){
				if(mi[2].getInt("DIV_RATE") != 0) {
					ret += mngDiv(svc, mi[2], strUserId);
				} else {
					ret += deleteDiv(svc, mi[2], 3);
				}
				
			}
			
			//2차배부기준안 처리
			while(mi[1].next()){
				if(mi[1].getInt("DIV_RATE") != 0) {
					ret += mngDiv(svc, mi[1], strUserId);
				} else {
					ret += deleteDiv(svc, mi[1], 2);
				}
				
			}
			
			//1차배부기준안 처리
			while(mi[0].next()){
				if(mi[0].getInt("DIV_RATE") != 0) {
					ret += mngDiv(svc, mi[0], strUserId);
				} else {
					ret += deleteDiv(svc, mi[0], 1);
				}
			}
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}
	
	/**
	 *  <p>배부기준안 수정 및 등록</p>
	 */
	private int mngDiv(Service svc, MultiInput mi, String strUserId) throws Exception {
		
		int ret        = 0;
		int i          = 0;
		String strLoc  = "UST_DIV";
		SqlWrapper sql = new SqlWrapper();
		
		sql.put(svc.getQuery(strLoc));
		
		sql.setString(++i, mi.getString("DIV_YM"));
		sql.setString(++i, mi.getString("DIV_CD"));
		sql.setString(++i, mi.getString("DIV_SEQ_FLAG"));
		sql.setString(++i, mi.getString("ORG_CD"));
		sql.setString(++i, "1");
		sql.setInt(++i, mi.getInt("DIV_RATE"));
		sql.setString(++i, mi.getString("ORG_LEVEL"));
		sql.setString(++i, strUserId);

		ret = this.update(sql);
		if(ret != 1)
			throw new Exception("[USER]"+"배분기준마스터 처리에 실패하였습니다.");
		
		return ret;
	}
	
	/**
	 *  <p>배부기준안 삭제</p>
	 */
	private int deleteDiv(Service svc, MultiInput mi, int flag) throws Exception {
		
		int ret        = 0;
		int i          = 0;
		String strLoc  = "DEL_DIV";
		SqlWrapper sql = new SqlWrapper();
		
		sql.put(svc.getQuery(strLoc));
		
		sql.setString(++i, mi.getString("DIV_YM"));
		sql.setString(++i, mi.getString("DIV_CD"));
		sql.setString(++i, mi.getString("ORG_CD").substring(0, 2));
		
		if(flag == 2){
			sql.put(svc.getQuery("DEL_DIV_WHERE_TEAM"));
			sql.setString(++i, mi.getString("ORG_CD").substring(4, 6));
		} else if(flag == 3){
			sql.put(svc.getQuery("DEL_DIV_WHERE_PC"));
			sql.setString(++i, mi.getString("ORG_CD").substring(4, 6));
			sql.setString(++i, mi.getString("ORG_CD").substring(6, 8));
		}

		ret = this.update(sql);
		
		return ret;
	}
	
	/**
	 * 전월배부기준안 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getPreData(ActionForm form) throws Exception {

		List ret         = null;
		SqlWrapper sql   = null;
		Service svc      = null;
		String strLoc    = null;
		int i            = 1;
		//파라미터 변수선언
		String strDivCd  = null;
		String strDivYM  = null;
		String strLvl    = null;
		String strPreYM  = null;
		String strCode   = null;

		try {
			//파라미터 값 가져오기
			strDivCd = String2.trimToEmpty(form.getParam("strDivCd")); //배부기준코드
			strDivYM = String2.trimToEmpty(form.getParam("strDivYM")); //배부기준년월
			strLvl   = String2.trimToEmpty(form.getParam("strLvl"));   //배부기준차수구분
			strCode  = String2.trimToEmpty(form.getParam("strCode"));  
			strPreYM = Util.addMonth(strDivYM+"01", -1 , "yyyyMM");

			strLoc = "SEL_PRE_DIV";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			sql.setString(i++, strPreYM);
			sql.setString(i++, strDivCd);
			sql.setString(i++, strLvl);
			
			if (!"".equals(strCode)){
				sql.put(svc.getQuery("SEL_PRE_DIV_WHERE_CD"));
				sql.setString(i++, strCode);
			}

			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
}
