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


import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>무인정산자료 비교표</p>
 * 
 * @created  on 1.0, 2016/10/27
 * @created  by 박래형
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PSal611DAO extends AbstractDAO {

	/**
	 * 무인정산자료 비교표 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String strId) throws Exception {
		
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strQuery = "";
		int i = 0;	
		
		String strStrCd       = String2.nvl(form.getParam("strStrCd"));
		String strSaleDt      = String2.nvl(form.getParam("strSaleDt"));
		String strSaleEndDt   = String2.nvl(form.getParam("strSaleEndDt"));
		String strPosNo       = String2.nvl(form.getParam("strPosNo"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		strQuery = svc.getQuery("SEL_MASTER") ;
		
		sql.put(strQuery);
		
		sql.setString(++i, strStrCd);
		sql.setString(++i, strPosNo);
		sql.setString(++i, strSaleDt);
		sql.setString(++i, strSaleEndDt);
		
		sql.setString(++i, strStrCd);
		sql.setString(++i, strPosNo);
		sql.setString(++i, strSaleDt);
		sql.setString(++i, strSaleEndDt);
		
		sql.setString(++i, strStrCd);
		sql.setString(++i, strSaleDt);
		sql.setString(++i, strSaleEndDt);
		sql.setString(++i, strPosNo);

		
		
		
		

		ret = select2List(sql);
		return ret;
	}

	/**
	 * 무인정산자료 비교표 상세조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDetail(ActionForm form, String strId) throws Exception {
		
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;                         
		String strQuery = "";
		int i = 0;	
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strStrDt = String2.nvl(form.getParam("strStrDt"));
		String strEndDt = String2.nvl(form.getParam("strEndDt"));
		String strPosNo = String2.nvl(form.getParam("strPosNo"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		sql.setString(++i, strStrCd);
		sql.setString(++i, strStrDt);
		sql.setString(++i, strEndDt);
		sql.setString(++i, strPosNo);
		sql.put(strQuery);

		ret = select2List(sql);
		return ret;
	}
}
