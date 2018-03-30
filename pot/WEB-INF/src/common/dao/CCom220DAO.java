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
 * 상품 조회 팝업 DAO
 * 
 * @created on 1.0, 2010/01/25
 * @created by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class CCom220DAO extends AbstractDAO {
	/**
	 * 점별 상품  팝업 조회
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
			throw new Exception("# CCom220DAO.searchOnPop] MuiltiInput is null");
		connect("pot");

		svc = (Service) form.getService();
		sql = new SqlWrapper();
		sql.put(svc.getQuery(mi.getString("SERVICE_ID")));

		int idx = 1;
		sql.setString(idx++, mi.getString("STR_CD"));
		
		if(!mi.getString("PUMBUN_CD").equals("")){
			sql.setString(idx++, mi.getString("PUMBUN_CD"));
		}
		if(mi.getString("SKU_GB").equals("01")){
			sql.put(svc.getQuery("ADD_SKU_POP2_01"));
		}
		if(mi.getString("SKU_GB").equals("02")){
			sql.put(svc.getQuery("ADD_SKU_POP2_02"));
		}
		if(!mi.getString("EVENT_CD").equals("")){
			sql.put(svc.getQuery("ADD_SKU_POP3_01"));
			sql.setString(idx++, mi.getString("EVENT_CD"));
		}
		sql.put(svc.getQuery("ADD_SKU_POP2_ORD"));
		
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

		ret = select2List(sql);

		return ret;
	}

}
