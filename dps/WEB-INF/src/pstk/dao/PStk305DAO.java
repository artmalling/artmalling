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

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;


/**
 * <p>예제  DAO</p>
 * 
 * @created  on 1.0, 2010/06/20
 * @created  by 이재득(FKSS)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PStk305DAO extends AbstractDAO {


	/**
	 * 조직별 월 손익명세서를 보여준다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String OrgFlag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));			
		String strDeptCd     = String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd     = String2.nvl(form.getParam("strTeamCd"));
		String strPcCd       = String2.nvl(form.getParam("strPcCd"));
		String strStkYm      = String2.nvl(form.getParam("strStkYm"));
		String strStkSYm     = String2.nvl(form.getParam("strStkSYm"));
		String strStkBfYm    = String2.nvl(form.getParam("strStkBfYm"));
		String strYyyy       = String2.nvl(form.getParam("strYyyy"));
		String strBuyFlag    = String2.nvl(form.getParam("strBuyFlag"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_MASTER") + "\n";

		sql.setString(i++, OrgFlag);

		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkYm);
		

		if(!strDeptCd.equals("%")){
			strQuery += svc.getQuery("SEL_MASTER_WHERE_DEPT_CD") + "\n";
			sql.setString(i++, strDeptCd);
		}
		
		if(!strTeamCd.equals("%")){
			strQuery += svc.getQuery("SEL_MASTER_WHERE_TEAM_CD") + "\n";
			sql.setString(i++, strTeamCd);
		}
		if(!strPcCd.equals("%")){
			strQuery += svc.getQuery("SEL_MASTER_WHERE_PC_CD") + "\n";
			sql.setString(i++, strPcCd);
		}

		if(!strBuyFlag.equals("%")){
			strQuery += svc.getQuery("SEL_MASTER_WHERE_BIZFLAG") + "\n";
			sql.setString(i++, strBuyFlag);
		}
		
		strQuery += svc.getQuery("SEL_MASTER_GROUP") + "\n";		
		
		strQuery += svc.getQuery("SEL_MASTER_ORDER");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
}
