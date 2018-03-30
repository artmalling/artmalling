/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dmbo.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>포인트 강제처리 현황표</p>
 * 
 * @created  on 1.0, 2010/03/24
 * @created  by 장형욱(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMbo605DAO extends AbstractDAO {

	/**
	 * 포인트 강제처리 현황을 조회한다.
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
		
		String strProrDt_f = String2.nvl(form.getParam("strProrDt_f"));
		String strProrDt_t = String2.nvl(form.getParam("strProrDt_t"));
		String strBrchCd   = String2.nvl(form.getParam("strBrchCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strProrDt_f);
		sql.setString(i++, strProrDt_t);
		sql.setString(i++, strBrchCd);

		strQuery = svc.getQuery("SEL_MASTER") + "\n";

		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	public List httpstore(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strProrDt_f = String2.nvl(form.getParam("strProrDt_f"));
		String strProrDt_t = String2.nvl(form.getParam("strProrDt_t"));
		String strBrchCd   = String2.nvl(form.getParam("strBrchCd")); 

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot"); 
 
		sql.setString(i++, strProrDt_f);
		sql.setString(i++, strProrDt_t);
		sql.setString(i++, strBrchCd);

	    strQuery = svc.getQuery("SEL_MASTER_REPORT"); 

		sql.put(strQuery);
	    ret = this.select(sql);
		return ret; 
	}

}
