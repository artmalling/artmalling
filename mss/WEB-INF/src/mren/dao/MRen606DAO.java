/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mren.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>
 * 관리비정산조회
 * </p>
 * 
 * @created on 1.0, 2010.05.26
 * @created by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MRen606DAO extends AbstractDAO {

	/**
	 * <p>
	 * 관리비정산내역조회
	 * </p>
	 */
	@SuppressWarnings("rawtypes")
	public List getMaster(ActionForm form) throws Exception {

		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		try {
			connect("pot");
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			
			String strGaugType 	= String2.nvl(form.getParam("strGaugType"));// 계량기구분
			String strStrCd 	= String2.nvl(form.getParam("strStrCd")); 	// 시설구분
			String strCalYM 	= String2.nvl(form.getParam("strCalYM"));	// 부과년월
			int i = 0;

			sql.put(svc.getQuery("SEL_MGAUGUSED_MONTH"));
			sql.setString(++i, strGaugType); 
			sql.setString(++i, strCalYM);
			sql.setString(++i, strStrCd);
			
			list = select2List(sql);

		} catch (Exception e) {
			throw e;
		}
		return list;
	}
}
