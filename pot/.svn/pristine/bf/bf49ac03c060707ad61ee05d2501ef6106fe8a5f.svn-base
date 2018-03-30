/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package common.dao;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import common.vo.SessionInfo;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>
 * 경영지원
 * </p>
 * 행사코드 조회 팝업 DAO
 * 
 * @created on 1.0, 2010/01/25
 * @created by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class CCom210DAO extends AbstractDAO {
	/**
	 * 점별 행사 코드 팝업 조회
	 * 
	 * @param svc
	 * @return List
	 * @throws Exception
	 */
	public List searchOnPop(ActionForm form, MultiInput mi) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;

		if (!mi.next())
			throw new Exception("# CCom210DAO.searchOnPop] MuiltiInput is null");
		connect("pot");

		svc = (Service) form.getService();
		sql = new SqlWrapper();

		sql.put(svc.getQuery(mi.getString("SERVICE_ID")));

		int idx = 1;
		sql.setString(idx++, mi.getString("COND_TXT"));
		sql.setString(idx++, mi.getString("COND_TXT"));
		sql.setString(idx++, mi.getString("STR_CD"));
		sql.setString(idx++, mi.getString("EVENT_S_DT"));
		sql.setString(idx++, mi.getString("EVENT_S_DT"));
		sql.setString(idx++, mi.getString("EVENT_E_DT"));
		sql.setString(idx++, mi.getString("EVENT_E_DT"));
		sql.setString(idx++, mi.getString("EVENT_S_DT"));
		sql.setString(idx++, mi.getString("EVENT_E_DT"));
		sql.setString(idx++, mi.getString("EVENT_S_DT"));
		sql.setString(idx++, mi.getString("EVENT_E_DT"));
		
		String addCond = mi.getString("ADD_CONDITION");
		if (!"".equals(addCond)) {
			String[] addConds = addCond.split("#G#");
			for (int i = 2; i < addConds.length; i++) {
				sql.put(svc.getQuery("SEL_STR_EVENT_POP_COND_0"+i));
				sql.setString(idx++, addConds[i]);
			}
		}
		sql.put(svc.getQuery("SEL_STR_EVENT_POP_TAIL"));
		
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 팝업 없이 조회하기
	 * 
	 * @param svc
	 * @return List
	 * @throws Exception
	 */
	public List getOneWithoutPop(ActionForm form, MultiInput mi)
			throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		
		if (!mi.next())
			throw new Exception(
					"# CCom210DAO.getOneWithoutPop] MuiltiInput is null");
		connect("pot");

		svc = (Service) form.getService();
		sql = new SqlWrapper();

		sql.put(svc.getQuery(mi.getString("SERVICE_ID")));
		int idx = 1;
		sql.setString(idx++, mi.getString("CODE_CD"));
		//sql.setString(idx++, mi.getString("CODE_CD"));
		
		String addCond = mi.getString("ADD_CONDITION");

		if (!"".equals(addCond)) {
			String[] addConds = addCond.split("#G#");
			for (int i = 0; i < addConds.length; i++) {
				sql.setString(idx++, addConds[i]);
			}
		}
		
		ret = select2List(sql);

		return ret;
	}

}
