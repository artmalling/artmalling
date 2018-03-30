/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pstk.dao;

import java.util.List;
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>기간수불장현황</p>
 * 
 * @created  on 1.0, 2010/04/12
 * @created  by 이재득(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PStk301DAO extends AbstractDAO {


	/**
	 * 수량기준 수불장현황을 조회 한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchPbnQty(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strStkYm      = String2.nvl(form.getParam("strStkYm"));
		String strAppSDt     = String2.nvl(form.getParam("strAppSDt"));
		String strAppEDt     = String2.nvl(form.getParam("strAppEDt"));
		String strStkDt      = String2.nvl(form.getParam("strStkDt"));
		String strDeptCd     = String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd     = String2.nvl(form.getParam("strTeamCd"));
		String strPcCd       = String2.nvl(form.getParam("strPcCd"));
		String strPumbunCd   = String2.nvl(form.getParam("strPumbunCd"));
		String strDayFlag    = String2.nvl(form.getParam("strDayFlag"));
		String strBuyFlag    = String2.nvl(form.getParam("strBuyFlag"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		if(strDayFlag.equals("A")){
			sql.setString(i++, strStkDt);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strAppSDt);
			sql.setString(i++, strAppEDt);
			sql.setString(i++, strStkYm);
	
			sql.setString(i++, strBuyFlag);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strAppSDt);
			sql.setString(i++, strAppEDt);
		} else {
			sql.setString(i++, strStkDt);
			sql.setString(i++, strAppSDt);
			sql.setString(i++, strAppSDt);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strAppSDt);
			sql.setString(i++, strAppEDt);
			sql.setString(i++, strStkYm);

			sql.setString(i++, strBuyFlag);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strAppSDt);
			sql.setString(i++, strAppEDt);	
		}
		
		if(strDayFlag.equals("A")){
			strQuery = svc.getQuery("SEL_PBNDAY_QTY") + "\n";       //일별수불장조회
		}else{
			strQuery = svc.getQuery("SEL_PBNDAY_QTY_TOTAL") + "\n"; //누계수불장조회
		}		
		

		if(!strDeptCd.equals("%")){
			strQuery += svc.getQuery("SEL_PBNDAY_QTY_WHERE_DEPT_CD") + "\n";
			sql.setString(i++, strDeptCd);
		}
		if(!strTeamCd.equals("%")){
			strQuery += svc.getQuery("SEL_PBNDAY_QTY_WHERE_TEAM_CD") + "\n";
			sql.setString(i++, strTeamCd);
		}
		if(!strPcCd.equals("%")){
			strQuery += svc.getQuery("SEL_PBNDAY_QTY_WHERE_PC_CD") + "\n";
			sql.setString(i++, strPcCd);
		}
		
		
		
		if(!strPumbunCd.equals("")){
			strQuery += svc.getQuery("SEL_PBNDAY_QTY_WHERE_PUMBUN_CD") + "\n";
			sql.setString(i++, strPumbunCd);
		}
		
		if(strDayFlag.equals("A")){
			strQuery += svc.getQuery("SEL_PBNDAY_QTY_GROUP") + "\n";       //일별수불장조회
		}else{
			strQuery += svc.getQuery("SEL_PBNDAY_QTY_GROUP_TOTAL") + "\n"; //누계수불장조회
		}
		if(strDayFlag.equals("A")){
			strQuery += svc.getQuery("SEL_PBNDAY_QTY_DAY_ORDER");
		} else {
			strQuery += svc.getQuery("SEL_PBNDAY_QTY_ORDER");
		}
		
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 금액기준 수불장 현황을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchPbnAmt(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strStkYm      = String2.nvl(form.getParam("strStkYm"));
		String strAppSDt     = String2.nvl(form.getParam("strAppSDt"));
		String strAppEDt     = String2.nvl(form.getParam("strAppEDt"));
		String strStkDt      = String2.nvl(form.getParam("strStkDt"));
		String strDeptCd     = String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd     = String2.nvl(form.getParam("strTeamCd"));
		String strPcCd       = String2.nvl(form.getParam("strPcCd"));
		String strPumbunCd   = String2.nvl(form.getParam("strPumbunCd"));
		String strTaxFlag    = String2.nvl(form.getParam("strTaxFlag"));
		String strDayFlag    = String2.nvl(form.getParam("strDayFlag"));
		String strBuyFlag    = String2.nvl(form.getParam("strBuyFlag"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
				
		if(strDayFlag.equals("A")){
			sql.setString(i++, strStkDt);
			sql.setString(i++, strStkDt);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strAppSDt);
			sql.setString(i++, strAppEDt);
			sql.setString(i++, strStkYm);
	
			sql.setString(i++, strBuyFlag);
			
			sql.setString(i++, strStrCd);	
			sql.setString(i++, strAppSDt);
			sql.setString(i++, strAppEDt);
		} else {
			sql.setString(i++, strStkDt);
			sql.setString(i++, strAppSDt);
			sql.setString(i++, strAppSDt);
			
			sql.setString(i++, strStkDt);
			sql.setString(i++, strAppSDt);
			sql.setString(i++, strAppSDt);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strAppSDt);
			sql.setString(i++, strAppEDt);
			sql.setString(i++, strStkYm);
	
			sql.setString(i++, strBuyFlag);
			
			sql.setString(i++, strStrCd);	
			sql.setString(i++, strAppSDt);
			sql.setString(i++, strAppEDt);
		}
		
		if(strDayFlag.equals("A")){
			if(strTaxFlag.equals("A")){
				strQuery = svc.getQuery("SEL_PBNDAY_AMT") + "\n";
			}else
				strQuery = svc.getQuery("SEL_PBNDAY_TAX_AMT") + "\n";
		}else{
			if(strTaxFlag.equals("A")){
				strQuery = svc.getQuery("SEL_PBNDAY_AMT_TOTAL") + "\n";
			}else
				strQuery = svc.getQuery("SEL_PBNDAY_TAX_AMT_TOTAL") + "\n";
		}

		if(!strDeptCd.equals("%")){
			strQuery += svc.getQuery("SEL_PBNDAY_AMT_WHERE_DEPT_CD") + "\n";
			sql.setString(i++, strDeptCd);
		}
		if(!strTeamCd.equals("%")){
			strQuery += svc.getQuery("SEL_PBNDAY_AMT_WHERE_TEAM_CD") + "\n";
			sql.setString(i++, strTeamCd);
		}
		if(!strPcCd.equals("%")){
			strQuery += svc.getQuery("SEL_PBNDAY_AMT_WHERE_PC_CD") + "\n";
			sql.setString(i++, strPcCd);
		}
		
		
		if(!strPumbunCd.equals("")){
			strQuery += svc.getQuery("SEL_PBNDAY_AMT_WHERE_PUMBUN_CD") + "\n";
			sql.setString(i++, strPumbunCd);
		}
		
		if(strDayFlag.equals("A")){
			strQuery += svc.getQuery("SEL_PBNDAY_AMT_GROUP") + "\n";
		}else{
			strQuery += svc.getQuery("SEL_PBNDAY_AMT_GROUP_TOTAL") + "\n";
		}
		
		if(strDayFlag.equals("A")){
			strQuery += svc.getQuery("SEL_PBNDAY_AMT_DAY_ORDER");
		} else {
			strQuery += svc.getQuery("SEL_PBNDAY_AMT_ORDER");
		}
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
}
