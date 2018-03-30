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
 * <p>고객수신동의송신현황조회</p>
 * 
 * @created  on 1.0, 2012.05.23
 * @created  by 강진
 * 
 * @modified on 
 * @modified by  
 * @caused   by 
 */

public class DCtm427DAO extends AbstractDAO {

	public List searchMaster(ActionForm form) throws Exception {
		Util util       = new Util();
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;          

		String strFromDt  = String2.nvl(form.getParam("strFromDt"));
		String strToDt  = String2.nvl(form.getParam("strToDt"));
	
		sql = new SqlWrapper();     
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_MASTER")); 
		
		sql.setString(i++, strFromDt);
		sql.setString(i++, strToDt);

		ret = select2List(sql);
        /*ret = util.decryptedStr(ret,4);
        ret = util.decryptedStr(ret,7);
        ret = util.decryptedStr(ret,8);
        ret = util.decryptedStr(ret,9);
        ret = util.decryptedStr(ret,10);
        ret = util.decryptedStr(ret,11);  */
        
		return ret;
	}
}

