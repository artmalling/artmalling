/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pstk.dao;

import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>재고실사일정관리</p>
 * 
 * @created  on 1.0, 2010/03/31
 * @created  by 이재득(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PStk201DAO extends AbstractDAO {


	/**
	 * 재고실사일정을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form , String userId , String orgFlag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd  = String2.nvl(form.getParam("strStrCd"));
		String strStkSYm = String2.nvl(form.getParam("strStkSYm"));
		String strStkEYm = String2.nvl(form.getParam("strStkEYm"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		//sql.setString(i++, strStrCd);
		
		sql.setString(i++, userId);
		sql.setString(i++, orgFlag);
		sql.setString(i++, strStrCd);
		
		strQuery = svc.getQuery("SEL_SCHEDULE") + "\n";
		
		if( !strStkSYm.equals("")){
			sql.setString(i++, strStkSYm);
			strQuery += svc.getQuery("SEL_SCHEDULE_WHERE_STK_S_YM") + "\n";
		}
		if( !strStkEYm.equals("")){
			sql.setString(i++, strStkEYm);
			strQuery += svc.getQuery("SEL_SCHEDULE_WHERE_STK_E_YM") + "\n";
		}

		strQuery += svc.getQuery("SEL_SCHEDULE_ORDER");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 재고실사일정을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchOverLap(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		String orgCdCnt = "";
		int i = 1;	
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strStkYm = String2.nvl(form.getParam("strStkYm"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkYm);
		
		strQuery = svc.getQuery("SEL_SCHEDULE_STRCD_CNT") + "\n";
		
		sql.put(strQuery);		

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 조직정보,
	 * 바이어 보,
	 * 바이어 조직정보
	 * 
	 * 저장, 수정  처리한다.
	 * 
	 * @param form
	 * @param mi[]
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi[], String strID)
			throws Exception {

		int ret = 0;
		try {
			connect("pot");
			begin();
			 
			for(int idx = 0 ; idx < 3 ; idx++){
				// Schedule
				if( idx == 0){
					ret = saveSchedule(form, mi[idx], strID);
				//Bigo
				}else if ( idx == 1){
					saveBigo(form, mi[idx], strID);
					
				//Noti
				}else if ( idx == 2){
					System.out.println("@@@@@@@@@@@@@@@@@@@");
					//saveNoti(form, mi[idx], strID);
								
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

	/**
	 * 재고실사일정을  저장, 수정  처리한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int saveSchedule(ActionForm form, MultiInput mi, String strID)
			throws Exception {

		int ret = 0;
		int res = 0;		
		SqlWrapper sql = null;
		Service svc = null;	
		String orgCdCnt = "";
		int i;
		try {
			if( getTrConnection() == null){
				connect("pot");
				begin();
			}
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			while (mi.next()) {
				sql.close();
				
				if (mi.IS_INSERT()) {
					i = 0;
					sql.put(svc.getQuery("SEL_SCHEDULE_STRCD_CNT"));							
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("STK_YM"));
					Map map = selectMap( sql );							
					orgCdCnt = String2.nvl((String)map.get("CNT"));
					if( !orgCdCnt.equals("0")) {
						throw new Exception("[USER]"+"중복된 데이터가 있습니다.");
					}
					sql.close();
					
					i = 0;
					sql.put(svc.getQuery("SEL_SCHEDULE_SRVY_DT_CNT"));
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("SRVY_S_DT"));
					sql.setString(++i, mi.getString("SRVY_E_DT"));
					Map map1 = selectMap( sql );							
					orgCdCnt = String2.nvl((String)map1.get("CNT"));
					if( !orgCdCnt.equals("0")) {
						throw new Exception("[USER]"+"중복된 데이터가 있습니다.");
					}
					sql.close();

					i = 0;					
					sql.put(svc.getQuery("INS_SCHEDULE"));
					
					sql.setString(++i, mi.getString("STR_CD"));	
					sql.setString(++i, mi.getString("STK_YM"));
					sql.setString(++i, mi.getString("STK_FLAG"));
					sql.setString(++i, mi.getString("SRVY_DT"));
					sql.setString(++i, mi.getString("SRVY_S_DT"));
					sql.setString(++i, mi.getString("SRVY_E_DT"));
					sql.setString(++i, strID);
					sql.setString(++i, strID);
					sql.setString(++i, mi.getString("STK_S_DT"));
					sql.setString(++i, mi.getString("STK_E_DT"));
					sql.setString(++i, mi.getString("LOSS_APP_DATE"));
					
					
				} else if (mi.IS_UPDATE()) {
					i = 0;
					/*
					sql.put(svc.getQuery("SEL_SCHEDULE_UPD_CNT"));							
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("STK_YM"));
					sql.setString(++i, mi.getString("STK_FLAG"));
					sql.setString(++i, mi.getString("SRVY_DT"));
					sql.setString(++i, mi.getString("SRVY_S_DT"));
					sql.setString(++i, mi.getString("SRVY_E_DT"));
					Map map = selectMap( sql );							
					orgCdCnt = String2.nvl((String)map.get("CNT"));
					if( !orgCdCnt.equals("0")) {
						throw new Exception("[USER]"+"중복된 데이터가 있습니다.");
					}
					sql.close();
					*/
					i = 0;
										
					sql.put(svc.getQuery("UPD_SCHEDULE"));					

					sql.setString(++i, mi.getString("STR_CD"));	
					sql.setString(++i, mi.getString("STK_YM"));
					sql.setString(++i, mi.getString("STK_FLAG"));
					sql.setString(++i, mi.getString("SRVY_DT"));
					sql.setString(++i, mi.getString("SRVY_S_DT"));
					sql.setString(++i, mi.getString("SRVY_E_DT"));
					sql.setString(++i, strID);
					sql.setString(++i, mi.getString("STK_S_DT"));
					sql.setString(++i, mi.getString("STK_E_DT"));
					sql.setString(++i, mi.getString("LOSS_APP_DATE"));

					sql.setString(++i, mi.getString("OLD_STR_CD"));
					sql.setString(++i, mi.getString("STK_YM"));
					
				} 
				
				res = update(sql);

				if (res != 1) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				ret += res;
			}

		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			if( getTrConnection() == null)
				end();
		}
		return ret;
	}
	
	/**
	 * 재고실사일정을  저장, 수정  처리한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int saveBigo(ActionForm form, MultiInput mi, String strID)
			throws Exception {

		int ret = 0;
		int res = 0;		
		SqlWrapper sql = null;
		Service svc = null;			
		int i;
		try {
			if( getTrConnection() == null){
				connect("pot");
				begin();
			}
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			String strBigo = URLDecoder.decode(String2.nvl(form.getParam("strBigo")), "UTF-8");

			while (mi.next()) {
				sql.close();
				
				if (mi.IS_INSERT()) {
					i = 0;					
										
					//비고 입력
					
					sql.put(svc.getQuery("INS_SCHEDULEBIGO"));
					
					sql.setString(++i, mi.getString("STR_CD"));	
					sql.setString(++i, mi.getString("STK_YM"));
					sql.setString(++i, mi.getString("BIGO"));
					sql.setString(++i, strID);
					sql.setString(++i, strID);
				} else if (mi.IS_UPDATE()) {					
					i = 0;						
					
					sql.put(svc.getQuery("UPD_SCHEDULEBIGO"));
					sql.setString(++i, mi.getString("BIGO"));
					sql.setString(++i, mi.getString("STR_CD"));	
					sql.setString(++i, mi.getString("STK_YM"));				
					
				} 
				
				res = update(sql);

				if (res != 1) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				ret += res;
			}

		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			if( getTrConnection() == null)
				end();
		}
		return ret;
	}
	
	/**
	 * 재고실사일정을  저장, 수정  처리한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int saveNoti(ActionForm form, MultiInput mi, String strID)
			throws Exception {
		System.out.println("##################################################");
		int ret = 0;
		int res = 0;		
		SqlWrapper sql = null;
		Service svc = null;			
		int i;
		try {
			if( getTrConnection() == null){
				connect("pot");
				begin();
			}
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			String strSendToAll = null;
			String strStkFlag   = null;
			//String strBigo = URLDecoder.decode(String2.nvl(form.getParam("strBigo")), "UTF-8");

			while (mi.next()) {
				sql.close();
				
				if (mi.IS_INSERT()) {
					i = 0;					
										
					//비고 입력
					
					sql.put(svc.getQuery("INS_NOTI"));
					
					if(mi.getString("STK_FLAG").equals("2")){
						strSendToAll = "N";
						strStkFlag   = "수시";
					}else if(mi.getString("STK_FLAG").equals("1")){
						strSendToAll = "Y";
						strStkFlag   = "정기";
					}
					
					sql.setString(++i, strStkFlag);					
					sql.setString(++i, mi.getString("BIGO"));
					sql.setString(++i, mi.getString("SRVY_S_DT"));
					sql.setString(++i, mi.getString("SRVY_E_DT"));
					//sql.setString(++i, strSendToAll);
					sql.setString(++i, strID);
					sql.setString(++i, strID);
				} 
				else if (mi.IS_UPDATE()){
					return 0;
				}
				res = update(sql);

				if (res != 1) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				ret += res;
			}

		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			if( getTrConnection() == null)
				end();
		}
		return ret;
	}
	
	/**
	 *  <p>
	 *  재고실사일정을 삭제한다.
	 *  
	 *  </p>
	 * @param form
	 * @param mi
	 * @param 
	 * @return
	 * @throws Exception
	 */
	public int delete(ActionForm form, MultiInput mi) 
						throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		int i;
		try {
			connect("pot");
			begin();	
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			while (mi.next()) {
				res = 0;
				sql.close();
				if ( mi.IS_DELETE()){
					i = 0;				
					sql.put(svc.getQuery("DEL_SCHEDULE"));
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("STK_YM"));	
					sql.setString(++i, mi.getString("STK_FLAG"));	
					sql.setString(++i, mi.getString("SRVY_DT"));	
					sql.setString(++i, mi.getString("SRVY_S_DT"));	
					sql.setString(++i, mi.getString("SRVY_E_DT"));					

					res = update(sql);	
				} 

				if (res < 1) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
							+ "데이터를 처리 하지 못했습니다.");
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
	 *  <p>
	 *  재고실사일정을 삭제한다.
	 *  
	 *  </p>
	 * @param form
	 * @param mi
	 * @param 
	 * @return
	 * @throws Exception
	 */
	public int deleteBigo(ActionForm form, MultiInput mi) 
						throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		int i;
		try {
			connect("pot");
			begin();	
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			while (mi.next()) {
				res = 0;
				sql.close();
				if ( mi.IS_DELETE()){
					i = 0;				
					sql.put(svc.getQuery("DEL_SCHEDULEBIGO"));
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("STK_YM"));				

					res = update(sql);	
				} 

				if (res < 1) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
							+ "데이터를 처리 하지 못했습니다.");
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
