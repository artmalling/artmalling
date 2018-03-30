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

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>기간별전자쿠폰사용내역</p>
 * 
 * @created  on 1.0, 2010/03/21
 * @created  by 김영진
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMbo406DAO extends AbstractDAO {

	public List getMaster(ActionForm form, String userId, String org_flag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null; 
		int i = 1;          
		
		String strStrCd   = String2.nvl(form.getParam("strStrCd"));
		String strFromDt  = String2.nvl(form.getParam("strFromDt"));
		String strToDt  = String2.nvl(form.getParam("strToDt"));
		String strGbFlag  = String2.nvl(form.getParam("strGbFlag"));
		
		sql = new SqlWrapper();     
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_MASTER")); 
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strFromDt);
		sql.setString(i++, strToDt);
		sql.setString(i++, strGbFlag);
		
		

		ret = select2List(sql);
		return ret;
	}
}

