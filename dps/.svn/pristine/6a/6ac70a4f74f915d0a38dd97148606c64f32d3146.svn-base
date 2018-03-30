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

public class PSal102DAO extends AbstractDAO {

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
		Service svc 	= null;
		
		int i 			= 1;
		
		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strPlanYear 		= String2.nvl(form.getParam("strPlanYear"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		sql.put(svc.getQuery("SEL_PLANTEAMYY"));

		sql.setString(i++, OrgFlag);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPlanYear);
		sql.setString(i++, userId);

		ret = select2List(sql);
		
		return ret;
	}

	/**
	 * 당초팀별년계획을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDetail(ActionForm form, String OrgFlag, String userId) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		
		int i 			= 1;
		
		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strPlanYear 		= String2.nvl(form.getParam("strPlanYear"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		sql.put(svc.getQuery("SEL_PLANTEAMYYDETAIL"));

		sql.setString(i++, OrgFlag);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPlanYear);
		sql.setString(i++, userId);

		ret = select2List(sql);
		
		return ret;
	}

	/**
	 * 당초팀별월계획 확정구분을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchTeam(ActionForm form, String OrgFlag, String userId) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		Service svc 	= null;
		
		int i 			= 1;
		
		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strPlanYear 		= String2.nvl(form.getParam("strPlanYear"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		sql.put(svc.getQuery("SEL_PLANTEAMCONFFLAG"));

		sql.setString(i++, OrgFlag);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPlanYear);
		sql.setString(i++, userId);

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
		
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			while (mi[0].next()) {//DateSet의 현제 Row의 상태를 체크한다 IS_INSERT, IS_UPDATE, IS_DELETE
				sql.close();
				if (mi[0].IS_UPDATE()) {
					if(mi[0].getString("CHK_FLAG").equals("T")){
						sql.close();
						sql.put(svc.getQuery("UPD_PLANTEAMYY"));
						
						sql.setString(1, mi[0].getString("CONF_DT"));
						sql.setString(2, strID);
						sql.setString(3, "Y");
						sql.setString(4, strID);
						sql.setString(5, mi[0].getString("STR_CD"));	
						sql.setString(6, mi[0].getString("PLAN_YEAR"));
						sql.setString(7, "N");		
						
						
						
					}
					else{
						sql.close();
						sql.put(svc.getQuery("UPD_PLANTEAMYY"));
						
						sql.setString(1, "");
						sql.setString(2, strID);
						sql.setString(3, "N");
						sql.setString(4, strID);
						sql.setString(5, mi[0].getString("STR_CD"));		
						sql.setString(6, mi[0].getString("PLAN_YEAR"));
						sql.setString(7, "Y");	
						
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
