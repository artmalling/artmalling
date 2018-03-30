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
 * <p>기간수불장현황(단품)</p>
 * 
 * @created  on 1.0, 2010/05/19
 * @created  by 이재득(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PStk302DAO extends AbstractDAO {


	/**
	 * 수량기준 수불장현황을 조회 한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchSkuQty(ActionForm form) throws Exception {
		
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
		String strSkuCd      = String2.nvl(form.getParam("strSkuCd"));
		String strDayFlag    = String2.nvl(form.getParam("strDayFlag"));
		String strPummokCd   = String2.nvl(form.getParam("strPummokCd"));
		String strBuyFlag    = String2.nvl(form.getParam("strBuyFlag"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		if(strDayFlag.equals("A")){
			strQuery = svc.getQuery("SEL_SKUDAY_QTY") + "\n";
		}else{
			strQuery = svc.getQuery("SEL_SKUDAY_QTY_TOTAL") + "\n";
		}
		
		if(strDayFlag.equals("A")){
			sql.setString(i++, strStkDt);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strAppSDt);
			sql.setString(i++, strAppEDt);
			sql.setString(i++, strStkYm);	
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPcCd);	
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
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPcCd);	
			sql.setString(i++, strAppSDt);
			sql.setString(i++, strAppEDt);
		}

		

		if(!strPumbunCd.equals("")){
			strQuery += svc.getQuery("SEL_SKUDAY_QTY_WHERE_PUMBUN_CD") + "\n";
			sql.setString(i++, strPumbunCd);
		}

		if(!strPummokCd.equals("")){
			strQuery += svc.getQuery("SEL_SKUDAY_QTY_WHERE_PUMMOK_CD") + "\n";
			sql.setString(i++, strPummokCd);
		}
		
		if(!strSkuCd.equals("")){
			strQuery += svc.getQuery("SEL_SKUDAY_QTY_WHERE_SKU_CD") + "\n";
			sql.setString(i++, strSkuCd);
		}

		if(!strBuyFlag.equals("%")){
			strQuery += svc.getQuery("SEL_SKUDAY_QTY_WHERE_BIZFLAG") + "\n";
			sql.setString(i++, strBuyFlag);
		}
		
		if(strDayFlag.equals("A")){
			strQuery += svc.getQuery("SEL_SKUDAY_QTY_GROUP") + "\n";
		}else{
			strQuery += svc.getQuery("SEL_SKUDAY_QTY_GROUP_TOTAL") + "\n";
		}
		
		if(strDayFlag.equals("A")){
			strQuery += svc.getQuery("SEL_SKUDAY_QTY_DAY_ORDER");
		} else {
			strQuery += svc.getQuery("SEL_SKUDAY_QTY_ORDER");
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
	public List searchSkuAmt(ActionForm form) throws Exception {
		
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
		String strSkuCd      = String2.nvl(form.getParam("strSkuCd"));
		String strTaxFlag    = String2.nvl(form.getParam("strTaxFlag"));
		String strDayFlag    = String2.nvl(form.getParam("strDayFlag"));
		String strPummokCd   = String2.nvl(form.getParam("strPummokCd"));
		String strBuyFlag    = String2.nvl(form.getParam("strBuyFlag"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		if(strDayFlag.equals("A")){
			if(strTaxFlag.equals("A")){
				strQuery = svc.getQuery("SEL_SKUDAY_AMT") + "\n";
			}else
				strQuery = svc.getQuery("SEL_SKUDAY_TAX_AMT") + "\n";
		}else{
			if(strTaxFlag.equals("A")){
				strQuery = svc.getQuery("SEL_SKUDAY_AMT_TOTAL") + "\n";
			}else
				strQuery = svc.getQuery("SEL_SKUDAY_TAX_AMT_TOTAL") + "\n";
		}
			
		if(strDayFlag.equals("A")){
			sql.setString(i++, strStkDt);
			sql.setString(i++, strStkDt);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strAppSDt);
			sql.setString(i++, strAppEDt);
			sql.setString(i++, strStkYm);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPcCd);
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
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPcCd);
			sql.setString(i++, strAppSDt);
			sql.setString(i++, strAppEDt);	
		}

		if(!strPumbunCd.equals("")){
			strQuery += svc.getQuery("SEL_SKUDAY_AMT_WHERE_PUMBUN_CD") + "\n";
			sql.setString(i++, strPumbunCd);
		}

		if(!strPummokCd.equals("")){
			strQuery += svc.getQuery("SEL_SKUDAY_AMT_WHERE_PUMMOK_CD") + "\n";
			sql.setString(i++, strPummokCd);
		}
		
		if(!strSkuCd.equals("")){
			strQuery += svc.getQuery("SEL_SKUDAY_AMT_WHERE_SKU_CD") + "\n";
			sql.setString(i++, strSkuCd);
		}

		if(!strBuyFlag.equals("%")){
			strQuery += svc.getQuery("SEL_SKUDAY_AMT_WHERE_BIZFLAG") + "\n";
			sql.setString(i++, strBuyFlag);
		}
		
		if(strDayFlag.equals("A")){
			strQuery += svc.getQuery("SEL_SKUDAY_AMT_GROUP") + "\n";
		}else{
			strQuery += svc.getQuery("SEL_SKUDAY_AMT_GROUP_TOTAL") + "\n";
		}
		
		if(strDayFlag.equals("A")){
			strQuery += svc.getQuery("SEL_SKUDAY_AMT_DAY_ORDER");
		} else {
			strQuery += svc.getQuery("SEL_SKUDAY_AMT_ORDER");
		}
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
}
