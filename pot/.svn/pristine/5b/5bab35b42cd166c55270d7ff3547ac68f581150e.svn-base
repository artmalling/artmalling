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
 * <p>가맹점 조회 팝업DAO</p>
 * @created on 1.0, 2010/02/21
 * @created by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class CCom201DAO extends AbstractDAO {
	/**
	 * 조회
	 * @param svc
	 * @return List
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public List getDate(ActionForm form, MultiInput mi)
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
			
			if(mi.getString("VEN_FLAG").equals("")){
				sql.put(svc.getQuery("SEL_EVT_VEN_ALL"));
			}else{
				sql.put(svc.getQuery("SEL_EVT_VEN")); 
				sql.setString(++i, mi.getString("VEN_FLAG"));
			}
			
			sql.setString(++i, mi.getString("STR_CD"));
			sql.setString(++i, mi.getString("CODE"));
			sql.setString(++i, mi.getString("NAME"));
			
			list = select2List(sql);
		} catch (Exception e) {
			 throw e;
		}
		return list;
	}
}
