/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pcod.dao;

import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>규격단품 관리</p>
 * 
 * @created  on 1.0, 2010/01/24
 * @created  by 정진영(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod609DAO extends AbstractDAO {
	
	/**
	 * 규격단품 마스터을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd    = String2.nvl(form.getParam("strStrCd"));
		String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));
		String strPummokCd = String2.nvl(form.getParam("strPummokCd"));
		String strSkuCd    = String2.nvl(form.getParam("strSkuCd"));
		String strSkuName  = URLDecoder.decode( String2.nvl(form.getParam("strSkuName")), "UTF-8");

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_SKUMST") + "\n";
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		
		if( !strPummokCd.equals("%")){
			sql.setString(i++, strPummokCd);
			strQuery += svc.getQuery("SEL_SKUMST_WHERE_PUMMOK_CD") + "\n";
		}
		
		if( !strSkuCd.equals("")){
			sql.setString(i++, strSkuCd);
			strQuery += svc.getQuery("SEL_SKUMST_WHERE_SKU_CD") + "\n";
		}
		if( !strSkuName.equals("")){
			sql.setString(i++, strSkuName);
			strQuery += svc.getQuery("SEL_SKUMST_WHERE_SKU_NAME") + "\n";
		}
		
		strQuery += svc.getQuery("SEL_SKUMST_ORDER");

		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 점별단품 을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDetail(ActionForm form) throws Exception {

		List ret = null;
	
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strStrCd    = String2.nvl(form.getParam("strStrCd"));
		String strSkuCd = String2.nvl(form.getParam("strSkuCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_STRSKUMST");
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSkuCd);

		sql.put(strQuery);

		ret = select2List(sql);
		return ret;
	}
}
