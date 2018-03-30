/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package ecom.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import ecom.vo.SessionInfo2;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>
 * 좌측 프레임/메뉴 구성
 * </p>
 * 
 * @created on 1.0, 2010/12/14
 * @created by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class ECom003DAO extends AbstractDAO2 {

	/**
	 * <p>
	 * 메뉴를 위한 List를 리턴한다.
	 * </p>
	 * 
	 */
	public List getMenuList(ActionForm form, String submenu, String strGb, String strVen) throws Exception {

		List list = null;
		SqlWrapper sql = null;
		Service svc = null;

		try {
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			  
			connect("pot");
			
			if(strGb.equals("@")) { 
				sql.put(svc.getQuery("SEL_MENU_LIST_99999"));
				sql.setString(1, strVen); 
			}
			else { 
				sql.put(svc.getQuery("SEL_MENU_LIST")); 
				sql.setString(1, submenu);  
			} 

			list = executeQuery(sql);

		} catch (Exception e) {
			throw e;
		}
		return list;
	}

}
