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

public class PSal309DAO extends AbstractDAO {

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
		String strSaleCmprDtS 	= String2.nvl(form.getParam("strSaleCmprDtS"));
		String strSaleCmprDtE 	= String2.nvl(form.getParam("strSaleCmprDtE"));
		String strGbn 	        = String2.nvl(form.getParam("strGbn"));
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
			sql.put(svc.getQuery("SEL_MASTER"));
			
						
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strUnit);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			
			
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strUnit);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			
		}else{
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strUnit);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			
			
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strUnit);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
		}
		
	
		ret = select2List(sql);
		
		return ret;
	}
	
	

	/**
	 * DETAIL 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDetail(ActionForm form, String OrgFlag, String userid) throws Exception {
		
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
		String strSaleCmprDtS 	= String2.nvl(form.getParam("strSaleCmprDtS"));
		String strGbn 	        = String2.nvl(form.getParam("strGbn"));
		String strOrgFlag       = String2.nvl(form.getParam("strOrgFlag"));
		String strEmUnit        = String2.nvl(form.getParam("strEmUnit"));
		String strSeq	        = String2.nvl(form.getParam("strSeq"));
		
		String strUnit = "1";		// '원'단위(01:원,02:천원)
		if(strEmUnit.equals("02")){	
			strUnit = "1000";
		}
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		if(strSeq.equals("2")){
			sql.put(svc.getQuery("SEL_MASTER2"));
			
			sql.setString(i++, strUnit);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			
			sql.setString(i++, strUnit);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			
		}else if(strSeq.equals("3")){
			sql.put(svc.getQuery("SEL_MASTER3"));
			
			sql.setString(i++, strUnit);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			
			sql.setString(i++, strUnit);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			
		}else {
			sql.put(svc.getQuery("SEL_MASTER4"));
			
			sql.setString(i++, strUnit);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			
			sql.setString(i++, strUnit);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			
		}
	
		ret = select2List(sql);
		
		return ret;
	}


}
