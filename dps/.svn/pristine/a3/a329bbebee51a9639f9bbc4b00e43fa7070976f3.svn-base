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
 * <p>카드현장할인쿠폰매출현황</p>
 * 
 * @created on 1.0, 2010/04/08
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class PSal542DAO extends AbstractDAO {

	/**
	 * 카드현장할인쿠폰매출현황 MASTER조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchCouSalMst(ActionForm form)
			throws Exception {

		List ret               = null;
		SqlWrapper sql         = null;
		Service svc            = null;
		String strLoc          = null;
		int i                  = 1;
		//파라미터 변수선언
		String strStoreCd      = null;
		String strStartDt      = null;
		String strEndDt        = null;
		String strPosNo        = null;
		String strCouponType   = null;
		String strCouponCd     = null;

		try {
			//파라미터 값 가져오기
			strStoreCd      = String2.trimToEmpty(form.getParam("strStoreCd"));      //점구분코드
			strStartDt      = String2.trimToEmpty(form.getParam("strStartDt"));      //조회기간 시작일 
			strEndDt        = String2.trimToEmpty(form.getParam("strEndDt"));        //조회기간 종료일
			strPosNo        = String2.trimToEmpty(form.getParam("strPosNo"));        //POS번호
			strCouponType   = String2.trimToEmpty(form.getParam("strCouponType"));   //쿠폰유형
			strCouponCd     = String2.trimToEmpty(form.getParam("strCouponCd"));   //쿠폰종류

			strLoc = "SEL_COU_SAL_MST_TOP";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));

			sql.setString(i++, strCouponType);	
			sql.setString(i++, strCouponCd);	
			sql.setString(i++, strStoreCd);
			sql.setString(i++, strStartDt);
			sql.setString(i++, strEndDt);
			
			if (!"".equals(strPosNo)){
				sql.put(svc.getQuery("SEL_COU_SAL_MST_WHERE_POS_NO"));
				sql.setString(i++, strPosNo);
			}
			
			sql.put(svc.getQuery("SEL_COU_SAL_MST_MIDDLE"));
			
			sql.setString(i++, strCouponType);	
			sql.setString(i++, strCouponCd);	
			sql.setString(i++, strStoreCd);
			sql.setString(i++, strStartDt);
			sql.setString(i++, strEndDt);
			
			if (!"".equals(strPosNo)){
				sql.put(svc.getQuery("SEL_COU_SAL_MST_WHERE_POS_NO"));
				sql.setString(i++, strPosNo);
			}
			
			sql.put(svc.getQuery("SEL_COU_SAL_MST_BOTTOM"));
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 쿠폰매출현황 DETAIL조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchCouSalDtl(ActionForm form)
			throws Exception {

		List ret          = null;
		SqlWrapper sql    = null;
		Service svc       = null;
		String strLoc     = null;
		int i             = 1;
		//파라미터 변수선언
		String strStoreCd = null;
		String strStartDt = null;
		String strPosNo   = null;
		String strCouType = null;
		String strCouponCd = null;

		try {
			//파라미터 값 가져오기
			strStoreCd = String2.trimToEmpty(form.getParam("strStoreCd")); //점코드
			strStartDt = String2.trimToEmpty(form.getParam("strStartDt")); //매출일자
			strCouponCd = String2.trimToEmpty(form.getParam("strCouponCd"));   //쿠폰종류

			strLoc = "SEL_COU_SAL_DTL";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strStoreCd);
			sql.setString(i++, strStartDt);
			sql.setString(i++, strCouponCd);	
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}

}
