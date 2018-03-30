/*
 * Copyright (c) 2010 한국후지쯔 All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package ppay.dao;

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
 * <p>세금계산서 발행기간 설정</p>
 * 
 * @created  on 1.0, 2010/04/07
 * @created  by 김경은
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PPay101DAO extends AbstractDAO {

	/**
	 * 세금계산서 발행기간 설정 내역 조회
	 *       
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMaster(ActionForm form, String userId, String org_flag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;               
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strYyyymm     = String2.nvl(form.getParam("strYyyymm"));
		String strPayCyc     = String2.nvl(form.getParam("strPayCyc"));
		String strPayCnt     = String2.nvl(form.getParam("strPayCnt"));
		String strSaleSdt    = String2.nvl(form.getParam("strSaleSdt"));
		String strSaleEdt    = String2.nvl(form.getParam("strSaleEdt"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_MASTER"));
		sql.setString(i++, strStrCd);
		sql.setString(i++, strYyyymm);          
		sql.setString(i++, strPayCyc);
		sql.setString(i++, strPayCnt);
      	                      
		ret = select2List(sql);
		System.out.println("search::"+ret);
		return ret;
		
		
	}
	
	/**
	 *  세금계산서 발행기간 설정  등록/수정한다.
	 * 
	 * @param form
	 * @param mi1
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi1,String userId, String org_flag)
			throws Exception {

		int ret 	= 0;
		int res 	= 0;
		int i   	= 0;

		SqlWrapper sql = null;
		Service svc = null;

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			// 마스터
			while (mi1.next()) {
				
				sql.close();
				if (mi1.IS_INSERT()) { // 저장

					i = 1; 
					// 1. 마스터테이블에 저장
					sql.put(svc.getQuery("INS_MASTER"));
					
					sql.setString(i++, mi1.getString("STR_CD"));  
					sql.setString(i++, mi1.getString("PAY_YM"));             
					sql.setString(i++, mi1.getString("PAY_CYC"));     
					sql.setString(i++, mi1.getString("PAY_CNT"));                        
					sql.setString(i++, mi1.getString("ISSUE_S_DT"));
					sql.setString(i++, mi1.getString("ISSUE_E_DT"));  
					sql.setString(i++, mi1.getString("TERM_S_DT"));
					sql.setString(i++, mi1.getString("TERM_E_DT"));
					sql.setString(i++, userId);       
					sql.setString(i++, userId);

				}else if(mi1.IS_UPDATE()){// 수정

					i = 1;
					// 1. 마스터테이블에 수정
					sql.put(svc.getQuery("UPD_MASTER")); 
					
					sql.setString(i++, mi1.getString("ISSUE_S_DT"));
					sql.setString(i++, mi1.getString("ISSUE_E_DT"));  
					sql.setString(i++, mi1.getString("TERM_S_DT"));
					sql.setString(i++, mi1.getString("TERM_E_DT"));
					sql.setString(i++, userId);
					sql.setString(i++, mi1.getString("STR_CD"));  
					sql.setString(i++, mi1.getString("PAY_YM"));             
					sql.setString(i++, mi1.getString("PAY_CYC"));     
					sql.setString(i++, mi1.getString("PAY_CNT"));  

				}else if (mi1.IS_DELETE()) { // 삭제
					i = 1; 
					// 1. 마스터테이블에 저장
					sql.put(svc.getQuery("DEL_MASTER"));               
					sql.setString(i++, mi1.getString("STR_CD")); 
					sql.setString(i++, mi1.getString("PAY_YM"));             
					sql.setString(i++, mi1.getString("PAY_CYC"));     
					sql.setString(i++, mi1.getString("PAY_CNT"));
				}
				res = update(sql);

				if (res <= 0) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
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
	 *  세금계산서 발행기간 설정  삭제한다.
	 * 
	 * @param form
	 * @param mi1
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int delete(ActionForm form, MultiInput mi1,String userId)
			throws Exception {

		int ret 	= 0;
		int res 	= 0;
		int i   	= 0;

		SqlWrapper sql = null;
		Service svc = null;

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			while (mi1.next()) {
				sql.close();
				if (mi1.IS_DELETE()) { // 삭제
					i = 1; 
					// 1. 마스터테이블에 저장
					sql.put(svc.getQuery("DEL_MASTER"));               
					sql.setString(i++, mi1.getString("STR_CD")); 
					sql.setString(i++, mi1.getString("PAY_YM"));             
					sql.setString(i++, mi1.getString("PAY_CYC"));     
					sql.setString(i++, mi1.getString("PAY_CNT"));
				}
				res = update(sql);

				if (res <= 0) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
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
	
}
