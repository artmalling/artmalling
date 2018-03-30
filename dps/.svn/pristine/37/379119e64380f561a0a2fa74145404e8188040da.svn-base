/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pcod.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
/**
 * <p>신선단품조회</p>
 * 
 * @created  on 1.0, 2010/03/21
 * @created  by 이재득(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod508DAO extends AbstractDAO {


	/**
	 * 신선단품정보를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, MultiInput mi) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		mi.next();
		
		strQuery = svc.getQuery("SEL_SKUMST") + "\n";
				
		if( !mi.getString("PUMBUN_CD").equals("")){
			sql.setString(i++, mi.getString("PUMBUN_CD"));
			strQuery += svc.getQuery("SEL_SKUMST_WHERE_PUMBUN_CD") + "\n";
		}		
		if( !mi.getString("PUMMOK_CD").equals("%")){
			sql.setString(i++, mi.getString("PUMMOK_CD"));
			strQuery += svc.getQuery("SEL_SKUMST_WHERE_PUMMOK_CD") + "\n";
		}
		if( !mi.getString("SKU_CD").equals("") || !mi.getString("SKU_NM").equals("")){
			sql.setString(i++, mi.getString("SKU_CD"));
			sql.setString(i++, mi.getString("SKU_NM"));
			strQuery += svc.getQuery("SEL_SKUMST_WHERE_LIKE_SKU_CD") + "\n";
		}
		if( !mi.getString("STYLE_CD").equals("") || !mi.getString("STYLE_NM").equals("")){
			sql.setString(i++, mi.getString("STYLE_CD"));
			sql.setString(i++, mi.getString("STYLE_NM"));
			strQuery += svc.getQuery("SEL_SKUMST_WHERE_STYLE_CD") + "\n";
		}
		if( !mi.getString("BRAND_CD").equals("%")){
			sql.setString(i++, mi.getString("BRAND_CD"));
			strQuery += svc.getQuery("SEL_SKUMST_WHERE_BRAND_CD") + "\n";
		}
		if( !mi.getString("SUB_BRD_CD").equals("%")){
			sql.setString(i++, mi.getString("SUB_BRD_CD"));
			strQuery += svc.getQuery("SEL_SKUMST_WHERE_SUB_BRD_CD") + "\n";
		}
		if( !mi.getString("PLAN_YEAR").equals("%")){
			sql.setString(i++, mi.getString("PLAN_YEAR"));
			strQuery += svc.getQuery("SEL_SKUMST_WHERE_PLAN_YEAR") + "\n";
		}		
		if( !mi.getString("SEASON_CD").equals("%")){
			sql.setString(i++, mi.getString("SEASON_CD"));
			strQuery += svc.getQuery("SEL_SKUMST_WHERE_SEASON_CD") + "\n";
		}
		if( !mi.getString("ITEM_CD").equals("%")){
			sql.setString(i++, mi.getString("ITEM_CD"));
			strQuery += svc.getQuery("SEL_SKUMST_WHERE_ITEM_CD") + "\n";
		}
		if( !mi.getString("MNG_CD1").equals("")){
			sql.setString(i++, mi.getString("MNG_CD1"));
			strQuery += svc.getQuery("SEL_SKUMST_WHERE_MNG_CD1") + "\n";
		}
		if( !mi.getString("MNG_CD2").equals("")){
			sql.setString(i++, mi.getString("MNG_CD2"));
			strQuery += svc.getQuery("SEL_SKUMST_WHERE_MNG_CD2") + "\n";
		}		
		if( !mi.getString("MNG_CD3").equals("")){
			sql.setString(i++, mi.getString("MNG_CD3"));
			strQuery += svc.getQuery("SEL_SKUMST_WHERE_MNG_CD3") + "\n";
		}
		if( !mi.getString("MNG_CD4").equals("")){
			sql.setString(i++, mi.getString("MNG_CD4"));
			strQuery += svc.getQuery("SEL_SKUMST_WHERE_MNG_CD4") + "\n";
		}
		if( !mi.getString("MNG_CD5").equals("")){
			sql.setString(i++, mi.getString("MNG_CD5"));
			strQuery += svc.getQuery("SEL_SKUMST_WHERE_MNG_CD5") + "\n";
		}
		
		strQuery += svc.getQuery("SEL_SKUMST_ORDER");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

}
