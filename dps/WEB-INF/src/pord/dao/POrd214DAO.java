/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pord.dao;

import java.util.List;
import java.util.Map;

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;


/**
 * <p>예제  DAO</p>
 * 
 * @created  on 1.0, 2010/01/13
 * @created  by 정진영(FKSS)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class POrd214DAO extends AbstractDAO {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
    
    /**
     * 예제 
     *
     * @param  : 
     * @return :
     */
	/**
	 * 물품 입고/반품 마스터 내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMaster(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strBizType = String2.nvl(form.getParam("strBizType"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strBizType);
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.put(strQuery);
		ret = select2List(sql);
		//System.out.println("ret.size()= " + ret.size());
		return ret;
	}
	
	/**
	 * 물품 입고/반품 상세 내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getDetail(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strBizType = String2.nvl(form.getParam("strBizType"));
		String strSlipFlag = String2.nvl(form.getParam("strSlipFlag"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strBizType);
		sql.setString(i++, strSlipFlag);

		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		sql.put(strQuery);
		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 발주결재라인관리 마스터 저장
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int saveMaster(ActionForm form, MultiInput mi, String userId)
			throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			while (mi.next()) {
				
				sql.close();
				int i = 1;
				
				sql.put(svc.getQuery("INS_MASTER")); 				
				sql.setString(i++, mi.getString("BIZ_TYPE"));
				sql.setString(i++, mi.getString("SLIP_FLAG"));
				sql.setString(i++, mi.getString("APP_S_DT"));
				sql.setString(i++, mi.getString("APP_E_DT"));
				sql.setString(i++, mi.getString("ORD_REG_YN"));
				sql.setString(i++, mi.getString("SM_CONF_YN"));
				sql.setString(i++, mi.getString("STEAM_CONF_YN"));
				sql.setString(i++, mi.getString("STR_CONF_YN"));
				sql.setString(i++, mi.getString("BUYER_CONF_YN"));
				sql.setString(i++, mi.getString("ACC_CONF_YN"));
				sql.setString(i++, mi.getString("BTEAM_CONF_YN"));
				sql.setString(i++, mi.getString("CHK_CONF_YN"));
				sql.setString(i++, userId);
				sql.setString(i++, userId);
				
				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
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
	 *  발주결재라인관리 디테일
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int saveDetail(ActionForm form, MultiInput mi, String userId)
			throws Exception {

		int ret = 0;
		int res = 0;
		int res2= 0;
		int res3= 0;
		int res4= 0;
		SqlWrapper sql = null;
		Service svc = null;

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			while (mi.next()) {	
				int i = 1;
				sql.close();
				
				String strPreAppEDt	= String2.nvl(form.getParam("strPreAppEDt"));		//저장할 데이터의 원래 적용시작일
				
				if (mi.IS_INSERT()) {		// 입력
				
					sql.put(svc.getQuery("INS_DETAIL")); 				
					sql.setString(i++, mi.getString("BIZ_TYPE"));
					sql.setString(i++, mi.getString("SLIP_FLAG"));
					sql.setString(i++, mi.getString("APP_S_DT"));
					sql.setString(i++, mi.getString("APP_E_DT"));
					sql.setString(i++, mi.getString("ORD_REG_YN"));
					sql.setString(i++, mi.getString("SM_CONF_YN"));
					sql.setString(i++, mi.getString("STEAM_CONF_YN"));
					sql.setString(i++, mi.getString("STR_CONF_YN"));
					sql.setString(i++, mi.getString("BUYER_CONF_YN"));
					sql.setString(i++, mi.getString("ACC_CONF_YN"));
					sql.setString(i++, mi.getString("BTEAM_CONF_YN"));
					sql.setString(i++, mi.getString("CHK_CONF_YN"));
					sql.setString(i++, userId);
					sql.setString(i++, userId);
					
					res = update(sql);								
				}else if(mi.IS_UPDATE()){	// 수정
					i = 1;
					sql.put(svc.getQuery("UPD_DETAIL_DATA"));
					sql.setString(i++, mi.getString("APP_S_DT"));
					sql.setString(i++, mi.getString("ORD_REG_YN"));
					sql.setString(i++, mi.getString("SM_CONF_YN"));
					sql.setString(i++, mi.getString("STEAM_CONF_YN"));
					sql.setString(i++, mi.getString("STR_CONF_YN"));
					sql.setString(i++, mi.getString("BUYER_CONF_YN"));
					sql.setString(i++, mi.getString("ACC_CONF_YN"));
					sql.setString(i++, mi.getString("BTEAM_CONF_YN"));
					sql.setString(i++, mi.getString("CHK_CONF_YN"));
					sql.setString(i++, userId);  						//수정일자, 수정자 아이디
					sql.setString(i++, mi.getString("BIZ_TYPE"));		//거래형태
					sql.setString(i++, mi.getString("SLIP_FLAG"));		//전표구분
//					sql.setString(i++, strPreAppEDt);					//수정전의  적용시작일
					sql.setString(i++, mi.getString("ROWID"));		    //로우아이디
					
					res2 = update(sql);
				}else if(mi.IS_DELETE()){	// 수정
					i = 1;
					
					sql.put(svc.getQuery("DEL_MASTER")); 					
					sql.setString(1, mi.getString("BIZ_TYPE"));
					sql.setString(2, mi.getString("SLIP_FLAG"));
					sql.setString(3, mi.getString("APP_S_DT"));
					sql.setString(4, "99991231");
					res3 = update(sql);
					
					if(res3 == 1){
						sql.close();
						sql.put(svc.getQuery("UPD_MASTER")); 		
						sql.setString(1, mi.getString("BIZ_TYPE"));
						sql.setString(2, mi.getString("SLIP_FLAG"));
						sql.setString(3, mi.getString("BIZ_TYPE"));
						sql.setString(4, mi.getString("SLIP_FLAG"));					
						res4 = update(sql);						
					}
				}				
				if (res == 1) {			// 입력시
					System.out.println("입력 들어온다");	
					ret += res;					
					updateDetail(form, mi, userId, "INS");
				} else if(res2 == 1){	// 수정시 
					System.out.println("수정 들어온다");
					ret += res2;
					updateDetail(form, mi, userId, "UPD");
				} else if(res3 == 1 || res3 == 2){	// 수정시 
					ret += res3;
				}else{
//					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
//							+ "데이터 입력을 하지 못했습니다.");
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
	 *  발주결재라인관리 디테일 적용종료일 업데이트
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int updateDetail(ActionForm form, MultiInput mi, String userId, String flag)
			throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;

		try {
			connect("pot");
			
			if( getTrConnection() == null){
				connect("pot");
				begin();
			}
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();

//			while (mi.next()) {
			sql.close();

			String strBizType	= "";		//거래형태
			String strSlipFlag	= "";		//전표구분
			String strAppSDt	= "";		//입력된 적용시작일
			String strAppEDt	= "";		//입력된 적용시작일에 대한 기존데이터의 작업종료일(신규시)			

			strBizType	= String2.nvl(form.getParam("strBizType"));			//거래형태
			strSlipFlag	= String2.nvl(form.getParam("strSlipFlag"));		//전표구분
			strAppSDt	= String2.nvl(form.getParam("strAppSDt"));			//입력된 적용시작일
			
			if(flag.equals("INS")){ 
				strAppEDt	= String2.nvl(form.getParam("strAppEDt"));		//입력된 적용시작일에 대한 기존데이터의 작업종료일(신규시)
			}else if(flag.equals("UPD")){
				strAppEDt   = String2.nvl(form.getParam("strCurAppSDt"));	//입력된 적용시작일에 대한 기존데이터의 작업종료일(저장시)
			}
			
			int i = 1;

			sql.put(svc.getQuery("UPD_BEFORE_DETAIL"));
			sql.setString(i++, strAppEDt);			
			sql.setString(i++, strBizType);
			sql.setString(i++, strSlipFlag);
			sql.setString(i++, strAppSDt);
			
			res = update(sql);
			
			if (res != 1 && res != 0) {
				throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
				+ "데이터 입력을 하지 못했습니다.");
			}
			
			ret += res;
//			}

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
	 * 물품 입고/반품 상세 내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMasterCount(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strBizType = String2.nvl(form.getParam("strBizType"));
		String strSlipFlag = String2.nvl(form.getParam("strSlipFlag"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strBizType);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
		sql.setString(i++, strSlipFlag);

		strQuery = svc.getQuery("SEL_COUNT_MASTER") + "\n";
		sql.put(strQuery);
		ret = select2List(sql);

		return ret;
	}		
	/**
	 * 물품 입고/반품 상세 내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getDetailCount(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strBizType = String2.nvl(form.getParam("strBizType"));
		String strSlipFlag = String2.nvl(form.getParam("strSlipFlag"));
		String strAppSDt = String2.nvl(form.getParam("strAppSDt"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strBizType);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
		sql.setString(i++, strSlipFlag);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
		sql.setString(i++, strAppSDt);

		strQuery = svc.getQuery("SEL_COUNT_DETAIL") + "\n";
		sql.put(strQuery);
		ret = select2List(sql);

		return ret;
	}
	
	/**
	 *  규격단품 매입발주  삭제한다.
	 * 
	 * @param form
	 * @param mi1
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int deleMaster(ActionForm form, MultiInput mi, String userId)
			throws Exception {
		int res = 0;
		int ret = 0;
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			while (mi.next()) {	
				sql.close();
				sql.put(svc.getQuery("DEL_MASTER")); 
					
				sql.setString(1, mi.getString("BIZ_TYPE"));
				sql.setString(2, mi.getString("SLIP_FLAG"));
				sql.setString(3, mi.getString("APP_S_DT"));
				sql.setString(4, "99991231");
				ret = update(sql);
				
				sql.close();
				sql.put(svc.getQuery("UPD_MASTER")); 
	
				sql.setString(1, mi.getString("BIZ_TYPE"));
				sql.setString(2, mi.getString("SLIP_FLAG"));
				sql.setString(3, mi.getString("BIZ_TYPE"));
				sql.setString(4, mi.getString("SLIP_FLAG"));
				res = update(sql);
	
				if (res  < 0) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 삭제를 하지 못했습니다.");
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
