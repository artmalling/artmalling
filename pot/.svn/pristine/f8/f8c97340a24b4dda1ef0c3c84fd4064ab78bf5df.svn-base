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
 * * 우편번호 조회 팝업
 * </p>
 * 우편번호 조회 팝업화면 DAO
 * 
 * @created on 1.0, 2010/12/24
 * @created by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class CCom400DAO extends AbstractDAO {
	/**
	 * 조회조건으로 준류 코드 조회
	 * 
	 * @param form
	 * @param mi
	 *            : 코드/코드명
	 * @return List : 분류 코드 조회 결과
	 */
	public List searchMaster(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strbrchName = String2.nvl(form.getParam("strbrchName"));
		String strcompNo = String2.nvl(form.getParam("strcompNo"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strbrchName);
		sql.setString(i++, strcompNo);

		strQuery = svc.getQuery("searchMaster") + "\n";

		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

}
