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
 * <p>상품권매출현황</p>
 * 
 * @created on 1.0, 2010/04/06
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class PSal505DAO extends AbstractDAO {

	/**
	 * 상품권매출 현황조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchVouSalList(ActionForm form)
			throws Exception {

		List ret          = null;
		SqlWrapper sql    = null;
		Service svc       = null;
		String strLoc     = null;
		int i             = 1;
		//파라미터 변수선언
		String strStoreCd = null;
		String strStartDt = null;
		String strEndDt   = null;
		String strVouType = null;

		try {
			//파라미터 값 가져오기
			strStoreCd  = String2.trimToEmpty(form.getParam("strStoreCd")); //점구분코드
			strStartDt  = String2.trimToEmpty(form.getParam("strStartDt")); //조회기간 시작일 
			strEndDt    = String2.trimToEmpty(form.getParam("strEndDt"));   //조회기간 종료일
			strVouType  = String2.trimToEmpty(form.getParam("strVouType")); //상품권구분코드

			strLoc = "SEL_VOU_SAL_LIST";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strStoreCd);
			sql.setString(i++, strStartDt);
			sql.setString(i++, strEndDt);
			
			if (!"%".equals(strVouType)){
				sql.put(svc.getQuery("SEL_VOU_SAL_LIST_WHERE_TYPE"));
				sql.setString(i++, strVouType);
			}
			
			sql.put(svc.getQuery("SEL_VOU_SAL_LIST_GROUP"));
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}

}
