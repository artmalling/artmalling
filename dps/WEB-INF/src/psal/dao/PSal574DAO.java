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

public class PSal574DAO extends AbstractDAO {

	/**
	 * 마스터를 조회한다
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String OrgFlag, String userid) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		
		Service svc 	= null;
		
		int i 			= 1;
		

		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strDeptCd 		= String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd 		= String2.nvl(form.getParam("strTeamCd"));
		String strPCCd 		    = String2.nvl(form.getParam("strPCCd"));
		String strSaleDtS 		= String2.nvl(form.getParam("strSaleDtS"));
		String strSaleDtE 		= String2.nvl(form.getParam("strSaleDtE"));
		String strOrgFlag   	= String2.nvl(form.getParam("strOrgFlag"));
		String strEmUnit 		 = String2.nvl(form.getParam("strEmUnit"));
		
		String strUnit = "1";		// '원'단위(01:원,02:천원)
		if(strEmUnit.equals("02")){	
			strUnit = "1000";
		}
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		if(strOrgFlag.equals("1")){
			sql.put(svc.getQuery("SEL_SALE_PC"));
			 // 월			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			 // 년
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS.substring(0, 4));
			 // 목표년
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS.substring(0, 4));
			sql.setString(i++, strSaleDtS.substring(0, 4));
			 // 목표월
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtS);			
			 // 대비월
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtE);
			 // 대비년
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtE.substring(0, 4));			
			
			sql.setString(i++, strUnit);
			
			/*
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);			
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, userid);
			*/
						
			
			
		}else{
			sql.put(svc.getQuery("SEL_SALE_PC2"));
			
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, strUnit);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);			
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, userid);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, userid);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, userid);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);			
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, userid);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, userid);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, userid);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);			
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, userid);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, userid);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, userid);
			
			
		}

		ret = select2List(sql);
		
		return ret;
	}

	/**
	 * 상세를 조회한다
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDetail(ActionForm form, String OrgFlag, String userid) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		
		Service svc 	= null;
		
		int i 			= 1;
		

		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strDeptCd 		= String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd 		= String2.nvl(form.getParam("strTeamCd"));
		String strPCCd 		    = String2.nvl(form.getParam("strPCCd"));
		String strSaleDtS 		= String2.nvl(form.getParam("strSaleDtS"));
		String strSaleDtE 		= String2.nvl(form.getParam("strSaleDtE"));
		String strOrgFlag 		= String2.nvl(form.getParam("strOrgFlag"));
		String strEmUnit 		 = String2.nvl(form.getParam("strEmUnit"));
		
		String strUnit = "1";		// '원'단위(01:원,02:천원)
		if(strEmUnit.equals("02")){	
			strUnit = "1000";
		}
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		if(strOrgFlag.equals("1")){
			sql.put(svc.getQuery("SEL_SALE_PUMBUN"));
			
			 // 월			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			 // 년
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS.substring(0, 4));
			 // 목표년
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS.substring(0, 4));
			sql.setString(i++, strSaleDtS.substring(0, 4));
			 // 목표월
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtS);			
			 // 대비월
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtE);
			 // 대비년
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtE.substring(0, 4));			
			
			sql.setString(i++, strUnit);
						
		}else{
			sql.put(svc.getQuery("SEL_SALE_PUMBUN2"));
			
			sql.setString(i++, strUnit);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);			
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, userid);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, userid);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, userid);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);			
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, userid);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, userid);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, userid);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);			
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, userid);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, userid);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, userid);
		}

		ret = select2List(sql);
		
		return ret;
	}
	
	/**
	 * 상세를 조회한다
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDetail2(ActionForm form, String OrgFlag, String userid) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		
		Service svc 	= null;
		
		int i 			= 1;
		

		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strSaleDtS 		= String2.nvl(form.getParam("strSaleDtS"));
		String strSaleDtE 		= String2.nvl(form.getParam("strSaleDtE"));
		String strOrgFlag 		= String2.nvl(form.getParam("strOrgFlag"));
		
	
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		if(strOrgFlag.equals("1")){
			sql.put(svc.getQuery("SEL_CMNTS2"));
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, userid);

			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, userid);
			
						
		}else{
			
		}

		ret = select2List(sql);
		
		return ret;
	}
	
	
	/**
	 * 마스터를 조회한다
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster2(ActionForm form, String OrgFlag, String userid) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		
		Service svc 	= null;
		
		int i 			= 1;
		

		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strSaleDtS 		= String2.nvl(form.getParam("strSaleDtS"));
		String strOrgFlag 		= String2.nvl(form.getParam("strOrgFlag"));
		
	
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		if(strOrgFlag.equals("1")){
			sql.put(svc.getQuery("SEL_CMNTS"));
			
			sql.setString(i++, userid);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			
						
		}else{
			
		}

		ret = select2List(sql);
		
		return ret;
	}
	
	
	/**
	 * 마스터를 조회한다
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List EMCreate(ActionForm form, String OrgFlag, String userid) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		
		Service svc 	= null;
		
		int i 			= 1;
		

		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strSaleDtS 		= String2.nvl(form.getParam("strSaleDtS"));
		String strOrgFlag 		= String2.nvl(form.getParam("strOrgFlag"));
		
	
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		if(strOrgFlag.equals("1")){
			sql.put(svc.getQuery("SEL_CMNTS_EM"));
			
			sql.setString(i++, userid);
			
						
		}else{
			
		}

		ret = select2List(sql);
		
		return ret;
	}
	
	/**
	 * 마스터를 조회한다
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List EMCreate2(ActionForm form, String OrgFlag, String userid) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		
		Service svc 	= null;
		
		int i 			= 1;
		

		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strSaleDtS 		= String2.nvl(form.getParam("strSaleDtS"));
		String strOrgFlag 		= String2.nvl(form.getParam("strOrgFlag"));
		
	
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		if(strOrgFlag.equals("1")){
			sql.put(svc.getQuery("SEL_CMNTS_EM2"));
			
			sql.setString(i++, userid);
			
						
		}else{
			
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
	
	
	public int saveData(ActionForm form, String OrgFlag, String userid) throws Exception {
		
		int ret 		= 0;
		SqlWrapper sql 	= null;
		SqlWrapper sql2	= null;
		Service svc 	= null;
		int i 			= 1;
		
		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strSaleDtS 		= String2.nvl(form.getParam("strSaleDtS"));
		
		String strOrg0          = String2.nvl(form.getParam("strOrg0"));
		String strOrg1          = String2.nvl(form.getParam("strOrg1"));
		String strOrg2          = String2.nvl(form.getParam("strOrg2"));
		String strOrg3          = String2.nvl(form.getParam("strOrg3"));
		String strOrg4          = String2.nvl(form.getParam("strOrg4"));
		String strOrg5          = String2.nvl(form.getParam("strOrg5"));
		String strOrg6          = String2.nvl(form.getParam("strOrg6"));
		String strOrg7          = String2.nvl(form.getParam("strOrg7"));
		String strOrg8          = String2.nvl(form.getParam("strOrg8"));
		String strOrg9          = String2.nvl(form.getParam("strOrg9"));
		String strOrg10          = String2.nvl(form.getParam("strOrg10"));
		
		
		String memo01          = String2.nvl(form.getParam("memo01"));
		String memo02          = String2.nvl(form.getParam("memo02"));
		String memo11          = String2.nvl(form.getParam("memo11"));
		String memo12          = String2.nvl(form.getParam("memo12"));
		String memo21          = String2.nvl(form.getParam("memo21"));
		String memo22          = String2.nvl(form.getParam("memo22"));
		String memo31          = String2.nvl(form.getParam("memo31"));
		String memo32          = String2.nvl(form.getParam("memo32"));
		String memo41          = String2.nvl(form.getParam("memo41"));
		String memo42          = String2.nvl(form.getParam("memo42"));
		String memo43          = String2.nvl(form.getParam("memo43"));
		String memo44          = String2.nvl(form.getParam("memo44"));
		String memo51          = String2.nvl(form.getParam("memo51"));
		String memo52          = String2.nvl(form.getParam("memo52"));
		String memo61          = String2.nvl(form.getParam("memo61"));
		String memo62          = String2.nvl(form.getParam("memo62"));
		String memo71          = String2.nvl(form.getParam("memo71"));
		String memo72          = String2.nvl(form.getParam("memo72"));
		String memo81          = String2.nvl(form.getParam("memo81"));
		String memo82          = String2.nvl(form.getParam("memo82"));
		String memo91          = String2.nvl(form.getParam("memo91"));
		String memo92          = String2.nvl(form.getParam("memo92"));

		sql = new SqlWrapper();
		sql2 = new SqlWrapper();
		svc = (Service) form.getService();
		
		
		try {
			
		
		connect("pot");
		begin();
		
		sql.put(svc.getQuery("DEL_CMNTS"));
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSaleDtS);
		sql.setString(i++, userid);

		update(sql);
		
		i = 1;
		
		sql2.put(svc.getQuery("INS_CMNTS"));
		
		sql2.setString(i++, strStrCd);
		sql2.setString(i++, strSaleDtS);
		sql2.setString(i++, userid);
		sql2.setString(i++, memo01);
		sql2.setString(i++, userid);
		sql2.setString(i++, strOrg0);
		
		sql2.setString(i++, strStrCd);
		sql2.setString(i++, strSaleDtS);
		sql2.setString(i++, userid);
		sql2.setString(i++, memo02);
		sql2.setString(i++, userid);
		sql2.setString(i++, strOrg0);
		
		sql2.setString(i++, strStrCd);
		sql2.setString(i++, strSaleDtS);
		sql2.setString(i++, userid);
		sql2.setString(i++, memo11);
		sql2.setString(i++, userid);
		sql2.setString(i++, strOrg1);
		
		sql2.setString(i++, strStrCd);
		sql2.setString(i++, strSaleDtS);
		sql2.setString(i++, userid);
		sql2.setString(i++, memo12);
		sql2.setString(i++, userid);
		sql2.setString(i++, strOrg1);
		
		sql2.setString(i++, strStrCd);
		sql2.setString(i++, strSaleDtS);
		sql2.setString(i++, userid);
		sql2.setString(i++, memo21);
		sql2.setString(i++, userid);
		sql2.setString(i++, strOrg2);
		
		sql2.setString(i++, strStrCd);
		sql2.setString(i++, strSaleDtS);
		sql2.setString(i++, userid);
		sql2.setString(i++, memo22);
		sql2.setString(i++, userid);
		sql2.setString(i++, strOrg2);
		
		sql2.setString(i++, strStrCd);
		sql2.setString(i++, strSaleDtS);
		sql2.setString(i++, userid);
		sql2.setString(i++, memo31);
		sql2.setString(i++, userid);
		sql2.setString(i++, strOrg3);
		
		sql2.setString(i++, strStrCd);
		sql2.setString(i++, strSaleDtS);
		sql2.setString(i++, userid);
		sql2.setString(i++, memo32);
		sql2.setString(i++, userid);
		sql2.setString(i++, strOrg3);
		
		sql2.setString(i++, strStrCd);
		sql2.setString(i++, strSaleDtS);
		sql2.setString(i++, userid);
		sql2.setString(i++, memo41);
		sql2.setString(i++, userid);
		sql2.setString(i++, strOrg4);
		
		sql2.setString(i++, strStrCd);
		sql2.setString(i++, strSaleDtS);
		sql2.setString(i++, userid);
		sql2.setString(i++, memo42);
		sql2.setString(i++, userid);
		sql2.setString(i++, strOrg4);
		
		sql2.setString(i++, strStrCd);
		sql2.setString(i++, strSaleDtS);
		sql2.setString(i++, userid);
		sql2.setString(i++, memo51);
		sql2.setString(i++, userid);
		sql2.setString(i++, strOrg5);
		
		sql2.setString(i++, strStrCd);
		sql2.setString(i++, strSaleDtS);
		sql2.setString(i++, userid);
		sql2.setString(i++, memo52);
		sql2.setString(i++, userid);
		sql2.setString(i++, strOrg5);
	
		sql2.setString(i++, strStrCd);
		sql2.setString(i++, strSaleDtS);
		sql2.setString(i++, userid);
		sql2.setString(i++, memo61);
		sql2.setString(i++, userid);
		sql2.setString(i++, strOrg6);
		
		sql2.setString(i++, strStrCd);
		sql2.setString(i++, strSaleDtS);
		sql2.setString(i++, userid);
		sql2.setString(i++, memo62);
		sql2.setString(i++, userid);
		sql2.setString(i++, strOrg6);
		
		sql2.setString(i++, strStrCd);
		sql2.setString(i++, strSaleDtS);
		sql2.setString(i++, userid);
		sql2.setString(i++, memo71);
		sql2.setString(i++, userid);
		sql2.setString(i++, strOrg7);
		
		sql2.setString(i++, strStrCd);
		sql2.setString(i++, strSaleDtS);
		sql2.setString(i++, userid);
		sql2.setString(i++, memo72);
		sql2.setString(i++, userid);
		sql2.setString(i++, strOrg7);
		
		sql2.setString(i++, strStrCd);
		sql2.setString(i++, strSaleDtS);
		sql2.setString(i++, userid);
		sql2.setString(i++, memo81);
		sql2.setString(i++, userid);
		sql2.setString(i++, strOrg8);
		
		sql2.setString(i++, strStrCd);
		sql2.setString(i++, strSaleDtS);
		sql2.setString(i++, userid);
		sql2.setString(i++, memo82);
		sql2.setString(i++, userid);
		sql2.setString(i++, strOrg8);
		
		sql2.setString(i++, strStrCd);
		sql2.setString(i++, strSaleDtS);
		sql2.setString(i++, userid);
		sql2.setString(i++, memo91);
		sql2.setString(i++, userid);
		sql2.setString(i++, strOrg9);
		
		sql2.setString(i++, strStrCd);
		sql2.setString(i++, strSaleDtS);
		sql2.setString(i++, userid);
		sql2.setString(i++, memo92);
		sql2.setString(i++, userid);
		sql2.setString(i++, strOrg9);
		
		sql2.setString(i++, strStrCd);
		sql2.setString(i++, strSaleDtS);
		sql2.setString(i++, userid);
		sql2.setString(i++, memo43);
		sql2.setString(i++, userid);
		sql2.setString(i++, strOrg10);
		
		sql2.setString(i++, strStrCd);
		sql2.setString(i++, strSaleDtS);
		sql2.setString(i++, userid);
		sql2.setString(i++, memo44);
		sql2.setString(i++, userid);
		sql2.setString(i++, strOrg10);

		ret = update(sql2);
		
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		
		return ret;
	}
	
	
	public int saveData2(ActionForm form, String OrgFlag, String userid) throws Exception {
		
		int ret 		= 0;
		SqlWrapper sql 	= null;
		SqlWrapper sql2	= null;
		Service svc 	= null;
		int i 			= 1;
		
		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strSaleDtS 		= String2.nvl(form.getParam("strSaleDtS"));
		
		String strGrp1          = String2.nvl(form.getParam("strGrp1"));
		String strGrp2          = String2.nvl(form.getParam("strGrp2"));
		String strGrp3          = String2.nvl(form.getParam("strGrp3"));
		String strGrp4          = String2.nvl(form.getParam("strGrp4"));
		String strGrp5          = String2.nvl(form.getParam("strGrp5"));
		
		String memoPre1          = String2.nvl(form.getParam("memoPre1"));
		String memoPre2          = String2.nvl(form.getParam("memoPre2"));
		String memoPre3          = String2.nvl(form.getParam("memoPre3"));
		String memoPre4          = String2.nvl(form.getParam("memoPre4"));
		String memoPre5          = String2.nvl(form.getParam("memoPre5"));
		
		

		sql = new SqlWrapper();
		sql2 = new SqlWrapper();
		svc = (Service) form.getService();
		
		
		try {
			
		
		connect("pot");
		begin();
		
		sql.put(svc.getQuery("DEL_CMNTS2"));
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSaleDtS);
		sql.setString(i++, userid);

		update(sql);
		
		i = 1;
		
		sql2.put(svc.getQuery("INS_CMNTS2"));
		
		sql2.setString(i++, strStrCd);
		sql2.setString(i++, strSaleDtS);
		sql2.setString(i++, strGrp1);
		sql2.setString(i++, memoPre1);
		sql2.setString(i++, userid);

	
		sql2.setString(i++, strStrCd);
		sql2.setString(i++, strSaleDtS);
		sql2.setString(i++, strGrp2);
		sql2.setString(i++, memoPre2);
		sql2.setString(i++, userid);

		sql2.setString(i++, strStrCd);
		sql2.setString(i++, strSaleDtS);
		sql2.setString(i++, strGrp3);
		sql2.setString(i++, memoPre3);
		sql2.setString(i++, userid);
		
		sql2.setString(i++, strStrCd);
		sql2.setString(i++, strSaleDtS);
		sql2.setString(i++, strGrp4);
		sql2.setString(i++, memoPre4);
		sql2.setString(i++, userid);
		
		sql2.setString(i++, strStrCd);
		sql2.setString(i++, strSaleDtS);
		sql2.setString(i++, strGrp5);
		sql2.setString(i++, memoPre5);
		sql2.setString(i++, userid);
		
		ret = update(sql2);
		
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		
		return ret;
	}
	
	
	

}
