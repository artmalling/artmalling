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

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>사은품행사현황</p>
 * 
 * @created on 1.0, 2010/04/15
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class PSal601DAO extends AbstractDAO {

	/**
	 * 사은품행사현황 MASTER조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchGiftEvtMst(ActionForm form, String strUsrId)
			throws Exception {

		List ret          = null;
		SqlWrapper sql    = null;
		Service svc       = null;
		int i             = 1;
		//파라미터 변수선언
		String strStoreCd = null;
		String strDeptCd  = null;
		String strTeamCd  = null;
		String strPcCd    = null;
		String strStartDt = null;
		String strEndDt   = null;
		String strEventCd = null;

		try {
			//파라미터 값 가져오기
			strStoreCd = String2.trimToEmpty(form.getParam("strStoreCd")); //점구분코드
			strDeptCd  = String2.trimToEmpty(form.getParam("strDeptCd"));  //부문구분코드
			strTeamCd  = String2.trimToEmpty(form.getParam("strTeamCd"));  //팀구분코드
			strPcCd    = String2.trimToEmpty(form.getParam("strPcCd"));    //PC구분코드
			strStartDt = String2.trimToEmpty(form.getParam("strStartDt")); //조회기간 시작일 
			strEndDt   = String2.trimToEmpty(form.getParam("strEndDt"));   //조회기간 종료일
			strEventCd = String2.trimToEmpty(form.getParam("strEventCd"));   //행사코드

			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			if ("%".equals(strDeptCd)){
				sql.put(svc.getQuery("SEL_GIFT_EVT_MST_DEPT"));
			}
			else{
				if ("%".equals(strTeamCd)) sql.put(svc.getQuery("SEL_GIFT_EVT_MST_TEAM"));
				else sql.put(svc.getQuery("SEL_GIFT_EVT_MST_PC"));
			}
			
			
			sql.setString(i++, strStoreCd);
			sql.setString(i++, strStartDt);
			sql.setString(i++, strEndDt);
			sql.setString(i++, strEventCd);
			sql.setString(i++, strStoreCd);
			if (!"%".equals(strDeptCd)){
				sql.setString(i++, strDeptCd);
			}
			
			if (!"%".equals(strTeamCd)){
				sql.setString(i++, strTeamCd);
			}
			sql.setString(i++, strStoreCd);
			sql.setString(i++, strStartDt);
			sql.setString(i++, strEndDt);
			sql.setString(i++, strEventCd);
			sql.setString(i++, strUsrId);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 사은품행사현황 DETAIL조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchGiftEvtDtl(ActionForm form, String strUsrId)
			throws Exception {

		List ret          = null;
		SqlWrapper sql    = null;
		Service svc       = null;
		String strLoc     = null;
		int i             = 1;
		//파라미터 변수선언
		String strStoreCd = null;
		String strDeptCd  = null;
		String strTeamCd  = null;
		String strPcCd    = null;
		String strStartDt = null;
		String strEndDt   = null;
		String strEventCd = null;

		try {
			//파라미터 값 가져오기
			strStoreCd = String2.trimToEmpty(form.getParam("strStoreCd")); //점구분코드
			strDeptCd  = String2.trimToEmpty(form.getParam("strDeptCd"));  //부문구분코드
			strTeamCd  = String2.trimToEmpty(form.getParam("strTeamCd"));  //팀구분코드
			strPcCd    = String2.trimToEmpty(form.getParam("strPcCd"));    //PC구분코드
			strStartDt = String2.trimToEmpty(form.getParam("strStartDt")); //조회시작일
			strEndDt   = String2.trimToEmpty(form.getParam("strEndDt"));   //조회종료일
			strEventCd = String2.trimToEmpty(form.getParam("strEventCd"));   //행사코드
            
			if ("%".equals(strDeptCd)){
				strLoc = "SEL_GIFT_EVT_DTL_DEPT";
			}
			else{
				strLoc = "SEL_GIFT_EVT_DTL_TEAM";
				if (!"%".equals(strPcCd)){
					strLoc = "SEL_GIFT_EVT_DTL_PC";
				}
			}
			
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strStoreCd);
			if (!"%".equals(strDeptCd)){
				sql.setString(i++, strDeptCd);
			}
			
			if (!"%".equals(strPcCd)){
				sql.setString(i++, strTeamCd);
			}
			sql.setString(i++, strStoreCd);
			sql.setString(i++, strStartDt);
			sql.setString(i++, strEndDt);
			sql.setString(i++, strEventCd);
			sql.setString(i++, strUsrId);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}

}
