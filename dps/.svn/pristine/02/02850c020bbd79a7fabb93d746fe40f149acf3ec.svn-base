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
 * <p>조직별 장부재고조회</p>
 * 
 * @created  on 1.0, 2010/05/06
 * @created  by 이재득(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PStk101DAO extends AbstractDAO {


	/**
	 * 조직별 장부재고 마스터정보를 조회한다.
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
		String strDeptCd     = String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd     = String2.nvl(form.getParam("strTeamCd"));
		String strPcCd       = String2.nvl(form.getParam("strPcCd"));
		String strStkYm      = String2.nvl(form.getParam("strStkYm"));
		String strStkSDt     = String2.nvl(form.getParam("strStkSDt"));
		String strStkEDt     = String2.nvl(form.getParam("strStkEDt"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		strQuery = svc.getQuery("SEL_MASTER_S") + "\n";
		strQuery += svc.getQuery("SEL_MASTER_PBN") + "\n";
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkYm);
		
		sql.setString(i++, strStrCd);		
		sql.setString(i++, strStkSDt);
		sql.setString(i++, strStkEDt);	
		
		
		
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

		strQuery += svc.getQuery("SEL_MASTER_PBN_GROUP") + "\n";

		strQuery += svc.getQuery("SEL_MASTER_PBN_SDAY") + "\n";

		sql.setString(i++, strStrCd);	
		sql.setString(i++, strStkEDt);	

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

		strQuery += svc.getQuery("SEL_MASTER_E") + "\n";
		strQuery += svc.getQuery("SEL_MASTER_ORDER");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 조직별 장부재고 Detail정보를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDetail(ActionForm form) throws Exception {
		
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
		String strStkSDt     = String2.nvl(form.getParam("strStkSDt"));
		String strStkEDt     = String2.nvl(form.getParam("strStkEDt"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		strQuery = svc.getQuery("SEL_DETAIL_S") + "\n";
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkYm);
		
		sql.setString(i++, strStrCd);		
		sql.setString(i++, strStkSDt);
		sql.setString(i++, strStkEDt);
		
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPcCd);

		sql.setString(i++, strStrCd);	
		sql.setString(i++, strStkEDt);

		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPcCd);

		sql.put(strQuery);

		ret = select2List(sql);


		return ret;
	}
}
