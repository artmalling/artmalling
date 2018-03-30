/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package psal.dao;

import java.util.List;
import java.util.Map;

import common.util.Util;
//import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PSal108DAO extends AbstractDAO {

	/**
	 * 당초팀별년계획을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String OrgFlag, String userid) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		int i 			= 1;
		
		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strDeptCd 		= String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd 		= String2.nvl(form.getParam("strTeamCd"));
		String strPCCd 		    = String2.nvl(form.getParam("strPCCd"));
		String strPlanYear 		= String2.nvl(form.getParam("strPlanYear"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		sql.put(svc.getQuery("SEL_PLANPC"));

		sql.setString(i++, strPlanYear);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPCCd);
		sql.setString(i++, strPlanYear);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPlanYear);
		sql.setString(i++, OrgFlag);
		sql.setString(i++, userid);

		ret = select2List(sql);
		
		return ret;
	}

	/**
	 * 당초PC별월계획을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDetail(ActionForm form, String OrgFlag, String userid) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		SqlWrapper sql3 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		String strMonth = "";
		
		int i 			= 1;
		int j 			= 1;
		
		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strDeptCd 		= String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd 		= String2.nvl(form.getParam("strTeamCd"));
		String strPCCd 		    = String2.nvl(form.getParam("strPCCd"));
		String strPlanYear 		= String2.nvl(form.getParam("strPlanYear"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
        
		connect("pot");
		
		sql.put(svc.getQuery("SEL_PLANPUMBUN_SELORIGIN"));


		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPCCd);
		sql.setString(i++, strPlanYear);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPCCd);
		sql.setString(i++, strPlanYear);
		sql.setString(i++, userid);

		ret = select2List(sql);
		
		return ret;
	}

	/**
	 * 당초PC별월계획을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDetailCheck(ActionForm form, String OrgFlag) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		SqlWrapper sql3 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		String strMonth = "";
		
		int i 			= 1;
		int j 			= 1;
		
		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strDeptCd 		= String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd 		= String2.nvl(form.getParam("strTeamCd"));
		String strPCCd 		    = String2.nvl(form.getParam("strPCCd"));
		String strPlanYear 		= String2.nvl(form.getParam("strPlanYear"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
        
		connect("pot");
		
		sql.put(svc.getQuery("SEL_PLANPC_DATA_CHECK"));

		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPCCd);
		sql.setString(i++, strPlanYear);
		sql.setString(i++, OrgFlag);

		ret = select2List(sql);
		
		return ret;
	}

	/**
	 * 당초PUMBUN별월매출계획 확정을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchPumbun(ActionForm form, String OrgFlag) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		
		int i 			= 1;
		
		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strDeptCd 		= String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd 		= String2.nvl(form.getParam("strTeamCd"));
		String strPlanYear 		= String2.nvl(form.getParam("strPlanYear"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		sql.put(svc.getQuery("SEL_PLANPUMBUNCONFFLAG"));

		sql.setString(i++, OrgFlag);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPlanYear);

		ret = select2List(sql);
		
		return ret;
	}

	/**
	 * 당초PC별월매출계획 확정을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchPC(ActionForm form, String OrgFlag) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		
		int i 			= 1;
		
		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strDeptCd 		= String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd 		= String2.nvl(form.getParam("strTeamCd"));
		String strPCCd 		    = String2.nvl(form.getParam("strPCCd"));
		String strPlanYear 		= String2.nvl(form.getParam("strPlanYear"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();


		connect("pot");
		sql.put(svc.getQuery("SEL_PLANPCCONFFLAG"));

		sql.setString(i++, OrgFlag);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPCCd);
		sql.setString(i++, strPlanYear);

		ret = select2List(sql);
		
		return ret;
	}



	/**
	 * 당초PC별월매출계획   저장, 수정  처리한다.
	 * 
	 * @param form
	 * @param mi[]
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi[], String strID)
			throws Exception {

		int ret 		= 0;
		int res 		= 0;
		Util util 		= new Util();
		SqlWrapper sql 	= null;
		Service svc 	= null;

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			while (mi[0].next()) {//DateSet의 현제 Row의 상태를 체크한다 IS_INSERT, IS_UPDATE, IS_DELETE
				sql.close();
				if (mi[0].IS_UPDATE()) {
					if(mi[0].getString("CONF_FLAG").equals("T")){

						sql.close();
						sql.put(svc.getQuery("UPD_PLANPUMBUN"));
						
						sql.setString(1, mi[0].getString("CONF_DT"));
						sql.setString(2, strID);
						sql.setString(3, "Y");
						sql.setString(4, strID);
						sql.setString(5, mi[0].getString("STR_CD"));
						sql.setString(6, mi[0].getString("DEPT_CD"));
						sql.setString(7, mi[0].getString("TEAM_CD"));	
						sql.setString(8, mi[0].getString("PC_CD"));
						sql.setString(9, mi[0].getString("PLAN_YEAR"));
						sql.setString(10, "N");		
					}
					else{
						sql.close();
						sql.put(svc.getQuery("UPD_PLANPUMBUN"));
						
						sql.setString(1, "");
						sql.setString(2, strID);
						sql.setString(3, "N");
						sql.setString(4, strID);
						sql.setString(5, mi[0].getString("STR_CD"));	
						sql.setString(6, mi[0].getString("DEPT_CD"));
						sql.setString(7, mi[0].getString("TEAM_CD"));	
						sql.setString(8, mi[0].getString("PC_CD"));
						sql.setString(9, mi[0].getString("PLAN_YEAR"));
						sql.setString(10, "Y");	
					}
				} 
				res = update(sql);
				
				if (res == 0) {
					throw new Exception("[USER]"+ "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				ret += 1;
			}

		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}
}
