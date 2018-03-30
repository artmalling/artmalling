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
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>POS 사은품 회수관리</p>
 * 
 * @created  on 1.0, 2011/03/14
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MCae407DAO extends AbstractDAO {
	/**
	 * POS 사은품 회수 조회
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
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		sql.setString(i++, String2.nvl(form.getParam("strStrCd")));
		sql.setString(i++, String2.nvl(form.getParam("strFlorCd")));
		sql.setString(i++, String2.nvl(form.getParam("strPosCd")));
		sql.setString(i++, String2.nvl(form.getParam("strSdt")));
		sql.setString(i++, String2.nvl(form.getParam("strEdt")));
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 합산 영수증 정보 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getDetail
(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		sql.setString(i++, String2.nvl(form.getParam("strStrCd")));
		sql.setString(i++, String2.nvl(form.getParam("strPosNo"))); 
		sql.setString(i++, String2.nvl(form.getParam("strSdt"))); 
		sql.setString(i++, String2.nvl(form.getParam("strEdt")));   
		
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	 
}
