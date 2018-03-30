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
 * @created  on 1.0, 2010/03/23
 * @created  by 박종은(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PSal558DAO extends AbstractDAO {

	/**
	 * 영업일정보를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String OrgFlag) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		int i 			= 1;
		
		String strStrCd     = String2.nvl(form.getParam("strStrCd"));
		String strSDate 		= String2.nvl(form.getParam("strSDate"));
		String strEDate 		= String2.nvl(form.getParam("strEDate"));		
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		sql.put(svc.getQuery("SEL_PS_VALEXETC"));

		sql.setString(i++, strStrCd);
		sql.setString(i++, strSDate);
		sql.setString(i++, strEDate);		

		ret = select2List(sql);
		
		return ret;
	}

	/**
	 * 대비영업일정보를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchCmpr(ActionForm form, String OrgFlag) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		int i 			= 1;
		
		String strStrCd     = String2.nvl(form.getParam("strStrCd"));
		String strSDate 		= String2.nvl(form.getParam("strSDate"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		sql.put(svc.getQuery("SEL_PS_SCHEDULE_CMPR"));

		sql.setString(i++, strStrCd);
		sql.setString(i++, strSDate);

		ret = select2List(sql);
		
		return ret;
	}

	/**
	 * 영업일정보 체크 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchSchedule(ActionForm form, String OrgFlag) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		int i 			= 1;
		
		String strStrCd       = String2.nvl(form.getParam("strStrCd"));
		String strSaleSDate   = String2.nvl(form.getParam("strSaleSDate"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		sql.put(svc.getQuery("SEL_PS_SCHEDULE_CHK"));

		sql.setString(i++, strStrCd);
		sql.setString(i++, strSaleSDate);

		ret = select2List(sql);
		
		return ret;
	}



	/**
	 * 영업일정보   저장, 수정  처리한다.
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
        int i = 1;

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			while (mi[0].next()) {//DateSet의 현제 Row의 상태를 체크한다 IS_INSERT, IS_UPDATE, IS_DELETE
				sql.close();
				if (mi[0].IS_INSERT()) {
					i = 1;
					sql.put(svc.getQuery("INS_PS_SCHEDULE"));
					
	                sql.setString(i++, mi[0].getString("STR_CD"));
	                sql.setString(i++, mi[0].getString("SALE_DT"));
	                sql.setString(i++, mi[0].getString("DAY_WEEK"));
	                sql.setDouble(i++, mi[0].getDouble("STD_WEIGHT"));
	                sql.setString(i++, mi[0].getString("HOLIDAY_GB"));
	                sql.setString(i++, mi[0].getString("SALE_REMARK"));
	                sql.setString(i++, mi[0].getString("CMPR_DT"));
	                sql.setString(i++, mi[0].getString("CMPR_DAY"));
	                sql.setString(i++, mi[0].getString("CMPR_HOLIDAY_GB"));
	                sql.setString(i++, mi[0].getString("CMPR_STD_WEIGHT"));
	                sql.setString(i++, mi[0].getString("WEATHER"));     
	                sql.setString(i++, mi[0].getString("LOW_TEMP"));    
	                sql.setString(i++, mi[0].getString("HIGH_TEMP"));   
	                sql.setString(i++, mi[0].getString("AVRG_TEMP"));
	                sql.setString(i++, strID);
	                sql.setString(i++, strID);
				}
				else{ 
					if (mi[0].IS_UPDATE()){
						i = 1;
						sql.put(svc.getQuery("UPD_PS_SCHEDULE"));
						
				 		sql.setString(i++, mi[0].getString("DAY_WEEK"));
				 		sql.setDouble(i++, mi[0].getDouble("STD_WEIGHT"));
				 		sql.setString(i++, mi[0].getString("HOLIDAY_GB"));
				 		sql.setString(i++, mi[0].getString("SALE_REMARK"));
				 		sql.setString(i++, mi[0].getString("CMPR_DT"));
				 		sql.setString(i++, mi[0].getString("CMPR_DAY"));
				 		sql.setString(i++, mi[0].getString("CMPR_HOLIDAY_GB"));
				 		sql.setString(i++, mi[0].getString("CMPR_STD_WEIGHT"));
		                sql.setString(i++, mi[0].getString("WEATHER"));     
		                sql.setString(i++, mi[0].getString("LOW_TEMP"));    
		                sql.setString(i++, mi[0].getString("HIGH_TEMP"));   
		                sql.setString(i++, mi[0].getString("AVRG_TEMP"));
				 		

				 		sql.setString(i++, strID);
				 		sql.setString(i++, mi[0].getString("STR_CD"));
				 		sql.setString(i++, mi[0].getString("SALE_DT"));
					}
				}
				 
				res = update(sql);
				
				if (res == 0) {
					throw new Exception("[USER]"+ "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				ret += res;
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
	 * 영업일정보    삭제  처리한다.
	 * 
	 * @param form
	 * @param mi[]
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int del(ActionForm form, MultiInput mi[], String strID)
			throws Exception {

		int ret 		= 0;
		int res 		= 0;
		Util util 		= new Util();
		SqlWrapper sql 	= null;
		Service svc 	= null;
        int i = 1;

		String strStrCd     = String2.nvl(form.getParam("strStrCd"));
		String strSMon 		= String2.nvl(form.getParam("strSMon"));
		
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			
				sql.close();
				
					
					sql.put(svc.getQuery("DEL_PS_SCHEDULE"));
					
	                sql.setString(1, strStrCd);
	                sql.setString(2, strSMon);
				
				 
				res = update(sql);
				
				ret += res;
			

		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}	
}
