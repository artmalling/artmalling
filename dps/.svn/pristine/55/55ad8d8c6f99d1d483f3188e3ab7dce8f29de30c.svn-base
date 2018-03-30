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

public class PSal407DAO extends AbstractDAO {

	/**
	 * 마스터 조회한다.
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
		String strDisp   		= String2.nvl(form.getParam("strDisp"));
		String strOrgFlag		= String2.nvl(form.getParam("strOrgFlag")); 

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		if(strOrgFlag.equals("1")){
	        if(!strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%")){
	        	
	        	if (strDisp.equals("0")) {
	        		sql.put(svc.getQuery("SEL_SALE_PUMBUN"));
	        		
	        	}  else {
	        		sql.put(svc.getQuery("SEL_SALE_PUMBUN_DATE"));
	        		
	        	}
	
	    		sql.setString(i++, strStrCd);
	    		sql.setString(i++, strDeptCd);
	    		sql.setString(i++, strTeamCd);
	    		sql.setString(i++, strPCCd);
	    		sql.setString(i++, strSaleDtS);
	    		sql.setString(i++, strSaleDtE);
	    		sql.setString(i++, userid);
	    	
	    		ret = select2List(sql);
			}
			else{
				if(strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%")){
					if (strDisp.equals("0")) {
						sql.put(svc.getQuery("SEL_SALE_PC"));
						
					}  else {
		        		sql.put(svc.getQuery("SEL_SALE_PC_DATE"));
		        		
		        	}
						
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
				
					ret = select2List(sql);
				}
				else{
					if(strPCCd.equals("%") &&  strTeamCd.equals("%") && !strDeptCd.equals("%")){
						if (strDisp.equals("0")) {
							sql.put(svc.getQuery("SEL_SALE_TEAM"));
							
						}  else {
			        		sql.put(svc.getQuery("SEL_SALE_TEAM_DATE"));
			        		
			        	}
						sql.setString(i++, strStrCd);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
						sql.setString(i++, userid);
					
						ret = select2List(sql);
					}
					else{
						if (strDisp.equals("0")) {
							sql.put(svc.getQuery("SEL_SALE_DEPT"));
							
						}  else {
			        		sql.put(svc.getQuery("SEL_SALE_DEPT_DATE"));
			        		
			        	}
	
						sql.setString(i++, strStrCd);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
						sql.setString(i++, userid);
					
						ret = select2List(sql);
					}
					
				}
					
			}
		}else{
			if(!strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%")){
	        	
	        	if (strDisp.equals("0")) {
	        		sql.put(svc.getQuery("SEL_SALE_PUMBUN2"));
	        		
	        	}  else {
	        		sql.put(svc.getQuery("SEL_SALE_PUMBUN_DATE2"));
	        		
	        	}
	
	    		sql.setString(i++, strStrCd);
	    		sql.setString(i++, strDeptCd);
	    		sql.setString(i++, strTeamCd);
	    		sql.setString(i++, strPCCd);
	    		sql.setString(i++, strSaleDtS);
	    		sql.setString(i++, strSaleDtE);
	    		sql.setString(i++, userid);
	    	
	    		ret = select2List(sql);
			}
			else{
				if(strPCCd.equals("%") && !strTeamCd.equals("%") && !strDeptCd.equals("%")){
					if (strDisp.equals("0")) {
						sql.put(svc.getQuery("SEL_SALE_PC2"));
						
					}  else {
		        		sql.put(svc.getQuery("SEL_SALE_PC_DATE2"));
		        		
		        	}
						
					sql.setString(i++, strStrCd);
					sql.setString(i++, strDeptCd);
					sql.setString(i++, strTeamCd);
					sql.setString(i++, strPCCd);
					sql.setString(i++, strSaleDtS);
					sql.setString(i++, strSaleDtE);
					sql.setString(i++, userid);
				
					ret = select2List(sql);
				}
				else{
					if(strPCCd.equals("%") &&  strTeamCd.equals("%") && !strDeptCd.equals("%")){
						if (strDisp.equals("0")) {
							sql.put(svc.getQuery("SEL_SALE_TEAM2"));
							
						}  else {
			        		sql.put(svc.getQuery("SEL_SALE_TEAM_DATE2"));
			        		
			        	}
						sql.setString(i++, strStrCd);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
						sql.setString(i++, userid);
					
						ret = select2List(sql);
					}
					else{
						if (strDisp.equals("0")) {
							sql.put(svc.getQuery("SEL_SALE_DEPT2"));
							
						}  else {
			        		sql.put(svc.getQuery("SEL_SALE_DEPT_DATE2"));
			        		
			        	}
	
						sql.setString(i++, strStrCd);
						sql.setString(i++, strDeptCd);
						sql.setString(i++, strTeamCd);
						sql.setString(i++, strPCCd);
						sql.setString(i++, strSaleDtS);
						sql.setString(i++, strSaleDtE);
						sql.setString(i++, userid);
					
						ret = select2List(sql);
					}
					
				}
					
			}
		}
		
		return ret;
	}


}
