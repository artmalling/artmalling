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

import common.vo.SessionInfo;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>
 * 경영지원
 * </p>
 * 행사코드 조회 팝업 DAO  ( 행사 마스터 외부조인)
 * 
 * @created on 1.0, 2010/05/16
 * @created by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class CCom217DAO extends AbstractDAO {
	/**
	 * 점별 행사 코드 팝업 조회
	 * 
	 * @param svc
	 * @return List
	 * @throws Exception
	 */
	public List getList(ActionForm form, MultiInput mi) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;

		if (!mi.next())
			throw new Exception("# CCom217DAO.searchOnPop] MuiltiInput is null");
		connect("pot");

		svc = (Service) form.getService();
		sql = new SqlWrapper();

		sql.put(svc.getQuery(mi.getString("SERVICE_ID")));

		int idx = 1;
		sql.setString(idx++, mi.getString("COND_TXT"));
		sql.setString(idx++, mi.getString("COND_TXT"));
		sql.setString(idx++, mi.getString("STR_CD"));
		sql.setString(idx++, mi.getString("EVENT_S_DT"));
		sql.setString(idx++, mi.getString("EVENT_S_DT"));
		sql.setString(idx++, mi.getString("EVENT_E_DT"));
		sql.setString(idx++, mi.getString("EVENT_E_DT"));
		sql.setString(idx++, mi.getString("EVENT_S_DT"));
		sql.setString(idx++, mi.getString("EVENT_E_DT"));
		sql.setString(idx++, mi.getString("EVENT_S_DT"));
		sql.setString(idx++, mi.getString("EVENT_E_DT"));
		
		String strEventType[];
		strEventType = mi.getString("EVENT_TYPE").split("/");
		String strSql = "";
		if(strEventType.length == 1){
			strSql =  "AND C.EVENT_TYPE = " + strEventType[0]; 
		}else if(strEventType.length > 1){
			strSql =  "AND C.EVENT_TYPE IN ('"; 
			for(int i=0;i<strEventType.length;i++){
				if(i<strEventType.length-1){
					strSql += strEventType[i]+ "','"; 
				}else{
					strSql += strEventType[i]+ "'";
				}
				
			}
			strSql += ")"; 
		}

		sql.put(strSql);
		// 상품권 종류 구분에 따른 조건 추가
		if(mi.getString("EVENT_GIFT_TYPE").equals("01") 
				|| mi.getString("EVENT_GIFT_TYPE").equals("02") 
				|| mi.getString("EVENT_GIFT_TYPE").equals("03")){
			sql.put(svc.getQuery("SEL_EVENT_GIFT_TYPE"));
			sql.setString(idx++, mi.getString("EVENT_GIFT_TYPE"));
		}else if(mi.getString("EVENT_GIFT_TYPE").equals("04")){
			sql.put(svc.getQuery("SEL_EVENT_GIFT_TYPE_04"));
			sql.setString(idx++, "01");
			sql.setString(idx++, "03");
		}else if(mi.getString("EVENT_GIFT_TYPE").equals("05")){
			sql.put(svc.getQuery("SEL_EVENT_GIFT_TYPE_04"));
//			sql.setString(idx++, "02");
//			sql.setString(idx++, "03"); 
			sql.setString(idx++, "01"); //상품권
			sql.setString(idx++, "02"); //물품
		}
		
		if(!strEventType[0].equals("5")){
			sql.put(svc.getQuery("SEL_MINUS"));
			sql.setString(idx++, mi.getString("EVENT_S_DT"));
			sql.setString(idx++, mi.getString("EVENT_S_DT"));
			sql.setString(idx++, mi.getString("EVENT_E_DT"));
			sql.setString(idx++, mi.getString("EVENT_E_DT"));
			sql.setString(idx++, mi.getString("EVENT_S_DT"));
			sql.setString(idx++, mi.getString("EVENT_E_DT"));
			sql.setString(idx++, mi.getString("EVENT_S_DT"));
			sql.setString(idx++, mi.getString("EVENT_E_DT"));
			
			if(strEventType.length == 1){
				strSql =  "AND C.EVENT_TYPE = " + strEventType[0]; 
			}else if(strEventType.length > 1){
				strSql =  "AND C.EVENT_TYPE IN ('"; 
				for(int i=0;i<strEventType.length;i++){
					if(i<strEventType.length-1){
						strSql += strEventType[i]+ "','"; 
					}else{
						strSql += strEventType[i]+ "'";
					}
					
				}
				strSql += ")"; 
			}
		}

		sql.put(svc.getQuery("SEL_ORDER"));
		
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
					"# CCom217DAO.getOneWithoutPop] MuiltiInput is null");
		connect("pot");

		svc = (Service) form.getService();
		sql = new SqlWrapper();

		sql.put(svc.getQuery(mi.getString("SERVICE_ID")));
		int idx = 1;
		sql.setString(idx++, mi.getString("CODE_CD"));
		sql.setString(idx++, mi.getString("STR_CD"));
		
		String strEventType[];
		strEventType = mi.getString("EVENT_TYPE").split("/");
		String strSql = "";
		if(strEventType.length == 1){
			strSql =  "AND C.EVENT_TYPE = " + strEventType[0]; 
		}else if(strEventType.length > 1){
			strSql =  "AND C.EVENT_TYPE IN ('"; 
			for(int i=0;i<strEventType.length;i++){
				if(i<strEventType.length-1){
					strSql += strEventType[i]+ "','"; 
				}else{
					strSql += strEventType[i]+ "'";
				}
				
			}
			strSql += ")"; 
		}
		sql.put(strSql);
		
		//, 상품권 종류 구분에 따른 조건 추가
		if(mi.getString("EVENT_GIFT_TYPE").equals("01") 
				|| mi.getString("EVENT_GIFT_TYPE").equals("02") 
				|| mi.getString("EVENT_GIFT_TYPE").equals("03")){
			sql.put(svc.getQuery("SEL_EVENT_GIFT_TYPE"));
			sql.setString(idx++, mi.getString("EVENT_GIFT_TYPE"));
		}else if(mi.getString("EVENT_GIFT_TYPE").equals("04")){
			sql.put(svc.getQuery("SEL_EVENT_GIFT_TYPE_04"));
			sql.setString(idx++, "01");
			sql.setString(idx++, "03");
		}else if(mi.getString("EVENT_GIFT_TYPE").equals("05")){
			sql.put(svc.getQuery("SEL_EVENT_GIFT_TYPE_04"));
			sql.setString(idx++, "02");
			sql.setString(idx++, "03");
		}
		
		ret = select2List(sql);

		return ret;
	}

}
