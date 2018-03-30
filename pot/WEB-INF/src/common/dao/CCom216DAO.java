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
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;

/**
 * <p>사은행사 마스터 관리 - 제휴카드사 조회</p>
 * @created on 1.0, 2010.05.02
 * @created by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class CCom216DAO extends AbstractDAO {
	/**
	 * 조회
	 * @param svc
	 * @return List
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public List getList(ActionForm form, MultiInput mi)
			throws Exception {

		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		try {
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			connect("pot");
			mi.next();
			int i = 0;
			sql.put(svc.getQuery("SEL_CODE")+"\n");
			sql.setString(++i, mi.getString("STR_CD"));
			sql.setString(++i, mi.getString("CARD_COMP"));
			if(!mi.getString("CARD_COMP_NM").equals("")){
				sql.put(svc.getQuery("SEL_CODE_NAME")+"\n");
				sql.setString(++i, mi.getString("CARD_COMP_NM"));
			}
			sql.put(svc.getQuery("SEL_CODE_ORDER")+"\n");
			list = select2List(sql);
		} catch (Exception e) {
			 throw e;
		}
		return list;
	}
}
