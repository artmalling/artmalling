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

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>평가항목배점관리/p>
 * 
 * @created  on 1.0, 2011/06/23
 * @created  by 김경은
 * 
 * @modified on 
 * @modified by                    
 * @caused   by           
 */

public class PSal701DAO extends AbstractDAO {
	/**
	 * 평가항목배점관리  리스트 조회
	 *       
	 * @param form   
	 * @return
	 * @throws Exception
	 */
	public List getList(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;          

		String strStrCd       = String2.nvl(form.getParam("strStrCd"));   
		String strEvaluYm     = String2.nvl(form.getParam("strEvaluYm"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_LIST"));     
		sql.setString(i++, strStrCd);  
		sql.setString(i++, strEvaluYm);
	
		ret = select2List(sql);
		return ret;
	}
	/**
	 * 평가항목배점관리  데이터 조회
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
		String strEvaluYm    = String2.nvl(form.getParam("strEvaluYm"));  
		String strVenEvaluCd = String2.nvl(form.getParam("strVenEvaluCd"));  
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_MASTER"));     
		sql.setString(i++, strStrCd); 
		sql.setString(i++, strEvaluYm); 
		sql.setString(i++, strVenEvaluCd); 

		ret = select2List(sql);
		return ret;
	}
	

	/**
	 *  평가항목배점관리 등록/수정 한다.
	 * 
	 * @param form
	 * @param mi1
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi1, String userId, String org_flag)
			throws Exception {

		int ret 	= 0;
		int res 	= 0;
		int i   	= 0;
		
		SqlWrapper sql = null;
		Service svc    = null;

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
					// 마스터테이블에 저장
					sql.put(svc.getQuery("INS_MASTER"));
					
					sql.setString(i++, mi1.getString("STR_CD"));   	 		 // 점코드 
					sql.setString(i++, mi1.getString("EVALU_YM"));       	 // 평가년월 
					sql.setString(i++, mi1.getString("VEN_EVALU_CD"));   	 // 평가항목코드 
					sql.setString(i++, mi1.getString("VEN_EVALU_NAME"));   	 // 평가항목명
					sql.setString(i++, mi1.getString("ALLOT_SCORE"));   	 // 배점
					sql.setString(i++, mi1.getString("ALLOC_BASE"));   	 	 // 점수부여기준 
					sql.setString(i++, userId); 
					sql.setString(i++, userId); 

				}else if(mi1.IS_UPDATE()){// 수정

					i = 1;        
					sql.put(svc.getQuery("UPD_MASTER"));                               
                    
					sql.setString(i++, mi1.getString("VEN_EVALU_NAME"));   	 // 평가항목명
					sql.setString(i++, mi1.getString("ALLOT_SCORE"));   	 // 배점
					sql.setString(i++, mi1.getString("ALLOC_BASE"));   	 	 // 점수부여기준 
					sql.setString(i++, userId); 
					sql.setString(i++, mi1.getString("STR_CD"));   	 		 // 점코드 
					sql.setString(i++, mi1.getString("EVALU_YM"));       	 // 평가년월 
					sql.setString(i++, mi1.getString("VEN_EVALU_CD"));   	 // 평가항목코드 
				}

				res = update(sql);

					
				if (res <= 0) {
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
	 *  평가항목배점관리  삭제한다.
	 * 
	 * @param form
	 * @param mi1
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int delete(ActionForm form, MultiInput mi1, String userId, String org_flag)
			throws Exception {
		int ret 			= 0;
		int res 			= 0;
		int i   			= 0;
		
		SqlWrapper sql = null;
		Service svc    = null;

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			// 마스터
			while (mi1.next()) {
				sql.close();
				if(mi1.IS_DELETE()){// 삭제
					sql.put(svc.getQuery("DEL_MASTER"));  

					i = 1;        
					sql.setString(i++, mi1.getString("STR_CD"));   	 		 // 점코드 
					sql.setString(i++, mi1.getString("EVALU_YM"));       	 // 평가년월 
					sql.setString(i++, mi1.getString("VEN_EVALU_CD"));   	 // 평가항목코드 
				}

				res = update(sql);
				if (res  < 0) {
					throw new Exception("[USER]"+ "데이터의 적합성 문제로 인하여"
							+ "데이터 삭제를 하지 못했습니다.");
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
	 *  평가항목배점관리  전월내역복사 한다.
	 * 
	 * @param form
	 * @param mi1
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int copy(ActionForm form, MultiInput mi1, String userId, String org_flag)
			throws Exception {
		int ret 			= 0;
		int res 			= 0;
		int i   			= 0;
		
		SqlWrapper sql = null;
		Service svc    = null;

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strStrCd       = String2.nvl(form.getParam("strStrCd"));   
			String strEvaluYm     = String2.nvl(form.getParam("strEvaluYm"));
			
			sql.close();
			sql.put(svc.getQuery("INS_MASTER_COPY"));  

			i = 1; 
			sql.setString(i++, strEvaluYm);       	     // 평가년월 
			sql.setString(i++, userId); 
			sql.setString(i++, userId); 
			sql.setString(i++, strStrCd);   	 		 // 점코드 
			sql.setString(i++, strEvaluYm);       	     // 평가년월 

			res = update(sql);
			if (res  < 0) {
				throw new Exception("[USER]"+ "전월내역복사를 하지 못했습니다.");
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
	 * 평가항목배점 확정여부
	 *       
	 * @param form   
	 * @return
	 * @throws Exception
	 */
	public List confCheck(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;          

		String strStrCd       = String2.nvl(form.getParam("strStrCd"));   
		String strEvaluYm     = String2.nvl(form.getParam("strEvaluYm"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_CONF_CHECK"));     
		sql.setString(i++, strStrCd);  
		sql.setString(i++, strEvaluYm);
	
		ret = select2List(sql);
		return ret;
	}
}
