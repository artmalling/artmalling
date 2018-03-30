/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pcod.dao;

import java.util.List;
import java.util.Map;


import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>행사장 매출조회</p>
 * 
 * @created  on 1.0, 2016/10/27
 * @created  by 박래형
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod712DAO extends AbstractDAO {

	/**
	 * 행사장 마스터를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String strId) throws Exception {
		
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strQuery = "";
		int i = 0;	
		
		String strStrCd        = String2.nvl(form.getParam("strStrCd"));
		String strEventPlaceCd = String2.nvl(form.getParam("strEventPlaceCd"));
		String strSaleDtS      = String2.nvl(form.getParam("strSaleDtS"));
		String strSaleDtE      = String2.nvl(form.getParam("strSaleDtE"));
		String strGbn          = String2.nvl(form.getParam("strGbn"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.setString(++i, strGbn);
		sql.setString(++i, strGbn);
		sql.setString(++i, strGbn);
		sql.setString(++i, strGbn);
		sql.setString(++i, strGbn);
		sql.setString(++i, strGbn);
		sql.setString(++i, strGbn);
		sql.setString(++i, strGbn);
		sql.setString(++i, strGbn);
		sql.setString(++i, strStrCd);
		sql.setString(++i, strEventPlaceCd);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strId);
		sql.put(strQuery);

		ret = select2List(sql);
		return ret;
	}

	/**
	 * 행사장 디테일 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List[] searchDetail(ActionForm form, String strId) throws Exception {
		
		List ret[]      = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strQuery = "";
		ret   = new List[1];
		int i = 0;
		
		String strStrCd        = String2.nvl(form.getParam("strStrCd"));
		String strEventPlaceCd = String2.nvl(form.getParam("strEventPlaceCd"));
		String strSaleDtS      = String2.nvl(form.getParam("strSaleDtS"));
		String strSaleDtE      = String2.nvl(form.getParam("strSaleDtE"));
		String strGbn          = String2.nvl(form.getParam("strGbn"));

		connect("pot");
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();	
		
		i = 0;
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		sql.setString(++i, strGbn);
		sql.setString(++i, strGbn);
		sql.setString(++i, strGbn);
		sql.setString(++i, strGbn);
		sql.setString(++i, strGbn);
		sql.setString(++i, strGbn);
		sql.setString(++i, strGbn);
		sql.setString(++i, strGbn);
		sql.setString(++i, strGbn);
		sql.setString(++i, strStrCd);
		sql.setString(++i, strEventPlaceCd);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strId);
		sql.put(strQuery);
		ret[0] = select2List(sql);
		sql.close();

		return ret;
	}
}
