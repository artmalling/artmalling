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

/**
 * <p>경영계획 조회 및 확정</p>
 * 
 * @created on 1.0, 2011/06/03
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MEis042DAO extends AbstractDAO {

	/**
	 * 점별 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchStore(ActionForm form, String strUsrId) throws Exception {

		List ret          = null;
		SqlWrapper sql    = null;
		Service svc       = null;
		String strLoc     = null;
		int i             = 1;
		//파라미터 변수선언
		String strStrCd   = null;
		String strYear    = null;
		String strConfirm = null;

		try {
			//파라미터 값 가져오기
			strStrCd   = String2.trimToEmpty(form.getParam("strStrCd")); 
			strYear    = String2.trimToEmpty(form.getParam("strYear"));  
			strConfirm = String2.trimToEmpty(form.getParam("strConfirm"));

			strLoc = "SEL_BY_STORE";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			sql.setString(i++, strYear);
			
			if (!"%".equals(strStrCd)){
				sql.put(svc.getQuery("SEL_BY_STORE_WHERE_STR"));
				sql.setString(i++, strStrCd);
			}
			
			if (!"%".equals(strConfirm)){
				sql.put(svc.getQuery("SEL_BY_STORE_WHERE_CFM"));
				sql.setString(i++, strConfirm);
			}
			
			sql.put(svc.getQuery("SEL_BY_STORE_GROUP_BY"));
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 항목별 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchBizCd(ActionForm form) throws Exception {

		List ret          = null;
		SqlWrapper sql    = null;
		Service svc       = null;
		String strLoc     = null;
		int i             = 1;
		//파라미터 변수선언
		String strStrCd   = null;
		String strYear    = null;
		String strConfirm = null;

		try {
			//파라미터 값 가져오기
			strStrCd   = String2.trimToEmpty(form.getParam("strStrCd")); 
			strYear    = String2.trimToEmpty(form.getParam("strYear"));  
			strConfirm = String2.trimToEmpty(form.getParam("strConfirm"));

			strLoc = "SEL_BY_BIZ_CD";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			sql.setString(i++, strYear);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strConfirm);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 조직별 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchOrg(ActionForm form) throws Exception {

		List ret          = null;
		SqlWrapper sql    = null;
		Service svc       = null;
		String strLoc     = null;
		int i             = 1;
		//파라미터 변수선언
		String strStrCd   = null;
		String strYear    = null;
		String strConfirm = null;
		String strBizCd   = null;

		try {
			//파라미터 값 가져오기
			strStrCd   = String2.trimToEmpty(form.getParam("strStrCd")); 
			strYear    = String2.trimToEmpty(form.getParam("strYear"));  
			strConfirm = String2.trimToEmpty(form.getParam("strConfirm"));
			strBizCd   = String2.trimToEmpty(form.getParam("strBizCd"));

			strLoc = "SEL_BY_ORG";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			sql.setString(i++, strYear);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strBizCd);
			sql.setString(i++, strConfirm);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 월별 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMonth(ActionForm form) throws Exception {

		List ret          = null;
		SqlWrapper sql    = null;
		Service svc       = null;
		String strLoc     = null;
		int i             = 1;
		//파라미터 변수선언
		String strStrCd   = null;
		String strYear    = null;
		String strConfirm = null;
		String strBizCd   = null;
		String strOrgCd   = null;

		try {
			//파라미터 값 가져오기
			strStrCd   = String2.trimToEmpty(form.getParam("strStrCd")); 
			strYear    = String2.trimToEmpty(form.getParam("strYear"));  
			strConfirm = String2.trimToEmpty(form.getParam("strConfirm"));
			strBizCd   = String2.trimToEmpty(form.getParam("strBizCd"));
			strOrgCd   = String2.trimToEmpty(form.getParam("strOrgCd"));

			strLoc = "SEL_BY_MONTH";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			sql.setString(i++, strYear);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strBizCd);
			sql.setString(i++, strOrgCd);
			sql.setString(i++, strConfirm);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 보고서 생성/삭제
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi, String strUserId)
			throws Exception {
		int ret        = 0;
		int i          = 0;
		Service svc    = null;
		SqlWrapper sql = null;
		String strConf = null;
		
		try {
			begin();
			connect("pot");
			
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			while(mi.next()){
				i = 0;
				if("1".equals(mi.getString("CONF_YN"))){
					strConf = "2";
				} else {
					strConf = "1";
				}
				String strLoc  = "UPD_REPORT";
				
				sql.put(svc.getQuery(strLoc));
				sql.setString(++i, strConf);
				sql.setString(++i, strUserId);
				sql.setString(++i, mi.getString("BIZ_PLAN_YEAR"));
				sql.setString(++i, mi.getString("STR_CD"));

				ret = this.update(sql);
				
				sql.close();
			}
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}
}
