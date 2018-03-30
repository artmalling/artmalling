/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package common.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;

/**
 * <p>가맹점 조회 팝업DAO</p>
 * @created on 1.0, 2010/02/21
 * @created by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */
public class CCom213DAO extends AbstractDAO {
	/**
	 * 조회
	 * @param svc
	 * @return List
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public List getList(ActionForm form, MultiInput mi)
			throws Exception {

		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		try {
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			connect("pot");
			mi.next();
			int i = 0;
			String addCondition = mi.getString("ADD_CONDITION");
			String[] addConds = addCondition.split("#G#");
			if(mi.getString("SEARCHGB").equals("A")){
				sql.put(svc.getQuery("SEL_EVT_VEN_ALL"));
			}else{
				if(mi.getString("TBGBN").equals("1")){ // 제휴
					sql.put(svc.getQuery("SEL_EVT_VEN_01")); 
					sql.setString(++i, "95");
				}else if(mi.getString("TBGBN").equals("2")){ //가맹점
					sql.put(svc.getQuery("SEL_EVT_VEN_02")); 
					//sql.setString(++i, "92");
				}else if(mi.getString("TBGBN").equals("3")){ // 위탁
					sql.put(svc.getQuery("SEL_EVT_VEN_02")); 
					//sql.setString(++i, "92");
				}else if(mi.getString("TBGBN").equals("4")){ //가맹점 - DPS 마스터 
					sql.put(svc.getQuery("SEL_EVT_VEN_A_01")); 
					sql.setString(++i, "92");
					sql.setString(++i, "40");
					sql.setString(++i, "50");
				// MARIO OUTLET START	
				////}else if(mi.getString("TBGBN").equals("5")){ //제휴 - MSS 마스터 
				////	sql.put(svc.getQuery("SEL_EVT_VEN_05")); 
				////	sql.setString(++i, "1");
				// MARIO OUTLET END
				// MARIO START	
				}else if(mi.getString("TBGBN").equals("5")){ //제휴 - MSS 마스터 
					sql.put(svc.getQuery("SEL_EVT_VEN_05")); 
					sql.setString(++i, "1");
				// MARIO END					
				}
				
				sql.put(svc.getQuery("SEL_CONDI_VEN"));
			}	
			
			sql.setString(++i, mi.getString("CODE"));
			sql.setString(++i, mi.getString("NAME"));
			
			//추가 조건이 있을경우
			if (!addCondition.equals("")) {
				for (int idx = 0; idx < addConds.length; idx++) {
					switch(idx){
				        case 0: //점코드
					        if( !addConds[idx].equals("") ){
					        	sql.put(svc.getQuery("SEL_CONDI_STR"));
					        	sql.setString(++i, addConds[idx] );
					        }
					    	break;
				        case 1: //매입매출 구분
					        if( !addConds[idx].equals("") ){
					        	sql.put(svc.getQuery("SEL_CONDI_BUY_SALE_FLAG"));
					        	sql.setString(++i, addConds[idx] );
					        }
					    	break;
					}
				}
			}
			if(mi.getString("TBGBN").equals("1")){ // 제휴
				sql.put(svc.getQuery("SEL_ORDER_01"));
				
				// MARIO OUTLET START
				////}else if(mi.getString("TBGBN").equals("2")){ //가맹점
				////	sql.put(svc.getQuery("SEL_ORDER_02"));
				////	sql.setString(++i, "3");
				// MARIO OUTLET END
				// MARIO SQUARE START
				}else if(mi.getString("TBGBN").equals("2")){ //가맹점
					sql.put(svc.getQuery("SEL_ORDER_02"));
					sql.setString(++i, "3");
				// MARIO SQUARE END
				}else if(mi.getString("TBGBN").equals("3")){ // 위탁
				sql.put(svc.getQuery("SEL_ORDER_02"));
				sql.setString(++i, "2");
		    // MARIO OUTLET START
			////}else if(mi.getString("TBGBN").equals("4")){ // //가맹점 - DPS 마스터
			////	sql.put(svc.getQuery("SEL_ORDER_A_01"));
			// MARIO OUTLET END
			//MARIO START
			}else if(mi.getString("TBGBN").equals("4")){ // //가맹점 - DPS 마스터
				sql.put(svc.getQuery("SEL_ORDER_A_01"));
			//MARIO END
			}else if(mi.getString("TBGBN").equals("5")){ // 제휴 - MSS 마스터 
				sql.put(svc.getQuery("SEL_ORDER_01"));
			}
			
			list = select2List(sql);
		} catch (Exception e) {
			 throw e;
		}
		return list;
	}
}
