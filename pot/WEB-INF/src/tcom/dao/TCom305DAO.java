/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package tcom.dao;

import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>실시간로그인현황</p>
 *  
 * @created  on 1.0, 2010/06/23
 * @created  by HSEON(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class TCom305DAO extends AbstractDAO { 

	/**
	 *  실시간로그인현황을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List selectList(ActionForm form) throws Exception {
		
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	 

        try { 
 
			String strEodDt = String2.nvl(form.getParam("strEodDt"));	//조직코드



			sql = new SqlWrapper();
			svc = (Service) form.getService();
	
			connect("pot");
			
			strQuery = svc.getQuery("SEL_EODLOG_LIST") + "\n";
			sql.setString(i++, strEodDt);

			sql.put(strQuery); 
			
			list = select2List(sql);
        } catch (Exception e) {
            throw e;
        }
        return list;
	}
}
