/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */
package meis.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>조직별손익계획상세 조회</p>
 * 
 * @created on 1.0, 2011/07/01
 * @created by 최재형
 * 
 * @modified on
 * @modified by
 * @caused by
 */
public class MEis048DAO extends AbstractDAO {
	
	/**
	 * 조직별손익계획상세 조회
	 * 
	 * @param form
	 * @param chartFlag TODO
	 * @return
	 * @throws Exception
	 */
	public List searchProfitAndLossPlanDtl(ActionForm form) throws Exception {
		
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strLoc   = null;
		int i           = 1;
		//파라미터 변수선언
		String strPlanY = null;
		String strOrgLevel = null;
		String strStrCd = null;
		String strDeptCd = null;
		String strTeamCd = null;
		String strPcCd = null;

		try {
			//파라미터 값 가져오기
			strPlanY = String2.trimToEmpty(form.getParam("strPlanY")); //경영계획년도
			strOrgLevel = String2.trimToEmpty(form.getParam("strOrgLevel")); //조직레벨(1:점.2"부문,3:팀,4:PC)
			strStrCd = String2.trimToEmpty(form.getParam("strStrCd")); //점코드
			strDeptCd = String2.trimToEmpty(form.getParam("strDeptCd")); //부문코드
			strTeamCd = String2.trimToEmpty(form.getParam("strTeamCd")); //팀코드
			strPcCd = String2.trimToEmpty(form.getParam("strPcCd")); //PC코드
			
			strLoc = "SEL_PROFIT_AND_LOSS_PLAN_DTL";
			
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));

			sql.setString(i++, strStrCd);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPcCd);
			sql.setString(i++, strPcCd);			
			
			sql.setString(i++, strPlanY);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPcCd);				
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

		return ret;

	}
}
