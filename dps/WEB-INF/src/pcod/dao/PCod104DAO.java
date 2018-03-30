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
import kr.fujitsu.ffw.util.String2;
/**
 * <p>협력사담당자 조회</p>
 * 
 * @created  on 1.0, 2010/03/08
 * @created  by 이재득(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod104DAO extends AbstractDAO {


	/**
	 * 협력사담당자를 조회한다.
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
		
		/** 협력사담당자  조회*/
		strQuery = svc.getQuery("SEL_VENEMP") + "\n";
		
		if( !mi.getString("BIZ_TYPE").equals("%")){			
			sql.setString(i++, mi.getString("BIZ_TYPE"));
			strQuery += svc.getQuery("SEL_VENEMP_WHERE_BIZ_TYPE") + "\n";
		}
		
		if( !mi.getString("VEN_CD").equals("") ||!mi.getString("VEN_NM").equals("")){
			sql.setString(i++, mi.getString("VEN_CD"));
			sql.setString(i++, mi.getString("VEN_NM"));
			strQuery += svc.getQuery("SEL_VENEMP_WHERE_LIKE_VEN_CD") + "\n";
		}
		if( !mi.getString("PUMBUN_CD").equals("") || !mi.getString("PUMBUN_NM").equals("")){
			sql.setString(i++, mi.getString("PUMBUN_CD"));
			sql.setString(i++, mi.getString("PUMBUN_NM"));
			strQuery += svc.getQuery("SEL_VENEMP_WHERE_LIKE_PUMBUN_CD") + "\n";
		}
		if( !mi.getString("VEN_TASK_FLAG").equals("%")){
			sql.setString(i++, mi.getString("VEN_TASK_FLAG"));
			strQuery += svc.getQuery("SEL_VENEMP_WHERE_VEN_TASK_FLAG") + "\n";
		}
		if( !mi.getString("USE_YN").equals("%")){
			sql.setString(i++, mi.getString("USE_YN"));
			strQuery += svc.getQuery("SEL_VENEMP_WHERE_USE_YN") + "\n";
		}
		
		/** 품번별협력사담당자  조회(UNION ALL)*/
		strQuery += svc.getQuery("SEL_PBNVENEMP") + "\n";
		
		if( !mi.getString("BIZ_TYPE").equals("%")){
			sql.setString(i++, mi.getString("BIZ_TYPE"));
			strQuery += svc.getQuery("SEL_PBNVENEMP_WHERE_BIZ_TYPE") + "\n";
		}
		if( !mi.getString("VEN_CD").equals("") ||!mi.getString("VEN_NM").equals("")){
			sql.setString(i++, mi.getString("VEN_CD"));
			sql.setString(i++, mi.getString("VEN_NM"));
			strQuery += svc.getQuery("SEL_PBNVENEMP_WHERE_LIKE_VEN_CD") + "\n";
		}
		if( !mi.getString("PUMBUN_CD").equals("") || !mi.getString("PUMBUN_NM").equals("")){
			sql.setString(i++, mi.getString("PUMBUN_CD"));
			sql.setString(i++, mi.getString("PUMBUN_NM"));
			strQuery += svc.getQuery("SEL_PBNVENEMP_WHERE_LIKE_PUMBUN_CD") + "\n";
		}
		if( !mi.getString("VEN_TASK_FLAG").equals("%")){
			sql.setString(i++, mi.getString("VEN_TASK_FLAG"));
			strQuery += svc.getQuery("SEL_PBNVENEMP_WHERE_VEN_TASK_FLAG") + "\n";
		}
		if( !mi.getString("USE_YN").equals("%")){
			sql.setString(i++, mi.getString("USE_YN"));
			strQuery += svc.getQuery("SEL_PBNVENEMP_WHERE_USE_YN") + "\n";
		}		
		
		strQuery += svc.getQuery("SEL_VENEMP_ORDER");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

}
