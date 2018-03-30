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
 * <p>열요금표관리</p>
 * 
 * @created  on 1.0, 2010.04.01
 * @created  by 신익수(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MRen110DAO extends AbstractDAO {
	/**
    * <p>온수-주택용 조회</p>
    */
   public List getWarmWtrprch(ActionForm form) throws Exception {

   	List       list = null;
       SqlWrapper  sql = null;
       Service     svc = null;
       try {
           connect("pot");
           svc  = (Service)form.getService();
           sql  = new SqlWrapper();
           int i = 0;
           
           sql.put(svc.getQuery("SEL_MR_WARMWTRPRCH"));
           
           list = select2List(sql);
       } catch (Exception e) {
           throw e;
       }
       return list;
   }
   
   /**
    * <p>온수-업무용 조회</p>
    */
   public List getWarmWtrprcb(ActionForm form) throws Exception {

   	List       list = null;
       SqlWrapper  sql = null;
       Service     svc = null;
       try {
           connect("pot");
           svc  = (Service)form.getService();
           sql  = new SqlWrapper();
           int i = 0;
          
           sql.put(svc.getQuery("SEL_MR_WARMWTRPRCB"));
           
           list = select2List(sql);
       } catch (Exception e) {
           throw e;
       }
       return list;
   }
   
   /**
    * <p>증기 조회</p>
    */
   public List getSteamPrc(ActionForm form) throws Exception {

   	List       list = null;
       SqlWrapper  sql = null;
       Service     svc = null;
       try {
           connect("pot");
           svc  = (Service)form.getService();
           sql  = new SqlWrapper();
           int i = 0;
            
           sql.put(svc.getQuery("SEL_MR_STEAMPRC"));
           
           list = select2List(sql);
       } catch (Exception e) {
           throw e;
       }
       return list;
   }
   
   /**
    * <p>냉수-기본요금 조회</p>
    */
   public List getColdWtrBa(ActionForm form) throws Exception {

   	List       list = null;
       SqlWrapper  sql = null;
       Service     svc = null;
       try {
           connect("pot");
           svc  = (Service)form.getService();
           sql  = new SqlWrapper();
           int i = 0;
           
           sql.put(svc.getQuery("SEL_MR_COLDWTRBASPRC"));
           
           list = select2List(sql);
       } catch (Exception e) {
           throw e;
       }
       return list;
   }
   
   /**
    * <p>냉수-사용요금 조회</p>
    */
   public List getcoldWtr(ActionForm form) throws Exception {

   	List       list = null;
       SqlWrapper  sql = null;
       Service     svc = null;
       try {
           connect("pot");
           svc  = (Service)form.getService();
           sql  = new SqlWrapper();
           int i = 0;
            
           sql.put(svc.getQuery("SEL_MR_COLDWTRPRC"));
           
           list = select2List(sql);
       } catch (Exception e) {
           throw e;
       }
       return list;
   }
   
   /**
	 * 열요금표 관리 등록/수정/삭제
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi0,MultiInput mi1,MultiInput mi2,
			        MultiInput mi3,MultiInput mi4, String userId)
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
			
			/**
			 * 온수-주택용 등록/수정
			 */
			while (mi0.next()) {
				i = 1;
				sql.close();
				
				// 온수-주택용  저장
				if (mi0.IS_INSERT()) { 
					sql.close();
					
					sql.put(svc.getQuery("INS_MR_WARMWTRPRCH"));

					sql.setString(i++, mi0.getString("BAS_PRC"));
					sql.setString(i++, mi0.getString("UNIT_PRC"));
					sql.setString(i++, mi0.getString("UNIT_PRC_01"));
					sql.setString(i++, mi0.getString("UNIT_PRC_02"));
					sql.setString(i++, mi0.getString("UNIT_PRC_03"));
					sql.setString(i++, mi0.getString("UNIT_PRC_04"));
					sql.setString(i++, mi0.getString("UNIT_PRC_05"));
					sql.setString(i++, mi0.getString("UNIT_PRC_06"));
					sql.setString(i++, mi0.getString("UNIT_PRC_07"));
					sql.setString(i++, mi0.getString("UNIT_PRC_08"));
					sql.setString(i++, mi0.getString("UNIT_PRC_09"));
					sql.setString(i++, mi0.getString("UNIT_PRC_10"));
					sql.setString(i++, mi0.getString("UNIT_PRC_11"));
					sql.setString(i++, mi0.getString("UNIT_PRC_12"));
					sql.setString(i++, userId);
					sql.setString(i++, userId);
			
				// 온수-주택용  수정
				} else if (mi0.IS_UPDATE()) {
					
					sql.put(svc.getQuery("UPD_MR_WARMWTRPRCH"));
					
					sql.setString(i++, mi0.getString("BAS_PRC"));
					sql.setString(i++, mi0.getString("UNIT_PRC"));
					sql.setString(i++, mi0.getString("UNIT_PRC_01"));
					sql.setString(i++, mi0.getString("UNIT_PRC_02"));
					sql.setString(i++, mi0.getString("UNIT_PRC_03"));
					sql.setString(i++, mi0.getString("UNIT_PRC_04"));
					sql.setString(i++, mi0.getString("UNIT_PRC_05"));
					sql.setString(i++, mi0.getString("UNIT_PRC_06"));
					sql.setString(i++, mi0.getString("UNIT_PRC_07"));
					sql.setString(i++, mi0.getString("UNIT_PRC_08"));
					sql.setString(i++, mi0.getString("UNIT_PRC_09"));
					sql.setString(i++, mi0.getString("UNIT_PRC_10"));
					sql.setString(i++, mi0.getString("UNIT_PRC_11"));
					sql.setString(i++, mi0.getString("UNIT_PRC_12"));
					sql.setString(i++, userId);
					sql.setString(i++, mi0.getString("WWTR_KIND_CD"));
				} 
				
				res = update(sql);

				if (res != 1) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여 데이터 입력을 하지 못했습니다.");
				} 
				ret += res;
			}
			
			/**
			 * 온수-업무용 등록/수정
			 */
			while (mi1.next()) {
				i = 1;
				sql.close();
				// 온수-업무용  등록수정
				if (mi1.IS_UPDATE()) {
					
					sql.put(svc.getQuery("UPD_MR_WARMWTRPRCB"));
					
					sql.setString(i++, mi1.getString("WWTR_KIND_CD"));
					sql.setString(i++, mi1.getString("BAS_PRC"));
					sql.setString(i++, mi1.getString("UNIT_PRC"));
					sql.setString(i++, mi1.getString("APP_S_MM"));
					sql.setString(i++, mi1.getString("APP_E_MM"));
					sql.setString(i++, mi1.getString("DEM_S_HH"));
					sql.setString(i++, mi1.getString("DEM_E_HH"));
					sql.setString(i++, mi1.getString("DEM_UNIT_PRC"));
					sql.setString(i++, mi1.getString("DEM_ETC_UNIT_PRC"));
					sql.setString(i++, userId);
					sql.setString(i++, userId);
				} 
				
				res = update(sql);

				if (res != 1) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여 데이터 입력을 하지 못했습니다.");
				} 
				ret += res;
			}
			
			/**
			 * 증기 등록/수정
			 */
			while (mi2.next()) {
				i = 1;
				sql.close();
				
				// 증기 저장
				if (mi2.IS_INSERT()) { 
					sql.close();
					
					sql.put(svc.getQuery("INS_MR_STEAMPRC"));

					sql.setString(i++, mi2.getString("BAS_PRC"));
					sql.setString(i++, mi2.getString("UNIT_PRC"));
					sql.setString(i++, userId);
					sql.setString(i++, userId);
			
				// 증기  수정
				} else if (mi2.IS_UPDATE()) {
					
					sql.put(svc.getQuery("UPD_MR_STEAMPRC"));
					
					sql.setString(i++, mi2.getString("BAS_PRC"));
					sql.setString(i++, mi2.getString("UNIT_PRC"));
					sql.setString(i++, userId);
					sql.setString(i++, mi2.getString("STM_KIND_CD"));
				} 

				res = update(sql);

				if (res != 1) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여 데이터 입력을 하지 못했습니다.");
				} 
				ret += res;
			}
			
			/**
			 * 냉수-기본요금  등록/수정/삭제
			 */
			while (mi3.next()) {
				i = 1;
				sql.close();
				
				// 냉수-기본요금 저장
				if (mi3.IS_INSERT()) { 
					sql.close();
					
					sql.put(svc.getQuery("INS_MR_COLDWTRBASPRC"));

					sql.setString(i++, mi3.getString("USE_S_QTY"));
					sql.setString(i++, mi3.getString("USE_E_QTY"));
					sql.setString(i++, mi3.getString("BAS_PRC"));
					sql.setString(i++, userId);
					sql.setString(i++, userId);
			
				// 냉수-기본요금  수정
				} else if (mi3.IS_UPDATE()) {
					
					sql.put(svc.getQuery("UPD_MR_COLDWTRBASPRC"));
					
					sql.setString(i++, mi3.getString("USE_S_QTY"));
					sql.setString(i++, mi3.getString("USE_E_QTY"));
					sql.setString(i++, mi3.getString("BAS_PRC"));
					sql.setString(i++, userId);
					sql.setString(i++, mi3.getString("CWTR_KIND_CD"));
					sql.setString(i++, mi3.getString("SEQ"));
				
			    //냉수-기본요금  삭제
				} else if(mi3.IS_DELETE()){
					sql.put(svc.getQuery("DEL_MR_COLDWTRBASPRC"));
					
					sql.setString(i++, mi3.getString("CWTR_KIND_CD"));
					sql.setString(i++, mi3.getString("SEQ"));
				}
				
				res = update(sql);

				if (res != 1) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여 데이터 입력을 하지 못했습니다.");
				} 
				ret += res;
			}
			
			/**
			 * 냉수-사용요금  등록/수정
			 */
			while (mi4.next()) {
				i = 1;
				sql.close();
				
				// 냉수-사용요금  저장/수정
				if (mi4.IS_UPDATE()) {
					
					sql.put(svc.getQuery("UPD_MR_COLDWTRPRC"));
					
	                sql.setString(i++, mi4.getString("CWTR_KIND_CD"));
		            sql.setString(i++, mi4.getString("TIME_ZONE"));
					sql.setString(i++, mi4.getString("APP_S_MM"));
					sql.setString(i++, mi4.getString("APP_E_MM"));
					sql.setString(i++, mi4.getString("APP_S_HH"));
					sql.setString(i++, mi4.getString("APP_E_HH"));
					sql.setString(i++, mi4.getString("UNIT_PRC"));
					sql.setString(i++, userId);
					sql.setString(i++, userId);
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
