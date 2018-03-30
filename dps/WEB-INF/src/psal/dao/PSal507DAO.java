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
 * <p>매출정정현황</p>
 * 
 * @created on 1.0, 2010/04/11
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class PSal507DAO extends AbstractDAO {

	/**
	 * 매출정정현황 MASTER조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchSalCorMst(ActionForm form, String strUsrId)
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
		String strPumCd   = null;
		String strPosNo   = null;

		try {
			//파라미터 값 가져오기
			strStoreCd = String2.trimToEmpty(form.getParam("strStoreCd")); //점구분코드
			strDeptCd  = String2.trimToEmpty(form.getParam("strDeptCd"));  //부문구분코드
			strTeamCd  = String2.trimToEmpty(form.getParam("strTeamCd"));  //팀구분코드
			strPcCd    = String2.trimToEmpty(form.getParam("strPcCd"));    //PC구분코드
			strStartDt = String2.trimToEmpty(form.getParam("strStartDt")); //조회기간 시작일 
			strEndDt   = String2.trimToEmpty(form.getParam("strEndDt"));   //조회기간 종료일
			strPumCd   = String2.trimToEmpty(form.getParam("strPumCd"));   //품번코드
			strPosNo   = String2.trimToEmpty(form.getParam("strPosNo"));   //POS번호

			strLoc = "SEL_SAL_COR_MST";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strStoreCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strStartDt);
			sql.setString(i++, strEndDt);
			sql.setString(i++, strUsrId);
			
			if (!"%".equals(strTeamCd)){
				sql.put(svc.getQuery("SEL_SAL_COR_MST_WHERE_TEAM"));
				sql.setString(i++, strTeamCd);
			}
			
			if (!"%".equals(strPcCd)){
				sql.put(svc.getQuery("SEL_SAL_COR_MST_WHERE_PC"));
				sql.setString(i++, strPcCd);
			}
			
			if (!"".equals(strPumCd)){
				sql.put(svc.getQuery("SEL_SAL_COR_MST_WHERE_PUMBUN"));
				sql.setString(i++, strPumCd);
			}
			
			if (!"".equals(strPosNo)){
				sql.put(svc.getQuery("SEL_SAL_COR_MST_WHERE_POSNO"));
				sql.setString(i++, strPosNo);
			}
			
			sql.put(svc.getQuery("SEL_SAL_COR_MST_GROUPBY"));
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 매출정정현황 DETAIL조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchSalCorDtl(ActionForm form, String strUsrId)
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
		String strCorDate = null;
		String strPumCd   = null;
		String strPosNo   = null;
		String strSaleUsr = null;

		try {
			//파라미터 값 가져오기
			strStoreCd = String2.trimToEmpty(form.getParam("strStoreCd")); //점구분코드
			strDeptCd  = String2.trimToEmpty(form.getParam("strDeptCd"));  //부문구분코드
			strTeamCd  = String2.trimToEmpty(form.getParam("strTeamCd"));  //팀구분코드
			strPcCd    = String2.trimToEmpty(form.getParam("strPcCd"));    //PC구분코드
			strCorDate = String2.trimToEmpty(form.getParam("strCorDate")); //수정매출일자
			strPumCd   = String2.trimToEmpty(form.getParam("strPumCd"));   //품번코드
			strPosNo   = String2.trimToEmpty(form.getParam("strPosNo"));   //POS번호
			strSaleUsr = String2.trimToEmpty(form.getParam("strSaleUsr")); //판매자

			strLoc = "SEL_SAL_COR_DTL";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strStoreCd);
			sql.setString(i++, strCorDate);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPcCd);
			sql.setString(i++, strPumCd);
			sql.setString(i++, strPosNo);
			sql.setString(i++, strSaleUsr);
			sql.setString(i++, strUsrId);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}

}
