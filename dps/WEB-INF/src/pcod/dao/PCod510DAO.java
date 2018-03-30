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
 * <p>점별단품조회</p>
 * 
 * @created  on 1.0, 2010.07.18
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod510DAO extends AbstractDAO {


	/**
	 * 점별단품을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, MultiInput mi , String userId , String orgFlag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		mi.next();
		
		sql.setString(i++, mi.getString("BAS_PRC_DT"));
		sql.setString(i++, mi.getString("BAS_PRC_DT"));
		sql.setString(i++, mi.getString("BAS_PRC_DT"));
		sql.setString(i++, mi.getString("BAS_PRC_DT"));
		sql.setString(i++, mi.getString("BAS_PRC_DT"));
		sql.setString(i++, mi.getString("BAS_PRC_DT"));
		sql.setString(i++, userId);
		sql.setString(i++, orgFlag);
		
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		
		if( !mi.getString("STR_CD").equals("%")){
			sql.setString(i++, mi.getString("STR_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_STR_CD") + "\n";
		}			
		if( !mi.getString("VEN_CD").equals("")){
			sql.setString(i++, mi.getString("VEN_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_VEN_CD") + "\n";
		}
		if( !mi.getString("VEN_NAME").equals("")){
			sql.setString(i++, mi.getString("VEN_NAME"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_VEN_NAME") + "\n";
		}		
		if( !mi.getString("PUMBUN_CD").equals("")){
			sql.setString(i++, mi.getString("PUMBUN_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_PUMBUN_CD") + "\n";
		}
		if( !mi.getString("PUMBUN_NAME").equals("")){
			sql.setString(i++, mi.getString("PUMBUN_NAME"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_PUMBUN_NAME") + "\n";
		}
		if( !mi.getString("SKU_CD").equals("")){
			sql.setString(i++, mi.getString("SKU_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_SKU_CD") + "\n";
		}
		if( !mi.getString("SKU_NAME").equals("")){
			sql.setString(i++, mi.getString("SKU_NAME"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_SKU_NAME") + "\n";
		}
		if( !mi.getString("STYLE_CD").equals("")){
			sql.setString(i++, mi.getString("STYLE_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_STYLE_CD") + "\n";
		}
		if( !mi.getString("PUMMOK_CD").equals("")){
			sql.setString(i++, mi.getString("PUMMOK_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_PUMMOK_CD") + "\n";
		}
		if( !mi.getString("PUMMOK_NAME").equals("")){
			sql.setString(i++, mi.getString("PUMMOK_NAME"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_PUMMOK_NAME") + "\n";
		}
		if( !mi.getString("EVENT_CD").equals("")){
			sql.setString(i++, mi.getString("EVENT_CD"));
			strQuery += svc.getQuery("SEL_MASTER_WHERE_EVENT_CD") + "\n";
		}
		
		strQuery += svc.getQuery("SEL_MASTER_ORDER");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	

}
