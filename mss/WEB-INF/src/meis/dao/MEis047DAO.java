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
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>조직별매출계획상세조회</p>
 * 
 * @created on 1.0, 2011/06/27
 * @created by 최재형
 * 
 * @modified on
 * @modified by
 * @caused by
 */
public class MEis047DAO extends AbstractDAO {

	/**
	 * 매출계획상세조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List<Map> searchSalesPlanDtl(ActionForm form) throws Exception {
		List<Map> ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strLoc   = null;
		int i           = 1;
		//파라미터 변수선언
		String strStrCd = null;
		String strPlanY = null;
		String strOrgLevel = null;

		try {
			//파라미터 값 가져오기
			strStrCd = String2.trimToEmpty(form.getParam("strStrCd")); //점코드
			strPlanY = String2.trimToEmpty(form.getParam("strPlanY")); //경영계획년도
			strOrgLevel = String2.trimToEmpty(form.getParam("strOrgLevel")); //조직레벨(1:점,3:팀,4:PC)
			
			//점
			if(strOrgLevel.equals("1")) {
				strLoc = "SEL_SALES_PLAN_DTL_STR";
			//팀
			} else if(strOrgLevel.equals("3")) {
				strLoc = "SEL_SALES_PLAN_DTL_TEAM";
			//PC
			} else if(strOrgLevel.equals("4")) {
				strLoc = "SEL_SALES_PLAN_DTL_PC";
			}
			
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));

			sql.setString(i++, strPlanY);
			sql.setString(i++, strPlanY);
			
			if(strOrgLevel.equals("3") || strOrgLevel.equals("4")) {
				sql.setString(i++, strStrCd);
			}
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return ret;
	}
	
}
