/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mren.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>전력 시간대 관리</p>
 * 
 * @created  on 1.0, 2010.04.01
 * @created  by 신익수(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MRen113DAO extends AbstractDAO {
	
   /**
    * <p>전력 시간대 관리  조회</p>
    */
   public List getPowerTime(ActionForm form) throws Exception {

       List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strTimeFlag = String2.nvl(form.getParam("strTimeFlag"));	//전력구분
        String strMonth = String2.nvl(form.getParam("strMonth"));	//월
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.put(svc.getQuery("SEL_MR_POWERTIME"));
        sql.setString(i++, strTimeFlag);
        sql.setString(i++, strMonth);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
   }
   
   /**
    * <p>중복키값조회</p>
    */
   @SuppressWarnings("rawtypes")
   public List getDupKeyValue(ActionForm form, MultiInput mi) throws Exception {
   	
   	List       list = null;
   	SqlWrapper  sql = null;
   	Service     svc = null;
   	try {
   		connect("pot");
   		svc  = (Service)form.getService();
   		sql  = new SqlWrapper();
   		int loopCnt = 0;
   		int i = 0;
   		
   	    while (mi.next()) {
               if (mi.IS_INSERT()) {
               	if (loopCnt == 0)  {
               		sql.put(svc.getQuery("SEL_DUP_KEYVALUE"));
               	} else {
               		sql.put(svc.getQuery("SEL_DUP_UNIONALL"));
               	}
               	sql.put(svc.getQuery("SEL_SUB_DUP_KEYVALUE"));
           		sql.setString(++i ,mi.getString("TIME_FLAG")); 
           		sql.setString(++i ,mi.getString("MONTH")); 
           		sql.setString(++i ,mi.getString("TIME")); 
           		
               	loopCnt++;
               } 
   	    }
   	    if (sql != null) sql.put(svc.getQuery("SEL_DUP_CLOSE"));
   	    list = select2List(sql);
   	} catch (Exception e) {
   		throw e;
   	}
   	return list;
   }
   
   /**
	 * 전력시간대 관리 등록/수정/삭제
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi0, String userId)
			throws Exception {

		int ret = 0;
		int res = 0;
		int i = 1;
		SqlWrapper sql = null;
		Service svc = null;
		
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			/**전력 시간대 등록/수정/삭제
			 */
			while (mi0.next()) {
				i = 1;
				sql.close();
				
				//저장
				if (mi0.IS_INSERT()) { 
					sql.close();
					
					sql.put(svc.getQuery("INS_MR_POWERTIME"));
					
					sql.setString(i++, mi0.getString("TIME_FLAG"));
					sql.setString(i++, mi0.getString("MONTH"));
					sql.setString(i++, mi0.getString("TIME"));
					sql.setString(i++, mi0.getString("TIME_ZONE"));
					sql.setString(i++, userId);
					sql.setString(i++, userId);
			
				//수정
				} else if (mi0.IS_UPDATE()) {
					sql.close();
					
					sql.put(svc.getQuery("UPD_MR_POWERTIME"));
					
					sql.setString(i++, mi0.getString("TIME_ZONE"));
					sql.setString(i++, userId);
					sql.setString(i++, mi0.getString("TIME_FLAG"));
					sql.setString(i++, mi0.getString("MONTH"));
					sql.setString(i++, mi0.getString("TIME"));
				
				//삭제
				} else if (mi0.IS_DELETE()) {
					sql.close();
					
					sql.put(svc.getQuery("DEL_MR_POWERTIME"));
					
					sql.setString(i++, mi0.getString("TIME_FLAG"));
					sql.setString(i++, mi0.getString("MONTH"));
					sql.setString(i++, mi0.getString("TIME"));
				}
				
				res = update(sql);

				if (res != 1) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여 데이터 입력을 하지 못했습니다.");
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
}
