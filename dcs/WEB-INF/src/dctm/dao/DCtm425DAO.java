/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dctm.dao;

import java.util.List;

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>브랜드별회원가입현황조회</p>
 * 
 * @created  on 1.0, 2012.05.23
 * @created  by 강진
 * 
 * @modified on 
 * @modified by  
 * @caused   by 
 */

public class DCtm425DAO extends AbstractDAO {

	public List getMaster(ActionForm form, String userId, String org_flag) throws Exception {
		Util util       = new Util();
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;          
		
		String strGbFlag  = String2.nvl(form.getParam("strGbFlag"));
		String strFromDt  = String2.nvl(form.getParam("strFromDt"));
		String strToDt  = String2.nvl(form.getParam("strToDt"));
		String strStrCd   = String2.nvl(form.getParam("strStrCd"));
	
		sql = new SqlWrapper();     
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_MASTER")); 
		
		sql.setString(i++, strFromDt);
		sql.setString(i++, strToDt);
		sql.setString(i++, strGbFlag);		
		sql.setString(i++, strFromDt);
		sql.setString(i++, strToDt);          
		sql.setString(i++, strGbFlag);		

		ret = select2List(sql);

		return ret;
	}
}
