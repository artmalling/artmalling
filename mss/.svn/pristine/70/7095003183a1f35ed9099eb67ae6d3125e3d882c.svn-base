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

public class MCae302DAO extends AbstractDAO {
	/**
	 * 물품 입고/반품조회 - MASTER
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
		 
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strSdt 	= String2.nvl(form.getParam("strSdt"));
		String strEdt	= String2.nvl(form.getParam("strEdt"));
		String strBuy	= String2.nvl(form.getParam("strBuy"));
		String strEvent = String2.nvl(form.getParam("strEvent")); 
		String strVencd = String2.nvl(form.getParam("strVencd")); 
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSdt);
		sql.setString(i++, strEdt);
		sql.setString(i++, strBuy);
		sql.setString(i++, strEvent);  
		sql.setString(i++, strVencd);  
		
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 물품 입고/반품조회 - DETAIL
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
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strEvent = String2.nvl(form.getParam("strEvent"));
		String strIlja	= String2.nvl(form.getParam("strIlja"));
		String strSlip	= String2.nvl(form.getParam("strSlip")); 
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEvent);
		sql.setString(i++, strIlja);
		sql.setString(i++, strSlip); 

		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}

}
