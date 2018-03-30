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
//import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PSal533DAO extends AbstractDAO {

	/**
	 * 마스터 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form, String OrgFlag, String userid) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		int i 			= 1;

		
		String strStrCd 		  = String2.nvl(form.getParam("strStrCd"));
		String strSaleYm 		  = String2.nvl(form.getParam("strSaleYm"));
		String strOriginAreaCd 	  = String2.nvl(form.getParam("strOriginAreaCd"));
		String strOriginAreaName  = String2.nvl(form.getParam("strOriginAreaName"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_MASTER"));
		sql.setString(i++, strSaleYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strOriginAreaCd);
		
		sql.setString(i++, strSaleYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strOriginAreaCd);
	
		ret = select2List(sql);
		
		return ret;
	}


	/**
	 * 디테일조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDitail(ActionForm form, String OrgFlag, String userid) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		int i 			= 1;

		
		String strStrCd 		  = String2.nvl(form.getParam("strStrCd"));
		String strSaleYm 		  = String2.nvl(form.getParam("strSaleYm"));
		String strOriginAreaCd 	  = String2.nvl(form.getParam("strOriginAreaCd"));
		String strOriginAreaName  = String2.nvl(form.getParam("strOriginAreaName"));
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("SEL_DITAIL"));
		sql.setString(i++, strSaleYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strOriginAreaCd);
	
		ret = select2List(sql);
		
		return ret;
	}


	
	/**
	 * 공제등록 조회 
	 *        
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List checkKeyVlaue(ActionForm form, String userId, String org_flag) throws Exception {
		
		List ret       = null;
		SqlWrapper sql = null;
		Service svc    = null;
		int i = 1;               
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strSaleYm = String2.nvl(form.getParam("strSaleYm"));
		String strOrdererCd = String2.nvl(form.getParam("strOrdererCd"));
		String strDedCd = String2.nvl(form.getParam("strDedCd"));
		
		sql = new SqlWrapper(); 
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("CHECK_JUNGBOK"));
		sql.setString(i++, strSaleYm);
		sql.setString(i++, strStrCd);	
		sql.setString(i++, strOrdererCd);	
		sql.setString(i++, strDedCd);	
      	                      
		ret = select2List(sql);
		return ret;
	}	
	/**
	 * 공제등록 조회 
	 *        
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List setVatXYN(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;               
		
		String strReasonCd      = String2.nvl(form.getParam("strReasonCd"));
		sql = new SqlWrapper(); 
		svc = (Service) form.getService();
		connect("pot");
		sql.put(svc.getQuery("SEL_VATXYN"));
		sql.setString(i++, strReasonCd);
      	                      
		ret = select2List(sql);
		return ret;
	}	
	/**
	 *  공제등록  등록/수정한다.
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

		String strSeqNo   = "";		// 순번
		String strSlipNo  = "";     // 전표번호		
		String strYYYYMM  = String2.nvl(form.getParam("strYYYYMM"));
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			// 마스터
			while (mi1.next()) {
				sql.close();
				
				if (mi1.IS_INSERT()) { // 저장
					// 2.전표번호를 생성한다.(MAX+1 이용)
					
						sql.put(svc.getQuery("SEL_SEQ_NO"));	
						
						Map mapSeqNo = (Map)selectMap(sql);
						strSeqNo= mapSeqNo.get("SEQ_NO").toString();
						mi1.setString("SEQ_NO", strSeqNo);
						
						sql.close();		
						i = 1; 
						// 1. 마스터테이블에 저장
						
						sql.put(svc.getQuery("INS_MASTER"));
						 
						sql.setString(i++, mi1.getString("SALE_YM"));  
						sql.setString(i++, mi1.getString("STR_CD"));             
						sql.setString(i++, mi1.getString("ORDERER_CD"));     
						sql.setString(i++, mi1.getString("SEQ_NO"));     
						sql.setString(i++, mi1.getString("DED_CD"));
						sql.setString(i++, mi1.getString("INPUT_AMT"));
						sql.setString(i++, mi1.getString("SUP_AMT"));        // 순번만들기
						sql.setString(i++, mi1.getString("VAT_YN"));                      // 전표번호 조합하기
						sql.setString(i++, mi1.getString("VAT_AMT"));     
						sql.setString(i++, mi1.getString("ETC"));     
						sql.setString(i++, "N");    
						sql.setString(i++, ""); 
						sql.setString(i++, userId);
						sql.setString(i++, userId);
					
				}else if(mi1.IS_UPDATE()){// 수정 
					i = 1;
					// 1. 마스터테이블에 수정
					sql.put(svc.getQuery("UPD_MASTER")); 
				      
					sql.setString(i++, mi1.getString("DED_CD"));
					sql.setString(i++, mi1.getString("INPUT_AMT"));  
					sql.setString(i++, mi1.getString("SUP_AMT"));    
					sql.setString(i++, mi1.getString("VAT_YN")); 
					sql.setString(i++, mi1.getString("VAT_AMT")); 
					sql.setString(i++, mi1.getString("ETC"));  
					sql.setString(i++, userId);
					sql.setString(i++, mi1.getString("SALE_YM"));  
					sql.setString(i++, mi1.getString("STR_CD"));             
					sql.setString(i++, mi1.getString("ORDERER_CD"));     
					sql.setString(i++, mi1.getString("SEQ_NO")); 

				}else if (mi1.IS_DELETE()) { // 삭제 
					i = 1;  
					// 1. 마스터테이블에 저장
					sql.put(svc.getQuery("DEL_MASTER"));            
					sql.setString(i++, mi1.getString("SALE_YM"));  
					sql.setString(i++, mi1.getString("STR_CD"));             
					sql.setString(i++, mi1.getString("ORDERER_CD"));     
					sql.setString(i++, mi1.getString("SEQ_NO")); 
					
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
	 *  공제등록  삭제한다.
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
					sql.setString(i++, mi1.getString("VEN_CD"));
					sql.setString(i++, mi1.getString("DED_VEN_CD"));
					sql.setString(i++, mi1.getString("SEQ_NO"));
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
