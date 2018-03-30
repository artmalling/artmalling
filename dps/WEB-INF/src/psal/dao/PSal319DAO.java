
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

public class PSal319DAO extends AbstractDAO {

	/**
	 * 마스터 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String userid) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		int i 			= 1;
		

		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strSaleDtS 		= String2.nvl(form.getParam("strSaleDtS"));
		String strSaleDtE 		= String2.nvl(form.getParam("strSaleDtE"));
		String strSaleTmS		= String2.nvl(form.getParam("strSaleTmS"));
		String strSaleTmE		= String2.nvl(form.getParam("strSaleTmE"));
		String strOrgFlag       = String2.nvl(form.getParam("strOrgFlag"));
		String strEmUnit 		= String2.nvl(form.getParam("strEmUnit"));
		String strChkTot 		= String2.nvl(form.getParam("strChkTot"));
		String strChkAvg 		= String2.nvl(form.getParam("strChkAvg"));
		String strChkOnl 		= String2.nvl(form.getParam("strChkOnl"));

		
		String strUnit = "1";		// '원'단위(01:원,02:천원)
				if(strEmUnit.equals("02")){	
					strUnit = "1000";
				}
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		if(strOrgFlag.equals("1")){
			
			sql.put(svc.getQuery("SEL_SALE_LIST"));
			
			//sql.setString(i++, strUnit);
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			//sql.setString(i++, strSaleTmS);
			//sql.setString(i++, strSaleTmE);
			
			if(!strChkOnl.equals("N"))
			{
				sql.put(svc.getQuery("SEL_SALE_ONLINE"));
				sql.setString(i++, strSaleDtE);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strStrCd);
				sql.setString(i++, strSaleDtS);
				sql.setString(i++, strSaleDtE);
			}
			
			sql.put(svc.getQuery("SEL_SALE_LISTEND"));
			
			sql.put(svc.getQuery("SEL_SALE_TIME"));
			sql.setString(i++, strUnit);
			sql.setString(i++, strSaleTmS);
			sql.setString(i++, strSaleTmE);
		
			
			if(!strChkTot.equals("N"))
			{
				sql.put(svc.getQuery("SEL_TOT_TIME"));
				sql.setString(i++, strUnit);
				sql.setString(i++, strSaleTmS);
				sql.setString(i++, strSaleTmE);
			}
			if(!strChkAvg.equals("N"))
			{
				sql.put(svc.getQuery("SEL_AVG_TIME"));
				sql.setString(i++, strUnit);
				sql.setString(i++, strSaleTmS);
				sql.setString(i++, strSaleTmE);
			}
			
			
			sql.put(svc.getQuery("SEL_ORDERBY"));

			
		}else if(strOrgFlag.equals("2")){
			
			sql.put(svc.getQuery("SEL_SALE_LIST"));
			
			//sql.setString(i++, strUnit);
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
			sql.setString(i++, strSaleTmS);
			sql.setString(i++, strSaleTmE);
	
			sql.put(svc.getQuery("SEL_SALE_TIME"));
			sql.setString(i++, strUnit);
		
			
			if(!strChkTot.equals("N"))
			{
				sql.put(svc.getQuery("SEL_TOT_TIME"));
				sql.setString(i++, strUnit);
			}
			if(!strChkAvg.equals("N"))
			{
				sql.put(svc.getQuery("SEL_AVG_TIME"));
				sql.setString(i++, strUnit);
			}
			
			
			sql.put(svc.getQuery("SEL_ORDERBY"));

			
			
		}
	
		ret = select2List(sql);
		
		return ret;
	}


}
