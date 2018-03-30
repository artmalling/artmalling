/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package psal.dao;

import java.net.URLDecoder;
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

public class PSal473DAO extends AbstractDAO {

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

		
		
		String strSaleDtS 		= String2.nvl(form.getParam("strSaleDtS"));
		String strSaleDtE 		= String2.nvl(form.getParam("strSaleDtE"));
		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strDeptCd 		= String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd 		= String2.nvl(form.getParam("strTeamCd"));
		String strPCCd 		    = String2.nvl(form.getParam("strPCCd"));
		
		String strCMPRDtS 		= String2.nvl(form.getParam("strCMPRDtS"));
		String strCMPRDtE 		= String2.nvl(form.getParam("strCMPRDtE"));
		//String strDept 			= URLDecoder.decode(String2.nvl(form.getParam("strDept")), "UTF-8");
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_SALE_MG_PUMBUN"));
		
		
		System.out.println(strSaleDtS);
		System.out.println(strSaleDtE);
		System.out.println(strCMPRDtS);
		System.out.println(strCMPRDtE);
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSaleDtS);		//매출
		sql.setString(i++, strSaleDtE);		//매출
		sql.setString(i++, userid);
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSaleDtS);		//목표
		sql.setString(i++, strSaleDtE);		//목표
		sql.setString(i++, userid);

		sql.setString(i++, strStrCd);
//		sql.setString(i++, strCMPRDtS);		//전년실적
//		sql.setString(i++, strCMPRDtE);		//전년실적
		sql.setString(i++, strSaleDtS);		//전년실적
		sql.setString(i++, strSaleDtE);		//전년실적		
		sql.setString(i++, userid);
				
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPCCd);
		
	
		ret = select2List(sql);
		
		return ret;
	}


}
