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
//import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>층별/상품별 매춣현황</p>
 * 
 * @created  on 1.0, 2010/07/28
 * @created  by 정진영(FKSS)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PSal443DAO extends AbstractDAO {

	/**
	 * 층별 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchFloor(ActionForm form) throws Exception {

		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		int i 			= 1;

		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strFromDt 		= String2.nvl(form.getParam("strFromDt"));
		String strToDt   		= String2.nvl(form.getParam("strToDt"));
		String strHallCd		= String2.nvl(form.getParam("strHallCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_FLOOR"));

		sql.setString(i++, strStrCd);
		sql.setString(i++, strFromDt);
		sql.setString(i++, strToDt);
		sql.setString(i++, strHallCd);
		

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 상품별 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchPType(ActionForm form) throws Exception {

		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		int i 			= 1;

		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strFromDt 		= String2.nvl(form.getParam("strFromDt"));
		String strToDt   		= String2.nvl(form.getParam("strToDt"));
		String strHallCd		= String2.nvl(form.getParam("strHallCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_PTYPE"));

		sql.setString(i++, strStrCd);
		sql.setString(i++, strFromDt);
		sql.setString(i++, strToDt);
		sql.setString(i++, strHallCd);

		ret = select2List(sql);

		return ret;
	}


}
