/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pstk.dao;

import java.util.List;
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>장부재고조회(의류잡화)</p>
 * 
 * @created  on 1.0, 2010/05/12
 * @created  by 이재득(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PStk111DAO extends AbstractDAO {


	/**
	 * 의류잡화 단품별 장부재고 현황을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strStkYm      = String2.nvl(form.getParam("strStkYm"));
		String strStkSDt     = String2.nvl(form.getParam("strStkSDt"));
		String strStkEDt     = String2.nvl(form.getParam("strStkEDt"));
		String strPumbunCd   = String2.nvl(form.getParam("strPumbunCd"));
		String strPummokCd   = String2.nvl(form.getParam("strPummokCd"));
		String strStyleCd    = String2.nvl(form.getParam("strStyleCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkYm);
		sql.setString(i++, strStrCd);		
		sql.setString(i++, strStkSDt);
		sql.setString(i++, strStkEDt);
		sql.setString(i++, strPumbunCd);
		
		strQuery += svc.getQuery("SEL_MASTER") + "\n";
		
		
		if(!strPummokCd.equals("")){
			strQuery += svc.getQuery("SEL_MASTER_WHERE_PUMMOK_CD") + "\n";
			sql.setString(i++, strPummokCd);
		}
		if(!strStyleCd.equals("")){
			strQuery += svc.getQuery("SEL_MASTER_WHERE_STYLE_CD") + "\n";
			sql.setString(i++, strStyleCd);
		}		
		
		strQuery += svc.getQuery("SEL_MASTER_GROUP") + "\n";
		strQuery += svc.getQuery("SEL_MASTER_ORDER");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 품번정보(조직명) 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchPbnInf(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strPumbunCd      = String2.nvl(form.getParam("strPumbunCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		
		strQuery = svc.getQuery("SEL_PBNINF");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
}
