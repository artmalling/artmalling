/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package common.dao;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import common.util.Util;
import common.vo.SessionInfo;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>
 * 공통코드 처리
 * </p>
 * 공통코드 팝업화면 DAO
 * 
 * @created on 1.0, 2010/12/24
 * @created by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class CCom911DAO extends AbstractDAO {
	/**
	 * 공통 팝업에서 조회하기
	 * 
	 * @param svc
	 * @return List
	 * @throws Exception
	 */
	public List searchOnPop(ActionForm form, MultiInput mi) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;

		if (!mi.next())
			throw new Exception("# GCod999DAO.searchOnPop] MuiltiInput is null");
		connect("pot");

		svc = (Service) form.getService();
		sql = new SqlWrapper();

		sql.put(svc.getQuery(mi.getString("SERVICE_ID")));

		int idx = 1;
		sql.setString(idx++, mi.getString("CODE"));
		sql.setString(idx++, mi.getString("NAME"));
		String addCond = mi.getString("ADD_CONDITION");

		if (!"".equals(addCond)) {
			String[] addConds = addCond.split("#G#");
			for (int i = 0; i < addConds.length; i++) {
				sql.setString(idx++, addConds[i]);
			}
		}

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 공통 팝업에서 조회하기 (조건값을 파라메터로 넘겨 사용)
	 * 
	 * @param svc
	 * @return List
	 * @throws Exception
	 */
	public List searchOnPopWithCond(ActionForm form, MultiInput mi)
			throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;

		if (!mi.next())
			throw new Exception(
					"# GCod999DAO.searchOnPopWithCond] MuiltiInput is null");
		connect("pot");

		svc = (Service) form.getService();
		sql = new SqlWrapper();

		sql.put(svc.getQuery(mi.getString("SERVICE_ID")));

		int idx = 1;
		sql.setString(idx++, mi.getString("CODE"));
		sql.setString(idx++, mi.getString("NAME"));
		String addCond = mi.getString("ADD_CONDITION");

		if (!"".equals(addCond)) {
			String[] addConds = addCond.split("#G#");
			for (int i = 0; i < addConds.length; i++) {
				sql.setString(idx++, addConds[i]);
			}
		}

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 팝업 없이 조회하기
	 * 
	 * @param svc
	 * @return List
	 * @throws Exception
	 */
	public List getOneWithoutPop(ActionForm form, MultiInput mi)
			throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		
		if (!mi.next())
			throw new Exception(
					"# GCod999DAO.getOneWithoutPop] MuiltiInput is null");
		connect("pot");

		svc = (Service) form.getService();
		sql = new SqlWrapper();

		sql.put(svc.getQuery(mi.getString("SERVICE_ID") + "_ONE"));
		int idx = 1;
		sql.setString(idx++, mi.getString("CODE_CD"));
		String addCond = mi.getString("ADD_CONDITION");

		if (!"".equals(addCond)) {
			String[] addConds = addCond.split("#G#");
			for (int i = 0; i < addConds.length; i++) {
				sql.setString(idx++, addConds[i]);
			}
		}

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 간편하게 QUERY 조회하기
	 * 
	 * @param svc
	 * @return List
	 * @throws Exception
	 */
	public List getCommonDataSet(ActionForm form, MultiInput mi)
			throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String getSql = null;

		svc = (Service) form.getService();
		sql = new SqlWrapper();

		if (!mi.next())
			throw new Exception(
					"# GCod999DAO.getCommonDataSet] MuiltiInput is null");

		connect("pot");
		getSql = svc.getQuery(mi.getString("SERVICE_ID"));

		sql.put(getSql);

		int idx = 1;
		String addCond = mi.getString("ADD_CONDITION");
		if (!"".equals(addCond)) {
			String[] addConds = addCond.split("#G#");
			for (int i = 0; i < addConds.length; i++) {
				sql.setString(idx++, addConds[i]);
			}
		}

		ret = select2List(sql);

		return ret;
	}

	

	/**
	 * TO DO LIST 셋팅한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int enroll2DoList(ActionForm form, MultiInput mi, String strID)
			throws Exception {

		int res = 0;
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;
		int ret 	= 0;	
		
		String dataProcFlag = null;
		int i;

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			while (mi.next()) {  
				
				sql.close();		
				if (mi.IS_INSERT()) {  
					i = 0;						
					
					if(mi.getString("TDL_SEQ").equals("")) dataProcFlag = "INSERT";
					else							 	   dataProcFlag = "UPDATE";
					
					if("INSERT".equals(dataProcFlag))
					{
						// TODOLIST SEQUENCE조회
						sql.put(svc.getQuery("SEL_TODOLIST_CNT"));		 
						sql.setString(++i, mi.getString("TDL_USER_ID"));
						
						Map map = selectMap( sql );	
						
						String seq = String2.nvl((String)map.get("TDL_SEQ"));
	 
						if( seq.equals("")) {
							throw new Exception("[USER]"+"TO DO LIST SEQUENCE 생성 에러입니다.(관리자에게 문의하세요)");
						}
						sql.close();
						
						i = 0;
						sql.put(svc.getQuery("INS_TODOLIST"));
						
						sql.setString(++i, mi.getString("TDL_USER_ID"));  
						sql.setString(++i, seq);  
						sql.setString(++i, mi.getString("RQS_USER_ID"));  
						sql.setString(++i, mi.getString("TDL_NAME"));  
						sql.setString(++i, mi.getString("TDL_URL"));  
						sql.setString(++i, mi.getString("TDL_LIMIT_DATE"));  
						sql.setString(++i, mi.getString("TDL_FLAG"));  
	
						ret = update(sql); 
						 
						if (ret < 1)  
							throw new Exception("" + "데이터의 적합성 문제로 인하여 데이터를 처리하지 못했습니다.");  
					}
					else
					{
						sql.close();
						
						i = 0;
						sql.put(svc.getQuery("UPT_TODOLIST"));
						
						sql.setString(++i, mi.getString("TDL_FLAG"));   
						sql.setString(++i, mi.getString("TDL_DATE"));  
						sql.setString(++i, mi.getString("TDL_USER_ID"));    
						sql.setString(++i, mi.getString("TDL_SEQ"));  
	
						ret = update(sql); 

						if (ret < 1)  
							throw new Exception("" + "데이터의 적합성 문제로 인하여 데이터를 처리하지 못했습니다.");  
					}
				} 
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
