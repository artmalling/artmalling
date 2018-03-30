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

public class PSal471DAO extends AbstractDAO {

	/**
	 * 마스터 조회
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
		String strExeYmS 		= String2.nvl(form.getParam("strExeYmS"));
		String strExeYmE 		= String2.nvl(form.getParam("strExeYmE"));
		String strOrgFlag 		= String2.nvl(form.getParam("strOrgFlag"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		try {
		
			if(strOrgFlag.equals("1"))		// 매장
			{
	
				sql.put(svc.getQuery("SEL_SALEWEEK01"));
		
				sql.setString(i++, strExeYmS);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strExeYmS);
				sql.setString(i++, strExeYmS);
				
				
				
				
				if(!strDeptCd.equals("%"))
				{
					sql.put(svc.getQuery("SEL_WHERE_SALE_1"));
					sql.setString(i++, strDeptCd);
				}
				if(!strTeamCd.equals("%"))
				{
					sql.put(svc.getQuery("SEL_WHERE_SALE_2"));
					sql.setString(i++, strTeamCd);
				}
				if(!strPCCd.equals("%"))
				{
					sql.put(svc.getQuery("SEL_WHERE_SALE_3"));
					sql.setString(i++, strPCCd);
				}
				
				sql.put(svc.getQuery("SEL_SALEWEEK02"));
				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strExeYmS);
				sql.setString(i++, strExeYmS);
				
				
				if(!strDeptCd.equals("%"))
				{
					sql.put(svc.getQuery("SEL_WHERE_SALE_1"));
					sql.setString(i++, strDeptCd);
				}
				if(!strTeamCd.equals("%"))
				{
					sql.put(svc.getQuery("SEL_WHERE_SALE_2"));
					sql.setString(i++, strTeamCd);
				}
				if(!strPCCd.equals("%"))
				{
					sql.put(svc.getQuery("SEL_WHERE_SALE_3"));
					sql.setString(i++, strPCCd);
				}
				
				sql.put(svc.getQuery("SEL_SALEWEEK03"));
				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strExeYmE);
				sql.setString(i++, strExeYmE);
				
				if(!strDeptCd.equals("%"))
				{
					sql.put(svc.getQuery("SEL_WHERE_SALE_1"));
					sql.setString(i++, strDeptCd);
				}
				if(!strTeamCd.equals("%"))
				{
					sql.put(svc.getQuery("SEL_WHERE_SALE_2"));
					sql.setString(i++, strTeamCd);
				}
				if(!strPCCd.equals("%"))
				{
					sql.put(svc.getQuery("SEL_WHERE_SALE_3"));
					sql.setString(i++, strPCCd);
				}
				
				sql.put(svc.getQuery("SEL_SALEWEEK04"));
				sql.setString(i++, userid);
				 
				sql.setString(i++, strStrCd);
				sql.setString(i++, strExeYmE);
				sql.setString(i++, strExeYmE);
				
				if(!strDeptCd.equals("%"))
				{
					sql.put(svc.getQuery("SEL_WHERE_SALE_1"));
					sql.setString(i++, strDeptCd);
				}
				if(!strTeamCd.equals("%"))
				{
					sql.put(svc.getQuery("SEL_WHERE_SALE_2"));
					sql.setString(i++, strTeamCd);
				}
				if(!strPCCd.equals("%"))
				{
					sql.put(svc.getQuery("SEL_WHERE_SALE_3"));
					sql.setString(i++, strPCCd);
				}
				
				sql.put(svc.getQuery("SEL_SALEWEEK05"));
				sql.setString(i++, userid);
				
	
				
			} else {
				
				sql.put(svc.getQuery("SEL_SALEWEEK01"));
				
				sql.setString(i++, strExeYmS);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strExeYmS);
				sql.setString(i++, strExeYmS);
				
				
				
				
				if(!strDeptCd.equals("%"))
				{
					sql.put(svc.getQuery("SEL_WHERE_BUY_1"));
					sql.setString(i++, strDeptCd);
				}
				if(!strTeamCd.equals("%"))
				{
					sql.put(svc.getQuery("SEL_WHERE_BUY_2"));
					sql.setString(i++, strTeamCd);
				}
				if(!strPCCd.equals("%"))
				{
					sql.put(svc.getQuery("SEL_WHERE_BUY_3"));
					sql.setString(i++, strPCCd);
				}
				
				sql.put(svc.getQuery("SEL_SALEWEEK02"));
				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strExeYmS);
				sql.setString(i++, strExeYmS);
				
				
				if(!strDeptCd.equals("%"))
				{
					sql.put(svc.getQuery("SEL_WHERE_BUY_1"));
					sql.setString(i++, strDeptCd);
				}
				if(!strTeamCd.equals("%"))
				{
					sql.put(svc.getQuery("SEL_WHERE_BUY_2"));
					sql.setString(i++, strTeamCd);
				}
				if(!strPCCd.equals("%"))
				{
					sql.put(svc.getQuery("SEL_WHERE_BUY_3"));
					sql.setString(i++, strPCCd);
				}
				
				sql.put(svc.getQuery("SEL_SALEWEEK03"));
				sql.setString(i++, userid);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strExeYmE);
				sql.setString(i++, strExeYmE);
				
				if(!strDeptCd.equals("%"))
				{
					sql.put(svc.getQuery("SEL_WHERE_BUY_1"));
					sql.setString(i++, strDeptCd);
				}
				if(!strTeamCd.equals("%"))
				{
					sql.put(svc.getQuery("SEL_WHERE_BUY_2"));
					sql.setString(i++, strTeamCd);
				}
				if(!strPCCd.equals("%"))
				{
					sql.put(svc.getQuery("SEL_WHERE_BUY_3"));
					sql.setString(i++, strPCCd);
				}
				
				sql.put(svc.getQuery("SEL_SALEWEEK04"));
				sql.setString(i++, userid);
				 
				sql.setString(i++, strStrCd);
				sql.setString(i++, strExeYmE);
				sql.setString(i++, strExeYmE);
				
				if(!strDeptCd.equals("%"))
				{
					sql.put(svc.getQuery("SEL_WHERE_BUY_1"));
					sql.setString(i++, strDeptCd);
				}
				if(!strTeamCd.equals("%"))
				{
					sql.put(svc.getQuery("SEL_WHERE_BUY_2"));
					sql.setString(i++, strTeamCd);
				}
				if(!strPCCd.equals("%"))
				{
					sql.put(svc.getQuery("SEL_WHERE_BUY_3"));
					sql.setString(i++, strPCCd);
				}
				
				sql.put(svc.getQuery("SEL_SALEWEEK05"));
				sql.setString(i++, userid);
				
			}
				
			ret = select2List(sql);
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return ret;
	}

}
