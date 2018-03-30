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
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
/**
 * <p>발행신청</p>
 * 
 * @created  on 1.0, 2011/04/08
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif117DAO extends AbstractDAO {
	/**
	 * 상품권종류 콤보
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftTypeCd(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		strQuery = svc.getQuery("SEL_COMBO") + "\n";
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 상품권입고내역 마스터 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMaster(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.setString(i++, form.getParam("strStrCd"));
		sql.setString(i++, form.getParam("strSdt"));
		sql.setString(i++, form.getParam("strEdt"));;
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 상품권입고내역 상세조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getDetail(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		sql.setString(i++, form.getParam("strInDt"));
		sql.setString(i++, form.getParam("strStrCd"));
		sql.setString(i++, form.getParam("strInSlipNo"));
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	

	/**
	 * 상품권입고내역 상품권마스터 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getDetail2(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		strQuery = svc.getQuery("SEL_DETAIL2") + "\n";
		sql.setString(i++, form.getParam("strInDt"));
		sql.setString(i++, form.getParam("strStrCd"));
		sql.setString(i++, form.getParam("strInSlipNo"));
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	

}
