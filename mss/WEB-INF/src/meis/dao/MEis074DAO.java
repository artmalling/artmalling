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
 * <p>월별조직별손익실적조회</p>
 * 
 * @created on 1.0, 2011/07/14
 * @created by 최재형
 * 
 * @modified on
 * @modified by
 * @caused by
 */
public class MEis074DAO extends AbstractDAO {

	/**
	 * 손익실적조회
	 * 
	 * @param form
	 * @param chartFlag TODO
	 * @return
	 * @throws Exception
	 */
	public List searchProfitAndLossRslt(ActionForm form, boolean chartFlag) throws Exception {
		
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strLoc   = null;
		int i           = 1;
		//파라미터 변수선언
		String strRsltY = null;
		String strOrgLevel = null;
		String strStrCd = null;
		String strDeptCd = null;
		String strTeamCd = null;
		String strPcCd = null;

		try {
			//파라미터 값 가져오기
			strRsltY = String2.trimToEmpty(form.getParam("strRsltY")); //경영실적년도
			strOrgLevel = String2.trimToEmpty(form.getParam("strOrgLevel")); //조직레벨(1:점.2"부문,3:팀,4:PC)
			strStrCd = String2.trimToEmpty(form.getParam("strStrCd")); //점코드
			strDeptCd = String2.trimToEmpty(form.getParam("strDeptCd")); //부문코드
			strTeamCd = String2.trimToEmpty(form.getParam("strTeamCd")); //팀코드
			strPcCd = String2.trimToEmpty(form.getParam("strPcCd")); //PC코드
			
			strLoc = "SEL_PROFIT_AND_LOSS_RSLT";
			if(chartFlag) strLoc = "SEL_PROFIT_AND_LOSS_RSLT_CHART";
			
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
			
			for(int j = 0; j < 3; j++) {
				sql.setString(i++, strRsltY);
				sql.setString(i++, strStrCd);
				sql.setString(i++, strDeptCd);
				sql.setString(i++, strTeamCd);
				sql.setString(i++, strPcCd);				
			}
			
			connect("pot");

			if(chartFlag) ret = this.select(sql); 
			else ret = select2List(sql);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

		return ret;

	}
	
}
