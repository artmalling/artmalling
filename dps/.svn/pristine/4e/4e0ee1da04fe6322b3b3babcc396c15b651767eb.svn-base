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

public class PSal460DAO extends AbstractDAO {

	/**
	 * 당초팀별년계획을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String OrgFlag, String userid) throws Exception {
		
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
		String strSaleCmprDtS 	= String2.nvl(form.getParam("strSaleCmprDtS"));
		String strSaleCmprDtE 	= String2.nvl(form.getParam("strSaleCmprDtE"));
		String strPummokL 		= String2.nvl(form.getParam("strPummokL"));
		String strPummokM 		= String2.nvl(form.getParam("strPummokM"));
		String strPummokS 		= String2.nvl(form.getParam("strPummokS"));
		String strOrgFlag 		= String2.nvl(form.getParam("strOrgFlag"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		if(strOrgFlag.equals("1")){
	        if(!strPummokL.equals("%") && !strPummokM.equals("%")){
	
				sql.put(svc.getQuery("SEL_PBN_PUMMOK_S-01"));
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
				
				sql.put(svc.getQuery("SEL_PBN_PUMMOK_S-02"));
				sql.setString(i++, strPummokL);
				sql.setString(i++, strPummokM);
				sql.setString(i++, strPummokS);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				sql.setString(i++, userid);

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
				
				sql.put(svc.getQuery("SEL_PBN_PUMMOK_S-03"));
				sql.setString(i++, strPummokL);
				sql.setString(i++, strPummokM);
				sql.setString(i++, strPummokS);
				sql.setString(i++, strSaleCmprDtS);
				sql.setString(i++, strSaleCmprDtE);
				sql.setString(i++, userid);
			}
			else{
				if(!strPummokL.equals("%") && strPummokM.equals("%") && strPummokS.equals("%")){
	
					sql.put(svc.getQuery("SEL_PBN_PUMMOK_M-01"));
					
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
					
					sql.put(svc.getQuery("SEL_PBN_PUMMOK_M-02"));
					sql.setString(i++, strPummokL);
					sql.setString(i++, strPummokM);
					sql.setString(i++, strPummokS);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
	
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
					
					sql.put(svc.getQuery("SEL_PBN_PUMMOK_M-03"));
					sql.setString(i++, strPummokL);
					sql.setString(i++, strPummokM);
					sql.setString(i++, strPummokS);
					sql.setString(i++, strSaleCmprDtS);
					sql.setString(i++, strSaleCmprDtE);
					sql.setString(i++, userid);
				}
				else{
					if(strPummokL.equals("%") && strPummokM.equals("%") &&  strPummokS.equals("%")){
	
						
						sql.put(svc.getQuery("SEL_PBN_PUMMOK_L-01"));
						
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
						
						sql.put(svc.getQuery("SEL_PBN_PUMMOK_L-02"));
						sql.setString(i++, strPummokL);
						sql.setString(i++, strPummokM);
						sql.setString(i++, strPummokS);
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
						sql.setString(i++, userid);
	
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
						
						sql.put(svc.getQuery("SEL_PBN_PUMMOK_L-03"));
						sql.setString(i++, strPummokL);
						sql.setString(i++, strPummokM);
						sql.setString(i++, strPummokS);
						sql.setString(i++, strSaleCmprDtS);
						sql.setString(i++, strSaleCmprDtE);
						sql.setString(i++, userid);
					}
				}
					
			}
		}else{
			if(!strPummokL.equals("%") && !strPummokM.equals("%")){
				
				sql.put(svc.getQuery("SEL_PBN_PUMMOK_S2-01"));
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
				
				sql.put(svc.getQuery("SEL_PBN_PUMMOK_S2-02"));
				sql.setString(i++, strPummokL);
				sql.setString(i++, strPummokM);
				sql.setString(i++, strPummokS);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				sql.setString(i++, userid);

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
				
				sql.put(svc.getQuery("SEL_PBN_PUMMOK_S2-03"));
				sql.setString(i++, strPummokL);
				sql.setString(i++, strPummokM);
				sql.setString(i++, strPummokS);
				sql.setString(i++, strSaleCmprDtS);
				sql.setString(i++, strSaleCmprDtE);
				sql.setString(i++, userid);
			}
			else{
				if(!strPummokL.equals("%") && strPummokM.equals("%") && strPummokS.equals("%")){
	
					sql.put(svc.getQuery("SEL_PBN_PUMMOK_M2-01"));
					
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
					
					sql.put(svc.getQuery("SEL_PBN_PUMMOK_M2-02"));
					sql.setString(i++, strPummokL);
					sql.setString(i++, strPummokM);
					sql.setString(i++, strPummokS);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
	
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
					
					sql.put(svc.getQuery("SEL_PBN_PUMMOK_M2-03"));
					sql.setString(i++, strPummokL);
					sql.setString(i++, strPummokM);
					sql.setString(i++, strPummokS);
					sql.setString(i++, strSaleCmprDtS);
					sql.setString(i++, strSaleCmprDtE);
					sql.setString(i++, userid);
				}
				else{
					if(strPummokL.equals("%") && strPummokM.equals("%") &&  strPummokS.equals("%")){
	
						
						sql.put(svc.getQuery("SEL_PBN_PUMMOK_L2-01"));
						
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
						
						sql.put(svc.getQuery("SEL_PBN_PUMMOK_L2-02"));
						sql.setString(i++, strPummokL);
						sql.setString(i++, strPummokM);
						sql.setString(i++, strPummokS);
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
						sql.setString(i++, userid);
	
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
						
						sql.put(svc.getQuery("SEL_PBN_PUMMOK_L2-03"));
						sql.setString(i++, strPummokL);
						sql.setString(i++, strPummokM);
						sql.setString(i++, strPummokS);
						sql.setString(i++, strSaleCmprDtS);
						sql.setString(i++, strSaleCmprDtE);
						sql.setString(i++, userid);
					}
				}
					
			}
		}
		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 당초팀별년계획을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchCmprdt(ActionForm form, String OrgFlag, String userid) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		int i 			= 1;
		
		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strSaleDtS 		= String2.nvl(form.getParam("strSaleDtS"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_CMPRDT"));
		
		sql.setString(i++, strSaleDtS);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSaleDtS);
		

		ret = select2List(sql);
		
		return ret;
	}
	
}
