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
import java.util.Map;


import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>긴급매가조회</p>
 * 
 * @created  on 1.0, 2010/04/19
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod608DAO extends AbstractDAO {
	
	/**
	 * 긴급매가가격을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, MultiInput mi, String userId, String orgFlag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		mi.next();		

		String skuType = mi.getString("SKU_TYPE");
		
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		
		if(skuType.equals("3")){
			strQuery += svc.getQuery("SEL_MASTER_STYLE") + "\n";
			strQuery += svc.getQuery("SEL_MASTER_WHERE") + "\n";
			strQuery += svc.getQuery("SEL_MASTER_WHERE_STYLE") + "\n";
			sql.setString(i++, mi.getString("PUMBUN_CD"));
			sql.setString(i++, mi.getString("STR_CD"));
			sql.setString(i++, mi.getString("PUMBUN_CD"));
			sql.setString(i++, mi.getString("APP_DT_S"));
			sql.setString(i++, mi.getString("APP_DT_E"));
		}else{
			strQuery += svc.getQuery("SEL_MASTER_WHERE") + "\n";
			sql.setString(i++, mi.getString("STR_CD"));
			sql.setString(i++, mi.getString("PUMBUN_CD"));
			sql.setString(i++, mi.getString("APP_DT_S"));
			sql.setString(i++, mi.getString("APP_DT_E"));
		}

		if(!mi.getString("CONF_YN").equals("%")){			
			strQuery += svc.getQuery("SEL_MASTER_WHERE_CONF_" + mi.getString("CONF_YN") ) + "\n";
		}
		
		if( !mi.getString("PUMMOK_CD").equals("%")){
			sql.setString(i++, mi.getString("PUMMOK_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_PUMMOK_CD") + "\n";
		}
		
		if( !mi.getString("SKU_CD").equals("")){
			sql.setString(i++, mi.getString("SKU_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_SKU_CD") + "\n";
		}
		
		if( !mi.getString("SKU_NAME").equals("")){
			sql.setString(i++, mi.getString("SKU_NAME"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_SKU_NAME") + "\n";
		}		

		if( !mi.getString("EVENT_CD").equals("")){			
			sql.setString(i++, mi.getString("EVENT_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_EVENT_CD") + "\n";
		}
		
		if( !mi.getString("EVENT_NAME").equals("")){			
			sql.setString(i++, mi.getString("EVENT_NAME"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_EVENT_NAME") + "\n";
		}		
		
		if( !mi.getString("A_STYLE_CD").equals("")){
			sql.setString(i++, mi.getString("A_STYLE_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_STYLE_CD") + "\n";
		}
		
		if( !mi.getString("A_STYLE_NAME").equals("")){
			sql.setString(i++, mi.getString("A_STYLE_NAME"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_STYLE_NAME") + "\n";
		}
		
		if( !mi.getString("A_BRAND_CD").equals("%")){
			sql.setString(i++, mi.getString("A_BRAND_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_BRAND_CD") + "\n";
		}
		
		if( !mi.getString("A_SUB_BRD_CD").equals("%")){
			sql.setString(i++, mi.getString("A_SUB_BRD_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_SUB_BRD_CD") + "\n";
		}
		
		if( !mi.getString("PLAN_YEAR_CD").equals("%")){
			sql.setString(i++, mi.getString("PLAN_YEAR_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_PLAN_YEAR_CD") + "\n";
		}
		
		if( !mi.getString("SEASON_CD").equals("%")){
			sql.setString(i++, mi.getString("SEASON_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_SEASON_CD") + "\n";
		}
		
		if( !mi.getString("ITEM_CD").equals("%")){
			sql.setString(i++, mi.getString("ITEM_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_ITEM_CD") + "\n";
		}
		
		if( !mi.getString("B_STYLE_CD").equals("")){
			sql.setString(i++, mi.getString("B_STYLE_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_STYLE_CD") + "\n";
		}
		
		if( !mi.getString("B_STYLE_NAME").equals("")){
			sql.setString(i++, mi.getString("B_STYLE_NAME"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_STYLE_NAME") + "\n";
		}
		
		if( !mi.getString("B_BRAND_CD").equals("%")){
			sql.setString(i++, mi.getString("B_BRAND_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_BRAND_CD") + "\n";
		}
		
		if( !mi.getString("B_SUB_BRD_CD").equals("%")){
			sql.setString(i++, mi.getString("B_SUB_BRD_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_SUB_BRD_CD") + "\n";
		}
		
		if( !mi.getString("MNG_CD1").equals("")){
			sql.setString(i++, mi.getString("MNG_CD1"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_MNG_CD1") + "\n";
		}
		
		if( !mi.getString("MNG_CD2").equals("")){
			sql.setString(i++, mi.getString("MNG_CD2"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_MNG_CD2") + "\n";
		}
		
		if( !mi.getString("MNG_CD3").equals("")){
			sql.setString(i++, mi.getString("MNG_CD3"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_MNG_CD3") + "\n";
		}
		
		if( !mi.getString("MNG_CD4").equals("")){
			sql.setString(i++, mi.getString("MNG_CD4"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_MNG_CD4") + "\n";
		}
		
		if( !mi.getString("MNG_CD5").equals("")){
			sql.setString(i++, mi.getString("MNG_CD5"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_MNG_CD5") + "\n";
		}
				
		if(skuType.equals("3"))
		    strQuery += svc.getQuery("SEL_MASTER_STYLE_ORDER");
		else
		    strQuery += svc.getQuery("SEL_MASTER_ORDER");

		sql.put(strQuery);
		ret = select2List(sql);

		return ret;
	}

}
