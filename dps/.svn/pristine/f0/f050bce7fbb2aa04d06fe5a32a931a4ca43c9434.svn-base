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
 * <p>바이어 평가등록/p>
 * 
 * @created  on 1.0, 2011/06/25
 * @created  by 김경은
 * 
 * @modified on 
 * @modified by                    
 * @caused   by           
 */

public class PSal704DAO extends AbstractDAO {
	/**
	 * 바이어 평가등록  데이터 조회
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
		String strBumun      = String2.nvl(form.getParam("strBumun"));
		String strTeam       = String2.nvl(form.getParam("strTeam"));
		String strPc         = String2.nvl(form.getParam("strPc"));
		String strOrgCd      = String2.nvl(form.getParam("strOrgCd"));
		String strEvaluYm    = String2.nvl(form.getParam("strEvaluYm"));
		String strBizType    = String2.nvl(form.getParam("strBizType"));  
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_MASTER"));     
		sql.setString(i++, strEvaluYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEvaluYm);
		sql.setString(i++, strStrCd);  
		sql.setString(i++, strEvaluYm);
		sql.setString(i++, strStrCd);  
		sql.setString(i++, strEvaluYm);
		sql.setString(i++, strOrgCd); 
		
		sql.setString(i++, strStrCd); 
		sql.setString(i++, strEvaluYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEvaluYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEvaluYm);
		sql.setString(i++, strStrCd); 
		sql.setString(i++, strOrgCd); 
		sql.setString(i++, strBizType);
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, userId); 

		ret = select2List(sql);
		return ret;
	}
	

	/**
	 *  바이어 평가등록/수정 한다.
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
					sql.setString(i++, mi1.getString("PUMBUN_CD"));   	 	 // 품번 
					
					sql.setString(i++, mi1.getString("ORG_CD"));   	 		 // 조직코드
					sql.setString(i++, mi1.getString("AREA_SIZE"));   	 	 // 면적
					sql.setString(i++, mi1.getString("PUMBUN_GRADE"));   	 // 등급
					sql.setString(i++, mi1.getString("PUMBUN_WEIGHT"));   	 // 가중치 
					sql.setString(i++, userId); 
					
					sql.setString(i++, mi1.getString("STR_CD"));   	 		 // 점코드 
					sql.setString(i++, mi1.getString("EVALU_YM"));       	 // 평가년월 
					sql.setString(i++, mi1.getString("PUMBUN_CD"));   	 	 // 품번 
					sql.setString(i++, mi1.getString("ORG_CD"));   	 		 // 조직코드
					sql.setString(i++, mi1.getString("AREA_SIZE"));   	 	 // 면적
					sql.setString(i++, mi1.getString("PUMBUN_GRADE"));   	 // 등급
					sql.setString(i++, mi1.getString("PUMBUN_WEIGHT"));   	 // 가중치 
					sql.setString(i++, userId); 
					sql.setString(i++, userId); 

				}else if(mi1.IS_UPDATE()){// 수정

					i = 1;        
					sql.put(svc.getQuery("UPD_MASTER"));                               
                    
					sql.setString(i++, mi1.getString("AREA_SIZE"));   	 	 // 면적
					sql.setString(i++, mi1.getString("PUMBUN_GRADE"));   	 // 등급
					sql.setString(i++, mi1.getString("PUMBUN_WEIGHT"));   	 // 가중치 
					sql.setString(i++, userId); 
					sql.setString(i++, mi1.getString("STR_CD"));   	 		 // 점코드 
					sql.setString(i++, mi1.getString("EVALU_YM"));       	 // 평가년월 
					sql.setString(i++, mi1.getString("PUMBUN_CD"));   	 	 // 품번 
				}

				res = update(sql);

				// 상세 데이터를 저장한다.
				saveDetail(form, mi1, userId);
				
					
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
	 *  상세데이터를 저장한다.
	 *  
	 * @param mi1
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public int saveDetail(ActionForm form, MultiInput mi1, String userId) 
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

			// 상세
			sql.close();
			i = 1; 
			// 2. 상세테이블에 저장
			sql.put(svc.getQuery("INS_DETAIL"));
			
			sql.setString(i++, mi1.getString("STR_CD"));           
			sql.setString(i++, mi1.getString("EVALU_YM"));   				
			sql.setString(i++, mi1.getString("PUMBUN_CD"));   		
			sql.setString(i++, "06");						/* 바이어평가 */
			
