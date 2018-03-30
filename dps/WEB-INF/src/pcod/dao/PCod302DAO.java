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
 * <p>마진조회</p>
 * 
 * @created  on 1.0, 2010/03/15
 * @created  by 이재득(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod302DAO extends AbstractDAO {


	/**
	 * 마진정보를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, MultiInput mi, String userId, String org_flag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		mi.next();
		
		strQuery = svc.getQuery("SEL_MARGINMST") + "\n";
		sql.setString(i++, userId);
		sql.setString(i++, org_flag);
		
		if( !mi.getString("STR_CD").equals("%")){
			sql.setString(i++, mi.getString("STR_CD"));
			strQuery += svc.getQuery("SEL_MARGINMST_WHERE_STR_CD") + "\n";
		}		
		if( !mi.getString("VEN_CD").equals("")){
			sql.setString(i++, mi.getString("VEN_CD"));
			strQuery += svc.getQuery("SEL_MARGINMST_WHERE_LIKE_VEN_CD") + "\n";
		}
		if( !mi.getString("VEN_NM").equals("")){
			sql.setString(i++, mi.getString("VEN_NM"));
			strQuery += svc.getQuery("SEL_MARGINMST_WHERE_LIKE_VEN_NAME") + "\n";
		}
		if( !mi.getString("PUMBUN_CD").equals("")){
			sql.setString(i++, mi.getString("PUMBUN_CD"));
			strQuery += svc.getQuery("SEL_MARGINMST_WHERE_LIKE_PUMBUN_CD") + "\n";
		}
		if( !mi.getString("PUMBUN_NM").equals("")){
			sql.setString(i++, mi.getString("PUMBUN_NM"));
			strQuery += svc.getQuery("SEL_MARGINMST_WHERE_LIKE_PUMBUN_NAME") + "\n";
		}
		if( !mi.getString("REP_VEN_CD").equals("")){
			sql.setString(i++, mi.getString("REP_VEN_CD"));
			strQuery += svc.getQuery("SEL_MARGINMST_WHERE_REP_VEN_CD") + "\n";
		}
		if( !mi.getString("REP_PUMBUN_CD").equals("")){
			sql.setString(i++, mi.getString("REP_PUMBUN_CD"));
			strQuery += svc.getQuery("SEL_MARGINMST_WHERE_REP_PUMBUN_CD") + "\n";
		}
		if( !mi.getString("MG_FLAG").equals("%")){
			sql.setString(i++, mi.getString("MG_FLAG"));
			strQuery += svc.getQuery("SEL_MARGINMST_WHERE_MG_FLAG") + "\n";
		}			
		if( !mi.getString("EVENT_CD").equals("")){
			sql.setString(i++, mi.getString("EVENT_CD"));
			strQuery += svc.getQuery("SEL_MARGINMST_WHERE_EVENT_CD") + "\n";
		}
		if( !mi.getString("EVENT_DT").equals("")){
			sql.setString(i++, mi.getString("EVENT_DT"));
			strQuery += svc.getQuery("SEL_MARGINMST_WHERE_EVENT_DT") + "\n";
		}
		
		strQuery += svc.getQuery("SEL_MARGINMST_ORDER");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

}
