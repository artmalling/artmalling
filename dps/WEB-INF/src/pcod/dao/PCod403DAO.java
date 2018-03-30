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
 * <p>점별품목별목표이익율조회</p>
 * 
 * @created  on 1.0, 2010/03/17
 * @created  by 이재득(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod403DAO extends AbstractDAO {


	/**
	 * 점별품목별목표이익율을 조회한다.
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
		
		strQuery = svc.getQuery("SEL_STRPMKPRFRT") + "\n";
				
		if( !mi.getString("STR_CD").equals("%")){
			sql.setString(i++, mi.getString("STR_CD"));
			strQuery += svc.getQuery("SEL_STRPMKPRFRT_WHERE_STR_CD") + "\n";
		}		
		if( !mi.getString("PUMMOK_CD").equals("")){
			sql.setString(i++, mi.getString("PUMMOK_CD"));
			strQuery += svc.getQuery("SEL_STRPMKPRFRT_WHERE_LIKE_PUMMOK_CD") + "\n";
		}
		if( !mi.getString("PUMMOK_NM").equals("")){
			sql.setString(i++, mi.getString("PUMMOK_NM"));
			strQuery += svc.getQuery("SEL_STRPMKPRFRT_WHERE_LIKE_PUMMOK_NAME") + "\n";
		}
		if( !mi.getString("L_CD").equals("%") && !mi.getString("L_CD").equals("")){
			sql.setString(i++, mi.getString("L_CD"));
			strQuery += svc.getQuery("SEL_STRPMKPRFRT_WHERE_L_CD") + "\n";
		}		
		if( !mi.getString("M_CD").equals("%") && !mi.getString("M_CD").equals("")){
			sql.setString(i++, mi.getString("M_CD"));
			strQuery += svc.getQuery("SEL_STRPMKPRFRT_WHERE_M_CD") + "\n";
		}
		if( !mi.getString("S_CD").equals("%") && !mi.getString("S_CD").equals("")){
			sql.setString(i++, mi.getString("S_CD"));
			strQuery += svc.getQuery("SEL_STRPMKPRFRT_WHERE_S_CD") + "\n";
		}
		if( !mi.getString("APP_DT").equals("")){
			sql.setString(i++, mi.getString("APP_DT"));
			strQuery += svc.getQuery("SEL_STRPMKPRFRT_WHERE_APP_DT") + "\n";
		}
		
		strQuery += svc.getQuery("SEL_STRPMKPRFRT_ORDER");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

}
