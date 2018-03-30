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

public class PSal317DAO extends AbstractDAO {

	/**
	 * 마스터를 조회한다.
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
		
		String strCmprFlag      = String2.nvl(form.getParam("strCmprFlag"));// 대비구분
		String strCmprDtS1      = String2.nvl(form.getParam("strCmprDtS1"));// 대비일자 1-1
		String strCmprDtE1      = String2.nvl(form.getParam("strCmprDtE1"));// 대비일자 1-2
		String strCmprDtS2      = String2.nvl(form.getParam("strCmprDtS2"));// 대비일자 2-1
	    String strCmprDtE2      = String2.nvl(form.getParam("strCmprDtE2"));// 대비일자 2-2
	    String strCornerCd      = String2.nvl(form.getParam("strCornerCd"));// 
	    
	   
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		if(!strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && OrgFlag.equals("1") && strCmprFlag.equals("1")){  //매장
			
			System.out.println("/* 코너(매장) -전년대비 매장, 전년대비,  점:선택, 부문:선택 팀:선택, PC:선택*/");
			sql.put(svc.getQuery("SEL_SALE_CORNER-01"));
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
			
			sql.put(svc.getQuery("SEL_SALE_CORNER-02"));
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);//추가

			sql.setString(i++, userid);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);//추가
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
			
			sql.put(svc.getQuery("SEL_SALE_CORNER-03"));
			sql.setString(i++, userid);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);//추가
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
			
			sql.put(svc.getQuery("SEL_SALE_CORNER-04"));
			sql.setString(i++, userid);
			
		}else if(!strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && OrgFlag.equals("2") && strCmprFlag.equals("1")){  //매장
			System.out.println("/* 코너(매입) -전년대비 매입, 전년대비,  점:선택, 부문:선택 팀:선택, PC:선택*/");
			sql.put(svc.getQuery("SEL_SALE_BRAND2-01"));
			
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
			
			
			//sql.setString(i++, strCornerCd);
			sql.put(svc.getQuery("SEL_SALE_BRAND2-02"));
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			sql.setString(i++, userid);
			
			sql.setString(i++, strStrCd);
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
			//sql.setString(i++, strCornerCd);
			
			sql.put(svc.getQuery("SEL_SALE_BRAND2-03"));
			
			sql.setString(i++, userid);
			
			sql.setString(i++, strStrCd);
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
			
			sql.put(svc.getQuery("SEL_SALE_BRAND2-04"));
			sql.setString(i++, userid);
			
		}else if(!strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && OrgFlag.equals("1") && strCmprFlag.equals("2")){  //매장
			System.out.println("/* 코너(매장) -전주대비 매장, 전주대비,  점:선택, 부문:선택 팀:선택, PC:선택*/");
			sql.put(svc.getQuery("SEL_SALE_CORNER3-01"));
			
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
			
			sql.put(svc.getQuery("SEL_SALE_CORNER3-02"));
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
		
			sql.put(svc.getQuery("SEL_SALE_CORNER3-03"));
			sql.setString(i++, strCmprDtS1);//대비기간 시작 1
			sql.setString(i++, strCmprDtE1);//대비기간 종료1
						
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
			
			sql.put(svc.getQuery("SEL_SALE_CORNER3-04"));
			sql.setString(i++, strCmprDtS2);//대비기간 시작 2
			sql.setString(i++, strCmprDtE2);//대비기간 종료2
			
			sql.setString(i++, userid);

			sql.setString(i++, strStrCd);
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
			
			sql.put(svc.getQuery("SEL_SALE_CORNER3-05"));
			sql.setString(i++, userid);
			
		}else if(!strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && OrgFlag.equals("2") && strCmprFlag.equals("2")){  //매장
			System.out.println("/* 코너(매입) -전주대비 매입, 전주대비,  점:선택, 부문:선택 팀:선택, PC:선택*/");
			sql.put(svc.getQuery("SEL_SALE_BRAND4"));
			
			sql.setString(i++, strStrCd);						
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strCornerCd);
			sql.setString(i++, strSaleDtS);			
			sql.setString(i++, strSaleDtE);
			
			sql.setString(i++, userid);
			
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strCmprDtS1);//대비기간 시작 1
			sql.setString(i++, strCmprDtE1);//대비기간 종료1
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strCornerCd);
						
			sql.setString(i++, userid);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strCmprDtS2);//대비기간 시작 2
			sql.setString(i++, strCmprDtE2);//대비기간 종료2
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strCornerCd);
			
			
			sql.setString(i++, userid);

			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);			
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, strStrCd);						
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, userid);
			
			
		}

		
		else{
			if(strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && OrgFlag.equals("1") && strCmprFlag.equals("1")){
				System.out.println("/* PC(매장) -전년대비 매장, 전년대비,  점:선택, 부문:선택 팀:선택, PC:전체*/");
				sql.put(svc.getQuery("SEL_SALE_PC-01"));
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
				sql.setString(i++, strSaleDtE);//추가

				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strSaleDtS);//추가
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
				
				sql.put(svc.getQuery("SEL_SALE_PC-03"));
				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strSaleDtS);//추가
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
				
				sql.put(svc.getQuery("SEL_SALE_PC-04"));
				sql.setString(i++, userid);
				
		
			}else if(strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && OrgFlag.equals("2") && strCmprFlag.equals("1")){
				System.out.println("/* PC(매입) -전년대비 매입, 전년대비,  점:선택, 부문:선택 팀:선택, PC:전체*/");
				sql.put(svc.getQuery("SEL_SALE_PC2-01"));
				
				
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
				sql.setString(i++, strSaleDtE);//추가

				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strSaleDtS);//추가
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

				sql.put(svc.getQuery("SEL_SALE_PC2-03"));
				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strSaleDtS);//추가
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
				
				sql.put(svc.getQuery("SEL_SALE_PC2-04"));
				sql.setString(i++, userid);
				
		
			}else if(strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && OrgFlag.equals("1") && strCmprFlag.equals("2")){
				System.out.println("/* PC(매장) -전주대비 매장, 전주대비,  점:선택, 부문:선택 팀:선택, PC:전체*/");
				sql.put(svc.getQuery("SEL_SALE_PC3-01"));
				
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
				
				sql.put(svc.getQuery("SEL_SALE_PC3-02"));
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
				
				sql.put(svc.getQuery("SEL_SALE_PC3-03"));
				sql.setString(i++, strCmprDtS1);//대비기간 시작 1
				sql.setString(i++, strCmprDtE1);//대비기간 종료1
							
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
				
				sql.put(svc.getQuery("SEL_SALE_PC3-04"));
				sql.setString(i++, strCmprDtS2);//대비기간 시작 2
				sql.setString(i++, strCmprDtE2);//대비기간 종료2
				
				sql.setString(i++, userid);

				sql.setString(i++, strStrCd);
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
				
				sql.put(svc.getQuery("SEL_SALE_PC3-05"));
				sql.setString(i++, userid);
				
		
			}else if(strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && OrgFlag.equals("2") && strCmprFlag.equals("2")){
				System.out.println("/* PC(매입) -전주대비 매입, 전주대비,  점:선택, 부문:선택 팀:선택, PC:전체*/");
				sql.put(svc.getQuery("SEL_SALE_PC4"));
				
				sql.setString(i++, strStrCd);						
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strSaleDtS);			
				sql.setString(i++, strSaleDtE);
				
				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
			
				sql.setString(i++, strCmprDtS1);//대비기간 시작 1
				sql.setString(i++, strCmprDtE1);//대비기간 종료1
							
				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCmprDtS2);//대비기간 시작 2
				sql.setString(i++, strCmprDtE2);//대비기간 종료2
				
				sql.setString(i++, userid);

				sql.setString(i++, strStrCd);
				sql.setString(i++, strSaleDtS);			
				sql.setString(i++, strSaleDtE);
				sql.setString(i++, strStrCd);						
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, userid);
				
		
			}



			else{
				
				if(strPCCd.equals("%") && strTeamCd.equals("%") && !strDeptCd.equals("%")&&OrgFlag.equals("1") && strCmprFlag.equals("1")){
					System.out.println("/* 팀(매장) -전년대비  매장, 전년대비,  점:선택, 부문:선택 팀:전체, PC:전체*/");
					sql.put(svc.getQuery("SEL_SALE_TEAM-01"));
					
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
					
					sql.put(svc.getQuery("SEL_SALE_TEAM-02"));
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);//추가

					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);//추가
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
					
					sql.put(svc.getQuery("SEL_SALE_TEAM-03"));
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);//추가
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
					
					sql.put(svc.getQuery("SEL_SALE_TEAM-04"));
					sql.setString(i++, userid);
					
				}else if(strPCCd.equals("%") && strTeamCd.equals("%") && !strDeptCd.equals("%")&&OrgFlag.equals("2") && strCmprFlag.equals("1")){
					System.out.println("/* 팀(매입) -전년대비 매입, 전년대비,  점:선택, 부문:선택 팀:전체, PC:전체*/");
					
					sql.put(svc.getQuery("SEL_SALE_TEAM2-01"));
					
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
					
					sql.put(svc.getQuery("SEL_SALE_TEAM2-02"));
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);//추가

					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);//추가
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
					
					sql.put(svc.getQuery("SEL_SALE_TEAM2-03"));
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);//추가
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
					
					sql.put(svc.getQuery("SEL_SALE_TEAM2-04"));
					sql.setString(i++, userid);

				}else if(strPCCd.equals("%") && strTeamCd.equals("%") && !strDeptCd.equals("%")&&OrgFlag.equals("1") && strCmprFlag.equals("2")){
					System.out.println("/* 팀(매장) -전주대비 매장, 전주대비,  점:선택, 부문:선택 팀:전체, PC:전체*/");
					sql.put(svc.getQuery("SEL_SALE_TEAM3-01"));
					
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
					
					sql.put(svc.getQuery("SEL_SALE_TEAM3-02"));
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
					
					
					sql.put(svc.getQuery("SEL_SALE_TEAM3-03"));
					sql.setString(i++, strCmprDtS1);//대비기간 시작 1
					sql.setString(i++, strCmprDtE1);//대비기간 종료1
								
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
					
					sql.put(svc.getQuery("SEL_SALE_TEAM3-04"));
					sql.setString(i++, strCmprDtS2);//대비기간 시작 2
					sql.setString(i++, strCmprDtE2);//대비기간 종료2
					
					sql.setString(i++, userid);

					sql.setString(i++, strStrCd);
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
					
					sql.put(svc.getQuery("SEL_SALE_TEAM3-05"));
					sql.setString(i++, userid);
					

				}else if(strPCCd.equals("%") && strTeamCd.equals("%") && !strDeptCd.equals("%")&&OrgFlag.equals("2") && strCmprFlag.equals("2")){
					sql.put(svc.getQuery("SEL_SALE_TEAM4"));
					System.out.println("/* 팀(매입) -전주대비 매입, 전주대비,  점:선택, 부문:선택 팀:전체, PC:전체*/");
					
					sql.setString(i++, strStrCd);						
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strSaleDtS);			
					sql.setString(i++, strSaleDtE);
					
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
				
					sql.setString(i++, strCmprDtS1);//대비기간 시작 1
					sql.setString(i++, strCmprDtE1);//대비기간 종료1
								
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strCmprDtS2);//대비기간 시작 2
					sql.setString(i++, strCmprDtE2);//대비기간 종료2
					
					sql.setString(i++, userid);

					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);			
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, strStrCd);						
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, userid);
					

				}


				else{
					if(strPCCd.equals("%") && strTeamCd.equals("%") && strDeptCd.equals("%") &&OrgFlag.equals("1") && strCmprFlag.equals("1")){
						System.out.println("/* 부분(매장) -전년대비 매장, 전년대비,  점:선택, 부문:전체 팀:전체, PC:전체  */");
						 
						sql.put(svc.getQuery("SEL_SALE_DEPT-01"));
						
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
						
						sql.put(svc.getQuery("SEL_SALE_DEPT-02"));
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);//추가

						sql.setString(i++, userid);
						
						sql.setString(i++, strStrCd);
						sql.setString(i++, strSaleDtS);//추가
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
						
						sql.put(svc.getQuery("SEL_SALE_DEPT-03"));
						sql.setString(i++, userid);
						
						sql.setString(i++, strStrCd);
						sql.setString(i++, strSaleDtS);//추가
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
						
						sql.put(svc.getQuery("SEL_SALE_DEPT-04"));
						sql.setString(i++, userid);
						
				
					}else if(strPCCd.equals("%") && strTeamCd.equals("%") && strDeptCd.equals("%") &&OrgFlag.equals("2") && strCmprFlag.equals("1")){
						System.out.println("/* 부분(매입) -전년대비 매입, 전년대비,  점:선택, 부문:전체 팀:전체, PC:전체*/");
						sql.put(svc.getQuery("SEL_SALE_DEPT2-01"));
						
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
						
						sql.put(svc.getQuery("SEL_SALE_DEPT2-02"));
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);//추가

						sql.setString(i++, userid);
						
						sql.setString(i++, strStrCd);
						sql.setString(i++, strSaleDtS);//추가
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
						
						sql.put(svc.getQuery("SEL_SALE_DEPT2-03"));
						sql.setString(i++, userid);
						
						sql.setString(i++, strStrCd);
						sql.setString(i++, strSaleDtS);//추가
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
						
						sql.put(svc.getQuery("SEL_SALE_DEPT2-04"));
						sql.setString(i++, userid);
						

					}else if(strPCCd.equals("%") && strTeamCd.equals("%") && strDeptCd.equals("%") &&OrgFlag.equals("1") && strCmprFlag.equals("2")){
						System.out.println("/* 부분(매장) -전주대비 매장, 전주대비,  점:선택, 부문:전체 팀:전체, PC:전체*/");
						sql.put(svc.getQuery("SEL_SALE_DEPT3-01"));
						
						
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
						
						sql.put(svc.getQuery("SEL_SALE_DEPT3-02"));
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
						
						sql.put(svc.getQuery("SEL_SALE_DEPT3-03"));
						sql.setString(i++, strCmprDtS1);//대비기간 시작 1
						sql.setString(i++, strCmprDtE1);//대비기간 종료1
									
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
						
						sql.put(svc.getQuery("SEL_SALE_DEPT3-04"));
						sql.setString(i++, strCmprDtS2);//대비기간 시작 2
						sql.setString(i++, strCmprDtE2);//대비기간 종료2
						
						sql.setString(i++, userid);

						sql.setString(i++, strStrCd);
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
						
						
						sql.put(svc.getQuery("SEL_SALE_DEPT3-05"));
						sql.setString(i++, userid);
						
					}else if(strPCCd.equals("%") && strTeamCd.equals("%") && strDeptCd.equals("%") &&OrgFlag.equals("2") && strCmprFlag.equals("2")){
						System.out.println("/* 부분(매입) -전주대비 매입, 전주대비,  점:선택, 부문:전체 팀:전체, PC:전체 */");
						sql.put(svc.getQuery("SEL_SALE_DEPT4-01"));
						
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
						
						sql.put(svc.getQuery("SEL_SALE_DEPT4-02"));
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
						
						sql.put(svc.getQuery("SEL_SALE_DEPT4-03"));
						sql.setString(i++, strCmprDtS1);//대비기간 시작 1
						sql.setString(i++, strCmprDtE1);//대비기간 종료1
									
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
						
						sql.put(svc.getQuery("SEL_SALE_DEPT4-04"));
						sql.setString(i++, strCmprDtS2);//대비기간 시작 2
						sql.setString(i++, strCmprDtE2);//대비기간 종료2
						
						sql.setString(i++, userid);

						sql.setString(i++, strStrCd);
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
						
						sql.put(svc.getQuery("SEL_SALE_DEPT4-05"));
						sql.setString(i++, userid);
						
					}
				}
			}
				
		}		
		

		ret = select2List(sql);
		
		
		return ret;
	}

	/**
	 * 마스터를 조회한다.(더블클릭시)
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster2(ActionForm form,  String userid) throws Exception {
				
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
		String strCornerCd 		= String2.nvl(form.getParam("strCornerCd"));
		String strPumbunCd 		= String2.nvl(form.getParam("strPumbunCd"));
		String strSaleDtS 		= String2.nvl(form.getParam("strSaleDtS"));
		String strSaleDtE 		= String2.nvl(form.getParam("strSaleDtE"));
		
		String strCmprFlag      = String2.nvl(form.getParam("strCmprFlag"));// 대비구분
		String strCmprDtS1      = String2.nvl(form.getParam("strCmprDtS1"));// 대비일자 1-1
		String strCmprDtE1      = String2.nvl(form.getParam("strCmprDtE1"));// 대비일자 1-2
		String strCmprDtS2      = String2.nvl(form.getParam("strCmprDtS2"));// 대비일자 2-1
	    String strCmprDtE2      = String2.nvl(form.getParam("strCmprDtE2"));// 대비일자 2-2
	    String strOrgFlag       = String2.nvl(form.getParam("strOrgFlag"));// 대비일자 2-2
	    String strType      	= String2.nvl(form.getParam("strType"));// 대비일자 2-2
	    String strDanpum      	= String2.nvl(form.getParam("strDanpum"));// 대비일자 2-2
	   
	
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		if(strDanpum.equals("Y") && !strPumbunCd.equals("") && !strCornerCd.equals("00") && !strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%")&& strOrgFlag.equals("1") && strCmprFlag.equals("1")){
			System.out.println("/* 단품(매장)-전년대비 */");
			sql.put(svc.getQuery("SEL_SALE_SKU"));
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strCornerCd);
			sql.setString(i++, strPumbunCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strCornerCd);
			sql.setString(i++, strPumbunCd);
			
			
		}else if(strDanpum.equals("Y") && !strPumbunCd.equals("") && !strCornerCd.equals("00") && !strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%")&& strOrgFlag.equals("2") && strCmprFlag.equals("1")){
			System.out.println("/* 단품(매입)-전년대비 */");
			sql.put(svc.getQuery("SEL_SALE_SKU2"));
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strCornerCd);
			sql.setString(i++, strPumbunCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strCornerCd);
			sql.setString(i++, strPumbunCd);	
			
		}else if(strDanpum.equals("Y") && !strPumbunCd.equals("") && !strCornerCd.equals("00") && !strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%")&& strOrgFlag.equals("1") && strCmprFlag.equals("2")){
			System.out.println("/* 단품(매장)-전주대비 */");
			sql.put(svc.getQuery("SEL_SALE_SKU3"));
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strCornerCd);
			sql.setString(i++, strPumbunCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strCornerCd);
			sql.setString(i++, strCmprDtS1);//대비기간 시작 1
			sql.setString(i++, strCmprDtE1);//대비기간 종료1
			sql.setString(i++, strPumbunCd);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strCornerCd);
			sql.setString(i++, strCmprDtS2);//대비기간 시작 1
			sql.setString(i++, strCmprDtE2);//대비기간 종료1
			sql.setString(i++, strPumbunCd);
			
		}else if(strDanpum.equals("Y") && !strPumbunCd.equals("") && !strCornerCd.equals("00") && !strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%")&& strOrgFlag.equals("2") && strCmprFlag.equals("2")){
			System.out.println("/* 단품(매입)-전주대비 */");
			sql.put(svc.getQuery("SEL_SALE_SKU4"));
			
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strCornerCd);
			sql.setString(i++, strPumbunCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strCornerCd);
			sql.setString(i++, strCmprDtS1);//대비기간 시작 1
			sql.setString(i++, strCmprDtE1);//대비기간 종료1
			sql.setString(i++, strPumbunCd);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strCornerCd);
			sql.setString(i++, strCmprDtS2);//대비기간 시작 1
			sql.setString(i++, strCmprDtE2);//대비기간 종료1
			sql.setString(i++, strPumbunCd);
			
		}

		else{ 
			
			if(!strCornerCd.equals("00") && !strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("1") && strCmprFlag.equals("1") && strType.equals("Y")){
				System.out.println("/* 품번(매장)-전년대비 매장, 코너별실적에서 DOUBLE-CLICK시 조회*/");
				sql.put(svc.getQuery("SEL_SALE_BRAND5-01"));
				
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
				
				sql.put(svc.getQuery("SEL_SALE_BRAND5-02"));  
				sql.setString(i++, strCornerCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				
				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
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
				
				sql.put(svc.getQuery("SEL_SALE_BRAND5-03"));
				sql.setString(i++, strCornerCd);
				
				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
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
				
				sql.put(svc.getQuery("SEL_SALE_BRAND5-04"));
				sql.setString(i++, userid);
				
			}else if(!strCornerCd.equals("00") && !strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("2") && strCmprFlag.equals("1") && strType.equals("Y")){
				System.out.println("/* 품번(매입)-전년대비 매입, 코너별실적에서 DOUBLE-CLICK시 조회*/");
				sql.put(svc.getQuery("SEL_SALE_BRAND6-01"));   
				
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
				//sql.setString(i++, strCornerCd);
				
				sql.put(svc.getQuery("SEL_SALE_BRAND6-02"));   
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				
				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
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
				//sql.setString(i++, strCornerCd);
				
				sql.put(svc.getQuery("SEL_SALE_BRAND6-03"));
				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
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
				
				sql.put(svc.getQuery("SEL_SALE_BRAND6-04"));
				sql.setString(i++, userid);
				
			}else if(!strCornerCd.equals("00") && !strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("1") && strCmprFlag.equals("2") && strType.equals("Y")){
				System.out.println("/* 품번(매장)-전주대비 매장, 코너별실적에서 DOUBLE-CLICK시 조회*/");
				sql.put(svc.getQuery("SEL_SALE_BRAND7-01"));
				
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
				
				
				//sql.setString(i++, strCornerCd);
				sql.put(svc.getQuery("SEL_SALE_BRAND7-02"));
				sql.setString(i++, strSaleDtS);			
				sql.setString(i++, strSaleDtE);
				
				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strCmprDtS1);//대비기간 시작 1
				sql.setString(i++, strCmprDtE1);//대비기간 종료1
				
				
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
				
				sql.put(svc.getQuery("SEL_SALE_BRAND7-03"));
				//sql.setString(i++, strCornerCd);
							
				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strCmprDtS2);//대비기간 시작 2
				sql.setString(i++, strCmprDtE2);//대비기간 종료2
				
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
				
				sql.put(svc.getQuery("SEL_SALE_BRAND7-04"));
				//sql.setString(i++, strCornerCd);
				
				sql.setString(i++, userid);

				sql.setString(i++, strStrCd);
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
				
				sql.put(svc.getQuery("SEL_SALE_BRAND7-05"));
				sql.setString(i++, userid);
				
			}else if(!strCornerCd.equals("00") && !strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("2") && strCmprFlag.equals("2") && strType.equals("Y")){
				System.out.println("/* 품번(매입)-전주대비 매입, 코너별실적에서 DOUBLE-CLICK시 조회*/");
				sql.put(svc.getQuery("SEL_SALE_BRAND8"));    //SEL_SALE_PUMBUN
				
				sql.setString(i++, strStrCd);						
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCornerCd);
				sql.setString(i++, strSaleDtS);			
				sql.setString(i++, strSaleDtE);
				
				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strCmprDtS1);//대비기간 시작 1
				sql.setString(i++, strCmprDtE1);//대비기간 종료1
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCornerCd);
			
							
				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strCmprDtS2);//대비기간 시작 2
				sql.setString(i++, strCmprDtE2);//대비기간 종료2
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCornerCd);
				
				sql.setString(i++, userid);

				sql.setString(i++, strStrCd);
				sql.setString(i++, strSaleDtS);			
				sql.setString(i++, strSaleDtE);
				sql.setString(i++, strStrCd);						
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, userid);
				
			}else if(!strCornerCd.equals("00") && !strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("1") && strCmprFlag.equals("1") && strType.equals("N")){
				System.out.println("/* 품번(매장)-전년대비 매장, 코너별실적에서 DOUBLE-CLICK시 조회*/");
				sql.put(svc.getQuery("SEL_SALE_BRAND-01"));				
				
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
				
				sql.put(svc.getQuery("SEL_SALE_BRAND-02"));
				//sql.setString(i++, strCornerCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				
				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
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
				
				sql.put(svc.getQuery("SEL_SALE_BRAND-03"));
				//sql.setString(i++, strCornerCd);
				
				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
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
				
				sql.put(svc.getQuery("SEL_SALE_BRAND-04"));
				sql.setString(i++, userid);
				
			}else if(!strCornerCd.equals("00") && !strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("2") && strCmprFlag.equals("1") && strType.equals("N")){
				System.out.println("/* 코너(매입) -전년대비 매입, 전년대비,  점:선택, 부문:선택 팀:선택, PC:선택*/");
				sql.put(svc.getQuery("SEL_SALE_BRAND2-01"));
				
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
				
				
				//sql.setString(i++, strCornerCd);
				sql.put(svc.getQuery("SEL_SALE_BRAND2-02"));
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
				
				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
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
				//sql.setString(i++, strCornerCd);
				
				sql.put(svc.getQuery("SEL_SALE_BRAND2-03"));
				
				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
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
				
				sql.put(svc.getQuery("SEL_SALE_BRAND2-04"));
				sql.setString(i++, userid);
				
			}else if(!strCornerCd.equals("00") && !strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("1") && strCmprFlag.equals("2") && strType.equals("N")){
				System.out.println("/* 품번(매장)-전주대비 매장, 코너별실적에서 DOUBLE-CLICK시 조회1111111111111*/");
				sql.put(svc.getQuery("SEL_SALE_BRAND3-01"));    //SEL_SALE_PUMBUN
				
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
				
				sql.put(svc.getQuery("SEL_SALE_BRAND3-02"));    //SEL_SALE_PUMBUN
				//sql.setString(i++, strCornerCd);
				sql.setString(i++, strSaleDtS);			
				sql.setString(i++, strSaleDtE);
				
				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strCmprDtS1);//대비기간 시작 1
				sql.setString(i++, strCmprDtE1);//대비기간 종료1
				
				
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
				
				sql.put(svc.getQuery("SEL_SALE_BRAND3-03"));    //SEL_SALE_PUMBUN
				//sql.setString(i++, strCornerCd);
			
							
				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strCmprDtS2);//대비기간 시작 2
				sql.setString(i++, strCmprDtE2);//대비기간 종료2
				
				
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
				
				
				//sql.setString(i++, strCornerCd);
				
				sql.put(svc.getQuery("SEL_SALE_BRAND3-04"));    //SEL_SALE_PUMBUN
				sql.setString(i++, userid);

				sql.setString(i++, strStrCd);
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
				
				sql.put(svc.getQuery("SEL_SALE_BRAND3-05"));    //SEL_SALE_PUMBUN
				sql.setString(i++, userid);
				
			}else if(!strCornerCd.equals("00") && !strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("2") && strCmprFlag.equals("2") && strType.equals("N")){
				System.out.println("/* 품번(매입)-전주대비 매입, 코너별실적에서 DOUBLE-CLICK시 조회*/");
				sql.put(svc.getQuery("SEL_SALE_BRAND4"));    //SEL_SALE_PUMBUN
				
				sql.setString(i++, strStrCd);						
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCornerCd);
				sql.setString(i++, strSaleDtS);			
				sql.setString(i++, strSaleDtE); 
				
				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strCmprDtS1);//대비기간 시작 1
				sql.setString(i++, strCmprDtE1);//대비기간 종료1
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCornerCd);
			
							
				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strCmprDtS2);//대비기간 시작 2
				sql.setString(i++, strCmprDtE2);//대비기간 종료2
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, strCornerCd);
				
				sql.setString(i++, userid);

				sql.setString(i++, strStrCd);
				sql.setString(i++, strSaleDtS);			
				sql.setString(i++, strSaleDtE);
				sql.setString(i++, strStrCd);						
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPCCd);
				sql.setString(i++, userid);
				
			}

			else{
				if(!strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("1") && strCmprFlag.equals("1")){  //매장
					System.out.println("/* 코너(매장) -전년대비 매장, 전년대비,  점:선택, 부문:선택 팀:선택, PC:선택*/");
					sql.put(svc.getQuery("SEL_SALE_CORNER-01"));
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
					
					sql.put(svc.getQuery("SEL_SALE_CORNER-02"));
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);//추가

					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);//추가
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
					
					sql.put(svc.getQuery("SEL_SALE_CORNER-03"));
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);//추가
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
					
					sql.put(svc.getQuery("SEL_SALE_CORNER-04"));
					sql.setString(i++, userid);
					
				}else if(!strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("2") && strCmprFlag.equals("1")){  //매장
					System.out.println("/* 코너(매입) -전년대비 매입, 전년대비,  점:선택, 부문:선택 팀:선택, PC:선택*/");
					sql.put(svc.getQuery("SEL_SALE_CORNER2"));
					
					sql.setString(i++, strStrCd);						
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);//추가

					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);//추가
					sql.setString(i++, strSaleDtE);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);

					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);//추가
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, strStrCd);						
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, userid);
					
				}else if(!strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("1") && strCmprFlag.equals("2")){  //매장
					System.out.println("/* 코너(매장) -전주대비 매장, 전주대비,  점:선택, 부문:선택 팀:선택, PC:선택*/");
					sql.put(svc.getQuery("SEL_SALE_CORNER3-01"));
					
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
					
					sql.put(svc.getQuery("SEL_SALE_CORNER3-02"));
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
				
					sql.put(svc.getQuery("SEL_SALE_CORNER3-03"));
					sql.setString(i++, strCmprDtS1);//대비기간 시작 1
					sql.setString(i++, strCmprDtE1);//대비기간 종료1
								
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
					
					sql.put(svc.getQuery("SEL_SALE_CORNER3-04"));
					sql.setString(i++, strCmprDtS2);//대비기간 시작 2
					sql.setString(i++, strCmprDtE2);//대비기간 종료2
					
					sql.setString(i++, userid);

					sql.setString(i++, strStrCd);
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
					
					sql.put(svc.getQuery("SEL_SALE_CORNER3-05"));
					sql.setString(i++, userid);
					
				}else if(!strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("2") && strCmprFlag.equals("2")){  //매장
					System.out.println("/* 코너(매입) -전주대비 매입, 전주대비,  점:선택, 부문:선택 팀:선택, PC:선택*/");
					sql.put(svc.getQuery("SEL_SALE_CORNER4"));
					
					sql.setString(i++, strStrCd);						
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strSaleDtS);			
					sql.setString(i++, strSaleDtE);
					
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
				
					sql.setString(i++, strCmprDtS1);//대비기간 시작 1
					sql.setString(i++, strCmprDtE1);//대비기간 종료1
								
					sql.setString(i++, userid);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strCmprDtS2);//대비기간 시작 2
					sql.setString(i++, strCmprDtE2);//대비기간 종료2
					
					sql.setString(i++, userid);

					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDtS);			
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, strStrCd);						
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, userid);
				}
				else{
					if(strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("1") && strCmprFlag.equals("1")){
						System.out.println("/* PC(매장) -전년대비 매장, 전년대비,  점:선택, 부문:선택 팀:선택, PC:전체*/");
						sql.put(svc.getQuery("SEL_SALE_PC-01"));
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
						sql.setString(i++, strSaleDtE);//추가

						sql.setString(i++, userid);
						
						sql.setString(i++, strStrCd);
						sql.setString(i++, strSaleDtS);//추가
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
						
						sql.put(svc.getQuery("SEL_SALE_PC-03"));
						sql.setString(i++, userid);
						
						sql.setString(i++, strStrCd);
						sql.setString(i++, strSaleDtS);//추가
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
						
						sql.put(svc.getQuery("SEL_SALE_PC-04"));
						sql.setString(i++, userid);
						
				
					}else if(strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("2") && strCmprFlag.equals("1")){
						System.out.println("/* PC(매입) -전년대비 매입, 전년대비,  점:선택, 부문:선택 팀:선택, PC:전체*/");
						sql.put(svc.getQuery("SEL_SALE_PC2-01"));
						
						
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
						sql.setString(i++, strSaleDtE);//추가

						sql.setString(i++, userid);
						
						sql.setString(i++, strStrCd);
						sql.setString(i++, strSaleDtS);//추가
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

						sql.put(svc.getQuery("SEL_SALE_PC2-03"));
						sql.setString(i++, userid);
						
						sql.setString(i++, strStrCd);
						sql.setString(i++, strSaleDtS);//추가
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
						
						sql.put(svc.getQuery("SEL_SALE_PC2-04"));
						sql.setString(i++, userid);
						
				
					}else if(strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("1") && strCmprFlag.equals("2")){
						System.out.println("/* PC(매장) -전주대비 매장, 전주대비,  점:선택, 부문:선택 팀:선택, PC:전체*/");
						sql.put(svc.getQuery("SEL_SALE_PC3-01"));
						
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
						
						sql.put(svc.getQuery("SEL_SALE_PC3-02"));
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
						
						sql.put(svc.getQuery("SEL_SALE_PC3-03"));
						sql.setString(i++, strCmprDtS1);//대비기간 시작 1
						sql.setString(i++, strCmprDtE1);//대비기간 종료1
									
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
						
						sql.put(svc.getQuery("SEL_SALE_PC3-04"));
						sql.setString(i++, strCmprDtS2);//대비기간 시작 2
						sql.setString(i++, strCmprDtE2);//대비기간 종료2
						
						sql.setString(i++, userid);

						sql.setString(i++, strStrCd);
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
						
						sql.put(svc.getQuery("SEL_SALE_PC3-05"));
						sql.setString(i++, userid);
						
				
					}else if(strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%") && strOrgFlag.equals("2") && strCmprFlag.equals("2")){
						System.out.println("/* PC(매입) -전주대비 매입, 전주대비,  점:선택, 부문:선택 팀:선택, PC:전체*/");
						sql.put(svc.getQuery("SEL_SALE_PC4"));
						
						sql.setString(i++, strStrCd);						
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						sql.setString(i++, strSaleDtS);			
						sql.setString(i++, strSaleDtE);
						
						sql.setString(i++, userid);
						
						sql.setString(i++, strStrCd);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
					
						sql.setString(i++, strCmprDtS1);//대비기간 시작 1
						sql.setString(i++, strCmprDtE1);//대비기간 종료1
									
						sql.setString(i++, userid);
						
						sql.setString(i++, strStrCd);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						sql.setString(i++, strCmprDtS2);//대비기간 시작 2
						sql.setString(i++, strCmprDtE2);//대비기간 종료2
						
						sql.setString(i++, userid);

						sql.setString(i++, strStrCd);
						sql.setString(i++, strSaleDtS);			
						sql.setString(i++, strSaleDtE);
						sql.setString(i++, strStrCd);						
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						sql.setString(i++, userid);
						
				
					}

					else{
						if(strPCCd.equals("%") && strTeamCd.equals("%") && !strDeptCd.equals("%")&&strOrgFlag.equals("1") && strCmprFlag.equals("1")){
							System.out.println("/* 팀(매장) -전년대비  매장, 전년대비,  점:선택, 부문:선택 팀:전체, PC:전체*/");
							sql.put(svc.getQuery("SEL_SALE_TEAM-01"));
							
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
							
							sql.put(svc.getQuery("SEL_SALE_TEAM-02"));
							sql.setString(i++, strSaleDtS);
							sql.setString(i++, strSaleDtE);//추가

							sql.setString(i++, userid);
							
							sql.setString(i++, strStrCd);
							sql.setString(i++, strSaleDtS);//추가
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
							
							sql.put(svc.getQuery("SEL_SALE_TEAM-03"));
							sql.setString(i++, userid);
							
							sql.setString(i++, strStrCd);
							sql.setString(i++, strSaleDtS);//추가
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
							
							sql.put(svc.getQuery("SEL_SALE_TEAM-04"));
							sql.setString(i++, userid);
							
						}else if(strPCCd.equals("%") && strTeamCd.equals("%") && !strDeptCd.equals("%")&&strOrgFlag.equals("2") && strCmprFlag.equals("1")){
							System.out.println("/* 팀(매입) -전년대비 매입, 전년대비,  점:선택, 부문:선택 팀:전체, PC:전체*/");
						
							sql.put(svc.getQuery("SEL_SALE_TEAM2-01"));
							
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
							
							sql.put(svc.getQuery("SEL_SALE_TEAM2-02"));
							sql.setString(i++, strSaleDtS);
							sql.setString(i++, strSaleDtE);//추가

							sql.setString(i++, userid);
							
							sql.setString(i++, strStrCd);
							sql.setString(i++, strSaleDtS);//추가
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
							
							sql.put(svc.getQuery("SEL_SALE_TEAM2-03"));
							sql.setString(i++, userid);
							
							sql.setString(i++, strStrCd);
							sql.setString(i++, strSaleDtS);//추가
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
							
							sql.put(svc.getQuery("SEL_SALE_TEAM2-04"));
							sql.setString(i++, userid);
							

						}else if(strPCCd.equals("%") && strTeamCd.equals("%") && !strDeptCd.equals("%")&&strOrgFlag.equals("1") && strCmprFlag.equals("2")){
							System.out.println("/* 팀(매장) -전주대비 매장, 전주대비,  점:선택, 부문:선택 팀:전체, PC:전체*/");
							sql.put(svc.getQuery("SEL_SALE_TEAM3-01"));
							
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
							
							sql.put(svc.getQuery("SEL_SALE_TEAM3-02"));
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
							
							
							sql.put(svc.getQuery("SEL_SALE_TEAM3-03"));
							sql.setString(i++, strCmprDtS1);//대비기간 시작 1
							sql.setString(i++, strCmprDtE1);//대비기간 종료1
										
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
							
							sql.put(svc.getQuery("SEL_SALE_TEAM3-04"));
							sql.setString(i++, strCmprDtS2);//대비기간 시작 2
							sql.setString(i++, strCmprDtE2);//대비기간 종료2
							
							sql.setString(i++, userid);

							sql.setString(i++, strStrCd);
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
							
							sql.put(svc.getQuery("SEL_SALE_TEAM3-05"));
							sql.setString(i++, userid);

						}else if(strPCCd.equals("%") && strTeamCd.equals("%") && !strDeptCd.equals("%")&&strOrgFlag.equals("2") && strCmprFlag.equals("2")){
							System.out.println("/* 팀(매입) -전주대비 매입, 전주대비,  점:선택, 부문:선택 팀:전체, PC:전체*/");
							sql.put(svc.getQuery("SEL_SALE_TEAM4"));
							
							sql.setString(i++, strStrCd);						
							sql.setString(i++, strDeptCd);
							sql.setString(i++, strTeamCd);
							sql.setString(i++, strPCCd);
							sql.setString(i++, strSaleDtS);			
							sql.setString(i++, strSaleDtE);
							
							sql.setString(i++, userid);
							
							sql.setString(i++, strStrCd);
							sql.setString(i++, strDeptCd);
							sql.setString(i++, strTeamCd);
							sql.setString(i++, strPCCd);
						
							sql.setString(i++, strCmprDtS1);//대비기간 시작 1
							sql.setString(i++, strCmprDtE1);//대비기간 종료1
										
							sql.setString(i++, userid);
							
							sql.setString(i++, strStrCd);
							sql.setString(i++, strDeptCd);
							sql.setString(i++, strTeamCd);
							sql.setString(i++, strPCCd);
							sql.setString(i++, strCmprDtS2);//대비기간 시작 2
							sql.setString(i++, strCmprDtE2);//대비기간 종료2
							
							sql.setString(i++, userid);

							sql.setString(i++, strStrCd);
							sql.setString(i++, strSaleDtS);			
							sql.setString(i++, strSaleDtE);
							sql.setString(i++, strStrCd);						
							sql.setString(i++, strDeptCd);
							sql.setString(i++, strTeamCd);
							sql.setString(i++, strPCCd);
							sql.setString(i++, userid);

						}
						else{
							if(strPCCd.equals("%") && strTeamCd.equals("%") && strDeptCd.equals("%") &&strOrgFlag.equals("1") && strCmprFlag.equals("1")){
								System.out.println("/* 부분(매장) -전년대비 매장, 전년대비,  점:선택, 부문:전체 팀:전체, PC:전체*/");
								sql.put(svc.getQuery("SEL_SALE_DEPT-01"));
								
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
								
								sql.put(svc.getQuery("SEL_SALE_DEPT-02"));
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);//추가

								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);//추가
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
								
								sql.put(svc.getQuery("SEL_SALE_DEPT-03"));
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);//추가
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
								
								sql.put(svc.getQuery("SEL_SALE_DEPT-04"));
								sql.setString(i++, userid);
								
						
							}else if(strPCCd.equals("%") && strTeamCd.equals("%") && strDeptCd.equals("%") &&strOrgFlag.equals("2") && strCmprFlag.equals("1")){
								System.out.println("/* 부분(매입) -전년대비 매입, 전년대비,  점:선택, 부문:전체 팀:전체, PC:전체*/");
								sql.put(svc.getQuery("SEL_SALE_DEPT2-01"));
								
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
								
								sql.put(svc.getQuery("SEL_SALE_DEPT2-02"));
								sql.setString(i++, strSaleDtS);
								sql.setString(i++, strSaleDtE);//추가

								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);//추가
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
								
								sql.put(svc.getQuery("SEL_SALE_DEPT2-03"));
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);//추가
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
								
								sql.put(svc.getQuery("SEL_SALE_DEPT2-04"));
								sql.setString(i++, userid);
								

							}else if(strPCCd.equals("%") && strTeamCd.equals("%") && strDeptCd.equals("%") &&strOrgFlag.equals("1") && strCmprFlag.equals("2")){
								System.out.println("/* 부분(매장) -전주대비 매장, 전주대비,  점:선택, 부문:전체 팀:전체, PC:전체*/");
								
								sql.put(svc.getQuery("SEL_SALE_DEPT3"));
								
								sql.setString(i++, strStrCd);						
								sql.setString(i++, strDeptCd);
								sql.setString(i++, strTeamCd);
								sql.setString(i++, strPCCd);
								sql.setString(i++, strSaleDtS);			
								sql.setString(i++, strSaleDtE);
								
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strDeptCd);
								sql.setString(i++, strTeamCd);
								sql.setString(i++, strPCCd);
							
								sql.setString(i++, strCmprDtS1);//대비기간 시작 1
								sql.setString(i++, strCmprDtE1);//대비기간 종료1
											
								sql.setString(i++, userid);
								
								sql.setString(i++, strStrCd);
								sql.setString(i++, strDeptCd);
								sql.setString(i++, strTeamCd);
								sql.setString(i++, strPCCd);
								sql.setString(i++, strCmprDtS2);//대비기간 시작 2
								sql.setString(i++, strCmprDtE2);//대비기간 종료2
								
								sql.setString(i++, userid);

								sql.setString(i++, strStrCd);
								sql.setString(i++, strSaleDtS);			
								sql.setString(i++, strSaleDtE);
								sql.setString(i++, strStrCd);						
								sql.setString(i++, strDeptCd);
								sql.setString(i++, strTeamCd);
								sql.setString(i++, strPCCd);
								sql.setString(i++, userid);
								
							}else if(strPCCd.equals("%") && strTeamCd.equals("%") && strDeptCd.equals("%") &&strOrgFlag.equals("2") && strCmprFlag.equals("2")){
								
								System.out.println("/* 부분(매입) -전주대비 매입, 전주대비,  점:선택, 부문:전체 팀:전체, PC:전체 */");
								sql.put(svc.getQuery("SEL_SALE_DEPT4-01"));
								
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
								
								sql.put(svc.getQuery("SEL_SALE_DEPT4-02"));
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
								
								sql.put(svc.getQuery("SEL_SALE_DEPT4-03"));
								sql.setString(i++, strCmprDtS1);//대비기간 시작 1
								sql.setString(i++, strCmprDtE1);//대비기간 종료1
											
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
								
								sql.put(svc.getQuery("SEL_SALE_DEPT4-04"));
								sql.setString(i++, strCmprDtS2);//대비기간 시작 2
								sql.setString(i++, strCmprDtE2);//대비기간 종료2
								
								sql.setString(i++, userid);

								sql.setString(i++, strStrCd);
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
								
								sql.put(svc.getQuery("SEL_SALE_DEPT4-05"));
								sql.setString(i++, userid);
								
								
							}
						}
					}						
				}
			}
		}
		
		
		

		ret =  select2List(sql);
		
		return ret;
	}

	
	public List getBrd(ActionForm form, String OrgFlag, String userid) throws Exception {
		  
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
		
		String strCmprFlag      = String2.nvl(form.getParam("strCmprFlag"));// 대비구분
		String strCmprDtS1      = String2.nvl(form.getParam("strCmprDtS1"));// 대비일자 1-1
		String strCmprDtE1      = String2.nvl(form.getParam("strCmprDtE1"));// 대비일자 1-2
		String strCmprDtS2      = String2.nvl(form.getParam("strCmprDtS2"));// 대비일자 2-1
	    String strCmprDtE2      = String2.nvl(form.getParam("strCmprDtE2"));// 대비일자 2-2
	    String strCornerCd      = String2.nvl(form.getParam("strCornerCd"));// 
	    
	   
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		
			
		System.out.println("/* 코너(매장) -전년대비 매장, 전년대비,  점:선택, 부문:선택 팀:선택, PC:선택*/");
		sql.put(svc.getQuery("SEL_SALE_CORNER-01"));
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
		
		sql.put(svc.getQuery("SEL_SALE_CORNER-02"));
		sql.setString(i++, strSaleDtS);
		sql.setString(i++, strSaleDtE);//추가

		sql.setString(i++, userid);
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSaleDtS);//추가
		sql.setString(i++, strSaleDtE);


		ret =  select2List(sql);
		
		return ret;
		
}
	
	/**
	 * 대비일자 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	/*public List searchCmprdt(ActionForm form, String OrgFlag, String userid) throws Exception {
		
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
		
		sql.put(svc.getQuery("searchMaster2 SEL_CMPRDT"));
	
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSaleDtS);
		

		ret = searchMaster2 SELect2List(sql);
		
		return ret;
	}
*/
    /**
	* 대비일자 조회한다.
	*
	* @param  : 
	* @return :
	*/
	public List searchCmprDate(ActionForm form) {
		// TODO Auto-generated method stub
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;               

		//strStrCd	
		//strSaleDtS
		String strStrCd=String2.nvl(form.getParam("strStrCd"));
		String strSaleDtS=String2.nvl(form.getParam("strSaleDtS"));
				
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		
		
			sql.put(svc.getQuery("SEARCH_CMPR_DATE"));  
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			
			
			
			try {
				ret = select2List(sql);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		return ret;
	}

	
}
