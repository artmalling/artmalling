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
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2010.07.24
 * @created  by 강진(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MCae607DAO extends AbstractDAO {
	/**
	 * 할인쿠폰번호조회 -MASTER
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
		sql.setString(i++, strSdt);
		sql.setString(i++, strEdt);
		sql.setString(i++, strEventCd);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 할인쿠폰번호조회 -DETAIL
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getDetail(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
 
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strSdate = String2.nvl(form.getParam("strSdate"));
		String strEdate = String2.nvl(form.getParam("strEdate"));
		String strEventCd = String2.nvl(form.getParam("strEventCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService(); 
		connect("pot");
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSdate);
		sql.setString(i++, strEdate);
		sql.setString(i++, strEventCd);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
}
