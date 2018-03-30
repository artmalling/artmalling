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

public class PSal214DAO extends AbstractDAO {

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
		int i 			= 0;

		String strStrCd    = String2.nvl(form.getParam("strStrCd"));
		String strTeamCd   = String2.nvl(form.getParam("strTeamCd"));
		String strPartCd   = String2.nvl(form.getParam("strPartCd"));
		String strPcCd 	   = String2.nvl(form.getParam("strPcCd"));
		String strSaleDtS  = String2.nvl(form.getParam("strSaleDtS"));
		String strSaleDtE  = String2.nvl(form.getParam("strSaleDtE"));
		String strOrgFlag  = String2.nvl(form.getParam("strOrgFlag"));
		String strBrandCd  = String2.nvl(form.getParam("strBrandCd"));
		String strSelFlag  = String2.nvl(form.getParam("strSelFlag"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		sql.put(svc.getQuery("SEL_MASTER"));
		
		// 원단위
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strStrCd);
		sql.setString(++i, strStrCd);
		sql.setString(++i, strTeamCd);
		sql.setString(++i, strPartCd);
		sql.setString(++i, strPcCd);
		sql.setString(++i, strBrandCd);
		sql.setString(++i, userid);
		sql.setString(++i, strOrgFlag);
		sql.setString(++i, strOrgFlag);

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
	public List searchDetail(ActionForm form, String userid) throws Exception {
		try{
		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		int i 			= 0;

		String strStrCd    = String2.nvl(form.getParam("strStrCd"));
		String strSearchCd = String2.nvl(form.getParam("strSearchCd"));
		String strSaleDtS  = String2.nvl(form.getParam("strSaleDtS"));
		String strSaleDtE  = String2.nvl(form.getParam("strSaleDtE"));
		String strOrgFlag  = String2.nvl(form.getParam("strOrgFlag"));
		String strSelFlag  = String2.nvl(form.getParam("strSelFlag"));
		String strBrandCd  = String2.nvl(form.getParam("strBrandCd"));
		String strGrpCd    = String2.nvl(form.getParam("strGrpCd"));

		String strSelId    = "SEL_DETAIL"  + strGrpCd;
		String strGrpOrdId = "SEL_GRP_ORD" + strGrpCd;
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		sql.put(svc.getQuery(strSelId));
		sql.put(svc.getQuery("SEL_BODY"));
		sql.put(svc.getQuery(strGrpOrdId));
		
		// 원단위
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		sql.setString(++i, strSelFlag);
		
		sql.setString(++i, strStrCd);
		sql.setString(++i, strSearchCd);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strBrandCd);
		sql.setString(++i, userid);
		sql.setString(++i, strOrgFlag);

		sql.setString(++i, strStrCd);
		sql.setString(++i, strSearchCd);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strSaleDtS);
		sql.setString(++i, strSaleDtE);
		sql.setString(++i, strBrandCd);
		sql.setString(++i, userid);
		sql.setString(++i, strOrgFlag);
		sql.setString(++i, strOrgFlag);
		ret = select2List(sql);
		
		return ret;
		} catch (Exception e){
			e.printStackTrace();
			throw e;
		}
	}
}