			sql.setString(i++, mi1.getString("EVALU_SCORE"));   			  
			sql.setString(i++, userId);
			
			sql.setString(i++, mi1.getString("STR_CD"));           
			sql.setString(i++, mi1.getString("EVALU_YM"));   				
			sql.setString(i++, mi1.getString("PUMBUN_CD"));   		
			sql.setString(i++, "06");   					/* 바이어평가 */
			sql.setString(i++, mi1.getString("EVALU_SCORE"));   					
			sql.setString(i++, userId); 
			sql.setString(i++, userId);                 

			res = update(sql);
			
			if(ret == 0){
				ret = res;        
			}
			
			if (res != 1) {
				throw new Exception("[USER]"+ "데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
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
	 *  바이어 평가등록  전월내역복사 한다.
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
			
			String strStrCd      = String2.nvl(form.getParam("strStrCd"));
			String strBumun      = String2.nvl(form.getParam("strBumun"));
			String strTeam       = String2.nvl(form.getParam("strTeam"));
			String strPc         = String2.nvl(form.getParam("strPc"));
			String strOrgCd      = String2.nvl(form.getParam("strOrgCd"));
			String strEvaluYm    = String2.nvl(form.getParam("strEvaluYm"));
			
			sql.close();
			sql.put(svc.getQuery("INS_MASTER_COPY"));  

			i = 1; 
			sql.setString(i++, strEvaluYm);       	     // 평가년월 
			sql.setString(i++, userId); 
			sql.setString(i++, userId); 
			
			sql.setString(i++, strStrCd);   	 		 // 점코드 
			sql.setString(i++, strEvaluYm);       	     // 평가년월
			sql.setString(i++, strOrgCd);       	     // 조직코드 
			sql.setString(i++, strStrCd);   	 		 // 점코드 
			sql.setString(i++, userId);
			res = update(sql);
			
			if (res  < 0) {
				throw new Exception("[USER]"+  "전월내역복사를 하지 못했습니다.");
			}      
			
			sql.close();
			sql.put(svc.getQuery("INS_DETAIL_COPY"));  

			i = 1; 
			sql.setString(i++, strEvaluYm);       	     // 평가년월 
			sql.setString(i++, userId); 
			sql.setString(i++, userId); 
			
			sql.setString(i++, strStrCd);   	 		 // 점코드 
			sql.setString(i++, strEvaluYm);       	     // 평가년월
			sql.setString(i++, strOrgCd);       	     // 조직코드 
			sql.setString(i++, strStrCd);   	 		 // 점코드 
			sql.setString(i++, userId);
			res = update(sql);
			
			if (res  < 0) {
				throw new Exception("[USER]"+  "전월내역복사를 하지 못했습니다.");
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
	
	/**
	 * 바이어 평가등록  데이터 조회
	 *       
	 * @param form   
	 * @return
	 * @throws Exception
	 */
	public List valCheck(ActionForm form, String userId, String org_flag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;          

		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strBumun      = String2.nvl(form.getParam("strBumun"));
		String strTeam       = String2.nvl(form.getParam("strTeam"));
		String strPc         = String2.nvl(form.getParam("strPc"));
		String strOrgCd      = String2.nvl(form.getParam("strOrgCd"));
		String strEvaluYm    = String2.nvl(form.getParam("strEvaluYm"));  
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_VALCHECK"));     
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEvaluYm);
		sql.setString(i++, strOrgCd);
		sql.setString(i++, strStrCd);
		sql.setString(i++, userId);  

		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * DEL_MASTER  배점 조회
	 *       
	 * @param form   
	 * @return
	 * @throws Exception
	 */
	public List getAllotScore(ActionForm form, String userId, String org_flag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;          

		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strEvaluYm    = String2.nvl(form.getParam("strEvaluYm"));  
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_ALLOT_SCORE"));     
		sql.setString(i++, strStrCd);  
		sql.setString(i++, strEvaluYm);

		ret = select2List(sql);
		return ret;
	}
}
