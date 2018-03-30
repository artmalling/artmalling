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
 * <p>행사별 사은품 현황내역</p>
 * 
 * @created  on 1.0, 2016/12/30
 * @created  by 윤지영 
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class MCae404DAO extends AbstractDAO {
	
	/**
	* 행사별 사은품 현황내역 현황
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
		String strSdt = String2.nvl(form.getParam("strSdt"));
		String strEdt = String2.nvl(form.getParam("strEdt"));
		String strEventCd = String2.nvl(form.getParam("strEventCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService(); 
		connect("pot");
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEventCd); 
		sql.setString(i++, strSdt); 
		sql.setString(i++, strEdt); 
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}  
}
