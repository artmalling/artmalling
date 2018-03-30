/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mcae.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
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

public class MCae450DAO extends AbstractDAO {
	/**
	 * 사은행사지급내역(사원별)
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
			
		String strStrCd  	= String2.nvl(form.getParam("strStrCd"));
		String strSaleFrDt 	= String2.nvl(form.getParam("strSaleFrDt"));
		String strSaleToDt 	= String2.nvl(form.getParam("strSaleToDt"));
		String strPosNo  	= String2.nvl(form.getParam("strPosNo"));
		String strTranNo  	= String2.nvl(form.getParam("strTranNo"));
		String strEventCd 	= String2.nvl(form.getParam("strEventCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService(); 
		connect("pot");
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSaleFrDt);
		sql.setString(i++, strSaleToDt);
		sql.setString(i++, strPosNo);
		sql.setString(i++, strTranNo);
		sql.setString(i++, strEventCd);
		
		
		
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 사은행사지급내역_상세
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
			
		String strStrCd  	= String2.nvl(form.getParam("strStrCd"));
		String strPrsntDt 	= String2.nvl(form.getParam("strPrsntDt"));
		String strPrsntNo 	= String2.nvl(form.getParam("strPrsntNo"));
		String strDt 		= String2.nvl(form.getParam("strDt"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService(); 
		connect("pot");
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		
		sql.setString(i++, strDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPrsntDt);
		sql.setString(i++, strPrsntNo);

		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	

}
