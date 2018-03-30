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
 * <p>조직조회</p>
 * 
 * @created  on 1.0, 2010/02/09
 * @created  by 이재득(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod003DAO extends AbstractDAO {


	/**
	 * 조직을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd   = String2.nvl(form.getParam("strStrCd"));
		String strOrgFlag = String2.nvl(form.getParam("strOrgFlag"));
		String strUseYn   = String2.nvl(form.getParam("strUseYn"));
		String strDeptCd  = String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd  = String2.nvl(form.getParam("strTeamCd"));
		String strPcCd    = String2.nvl(form.getParam("strPcCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		strQuery = svc.getQuery("SEL_ORGMST") + "\n";
        
		if( !strStrCd.equals("%")){
			sql.setString(i++, strStrCd);
			strQuery += svc.getQuery("SEL_ORGMST_WHERE_STR_CD") + "\n";
		}
		if( !strOrgFlag.equals("%")){
			sql.setString(i++, strOrgFlag);
			strQuery += svc.getQuery("SEL_ORGMST_WHERE_ORG_FLAG") + "\n";
		}
		if( !strUseYn.equals("%")){
			sql.setString(i++, strUseYn);
			strQuery += svc.getQuery("SEL_ORGMST_WHERE_USE_YN") + "\n";
		}
		if( !strDeptCd.equals("%")){
			sql.setString(i++, strDeptCd);
			strQuery += svc.getQuery("SEL_ORGMST_WHERE_DEPT_CD") + "\n";
		}
		if( !strTeamCd.equals("%")){
			sql.setString(i++, strTeamCd);
			strQuery += svc.getQuery("SEL_ORGMST_WHERE_TEAM_CD") + "\n";
		}
		if( !strPcCd.equals("%")){
			sql.setString(i++, strPcCd);
			strQuery += svc.getQuery("SEL_ORGMST_WHERE_PC_CD") + "\n";
		}

		strQuery += svc.getQuery("SEL_ORGMST_ORDER");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

}
