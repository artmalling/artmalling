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
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
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

public class MCae503DAO extends AbstractDAO {
	/**
	 * 사은품 일수불 조회
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
		
		String strStrCd 	= String2.nvl(form.getParam("strStrCd"));
		String strEventCd 	= String2.nvl(form.getParam("strEventCd"));   
		String strDate 	= String2.nvl(form.getParam("strDate"));
		String strAQ 	= String2.nvl(form.getParam("strAQ"));
		 
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" + strAQ);
		if(strAQ.equals("1")) {
			strQuery = svc.getQuery("SEL_MASTER") + "\n";
			sql.setString(i++, strDate);  
			sql.setString(i++, strDate);  
			sql.setString(i++, strEventCd); 
			sql.setString(i++, strStrCd); 
			sql.put(strQuery);

			ret = select2List(sql);
		}
		else {
			strQuery = svc.getQuery("SEL_MASTER2") + "\n";
			sql.setString(i++, strDate);  
			sql.setString(i++, strDate);  
			sql.setString(i++, strEventCd); 
			sql.setString(i++, strStrCd); 
			sql.put(strQuery);

			ret = select2List(sql);
		} 
		return ret;
	} 
}
