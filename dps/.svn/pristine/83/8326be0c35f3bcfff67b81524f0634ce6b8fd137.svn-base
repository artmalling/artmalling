/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package psal.dao;

import java.util.List;
import java.util.Map;

import common.util.Util;
//import java.util.Map;

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

public class PSal402DAO extends AbstractDAO {

	/**
	 * 마스터 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String OrgFlag, String userid) throws Exception {
		try{
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		int i 			= 1;
		

		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strDeptCd 		= String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd 		= String2.nvl(form.getParam("strTeamCd"));
		String strPCCd 		    = String2.nvl(form.getParam("strPCCd"));
		String strSaleDtS 		= String2.nvl(form.getParam("strSaleDtS"));
		String strSaleDtE 		= String2.nvl(form.getParam("strSaleDtE"));
		String strOrgFlag       = String2.nvl(form.getParam("strOrgFlag"));
		String strEmUnit        = String2.nvl(form.getParam("strEmUnit"));
		
		String strUnit = "1";		// '원'단위(01:원,02:천원)
		if(strEmUnit.equals("02")){	
			strUnit = "1000";
		}
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		if(strOrgFlag.equals("1")){
			sql.put(svc.getQuery("SEL_SALE_PC-01"));
			
			sql.setString(i++, strUnit);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			sql.setString(i++, strStrCd);
			
			if(!strDeptCd.equals("%"))
			{
				sql.put(svc.getQuery("WHERE_DEPT_CD"));
				sql.setString(i++, strDeptCd);
			}
			if(!strTeamCd.equals("%"))
			{
				sql.put(svc.getQuery("WHERE_TEAM_CD"));
				sql.setString(i++, strTeamCd);
			}
			if(!strPCCd.equals("%"))
			{
				sql.put(svc.getQuery("WHERE_PC_CD"));
				sql.setString(i++, strPCCd);
			}
			
			sql.put(svc.getQuery("SEL_SALE_PC-02"));
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, userid);
			sql.setString(i++, strOrgFlag);
			
			sql.setString(i++, strStrCd);
			
			if(!strDeptCd.equals("%"))
			{
				sql.put(svc.getQuery("WHERE_DEPT_CD"));
				sql.setString(i++, strDeptCd);
			}
			if(!strTeamCd.equals("%"))
			{
				sql.put(svc.getQuery("WHERE_TEAM_CD"));
				sql.setString(i++, strTeamCd);
			}
			if(!strPCCd.equals("%"))
			{
				sql.put(svc.getQuery("WHERE_PC_CD"));
				sql.setString(i++, strPCCd);
			}
			
			sql.put(svc.getQuery("SEL_SALE_PC-03"));
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, userid);
			sql.setString(i++, strOrgFlag);
			
		}else{
			sql.put(svc.getQuery("SEL_SALE_PC2-01"));
			
			sql.setString(i++, strUnit);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			sql.setString(i++, strStrCd);
			
			if(!strDeptCd.equals("%"))
			{
				sql.put(svc.getQuery("WHERE_DEPT_CD"));
				sql.setString(i++, strDeptCd);
			}
			if(!strTeamCd.equals("%"))
			{
				sql.put(svc.getQuery("WHERE_TEAM_CD"));
				sql.setString(i++, strTeamCd);
			}
			if(!strPCCd.equals("%"))
			{
				sql.put(svc.getQuery("WHERE_PC_CD"));
				sql.setString(i++, strPCCd);
			}
			
			sql.put(svc.getQuery("SEL_SALE_PC2-02"));
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, userid);
			sql.setString(i++, strOrgFlag);
			
			sql.setString(i++, strStrCd);
			
			
			
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			
			
			
			sql.put(svc.getQuery("SEL_SALE_PC2-03"));
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, userid);
			sql.setString(i++, strOrgFlag);
		}
		ret = select2List(sql);
		
		return ret;
		} catch (Exception e){
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 상세 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDetail(ActionForm form, String OrgFlag, String userid) throws Exception {
		try{
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		int i 			= 1;
		

		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strDeptCd 		= String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd 		= String2.nvl(form.getParam("strTeamCd"));
		String strPCCd 		    = String2.nvl(form.getParam("strPCCd"));
		String strSaleDtS 		= String2.nvl(form.getParam("strSaleDtS"));
		String strSaleDtE 		= String2.nvl(form.getParam("strSaleDtE"));
		String strOrgFlag 		= String2.nvl(form.getParam("strOrgFlag"));
		String strEmUnit        = String2.nvl(form.getParam("strEmUnit"));
		
		String strUnit = "1";		// '원'단위(01:원,02:천원)
		if(strEmUnit.equals("02")){	
			strUnit = "1000";
		}
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		if(strOrgFlag.equals("1")){
			sql.put(svc.getQuery("SEL_SALE_PUMBUN-01"));
			
			sql.setString(i++, strUnit);
			sql.setString(i++, strStrCd);
			
			if(!strDeptCd.equals("%"))
			{
				sql.put(svc.getQuery("WHERE_DEPT_CD"));
				sql.setString(i++, strDeptCd);
			}
			if(!strTeamCd.equals("%"))
			{
				sql.put(svc.getQuery("WHERE_TEAM_CD"));
				sql.setString(i++, strTeamCd);
			}
			if(!strPCCd.equals("%"))
			{
				sql.put(svc.getQuery("WHERE_PC_CD"));
				sql.setString(i++, strPCCd);
			}
			
			sql.put(svc.getQuery("SEL_SALE_PUMBUN-02"));
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);		
			sql.setString(i++, userid);
			sql.setString(i++, strOrgFlag);
			
			sql.setString(i++, strStrCd);
			
			if(!strDeptCd.equals("%"))
			{
				sql.put(svc.getQuery("WHERE_DEPT_CD"));
				sql.setString(i++, strDeptCd);
			}
			if(!strTeamCd.equals("%"))
			{
				sql.put(svc.getQuery("WHERE_TEAM_CD"));
				sql.setString(i++, strTeamCd);
			}
			if(!strPCCd.equals("%"))
			{
				sql.put(svc.getQuery("WHERE_PC_CD"));
				sql.setString(i++, strPCCd);
			}
			
			sql.put(svc.getQuery("SEL_SALE_PUMBUN-03"));
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);		
			sql.setString(i++, userid);
			sql.setString(i++, strOrgFlag);
		}else{
			sql.put(svc.getQuery("SEL_SALE_PUMBUN2-01"));
						
			sql.setString(i++, strUnit);
			sql.setString(i++, strStrCd);
			
			
			if(!strDeptCd.equals("%"))
			{
				sql.put(svc.getQuery("WHERE_DEPT_CD"));
				sql.setString(i++, strDeptCd);
			}
			if(!strTeamCd.equals("%"))
			{
				sql.put(svc.getQuery("WHERE_TEAM_CD"));
				sql.setString(i++, strTeamCd);
			}
			if(!strPCCd.equals("%"))
			{
				sql.put(svc.getQuery("WHERE_PC_CD"));
				sql.setString(i++, strPCCd);
			}
			
			sql.put(svc.getQuery("SEL_SALE_PUMBUN2-02"));
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);		
			sql.setString(i++, userid);
			sql.setString(i++, strOrgFlag);
			
			sql.setString(i++, strStrCd);
			
			
			if(!strDeptCd.equals("%"))
			{
				sql.put(svc.getQuery("WHERE_DEPT_CD"));
				sql.setString(i++, strDeptCd);
			}
			if(!strTeamCd.equals("%"))
			{
				sql.put(svc.getQuery("WHERE_TEAM_CD"));
				sql.setString(i++, strTeamCd);
			}
			if(!strPCCd.equals("%"))
			{
				sql.put(svc.getQuery("WHERE_PC_CD"));
				sql.setString(i++, strPCCd);
			}
			
			sql.put(svc.getQuery("SEL_SALE_PUMBUN2-03"));
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);		
			sql.setString(i++, userid);
			sql.setString(i++, strOrgFlag);
		}
		ret = select2List(sql);

		return ret;
	} catch (Exception e){
		e.printStackTrace();
		throw e;
	}
	}

}
