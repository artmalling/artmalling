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

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>경영실적조정관리</p>
 * 
 * @created on 1.0, 2011/08/19
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MEis062DAO extends AbstractDAO {

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
	 * 경영실적 조정내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchAdj(ActionForm form) throws Exception {

		List ret         = null;
		SqlWrapper sql   = null;
		Service svc      = null;
		String strLoc    = null;
		int i            = 1;
		//파라미터 변수선언
		String strRsltYm = null;
		String strStrCd  = null;
		String strOrgCd  = null;
		String strBizCd  = null;

		try {
			//파라미터 값 가져오기
			strRsltYm = String2.trimToEmpty(form.getParam("strRsltYm"));
			strStrCd  = String2.trimToEmpty(form.getParam("strStrCd"));
			strOrgCd  = String2.trimToEmpty(form.getParam("strOrgCd"));
			strBizCd  = String2.trimToEmpty(form.getParam("strBizCd"));

			strLoc = "SEL_ADJ";
            
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
	 * 실적 조정 저장
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi, String strUserId)
			throws Exception {
		int ret        = 0;
		int i          = 1;
		Service svc    = null;
		SqlWrapper sql = null;
		Map map        = null;
		try {
			begin();
			connect("pot");
			
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			
			while(mi.next()){
				//배부이력 체크
				i = 1;
				sql.put(svc.getQuery("SEL_DIV_HIS"));
				sql.setString(i++, mi.getString("BIZ_RSLT_YM"));
				sql.setString(i++, mi.getString("STR_CD"));
				sql.setString(i++, mi.getString("ORG_CD"));
				sql.setString(i++, mi.getString("BIZ_CD"));
				map = this.selectMap(sql);
				sql.close();
				if(map.size() != 0)
					throw new Exception("[USER]"+"배부이력이 있어 조정을 할수 없습니다.");
					
				//조정조직의 조정금액 변경
				i = 1;
				sql.put(svc.getQuery("UPD_BIZ_RSLT"));
				sql.setDouble(i++, mi.getDouble("ADJST_AMT"));
				sql.setString(i++, strUserId);
				sql.setString(i++, mi.getString("BIZ_RSLT_YM"));
				sql.setString(i++, mi.getString("STR_CD"));
				sql.setString(i++, mi.getString("BIZ_CD"));
				sql.setString(i++, mi.getString("ORG_CD"));
				ret += this.update(sql);
				sql.close();
				
				//조정대상조직의 조정금액 저장
				i = 1;
				sql.put(svc.getQuery("UST_BIZ_RSLT"));
				sql.setString(i++, mi.getString("BIZ_RSLT_YM"));
				sql.setString(i++, mi.getString("STR_CD"));
				sql.setString(i++, mi.getString("TGET_BIZ_CD"));
				sql.setString(i++, mi.getString("TGET_ORG_CD"));
				sql.setDouble(i++, mi.getDouble("ADJST_AMT"));
				sql.setString(i++, strUserId);
				sql.setString(i++, mi.getString("TGET_ORG_CD"));
				sql.setString(i++, mi.getString("TGET_ORG_CD"));
				ret += this.update(sql);
				sql.close();
				
				//조정내역 저장
				i = 1;
				sql.put(svc.getQuery("INS_ADJ_HIS")); 
				sql.setString(i++, mi.getString("BIZ_RSLT_YM"));
				sql.setString(i++, mi.getString("STR_CD"));
				sql.setString(i++, mi.getString("BIZ_CD"));
				sql.setString(i++, mi.getString("ORG_CD"));
				sql.setString(i++, mi.getString("BIZ_RSLT_YM"));
				sql.setString(i++, mi.getString("STR_CD"));
				sql.setString(i++, mi.getString("BIZ_CD"));
				sql.setString(i++, mi.getString("ORG_CD"));
				sql.setString(i++, mi.getString("ORG_FLAG"));
				sql.setString(i++, mi.getString("ORG_LEVEL"));
				sql.setString(i++, mi.getString("DEPT_CD"));
				sql.setString(i++, mi.getString("TEAM_CD"));
				sql.setString(i++, mi.getString("PC_CD"));
				sql.setDouble(i++, mi.getDouble("ADJST_AMT"));
				sql.setString(i++, mi.getString("TGET_BIZ_CD"));
				sql.setString(i++, mi.getString("REMARK"));
				sql.setString(i++, strUserId);
				sql.setString(i++, strUserId);
				sql.setString(i++, mi.getString("TGET_ORG_CD"));
				ret += this.update(sql);
				sql.close();				
			}
		} catch (Exception e) {
			e.printStackTrace();
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}
}
