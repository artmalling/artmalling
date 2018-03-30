/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pstk.dao;

import java.util.List;
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>실사재고등록(비단품)</p>
 * 
 * @created  on 1.0, 2010/04/12
 * @created  by 이재득(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PStk206DAO extends AbstractDAO {


	/**
	 * 실사재고 마스터정보를 조회한다.
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
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strStkYm      = String2.nvl(form.getParam("strStkYm"));
		String strStkDt      = String2.nvl(form.getParam("strStkDt"));		
		String strDeptCd     = String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd     = String2.nvl(form.getParam("strTeamCd"));
		String strPcCd       = String2.nvl(form.getParam("strPcCd"));
		String strCornerCd   = String2.nvl(form.getParam("strCornerCd"));
		String strStkSdt     = String2.nvl(form.getParam("strStkSdt"));
		String strStkEDt     = String2.nvl(form.getParam("strStkEDt"));
		String strPumbunCd   = String2.nvl(form.getParam("strPumbunCd"));
		String strFloorCd    = String2.nvl(form.getParam("strFloorCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");		

		strQuery = svc.getQuery("SEL_PBNMONTH") + "\n";
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkDt);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPcCd);
		
		/*
		sql.setString(i++, strStkYm);
		sql.setString(i++, strStkEDt);
		sql.setString(i++, strStkYm);
		sql.setString(i++, strStkEDt);		
		sql.setString(i++, strStrCd);
        sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPcCd);
		sql.setString(i++, strStkSdt);
		sql.setString(i++, strStkEDt);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strStrCd);		
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkDt);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPcCd);
		*/
		if(!strPumbunCd.equals("") && !strPumbunCd.equals("%")){
			strQuery += svc.getQuery("SEL_PBNMONTH_PUMBUN_CD") + "\n";
			sql.setString(i++, strPumbunCd);
		}
		
		if(!strCornerCd.equals("") && !strCornerCd.equals("%")){
			strQuery += svc.getQuery("SEL_PBNMONTH_CORNER_CD") + "\n";
			sql.setString(i++, strCornerCd);
		}

		if(!strFloorCd.equals("") && !strFloorCd.equals("%")){
			strQuery += svc.getQuery("SEL_PBNMONTH_FLOR_CD") + "\n";
			sql.setString(i++, strFloorCd);
		}
		
		////strQuery += svc.getQuery("SEL_PBNMONTH_GROUP") + "\n";
		strQuery += svc.getQuery("SEL_PBNMONTH_ORDER");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 품번에따른 재고실사 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchPbnStk(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));	
		String strStkYm      = String2.nvl(form.getParam("strStkYm"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStrCd);		
		sql.setString(i++, strStkYm);
		
		strQuery = svc.getQuery("SEL_PBNSTK");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 품번에따른 재고실사 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchPbnInf(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strPumbunCd      = String2.nvl(form.getParam("strPumbunCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		
		strQuery = svc.getQuery("SEL_PBNINF");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

}
