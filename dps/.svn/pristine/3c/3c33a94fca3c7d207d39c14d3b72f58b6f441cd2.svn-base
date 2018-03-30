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
 * @created  on 1.0, 2012/06/04
 * @created  by DHL (FUJITSU KOREA SOLUTION SERVICE LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PSal457DAO extends AbstractDAO {

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
		Service svc 	= null;
		String strQuery = "";
		int i 			= 1;
		
        String strOrgFlag    = String2.nvl(form.getParam("strOrgFlag"));      // 조직구분 코드
        String strSearchFg   = String2.nvl(form.getParam("strSearchFg"));     // 조회구분
		String strStrCd 	 = String2.nvl(form.getParam("strStrCd"));        // 점
		String strDeptCd 	 = String2.nvl(form.getParam("strDeptCd"));       // 부문
		String strTeamCd 	 = String2.nvl(form.getParam("strTeamCd"));       // 팀
		String strPCCd 		 = String2.nvl(form.getParam("strPCCd"));         // PC
		
		String strSaleDtS 	 = String2.nvl(form.getParam("strSaleDtS"));      // 매출일자-1
		String strSaleDtE 	 = String2.nvl(form.getParam("strSaleDtE"));      // 매출일자-2
	    String strSearchCnt  = String2.nvl(form.getParam("strSearchCnt"));    // 조회건수
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		// 협력사/브랜드
		if (strSearchFg.equals("1")) {
			sql.put(svc.getQuery("SEL_SALE_VEN"));
			
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, strSaleDtS);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strOrgFlag);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strOrgFlag);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strOrgFlag);
			sql.setString(i++, strPCCd);	
			
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, strSearchCnt);

			//sql.setString(i++, userid);
			
		// 브랜드
		} else if (strSearchFg.equals("2")) {
			sql.put(svc.getQuery("SEL_SALE_BRAND"));

			sql.setString(i++, strSaleDtE);
			sql.setString(i++, strSaleDtS);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strOrgFlag);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strOrgFlag);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strOrgFlag);
			sql.setString(i++, strPCCd);	
			
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, strSearchCnt);

			//sql.setString(i++, userid);
		} 

		ret = select2List(sql);
		return ret;
	}


	
}
