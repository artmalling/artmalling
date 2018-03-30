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
 * @created  on 1.0, 2010/03/18
 * @created  by 이재득(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod507DAO extends AbstractDAO {


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
				
		if( !mi.getString("PUMBUN_CD").equals("%")){
			sql.setString(i++, mi.getString("PUMBUN_CD"));
			strQuery += svc.getQuery("SEL_SKUMST_WHERE_PUMBUN_CD") + "\n";
		}		
		if( !mi.getString("PUMMOK_CD").equals("%")){
			sql.setString(i++, mi.getString("PUMMOK_CD"));
			strQuery += svc.getQuery("SEL_SKUMST_WHERE_PUMMOK_CD") + "\n";
		}
		if( !mi.getString("SKU_CD").equals("")){
			sql.setString(i++, mi.getString("SKU_CD"));
			strQuery += svc.getQuery("SEL_SKUMST_WHERE_LIKE_SKU_CD") + "\n";
		}
		if( !mi.getString("SKU_NM").equals("")){
			sql.setString(i++, mi.getString("SKU_NM"));
			strQuery += svc.getQuery("SEL_SKUMST_WHERE_LIKE_SKU_NAME") + "\n";
		}
		
		strQuery += svc.getQuery("SEL_SKUMST_ORDER");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

}
