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

public class PSal111DAO extends AbstractDAO {

	/**
	 * 당초PC별월매출계획을 조회한다.
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
	 * 당초팀별월계획을 조회한다.
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
		sql.put(svc.getQuery("SEL_MASTER"));

		// 전년품번별월매출계획 
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPCCd);
		sql.setString(i++, strPlanYear);
		sql.setString(i++, OrgFlag);

		// 당초품번별월매출계획 
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPCCd);
		sql.setString(i++, strPlanYear);
		sql.setString(i++, OrgFlag);

		// 점별품번 
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPCCd);
		sql.setString(i++, OrgFlag);
		sql.setString(i++, strPlanYear);
		
		// 권한
		sql.setString(i++, userid);

		ret = select2List(sql);
		return ret;
	}

	/**
	 * 전년매출을  조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchBFYY(ActionForm form, String OrgFlag, String userId) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		int i 			= 1;
		
		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strPlanYm 		= String2.nvl(form.getParam("strPlanYm"));
		String strDeptCd 		= String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd 		= String2.nvl(form.getParam("strTeamCd"));
		String strPCCd 		    = String2.nvl(form.getParam("strPCCd"));
		String strPumbunCd 		    = String2.nvl(form.getParam("strPumbunCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		sql.put(svc.getQuery("SEL_PLANTEAM_BFYY"));

		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPCCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strPlanYm);
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
		String strOrgLevel 		= "4";
		String strDeptCd 		= String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd 		= String2.nvl(form.getParam("strTeamCd"));
		String strPCCd 		= String2.nvl(form.getParam("strPCCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		sql.put(svc.getQuery("SEL_ORGMST"));

		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);	
		sql.setString(i++, strTeamCd);	
		sql.setString(i++, strPCCd);
		sql.setString(i++, strOrgLevel);
		sql.setString(i++, OrgFlag);
		
		ret = select2List(sql);
		
		return ret;
	}

	/**
	 * 당초년매출계획 확정데이터  조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchConfFlag(ActionForm form, String OrgFlag) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		int i 			= 1;
		
		String strStrCd     = String2.nvl(form.getParam("strStrCd"));
		String strDeptCd    = String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd    = String2.nvl(form.getParam("strTeamCd"));
		String strPCCd 		= String2.nvl(form.getParam("strPCCd"));
		String strPlanYear  = String2.nvl(form.getParam("strPlanYear"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		sql.put(svc.getQuery("SEL_CONF_FLAG"));

		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPCCd);
		sql.setString(i++, strPlanYear);
		
		ret = select2List(sql);
		
		return ret;
	}

	/**
	 * 당초월매출계획 확정데이터  조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchConfFlagM(ActionForm form, String OrgFlag) throws Exception {
		
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
		sql.put(svc.getQuery("SEL_CONF_FLAG_PUMBUN"));

		sql.setString(i++, strStrCd);
		sql.setString(i++, strDeptCd);
		sql.setString(i++, strTeamCd);
		sql.setString(i++, strPCCd);
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
		
		String confFlag = "";
		
		
		int	cnt			= 0;
		int i			= 1;

		String strStrCd 	= String2.nvl(form.getParam("strStrCd"));
		String strDeptCd 	= String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd 	= String2.nvl(form.getParam("strTeamCd"));
		String strPCCd 	    = String2.nvl(form.getParam("strPCCd"));
		String strPlanYear 	= String2.nvl(form.getParam("strPlanYear"));
		
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			while (mi[0].next()) {//DateSet의 현제 Row의 상태를 체크한다 IS_INSERT, IS_UPDATE, IS_DELETE
				
				if (mi[0].IS_INSERT()) {

					System.out.println("입력로직 = " + mi[0].getString("PLAN_YM"));
					System.out.println("입력로직 = " + mi[0].getString("PLAN_YM"));
					System.out.println("입력로직 = " + mi[0].getString("PLAN_YM"));

					sql.close();
					sql.put(svc.getQuery("SEL_CONFFLAG"));
					
					sql.setString(1, strStrCd);	
					sql.setString(2, strDeptCd);		
					sql.setString(3, strTeamCd);		
					sql.setString(4, strPCCd);
					sql.setString(5, strPlanYear);			

					
					Map map = selectMap( sql );
					
					confFlag = String2.nvl((String)map.get("CONF_FLAG"));

					if( !confFlag.equals("") && !mi[0].getString("PLAN_YM").equals("")) {
						if(!confFlag.equals("Y") && !mi[0].getString("PLAN_YM").equals("")){
							if(cnt == 0){
								sql.close();
								sql.put(svc.getQuery("DEL_PLANPC"));
			
								sql.setString(1, strStrCd);
								sql.setString(2, strDeptCd);			
								sql.setString(3, strTeamCd);		
								sql.setString(4, strPCCd);
								sql.setString(5, strPlanYear);	
								res = update(sql);
							}
							cnt++;
							i = 1;
							
							sql.close();
							sql.put(svc.getQuery("INS_PLANPC"));
							sql.setString(i++, strStrCd);	
							sql.setString(i++, mi[0].getString("PLAN_YM"));	
							sql.setString(i++, strStrCd+ strDeptCd + strTeamCd + mi[0].getString("PC_CD") + "00");
							sql.setString(i++, mi[0].getString("PUMBUN_CD"));
							sql.setString(i++, strDeptCd);		
							sql.setString(i++, strTeamCd);		
							sql.setString(i++, mi[0].getString("PC_CD"));
							sql.setString(i++, mi[0].getString("BFYY_NORM_SAMT"));	
							sql.setString(i++, mi[0].getString("BFYY_EVT_SAMT"));	
							sql.setString(i++, mi[0].getString("BFYY_SALE_TAMT"));	
							sql.setString(i++, mi[0].getString("BFYY_PROF_TAMT"));	
							sql.setString(i++, mi[0].getString("BFYY_SALE_CRATE"));	
							sql.setString(i++, mi[0].getString("BFYY_PROF_CRATE"));	
							sql.setString(i++, mi[0].getString("ORIGIN_NORM_SAMT"));	
							sql.setString(i++, mi[0].getString("ORIGIN_EVT_SAMT"));	
							sql.setString(i++, mi[0].getString("ORIGIN_SALE_TAMT"));	
							sql.setString(i++, mi[0].getString("ORIGIN_PROF_TAMT"));	
							sql.setString(i++, mi[0].getString("ORIGIN_SALE_CRATE"));	
							sql.setString(i++, mi[0].getString("ORIGIN_PROF_CRATE"));	
							sql.setString(i++, mi[0].getString("ORIGIN_SALE_IRATE"));	
							sql.setString(i++, mi[0].getString("ORIGIN_PROF_IRATE"));
							sql.setString(i++, strID);
							sql.setString(i++, strID);
							
							res = update(sql);
							
							if (res != 1) {
								throw new Exception("[USER]"+ "데이터의 적합성 문제로 인하여"
										+ "데이터 입력을 하지 못했습니다.");
							}
							ret += res;
						}
						else{
							throw new Exception("[USER]"+"확정된데이터입니다." + ""
									+ "데이터 입력을 하지 못했습니다.");
						}
					}
					else{
						if(  !mi[0].getString("PLAN_YM").equals("")){
							cnt++;
							i = 1;
							sql.close();
							sql.put(svc.getQuery("INS_PLANPC"));
							sql.setString(i++, strStrCd);	
							sql.setString(i++, mi[0].getString("PLAN_YM"));	
							sql.setString(i++, strStrCd+ strDeptCd + strTeamCd + mi[0].getString("PC_CD") + "00");
							sql.setString(i++, mi[0].getString("PUMBUN_CD"));
							sql.setString(i++, strDeptCd);		
							sql.setString(i++, strTeamCd);		
							sql.setString(i++, mi[0].getString("PC_CD"));
							sql.setString(i++, mi[0].getString("BFYY_NORM_SAMT"));	
							sql.setString(i++, mi[0].getString("BFYY_EVT_SAMT"));	
							sql.setString(i++, mi[0].getString("BFYY_SALE_TAMT"));	
							sql.setString(i++, mi[0].getString("BFYY_PROF_TAMT"));	
							sql.setString(i++, mi[0].getString("BFYY_SALE_CRATE"));	
							sql.setString(i++, mi[0].getString("BFYY_PROF_CRATE"));	
							sql.setString(i++, mi[0].getString("ORIGIN_NORM_SAMT"));	
							sql.setString(i++, mi[0].getString("ORIGIN_EVT_SAMT"));	
							sql.setString(i++, mi[0].getString("ORIGIN_SALE_TAMT"));	
							sql.setString(i++, mi[0].getString("ORIGIN_PROF_TAMT"));	
							sql.setString(i++, mi[0].getString("ORIGIN_SALE_CRATE"));	
							sql.setString(i++, mi[0].getString("ORIGIN_PROF_CRATE"));	
							sql.setString(i++, mi[0].getString("ORIGIN_SALE_IRATE"));	
							sql.setString(i++, mi[0].getString("ORIGIN_PROF_IRATE"));
							sql.setString(i++, strID);
							sql.setString(i++, strID);
							
							res = update(sql);
							
							if (res != 1) {
								throw new Exception("[USER]"+ "데이터의 적합성 문제로 인하여"
										+ "데이터 입력을 하지 못했습니다.");
							}
							ret += res;
						}
					}
				}
				else if (mi[0].IS_UPDATE()) {
					
					System.out.println("수정로직 = " + mi[0].getString("PLAN_YM"));
					System.out.println("수정로직 = " + mi[0].getString("PLAN_YM"));
					System.out.println("수정로직 = " + mi[0].getString("PLAN_YM"));
					
					sql.close();
					sql.put(svc.getQuery("SEL_CONFFLAG"));

					sql.setString(1, strStrCd);	
					sql.setString(2, strDeptCd);			
					sql.setString(3, strTeamCd);			
					sql.setString(4, strPCCd);
					sql.setString(5, strPlanYear);	
					
					Map map = selectMap( sql );
					
					confFlag = String2.nvl((String)map.get("CONF_FLAG"));

					if( confFlag.equals("") && !mi[0].getString("PLAN_YM").equals("")) {
						cnt++;

						i = 1;
						sql.close();
						sql.put(svc.getQuery("INS_PLANPC"));
						sql.setString(i++, strStrCd);	
						sql.setString(i++, mi[0].getString("PLAN_YM"));	
						sql.setString(i++, strStrCd+ strDeptCd + strTeamCd + mi[0].getString("PC_CD") + "00");
						sql.setString(i++, mi[0].getString("PUMBUN_CD"));
						sql.setString(i++, strDeptCd);		
						sql.setString(i++, strTeamCd);		
						sql.setString(i++, mi[0].getString("PC_CD"));
						sql.setString(i++, mi[0].getString("BFYY_NORM_SAMT"));	
						sql.setString(i++, mi[0].getString("BFYY_EVT_SAMT"));	
						sql.setString(i++, mi[0].getString("BFYY_SALE_TAMT"));	
						sql.setString(i++, mi[0].getString("BFYY_PROF_TAMT"));	
						sql.setString(i++, mi[0].getString("BFYY_SALE_CRATE"));	
						sql.setString(i++, mi[0].getString("BFYY_PROF_CRATE"));	
						sql.setString(i++, mi[0].getString("ORIGIN_NORM_SAMT"));	
						sql.setString(i++, mi[0].getString("ORIGIN_EVT_SAMT"));	
						sql.setString(i++, mi[0].getString("ORIGIN_SALE_TAMT"));	
						sql.setString(i++, mi[0].getString("ORIGIN_PROF_TAMT"));	
						sql.setString(i++, mi[0].getString("ORIGIN_SALE_CRATE"));	
						sql.setString(i++, mi[0].getString("ORIGIN_PROF_CRATE"));	
						sql.setString(i++, mi[0].getString("ORIGIN_SALE_IRATE"));	
						sql.setString(i++, mi[0].getString("ORIGIN_PROF_IRATE"));
						sql.setString(i++, strID);
						sql.setString(i++, strID);

						res = update(sql);
						if (res != 1) {
							throw new Exception("[USER]"+ "데이터의 적합성 문제로 인하여"
									+ "데이터 입력을 하지 못했습니다.");
						}
						ret += res;
					}
					else{
						if(!confFlag.equals("Y") && !mi[0].getString("PLAN_YM").equals("")){

							if(cnt == 0){
								sql.close();
								sql.put(svc.getQuery("DEL_PLANPC"));
			
								sql.setString(1, strStrCd);
								sql.setString(2, strDeptCd);			
								sql.setString(3, strTeamCd);			
								sql.setString(4, strPCCd);
								sql.setString(5, strPlanYear);	
								res = update(sql);
							}
							cnt++;

							i = 1;
							sql.close();
							sql.put(svc.getQuery("INS_PLANPC"));
							sql.setString(i++, strStrCd);	
							sql.setString(i++, mi[0].getString("PLAN_YM"));	
							sql.setString(i++, strStrCd+ strDeptCd + strTeamCd + mi[0].getString("PC_CD") + "00");
							sql.setString(i++, mi[0].getString("PUMBUN_CD"));
							sql.setString(i++, strDeptCd);		
							sql.setString(i++, strTeamCd);		
							sql.setString(i++, mi[0].getString("PC_CD"));
							sql.setString(i++, mi[0].getString("BFYY_NORM_SAMT"));	
							sql.setString(i++, mi[0].getString("BFYY_EVT_SAMT"));	
							sql.setString(i++, mi[0].getString("BFYY_SALE_TAMT"));	
							sql.setString(i++, mi[0].getString("BFYY_PROF_TAMT"));	
							sql.setString(i++, mi[0].getString("BFYY_SALE_CRATE"));	
							sql.setString(i++, mi[0].getString("BFYY_PROF_CRATE"));	
							sql.setString(i++, mi[0].getString("ORIGIN_NORM_SAMT"));	
							sql.setString(i++, mi[0].getString("ORIGIN_EVT_SAMT"));	
							sql.setString(i++, mi[0].getString("ORIGIN_SALE_TAMT"));	
							sql.setString(i++, mi[0].getString("ORIGIN_PROF_TAMT"));	
							sql.setString(i++, mi[0].getString("ORIGIN_SALE_CRATE"));	
							sql.setString(i++, mi[0].getString("ORIGIN_PROF_CRATE"));	
							sql.setString(i++, mi[0].getString("ORIGIN_SALE_IRATE"));	
							sql.setString(i++, mi[0].getString("ORIGIN_PROF_IRATE"));
							sql.setString(i++, strID);
							sql.setString(i++, strID);

							res = update(sql);
							ret += res;
						}
						else{
							throw new Exception("[USER]"+"확정된데이터입니다." + ""
									+ "데이터 입력을 하지 못했습니다.");
						}
					}
				} 
			}
			if(ret > 0 ) ret = 1;
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}
}
