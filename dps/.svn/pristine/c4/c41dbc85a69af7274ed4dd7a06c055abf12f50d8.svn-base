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

public class PSal101DAO extends AbstractDAO {

	/**
	 * 당초팀별년계획을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String OrgFlag, String userId) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		int i 			= 1;
		
		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strPlanYear 		= String2.nvl(form.getParam("strPlanYear"));
		int strPlanJYear		= Integer.parseInt(strPlanYear)-1;
		String strPlanJYear1	= String2.toString(strPlanJYear);
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		sql.put(svc.getQuery("SEL_PLANTEAMYY"));
		
		sql.setString(i++, strPlanYear);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPlanJYear1);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPlanYear);
		sql.setString(i++, strPlanYear);
		sql.setString(i++, strStrCd);
		sql.setString(i++, OrgFlag);
		sql.setString(i++, userId);
		
		ret = select2List(sql);
		
		
		return ret;
	}

	public List searchBFYY(ActionForm form, String OrgFlag, String userId) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		int i 			= 1;
		
		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strPlanYear 		= String2.nvl(form.getParam("strPlanYear"));
		int strPlanJYear		= Integer.parseInt(strPlanYear)-1;
		String strPlanJYear1	= String2.toString(strPlanJYear);
		String strDeptCd 		= String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd 		= String2.nvl(form.getParam("strTeamCd"));
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		sql.put(svc.getQuery("SEL_PLANTEAMYYBFYY"));

		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPlanJYear1);
		sql.setString(i++, OrgFlag);
		sql.setString(i++, userId);

		ret = select2List(sql);
		return ret;
	}

	/**
	 * 조직마스터를  조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchOrgMst(ActionForm form, String OrgFlag) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		int i 			= 1;
		
		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strOrgCd 		= String2.nvl(form.getParam("strOrgCd"));
		String strOrgLevel 		= String2.nvl(form.getParam("strOrgLevel"));
		String strDeptCd 		= String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd 		= String2.nvl(form.getParam("strTeamCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		sql.put(svc.getQuery("SEL_ORGMST"));

		sql.setString(i++, strStrCd);
		sql.setString(i++, strOrgCd);
		sql.setString(i++, strDeptCd);	
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strOrgLevel);
		sql.setString(i++, OrgFlag);
		
		ret = select2List(sql);
		
		return ret;
	}

	/**
	 * 조직마스터를  조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchConfFlag(ActionForm form, String OrgFlag) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		int i 			= 1;
		
		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strPlanYear 		= String2.nvl(form.getParam("strPlanYear"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		sql.put(svc.getQuery("SEL_CONF_FLAG"));

		sql.setString(i++, strStrCd);
		sql.setString(i++, strPlanYear);
		
		ret = select2List(sql);
		
		return ret;
	}

	/**
	 * 당초팀별년매출계획   저장, 수정  처리한다.
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
		String updAppSDt = "";
		String confFlag = "";
		int	cnt			= 0;
		String strStr_Cd = "";
		String strPlan_Year = "";
		
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			while (mi[0].next()) {//DateSet의 현제 Row의 상태를 체크한다 IS_INSERT, IS_UPDATE, IS_DELETE
				sql.close();
				if (mi[0].IS_INSERT()) {
					sql.close();
					sql.put(svc.getQuery("SEL_CONFFLAG"));
					
					sql.setString(1, mi[0].getString("STR_CD"));
					sql.setString(2, mi[0].getString("ORG_CD"));	
					sql.setString(3, mi[0].getString("DEPT_CD"));		
					sql.setString(4, mi[0].getString("TEAM_CD"));
					sql.setString(5, mi[0].getString("ORG_LEVEL"));					
					sql.setString(6, mi[0].getString("PLAN_YEAR"));	
					
					strStr_Cd    = mi[0].getString("STR_CD");
					strPlan_Year = mi[0].getString("PLAN_YEAR");
					
					Map map = selectMap( sql );
					
					confFlag = String2.nvl((String)map.get("CONF_FLAG"));

					
					if( !confFlag.equals("")) {
						if(!confFlag.equals("Y")){
							if(cnt == 0){
								sql.close();
								sql.put(svc.getQuery("DEL_PLANTEAMYY"));
			
								sql.setString(1, mi[0].getString("STR_CD"));
								sql.setString(2, mi[0].getString("ORG_LEVEL"));			
								sql.setString(3, mi[0].getString("PLAN_YEAR"));	
								update(sql);
							}
							cnt++;
		
							sql.close();
							sql.put(svc.getQuery("INS_PLANTEAMYY"));
							
							sql.setString(1, mi[0].getString("STR_CD"));
							sql.setString(2, mi[0].getString("ORG_CD"));					
							sql.setString(3, mi[0].getString("PLAN_YEAR"));
							sql.setString(4, mi[0].getString("ORG_LEVEL"));		
							sql.setString(5, mi[0].getString("DEPT_CD"));		
							sql.setString(6, mi[0].getString("TEAM_CD"));		
							sql.setDouble(7, mi[0].getDouble("BFYY_NORM_SAMT"));		
							sql.setDouble(8, mi[0].getDouble("BFYY_EVT_SAMT"));	
							sql.setDouble(9, mi[0].getDouble("BFYY_SALE_TAMT"));	
							sql.setDouble(10, mi[0].getDouble("BFYY_PROF_TAMT"));	
							sql.setDouble(11, mi[0].getDouble("BFYY_SALE_CRATE"));	
							sql.setDouble(12, mi[0].getDouble("BFYY_PROF_CRATE"));	
							sql.setDouble(13, mi[0].getDouble("ORIGIN_NORM_SAMT"));	
							sql.setDouble(14, mi[0].getDouble("ORIGIN_EVT_SAMT"));	
							sql.setDouble(15, mi[0].getDouble("ORIGIN_SALE_TAMT"));	
							sql.setDouble(16, mi[0].getDouble("ORIGIN_PROF_TAMT"));	
							sql.setDouble(17, mi[0].getDouble("ORIGIN_SALE_CRATE"));	
							sql.setDouble(18, mi[0].getDouble("ORIGIN_PROF_CRATE"));	
							sql.setDouble(19, mi[0].getDouble("ORIGIN_SALE_IRATE"));	
							sql.setDouble(20, mi[0].getDouble("ORIGIN_PROF_IRATE"));
							sql.setString(21, strID);
							sql.setString(22, strID);
							
							res = update(sql);
						}
						else{
							throw new Exception("[USER]"+"확정된데이터입니다." + ""
									+ "데이터 입력을 하지 못했습니다.");
						}
					}
					else{
		
						sql.close();
						sql.put(svc.getQuery("INS_PLANTEAMYY"));
						
						sql.setString(1, mi[0].getString("STR_CD"));
						sql.setString(2, mi[0].getString("ORG_CD"));					
						sql.setString(3, mi[0].getString("PLAN_YEAR"));
						sql.setString(4, mi[0].getString("ORG_LEVEL"));		
						sql.setString(5, mi[0].getString("DEPT_CD"));		
						sql.setString(6, mi[0].getString("TEAM_CD"));		
						sql.setDouble(7, mi[0].getDouble("BFYY_NORM_SAMT"));		
						sql.setDouble(8, mi[0].getDouble("BFYY_EVT_SAMT"));	
						sql.setDouble(9, mi[0].getDouble("BFYY_SALE_TAMT"));	
						sql.setDouble(10, mi[0].getDouble("BFYY_PROF_TAMT"));	
						sql.setDouble(11, mi[0].getDouble("BFYY_SALE_CRATE"));	
						sql.setDouble(12, mi[0].getDouble("BFYY_PROF_CRATE"));	
						sql.setDouble(13, mi[0].getDouble("ORIGIN_NORM_SAMT"));	
						sql.setDouble(14, mi[0].getDouble("ORIGIN_EVT_SAMT"));	
						sql.setDouble(15, mi[0].getDouble("ORIGIN_SALE_TAMT"));	
						sql.setDouble(16, mi[0].getDouble("ORIGIN_PROF_TAMT"));	
						sql.setDouble(17, mi[0].getDouble("ORIGIN_SALE_CRATE"));	
						sql.setDouble(18, mi[0].getDouble("ORIGIN_PROF_CRATE"));	
						sql.setDouble(19, mi[0].getDouble("ORIGIN_SALE_IRATE"));	
						sql.setDouble(20, mi[0].getDouble("ORIGIN_PROF_IRATE"));
						sql.setString(21, strID);
						sql.setString(22, strID);
							
							res = update(sql);
						
					}

				} else if (mi[0].IS_UPDATE()) {

					sql.close();
					sql.put(svc.getQuery("SEL_CONFFLAG"));

					sql.setString(1, mi[0].getString("STR_CD"));
					sql.setString(2, mi[0].getString("ORG_CD"));	
					sql.setString(3, mi[0].getString("DEPT_CD"));		
					sql.setString(4, mi[0].getString("TEAM_CD"));
					sql.setString(5, mi[0].getString("ORG_LEVEL"));					
					sql.setString(6, mi[0].getString("PLAN_YEAR"));			

					strStr_Cd    = mi[0].getString("STR_CD");
					strPlan_Year = mi[0].getString("PLAN_YEAR");
					
					Map map = selectMap( sql );
					
					confFlag = String2.nvl((String)map.get("CONF_FLAG"));

					
					if( confFlag.equals("")) {


						sql.close();
						sql.put(svc.getQuery("INS_PLANTEAMYY"));
						
						sql.setString(1, mi[0].getString("STR_CD"));
						sql.setString(2, mi[0].getString("ORG_CD"));					
						sql.setString(3, mi[0].getString("PLAN_YEAR"));
						sql.setString(4, mi[0].getString("ORG_LEVEL"));		
						sql.setString(5, mi[0].getString("DEPT_CD"));		
						sql.setString(6, mi[0].getString("TEAM_CD"));		
						sql.setDouble(7, mi[0].getDouble("BFYY_NORM_SAMT"));		
						sql.setDouble(8, mi[0].getDouble("BFYY_EVT_SAMT"));	
						sql.setDouble(9, mi[0].getDouble("BFYY_SALE_TAMT"));	
						sql.setDouble(10, mi[0].getDouble("BFYY_PROF_TAMT"));	
						sql.setDouble(11, mi[0].getDouble("BFYY_SALE_CRATE"));	
						sql.setDouble(12, mi[0].getDouble("BFYY_PROF_CRATE"));	
						sql.setDouble(13, mi[0].getDouble("ORIGIN_NORM_SAMT"));	
						sql.setDouble(14, mi[0].getDouble("ORIGIN_EVT_SAMT"));	
						sql.setDouble(15, mi[0].getDouble("ORIGIN_SALE_TAMT"));	
						sql.setDouble(16, mi[0].getDouble("ORIGIN_PROF_TAMT"));	
						sql.setDouble(17, mi[0].getDouble("ORIGIN_SALE_CRATE"));	
						sql.setDouble(18, mi[0].getDouble("ORIGIN_PROF_CRATE"));	
						sql.setDouble(19, mi[0].getDouble("ORIGIN_SALE_IRATE"));	
						sql.setDouble(20, mi[0].getDouble("ORIGIN_PROF_IRATE"));
						sql.setString(21, strID);
						sql.setString(22, strID);

						res = update(sql);
					}
					else{
							if(!confFlag.equals("Y")){

								if(cnt == 0){
									sql.close();
									sql.put(svc.getQuery("DEL_PLANTEAMYY"));
				
									sql.setString(1, mi[0].getString("STR_CD"));
									sql.setString(2, mi[0].getString("ORG_LEVEL"));			
									sql.setString(3, mi[0].getString("PLAN_YEAR"));	
									update(sql);
								}
								cnt++;

								sql.close();
								sql.put(svc.getQuery("INS_PLANTEAMYY"));
								
								sql.setString(1, mi[0].getString("STR_CD"));
								sql.setString(2, mi[0].getString("ORG_CD"));					
								sql.setString(3, mi[0].getString("PLAN_YEAR"));
								sql.setString(4, mi[0].getString("ORG_LEVEL"));		
								sql.setString(5, mi[0].getString("DEPT_CD"));		
								sql.setString(6, mi[0].getString("TEAM_CD"));		
								sql.setDouble(7, mi[0].getDouble("BFYY_NORM_SAMT"));		
								sql.setDouble(8, mi[0].getDouble("BFYY_EVT_SAMT"));	
								sql.setDouble(9, mi[0].getDouble("BFYY_SALE_TAMT"));	
								sql.setDouble(10, mi[0].getDouble("BFYY_PROF_TAMT"));	
								sql.setDouble(11, mi[0].getDouble("BFYY_SALE_CRATE"));	
								sql.setDouble(12, mi[0].getDouble("BFYY_PROF_CRATE"));	
								sql.setDouble(13, mi[0].getDouble("ORIGIN_NORM_SAMT"));	
								sql.setDouble(14, mi[0].getDouble("ORIGIN_EVT_SAMT"));	
								sql.setDouble(15, mi[0].getDouble("ORIGIN_SALE_TAMT"));	
								sql.setDouble(16, mi[0].getDouble("ORIGIN_PROF_TAMT"));	
								sql.setDouble(17, mi[0].getDouble("ORIGIN_SALE_CRATE"));	
								sql.setDouble(18, mi[0].getDouble("ORIGIN_PROF_CRATE"));	
								sql.setDouble(19, mi[0].getDouble("ORIGIN_SALE_IRATE"));	
								sql.setDouble(20, mi[0].getDouble("ORIGIN_PROF_IRATE"));
								sql.setString(21, strID);
								sql.setString(22, strID);

								res = update(sql);
							}
							else{
								throw new Exception("[USER]"+"확정된데이터입니다." + ""
										+ "데이터 입력을 하지 못했습니다.");
							}
						}
					
						
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
