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
 * <p>품목코드조회</p>
 * 
 * @created  on 1.0, 2010/03/15
 * @created  by 이재득(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod402DAO extends AbstractDAO {


	/**
	 * 품목정보를 조회한다.
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
		
		strQuery = svc.getQuery("SEL_PMKMST") + "\n";
		
		if( !mi.getString("L_CD").equals("%") && !mi.getString("L_CD").equals("")){
			sql.setString(i++, mi.getString("L_CD"));
			strQuery += svc.getQuery("SEL_PMKMST_WHERE_L_CD") + "\n";
		}		
		if( !mi.getString("M_CD").equals("%") && !mi.getString("M_CD").equals("")){
			sql.setString(i++, mi.getString("M_CD"));
			strQuery += svc.getQuery("SEL_PMKMST_WHERE_M_CD") + "\n";
		}
		if( !mi.getString("S_CD").equals("%") && !mi.getString("S_CD").equals("")){
			sql.setString(i++, mi.getString("S_CD"));
			strQuery += svc.getQuery("SEL_PMKMST_WHERE_S_CD") + "\n";
		}
		if( !mi.getString("FCL_FLAG").equals("%")){
			sql.setString(i++, mi.getString("FCL_FLAG"));
			strQuery += svc.getQuery("SEL_PMKMST_WHERE_FCL_FLAG") + "\n";
		}
		if( !mi.getString("FRESH_YN").equals("%")){
			sql.setString(i++, mi.getString("FRESH_YN"));
			strQuery += svc.getQuery("SEL_PMKMST_WHERE_FRESH_YN") + "\n";
		}
		if( !mi.getString("PUMMOK_CD").equals("")){
			sql.setString(i++, mi.getString("PUMMOK_CD"));
			strQuery += svc.getQuery("SEL_PMKMST_WHERE_LIKE_PUMMOK_CD") + "\n";
		}
		if( !mi.getString("PUMMOK_NM").equals("")){
			sql.setString(i++, mi.getString("PUMMOK_NM"));
			strQuery += svc.getQuery("SEL_PMKMST_WHERE_LIKE_PUMMOK_NAME") + "\n";
		}
		
		strQuery += svc.getQuery("SEL_PMKMST_ORDER");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

}
