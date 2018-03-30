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

public class PSal449DAO extends AbstractDAO {

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
		String strDeptCd 		= String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd 		= String2.nvl(form.getParam("strTeamCd"));
		String strPCCd 		    = String2.nvl(form.getParam("strPCCd"));
		String strPumbunCd 	    = String2.nvl(form.getParam("strPumbunCd"));
		String strSkuCd   	    = String2.nvl(form.getParam("strSkuCd"));
		String strDisp   	    = String2.nvl(form.getParam("strDisp"));
		String strSaleDtS 		= String2.nvl(form.getParam("strSaleDtS"));
		String strSaleDtE 		= String2.nvl(form.getParam("strSaleDtE"));
		String strOrgFlag 		= String2.nvl(form.getParam("strOrgFlag"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		if(strOrgFlag.equals("1")){
			//단품별
			if (strDisp.equals("0")) {
				strQuery = svc.getQuery("SEL_SKU") + "\n";
				
			//일자별단품별
			} else if (strDisp.equals("1")) {
				strQuery = svc.getQuery("SEL_SKU_SALE_DT") + "\n";
				
			//품번별
			} else if (strDisp.equals("2")) {
				strQuery = svc.getQuery("SEL_PUMBUN") + "\n";
				
			//일자별품번별
			} else if (strDisp.equals("3")) {
				strQuery = svc.getQuery("SEL_PUMBUN_SALE_DT") + "\n";
				
			}
	
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strPumbunCd);
			sql.setString(i++, strSkuCd);
			
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
	
			sql.setString(i++, userid);
	
			sql.put(strQuery);
		}else{
			//단품별
			if (strDisp.equals("0")) {
				strQuery = svc.getQuery("SEL_SKU2") + "\n";
				
			//일자별단품별
			} else if (strDisp.equals("1")) {
				strQuery = svc.getQuery("SEL_SKU_SALE_DT2") + "\n";
				
			//품번별
			} else if (strDisp.equals("2")) {
				strQuery = svc.getQuery("SEL_PUMBUN2") + "\n";
				
			//일자별품번별
			} else if (strDisp.equals("3")) {
				strQuery = svc.getQuery("SEL_PUMBUN_SALE_DT2") + "\n";
				
			}
	
			sql.setString(i++, strStrCd);
			sql.setString(i++, strDeptCd);
			sql.setString(i++, strTeamCd);
			sql.setString(i++, strPCCd);
			sql.setString(i++, strPumbunCd);
			sql.setString(i++, strSkuCd);
			
			sql.setString(i++, strSaleDtS);
			sql.setString(i++, strSaleDtE);
	
			sql.setString(i++, userid);
	
			sql.put(strQuery);
		}
		ret = select2List(sql);
		
		return ret;
	}


}
