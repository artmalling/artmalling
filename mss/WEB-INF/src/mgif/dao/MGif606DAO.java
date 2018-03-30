/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mgif.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>자사위탁판매 채권관리</p>
 * 
 * @created on 1.0, 2011/04/20
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MGif606DAO extends AbstractDAO {

	/**
	 * 위탁판매채권 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchConBondList(ActionForm form)
			throws Exception {

		List ret          = null;
		SqlWrapper sql    = null;
		Service svc       = null;
		String strLoc     = null;
		int i             = 1;
		//파라미터 변수선언
		String strStoreCd = null;
		String strCloseYM = null;
		String strVenCd   = null;

		try {
			//파라미터 값 가져오기
			strStoreCd  = String2.trimToEmpty(form.getParam("strStoreCd")); //본사점구분코드
			strCloseYM  = String2.trimToEmpty(form.getParam("strCloseYM")); //마감년월
			strVenCd    = String2.trimToEmpty(form.getParam("strVenCd"));   //위탁협력사코드

			strLoc = "SEL_CON_BOND_LIST";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strStoreCd);
			sql.setString(i++, strCloseYM);
			
			if (!"".equals(strVenCd)){
				sql.put(svc.getQuery("SEL_CON_BOND_LIST_WHERE_VEN_CD"));
				sql.setString(i++, strVenCd);
			}
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}

}
