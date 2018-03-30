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

public class PSal523DAO extends AbstractDAO {

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
		String strPosFloor 		= String2.nvl(form.getParam("strPosFloor"));
		String strPosFlag 		= String2.nvl(form.getParam("strPosFlag"));
		String strPosNoS 	    = String2.nvl(form.getParam("strPosNoS"));
		String strPosNoE 	    = String2.nvl(form.getParam("strPosNoE"));
		String strSaleDtS 		= String2.nvl(form.getParam("strSaleDtS"));
		String strSaleDtE 		= String2.nvl(form.getParam("strSaleDtE"));
		String strDealNo 		= String2.nvl(form.getParam("strDealNo"));
		
//		String strSkuCd 		= String2.nvl(form.getParam("strSkuCd"));
//		String strPumbunCd 		= String2.nvl(form.getParam("strPumbunCd"));
		String strFromSaleAmt 	= String2.nvl(form.getParam("strFromSaleAmt"));
		String strToSaleAmt 	= String2.nvl(form.getParam("strToSaleAmt"));
		String strFromSaleTime 	= String2.nvl(form.getParam("strFromSaleTime"));
		String strToSaleTime 	= String2.nvl(form.getParam("strToSaleTime"));
		String strCashCardNo 	= String2.nvl(form.getParam("strCashCardNo"));
		String strVanID         = String2.nvl(form.getParam("strVanID"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPosFloor);
		sql.setString(i++, strPosFlag);
		sql.setString(i++, strVanID);
		sql.setString(i++, strPosNoS);
		sql.setString(i++, strPosNoE);
		sql.setString(i++, strDealNo);
		sql.setString(i++, strSaleDtS);
		sql.setString(i++, strSaleDtE);
//		sql.setString(i++, userid);
		
	
		strQuery = svc.getQuery("SEL_SALE_POS_M") + "\n";
/*
		if( !strSkuCd.equals("")){
			sql.setString(i++, strSkuCd);
			strQuery += svc.getQuery("SEL_AND_SKU_CD") + "\n";
		}	
		
		if( !strPumbunCd.equals("")){
			sql.setString(i++, strPumbunCd);
			strQuery += svc.getQuery("SEL_AND_PUMBUN_CD") + "\n";
		}
*/
		if( !strFromSaleAmt.equals("")){
			sql.setString(i++, strFromSaleAmt);
			strQuery += svc.getQuery("SEL_AND_SALE_AMT_FROM") + "\n";
		}
		
		if( !strToSaleAmt.equals("")){
			sql.setString(i++, strToSaleAmt);
			strQuery += svc.getQuery("SEL_AND_SALE_AMT_TO") + "\n";
		}
		
		if( !strFromSaleTime.equals("")){
			sql.setString(i++, strFromSaleTime);
			strQuery += svc.getQuery("SEL_AND_SALE_TIME_FROM") + "\n";
		}
		
		if( !strToSaleTime.equals("")){
			sql.setString(i++, strToSaleTime);
			strQuery += svc.getQuery("SEL_AND_SALE_TIME_TO") + "\n";
		}
		
		if( !strCashCardNo.equals("")){
			sql.setString(i++, strCashCardNo);
			strQuery += svc.getQuery("SEL_CASH_CARD_NO") + "\n";
		}
		
/*
		if( !strVanID.equals("")){
			sql.setString(i++, strVanID);
			strQuery += svc.getQuery("SEL_APP_VAN_ID") + "\n";
		}
*/

		strQuery += svc.getQuery("SEL_GROUP_BY");
		
		sql.put(strQuery);
		
		
		
		ret = select2List(sql);
		
		return ret;
	}
  

	/**
	 * POSNO 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchPosNo(ActionForm form, String OrgFlag, String userid) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		int i 			= 1;
		

		
		String strPosNo 	    = String2.nvl(form.getParam("strPosNo"));
		
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_POSNO"));

		sql.setString(i++, strPosNo);
		
	
		ret = select2List(sql);
		
		return ret;
	}

	/**
	 * POSNO 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchPosNoMM(ActionForm form, String OrgFlag, String userid) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		int i 			= 1;
		

		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_POSNOMM"));

	
		ret = select2List(sql);
		
		return ret;
	}


}
