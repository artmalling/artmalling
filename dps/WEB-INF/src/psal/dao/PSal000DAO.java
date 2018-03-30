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

public class PSal000DAO extends AbstractDAO {

	/**
	 * 마스터 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String userid) throws Exception {
		try{
		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		
		String strQuery	= "";
		int i 			= 0;
		

	
		String strStrCd     	= String2.nvl(form.getParam("strStrCd"));
		String strSaleDtS   	= String2.nvl(form.getParam("strSaleDtS"));
		String strSaleDtE   	= String2.nvl(form.getParam("strSaleDtE"));
		String strDocTitle 		= String2.nvl(form.getParam("strDocTitle"));
		String strUserPostName	= String2.nvl(form.getParam("strUserPostName"));
		String strUserEmpNo   	= String2.nvl(form.getParam("strUserEmpNo"));
		String strUserEmpName   = String2.nvl(form.getParam("strUserEmpName"));
		String strAppGb   		= String2.nvl(form.getParam("strAppGb"));
		String strChkExcept		= String2.nvl(form.getParam("strChkExcept"));
	
		sql = new SqlWrapper();
		svc = (Service) form.getService();
	
		connect("pot");
		
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		
		
		//실적
		sql.setString(++i, strStrCd);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strDocTitle);
		sql.setString(++i, strUserPostName);
		sql.setString(++i, strUserEmpNo);
		sql.setString(++i, strUserEmpName);
		sql.setString(++i, strAppGb);
		
		if (strChkExcept.equals("1"))
			strQuery = strQuery + svc.getQuery("SEL_MASTER_EXCEPT") +  "\n";
		
		strQuery = strQuery + "			    ORDER BY EXPENDDATE DESC ";	 
		
		sql.put(strQuery);
		ret = select2List(sql);

		return ret;
		} catch (Exception e){
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 디테일 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDetail(ActionForm form, String userid, String strOrgFlag) throws Exception {
		try{
			List ret 		= null;
			SqlWrapper sql 	= null;
			Service svc 	= null;
			int i 			= 0;

			String strStrCd     = String2.nvl(form.getParam("strStrCd"));
			int    nExpendNo  		= Integer.parseInt(String2.nvl(form.getParam("nExpendNo")));
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			connect("pot");

			sql.put(svc.getQuery("SEL_DETAIL"));
			sql.setString(++i, strStrCd);
			sql.setInt(++i,nExpendNo);	
			
			ret = select2List(sql);
		
		return ret;
		} catch (Exception e){
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 결재 순서 정보를 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchApprLine(ActionForm form, String userid, String strOrgFlag) throws Exception {
		try{
			List ret 		= null;
			SqlWrapper sql 	= null;
			Service svc 	= null;
			int i 			= 0;
			//String strStrCd     = String2.nvl(form.getParam("strStrCd"));
			int    nDocId  		= Integer.parseInt(String2.nvl(form.getParam("strDocId")));
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			connect("pot");

			sql.put(svc.getQuery("SEL_APPRLINE"));
			//sql.setString(++i, strStrCd);
			sql.setInt(++i,nDocId);			
			
			ret = select2List(sql);
		
		return ret;
		} catch (Exception e){
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 계정과목 합계 조회.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchAccnt(ActionForm form, String userid, String strOrgFlag) throws Exception {
		try{
			List ret 		= null;
			SqlWrapper sql 	= null;
			Service svc 	= null;
			int i 			= 0;

			String strStrCd     = String2.nvl(form.getParam("strStrCd"));
			String strSaleDtS   = String2.nvl(form.getParam("strSaleDtS"));
			String strSaleDtE   = String2.nvl(form.getParam("strSaleDtE"));

			sql = new SqlWrapper();
			svc = (Service) form.getService();

			connect("pot");

			sql.put(svc.getQuery("SEL_ACCOUNT"));
			
			sql.setString(++i, strStrCd);
			sql.setString(++i, strSaleDtS);
			sql.setString(++i, strSaleDtE);
			sql.setString(++i, strStrCd);
			sql.setString(++i, strSaleDtS);
			sql.setString(++i, strSaleDtE);
			
			ret = select2List(sql);
		
		return ret;
		} catch (Exception e){
			e.printStackTrace();
			throw e;
		}
	}
}
