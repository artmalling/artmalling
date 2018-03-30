/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pord.dao;
 
import java.util.List;
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import common.util.Util;
/**
 * <p>물품 입고/반품 등록</p>
 *  
 * @created  on 1.0, 2010/01/26 
 * @created  by 박래형(FUJITSU KOREA LTD.)
 * 
 * @modified on  
 * @modified by 
 * @caused   by   
 */

public class POrd701DAO extends AbstractDAO {    	  
	/**
	 * 규격단품 매입발주 리스트 내역 조회
	 *  
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getList(ActionForm form, String userId, String org_flag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = ""; 
		int i = 1;
				
		String strStrCd        = String2.nvl(form.getParam("strStrCd"));
		sql = new SqlWrapper(); 
		svc = (Service) form.getService();
		connect("pot"); 
		
		sql.setString(i++, strStrCd); 
		sql.put(svc.getQuery("SEL_LIST"));
		
		ret = select2List(sql);
		return ret;
	}
}
