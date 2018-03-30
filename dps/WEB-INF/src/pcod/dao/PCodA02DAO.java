/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pcod.dao;

import java.net.URLDecoder;
import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>EOD로그 조회  </p>
 * 
 * @created  on 1.0, 2010/08/04
 * @created  by 김경은
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCodA02DAO extends AbstractDAO {

	/**
	 * 마스터 을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
	    
		String strBldDt       = String2.nvl(form.getParam("strBldDt"));
		String strWkFlag      = String2.nvl(form.getParam("strWkFlag"));
		String strLogCd       = String2.nvl(form.getParam("strLogCd"));
		String strProcId      = URLDecoder.decode( String2.nvl(form.getParam("strProcId")), "UTF-8");
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
   
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.setString(i++, strBldDt);
		sql.setString(i++, strBldDt);

		if( !strWkFlag.equals("%")){
			sql.setString(i++, strWkFlag);
			strQuery += svc.getQuery("WHERE_WK_FLAG") + "\n";
		}
		if( !strLogCd.equals("%")){
			sql.setString(i++, strLogCd);
			strQuery += svc.getQuery("WHERE_LOG_CD") + "\n";  
		}
		if( !strProcId.equals("%")){
			sql.setString(i++, strProcId);
			sql.setString(i++, strProcId);
			strQuery += svc.getQuery("WHERE_PROC_ID") + "\n";
		}
		
		strQuery += svc.getQuery("SEL_ORDER");
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 마스터 을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getProcId(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_PROC_ID") + "\n";
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
}
