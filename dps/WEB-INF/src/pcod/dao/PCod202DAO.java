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
 * <p>품번현황</p>
 * 
 * @created  on 1.0, 2010/03/10
 * @created  by 이재득(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod202DAO extends AbstractDAO {


	/**
	 * 품번현황을 조회한다.
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
		
		strQuery = svc.getQuery("SEL_PBNMST") + "\n";
		
		if( !mi.getString("BIZ_TYPE").equals("%")){
			sql.setString(i++, mi.getString("BIZ_TYPE"));
			strQuery += svc.getQuery("SEL_PBNMST_WHERE_BIZ_TYPE") + "\n";
		}
		if( !mi.getString("SKU_FLAG").equals("%")){
			sql.setString(i++, mi.getString("SKU_FLAG"));
			strQuery += svc.getQuery("SEL_PBNMST_WHERE_SKU_FLAG") + "\n";
		}
		if( !mi.getString("PUMBUN_TYPE").equals("%")){
			sql.setString(i++, mi.getString("PUMBUN_TYPE"));
			strQuery += svc.getQuery("SEL_PBNMST_WHERE_PUMBUN_TYPE") + "\n";
		}
		if( !mi.getString("PUMBUN_FLAG").equals("%")){
			sql.setString(i++, mi.getString("PUMBUN_FLAG"));
			strQuery += svc.getQuery("SEL_PBNMST_WHERE_PUMBUN_FLAG") + "\n";
		}
		if( !mi.getString("SKU_TYPE").equals("%")){
			sql.setString(i++, mi.getString("SKU_TYPE"));
			strQuery += svc.getQuery("SEL_PBNMST_WHERE_SKU_TYPE") + "\n";
		}
		if( !mi.getString("REP_PUMBUN_CD").equals("")){
			sql.setString(i++, mi.getString("REP_PUMBUN_CD"));
			strQuery += svc.getQuery("SEL_PBNMST_WHERE_LIKE_REP_PUMBUN_CD") + "\n";
		}
		if( !mi.getString("VEN_CD").equals("")){
			sql.setString(i++, mi.getString("VEN_CD"));
			strQuery += svc.getQuery("SEL_PBNMST_WHERE_LIKE_VEN_CD") + "\n";
		}
		if( !mi.getString("VEN_NM").equals("")){
			sql.setString(i++, mi.getString("VEN_NM"));
			strQuery += svc.getQuery("SEL_PBNMST_WHERE_LIKE_VEN_NAME") + "\n";
		}
		if( !mi.getString("PUMBUN_CD").equals("")){
			sql.setString(i++, mi.getString("PUMBUN_CD"));
			strQuery += svc.getQuery("SEL_PBNMST_WHERE_LIKE_PUMBUN_CD") + "\n";
		}
		if( !mi.getString("PUMBUN_NM").equals("")){
			sql.setString(i++, mi.getString("PUMBUN_NM"));
			strQuery += svc.getQuery("SEL_PBNMST_WHERE_LIKE_PUMBUN_NAME") + "\n";
		}
		if( !mi.getString("USE_YN").equals("%")){
			sql.setString(i++, mi.getString("USE_YN"));
			strQuery += svc.getQuery("SEL_PBNMST_WHERE_USE_YN") + "\n";
		}
		
		strQuery += svc.getQuery("SEL_PBNMST_ORDER");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

}
