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
import java.util.Map;

import common.util.Util;
//import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PSal427DAO extends AbstractDAO {

	/**
	 * 마스터 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String OrgFlag, String userid) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		int i 			= 1;
		

		
		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strPosFloor 		= String2.nvl(form.getParam("strPosFloor"));
		String strPosFlag 		= String2.nvl(form.getParam("strPosFlag"));
		String strPosNoS 	    = String2.nvl(form.getParam("strPosNoS"));
		String strPosNoE 	    = String2.nvl(form.getParam("strPosNoE"));
		String strSaleDtS 		= String2.nvl(form.getParam("strSaleDtS"));
		String strSaleDtE 		= String2.nvl(form.getParam("strSaleDtE"));
		String strCreditFlag 	= String2.nvl(form.getParam("strCreditFlag"));
		
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_SALE_POS_M"));

		sql.setString(i++, strStrCd);
		sql.setString(i++, strPosFloor);
		sql.setString(i++, strPosFlag);
		sql.setString(i++, strPosNoS);
		sql.setString(i++, strPosNoE);
		sql.setString(i++, strCreditFlag);
		sql.setString(i++, strCreditFlag);
		sql.setString(i++, strSaleDtS);
		sql.setString(i++, strSaleDtE);
		sql.setString(i++, userid);
		
	
		ret = select2List(sql);
		
		return ret;
	}


	/**
	 * POSNO 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchPosNo(ActionForm form, String OrgFlag, String userid) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		int i 			= 1;
		

		
		String strPosNo 	    = String2.nvl(form.getParam("strPosNo"));
		
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_POSNO"));

		sql.setString(i++, strPosNo);
		
	
		ret = select2List(sql);
		
		return ret;
	}

	/**
	 * POSNO 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchPosNoMM(ActionForm form, String OrgFlag, String userid) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		int i 			= 1;
		

		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_POSNOMM"));

	
		ret = select2List(sql);
		
		return ret;
	}


}
