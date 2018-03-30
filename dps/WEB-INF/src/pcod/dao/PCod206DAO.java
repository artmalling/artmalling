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

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>품번이동 관리</p>
 * 
 * @created  on 1.0, 2010/03/04
 * @created  by 이재득(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod206DAO extends AbstractDAO {

	/**
	 * 품번이동 마스터를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form , MultiInput mi) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		String strModAftOrgCd = "";
		String strModBfOrgCd  = "";
		int i = 1;	
		mi.next();
		strModBfOrgCd = mi.getString("STR_CD");
		if(!mi.getString("BF_DEPT_CD").equals("%") && !mi.getString("BF_DEPT_CD").equals(""))
			strModBfOrgCd += mi.getString("BF_DEPT_CD");
		else			
		    strModBfOrgCd += "";
		if(!mi.getString("BF_TEAM_CD").equals("%") && !mi.getString("BF_TEAM_CD").equals(""))
			strModBfOrgCd += mi.getString("BF_TEAM_CD");
		else			
		    strModBfOrgCd += "";
		if(!mi.getString("BF_PC_CD").equals("%") && !mi.getString("BF_PC_CD").equals(""))
			strModBfOrgCd += mi.getString("BF_PC_CD");
		else			
		    strModBfOrgCd += "";
		
		strModAftOrgCd = mi.getString("STR_CD");
		if(!mi.getString("AFT_DEPT_CD").equals("%") && !mi.getString("AFT_DEPT_CD").equals(""))
			strModAftOrgCd += mi.getString("AFT_DEPT_CD");
		else			
		    strModAftOrgCd += "";
		if(!mi.getString("AFT_TEAM_CD").equals("%") && !mi.getString("AFT_TEAM_CD").equals(""))
			strModAftOrgCd += mi.getString("AFT_TEAM_CD");
		else			
		    strModAftOrgCd += "";
		if(!mi.getString("AFT_PC_CD").equals("%") && !mi.getString("AFT_PC_CD").equals(""))
			strModAftOrgCd += mi.getString("AFT_PC_CD");
		else			
		    strModAftOrgCd += "";
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_PBNTRNSMST") + "\n";
		
		sql.setString(i++, mi.getString("STR_CD"));
		sql.setString(i++, mi.getString("START_DT"));
		sql.setString(i++, mi.getString("END_DT"));	
		
		if( !mi.getString("PUMBUN_CD").equals("")){
			sql.setString(i++, mi.getString("PUMBUN_CD"));
			strQuery += svc.getQuery("SEL_PBNTRNSMST_WHERE_PUMBUN_CD") + "\n";
		}
		if( !mi.getString("PUMBUN_NM").equals("")){
			sql.setString(i++, mi.getString("PUMBUN_NM"));
			strQuery += svc.getQuery("SEL_PBNTRNSMST_WHERE_PUMBUN_NAME") + "\n";
		}
		if( !mi.getString("ORG_FLAG").equals("%") && !mi.getString("ORG_FLAG").equals("")){
			sql.setString(i++, mi.getString("ORG_FLAG"));
			sql.setString(i++, mi.getString("ORG_FLAG"));
			strQuery += svc.getQuery("SEL_PBNTRNSMST_WHERE_ORG_FLAG") + "\n";
		}
		if( !strModBfOrgCd.equals("") && !strModBfOrgCd.equals("0")){
			sql.setString(i++, strModBfOrgCd);
			strQuery += svc.getQuery("SEL_PBNTRNSMST_WHERE_MOD_BF_ORG_CD") + "\n";
		}
		if( !strModAftOrgCd.equals("") && !strModBfOrgCd.equals("0")){
			sql.setString(i++, strModAftOrgCd);
			strQuery += svc.getQuery("SEL_PBNTRNSMST_WHERE_MOD_AFT_ORG_CD") + "\n";
		}
		if( !mi.getString("PROC_YN").equals("%")){
			sql.setString(i++, mi.getString("PROC_YN"));
			strQuery += svc.getQuery("SEL_PBNTRNSMST_WHERE_PROC_YN") + "\n";
		}
		strQuery += svc.getQuery("SEL_PBNTRNSMST_ORDER");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
}
