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
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
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

public class PSal112DAO extends AbstractDAO {

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
	 * @param strId
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi[], String strId)
			throws Exception {

		int ret 		= 0;
		int res 		= 0;
		SqlWrapper sql 	= null;
		Service svc 	= null;
        
		int i = 0;
		String strConfDt    = "";
		String strConfFlag1 = "";
		String strConfFlag2 = "";
		
		try {
			connect("pot");
			begin();
			svc = (Service) form.getService();

			//DateSet의 현제 Row의 상태를 체크한다 IS_INSERT, IS_UPDATE, IS_DELETE
			while (mi[0].next()) {
				
				if (mi[0].IS_UPDATE()) {
					
					if(mi[0].getString("CONF_FLAG").equals("T")){		// 변경 된 데이터가 확정이면(확정 로직)
						strConfDt    = mi[0].getString("CONF_DT");
						strConfFlag1 = "Y";
						strConfFlag2 = "N";
					}else{												// 변경 된 데이터가 미 확정이면(확정취소 로직)
						strConfDt    = "";
						strConfFlag1 = "N";
						strConfFlag2 = "Y";
					}
					
					/*********************************** 품번별 월별 매출계획 확정/확정취소 시작***********************************/
					// sql객체 초기화
					sql = new SqlWrapper();	
					
					// value idx 초기화
					i = 0;

					// 품번별 월별 매출계획
					sql.put(svc.getQuery("UPD_PLAN_PUMBUN"));
					sql.setString(++i, strConfDt);
					sql.setString(++i, strId);
					sql.setString(++i, strConfFlag1);
					sql.setString(++i, strId);
					sql.setString(++i, mi[0].getString("STR_CD"));	
					sql.setString(++i, mi[0].getString("DEPT_CD"));
					sql.setString(++i, mi[0].getString("TEAM_CD"));	
					sql.setString(++i, mi[0].getString("PC_CD"));
					sql.setString(++i, mi[0].getString("PLAN_YEAR"));
					sql.setString(++i, strConfFlag2);
					res += update(sql);
					
					// sql객체 닫기
					sql.close();
					/*********************************** 품번별 월별 매출계획 확정/확정취소 끝***********************************/
					
					/*********************************** PC별 월별 매출계획 확정/확정취소 시작***********************************/
					// sql객체 초기화
					sql = new SqlWrapper();	
					
					// value idx 초기화
					i = 0;

					// 품번별 월별 매출계획 1월
					sql.put(svc.getQuery("MER_PLAN_PC"));
					sql.setString(++i, mi[0].getString("STR_CD"));	
					sql.setString(++i, mi[0].getString("PLAN_YEAR") + "01");
					sql.setString(++i, mi[0].getString("STR_CD"));	
					sql.setString(++i, mi[0].getString("DEPT_CD"));
					sql.setString(++i, mi[0].getString("TEAM_CD"));	
					sql.setString(++i, mi[0].getString("PC_CD"));
//					sql.setDouble(++i, mi[0].getDouble("BFYY_NORM_SAMT_JAN"));
//					sql.setDouble(++i, mi[0].getDouble("BFYY_EVT_SAMT_JAN"));
//					sql.setDouble(++i, mi[0].getDouble("BFYY_SALE_TAMT_JAN"));
//					sql.setDouble(++i, mi[0].getDouble("BFYY_PROF_TAMT_JAN"));
//					sql.setDouble(++i, mi[0].getDouble("BFYY_PROF_CRATE_JAN"));
//					sql.setDouble(++i, mi[0].getDouble("BFYY_SALE_CRATE_JAN"));
					sql.setDouble(++i, 0);
					sql.setDouble(++i, 0);
					sql.setDouble(++i, 0);
					sql.setDouble(++i, 0);
					sql.setDouble(++i, 0);
					sql.setDouble(++i, 0);
					sql.setDouble(++i, mi[0].getDouble("ORIGIN_NORM_SAMT_JAN"));
					sql.setDouble(++i, mi[0].getDouble("ORIGIN_EVT_SAMT_JAN"));
					sql.setDouble(++i, mi[0].getDouble("ORIGIN_SALE_TAMT_JAN"));
					sql.setDouble(++i, mi[0].getDouble("ORIGIN_PROF_TAMT_JAN"));
					sql.setDouble(++i, mi[0].getDouble("ORIGIN_PROF_CRATE_JAN"));
					sql.setDouble(++i, mi[0].getDouble("ORIGIN_SALE_CRATE_JAN"));
					sql.setString(++i, strConfDt);
					sql.setString(++i, strId);
//					sql.setString(++i, strConfFlag1);
					sql.setString(++i, "N");
					sql.setString(++i, strId);

					sql.setString(++i, mi[0].getString("STR_CD"));	
					sql.setString(++i, mi[0].getString("PLAN_YEAR") + "01");
					sql.setString(++i, mi[0].getString("STR_CD"));	
					sql.setString(++i, mi[0].getString("DEPT_CD"));
					sql.setString(++i, mi[0].getString("TEAM_CD"));	
					sql.setString(++i, mi[0].getString("PC_CD"));
					sql.setString(++i, mi[0].getString("DEPT_CD"));
					sql.setString(++i, mi[0].getString("TEAM_CD"));	
					sql.setString(++i, mi[0].getString("PC_CD"));
//					sql.setDouble(++i, mi[0].getDouble("BFYY_NORM_SAMT_JAN"));
//					sql.setDouble(++i, mi[0].getDouble("BFYY_EVT_SAMT_JAN"));
//					sql.setDouble(++i, mi[0].getDouble("BFYY_SALE_TAMT_JAN"));
//					sql.setDouble(++i, mi[0].getDouble("BFYY_PROF_TAMT_JAN"));
//					sql.setDouble(++i, mi[0].getDouble("BFYY_PROF_CRATE_JAN"));
//					sql.setDouble(++i, mi[0].getDouble("BFYY_SALE_CRATE_JAN"));
					sql.setDouble(++i, 0);
					sql.setDouble(++i, 0);
					sql.setDouble(++i, 0);
					sql.setDouble(++i, 0);
					sql.setDouble(++i, 0);
					sql.setDouble(++i, 0);
					sql.setDouble(++i, mi[0].getDouble("ORIGIN_NORM_SAMT_JAN"));
					sql.setDouble(++i, mi[0].getDouble("ORIGIN_EVT_SAMT_JAN"));
					sql.setDouble(++i, mi[0].getDouble("ORIGIN_SALE_TAMT_JAN"));
					sql.setDouble(++i, mi[0].getDouble("ORIGIN_PROF_TAMT_JAN"));
					sql.setDouble(++i, mi[0].getDouble("ORIGIN_PROF_CRATE_JAN"));
					sql.setDouble(++i, mi[0].getDouble("ORIGIN_SALE_CRATE_JAN"));
					sql.setString(++i, strConfDt);
					sql.setString(++i, strId);
//					sql.setString(++i, strConfFlag1);
					sql.setString(++i, "N");
					sql.setString(++i, strId);
					sql.setString(++i, strId);
					res += update(sql);
					
					// sql객체 닫기
					sql.close();
					/*********************************** 품번별 월별 매출계획 확정/확정취소 끝***********************************/
				}
				
				if (res == 0) {
					throw new Exception("[USER]"+ "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				ret = res;

				System.out.println("**************************************");
				System.out.println("**************************************");
				System.out.println("ret = " + ret);
				System.out.println("**************************************");
				System.out.println("**************************************");
			}

		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}



	/**
	 * 당초PC별월매출계획   저장, 수정  처리한다.
	 * 
	 * @param form
	 * @param mi[]
	 * @param strId
	 * @return
	 * @throws Exception
	 */
	public int save2(ActionForm form, MultiInput mi[], String strId, String strOrgFlag)
			throws Exception {

		int ret 		= 0;
		int res 		= 0;
		SqlWrapper sql 	= null;
		Service svc 	= null;
        
		int i = 0;
		String strConfDt   = "";
		String strConfFlag = "";
		int intRtVal       = 0;
		String strRtMsg    = "";
		
		try {
			connect("pot");
			begin();
			svc = (Service) form.getService();

			//DateSet의 현제 Row의 상태를 체크한다 IS_INSERT, IS_UPDATE, IS_DELETE
			while (mi[0].next()) {
				
				if (mi[0].IS_UPDATE()) {
					
					if(mi[0].getString("CONF_FLAG").equals("T")){		// 변경 된 데이터가 확정이면(확정 로직)
						strConfDt    = mi[0].getString("CONF_DT");
						strConfFlag  = "Y";
					}else{												// 변경 된 데이터가 미 확정이면(확정취소 로직)
						strConfDt    = "";
						strConfFlag  = "N";
					}
					
					/*********************************** 매출계획 확정/확정취소 시작***********************************/
			        ProcedureWrapper 	psql = null; 
			        ProcedureResultSet 	prs  = null; 
		            psql = new ProcedureWrapper();

		            // 처리로직 프로시저 호출
					psql.put("DPS.PR_PSPLAN", 11);
					psql.setString(++i, strConfDt);
					psql.setString(++i, strId);
					psql.setString(++i, strConfFlag);
					psql.setString(++i, strOrgFlag);
					psql.setString(++i, mi[0].getString("STR_CD"));
					psql.setString(++i, mi[0].getString("DEPT_CD"));
					psql.setString(++i, mi[0].getString("TEAM_CD"));
					psql.setString(++i, mi[0].getString("PC_CD"));
					psql.setString(++i, mi[0].getString("PLAN_YEAR"));
					psql.registerOutParameter(++i, DataTypes.INTEGER);
					psql.registerOutParameter(++i, DataTypes.VARCHAR);
					prs = updateProcedure(psql);

					intRtVal = prs.getInt(10);
					strRtMsg = prs.getString(11);
					if(intRtVal < 0){
						throw new Exception("[USER]"+ strRtMsg);
					}
					/*********************************** 매출계획 확정/확정취소 끝***********************************/
				}
				ret = res;
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
