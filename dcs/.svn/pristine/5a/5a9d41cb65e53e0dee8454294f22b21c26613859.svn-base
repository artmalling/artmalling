/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dvoc.dao;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import common.util.Util;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
 
/**
 * <p> 컴플레인 등록  DAO </p>
 * 
 * @created  on 1.0, 2016/11/28 
 * @created  by 윤지영
 * 
 * @modified on 
 * @modified by 
 * @caused   by  
 */

public class DVoc001DAO extends AbstractDAO {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DVoc001DAO.class);

	/**
	 * 컴플레인  조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String query = "";
		
		int i = 1; 
		
		String strJumCd    = String2.nvl(form.getParam("strJumCd"));
		String strFromDt   = String2.nvl(form.getParam("strFromDt"));
		String strToDt     = String2.nvl(form.getParam("strToDt"));
		String strClmKind  = String2.nvl(form.getParam("strClmKind"));
		String strProcGbn  = String2.nvl(form.getParam("strProcGbn"));
		String strCustNm   = String2.nvl(form.getParam("strCustNm"));
		String strTitle    = String2.nvl(form.getParam("strTitle"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		query = svc.getQuery("SEL_MASTER");  
	    sql.setString(i++, strJumCd); 
        sql.setString(i++, strFromDt);
        sql.setString(i++, strToDt);
        sql.setString(i++, strClmKind);
        sql.setString(i++, strProcGbn);
        sql.setString(i++, strCustNm);
        sql.setString(i++, strTitle);
		sql.put(query);
		ret = select2List(sql);

		return ret;
	}  
	
	/**
	 * 컴플레인  등록
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi, String userId) throws Exception { 
		
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
			while (mi.next()) {
				
				sql.close(); 		 
				
				if (mi.IS_INSERT()) { // 저장 
					
					i = 1; 
					
					// 1.컴플레인 테이블 등록 
					sql.put(svc.getQuery("INS_DV_VOCMST"));
					
					sql.setString(i++,mi.getString("STR_CD"));
					sql.setString(i++,mi.getString("REC_DT"));
					sql.setString(i++,mi.getString("STR_CD")); 
					sql.setString(i++,mi.getString("REC_DT"));
					sql.setString(i++,mi.getString("REC_TITLE"));
					sql.setString(i++,mi.getString("REC_CONT"));
					sql.setString(i++,mi.getString("REC_SUMMARY")); 
					sql.setString(i++,mi.getString("CLM_KIND"));
					sql.setString(i++,mi.getString("CLM_GRADE"));
					sql.setString(i++,mi.getString("REC_TYPE"));
					sql.setString(i++,mi.getString("MBR_GBN"));
					sql.setString(i++,mi.getString("CUST_ID")); 
					sql.setString(i++,mi.getString("CUST_NAME"));
					sql.setString(i++,mi.getString("MOBILE_PH1"));
					sql.setString(i++,mi.getString("MOBILE_PH2"));
					sql.setString(i++,mi.getString("MOBILE_PH3"));
					sql.setString(i++,mi.getString("SALE_ORG_CD"));
					sql.setString(i++,mi.getString("BRAND_CD"));  
					sql.setString(i++,userId);   
					sql.setString(i++,mi.getString("PROC_GBN"));  
					sql.setString(i++,mi.getString("PROC_DEPT")); 
					res = update(sql); 
					
					if (res <= 0) {
						throw new Exception("[USER]"+ "데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					}

				} else if(mi.IS_UPDATE()){// 수정
					 
					if (! isVocmst_Chk(svc, mi)) {
						throw new Exception("[USER]"+ "처리구분이 접수 인 상태만 처리 할수 있습니다.");
					}
					
					i = 1;
					
					//2.컴플레인 테이블 수정
					sql.put(svc.getQuery("UPD_DV_VOCMST"));
					
					sql.setString(i++,mi.getString("REC_TITLE"));
					sql.setString(i++,mi.getString("REC_CONT"));
					sql.setString(i++,mi.getString("REC_SUMMARY")); 
					sql.setString(i++,mi.getString("CLM_KIND"));
					sql.setString(i++,mi.getString("CLM_GRADE"));
					sql.setString(i++,mi.getString("REC_TYPE"));
					sql.setString(i++,mi.getString("MBR_GBN"));
					sql.setString(i++,mi.getString("CUST_ID")); 
					sql.setString(i++,mi.getString("CUST_NAME"));
					sql.setString(i++,mi.getString("MOBILE_PH1"));
					sql.setString(i++,mi.getString("MOBILE_PH2"));
					sql.setString(i++,mi.getString("MOBILE_PH3"));
					sql.setString(i++,mi.getString("SALE_ORG_CD"));
					sql.setString(i++,mi.getString("BRAND_CD"));  
					sql.setString(i++,mi.getString("REC_ID")); 
					sql.setString(i++,mi.getString("PROC_DEPT")); 
					sql.setString(i++,mi.getString("STR_CD"));
					sql.setString(i++,mi.getString("REC_DT"));
					sql.setString(i++,mi.getString("REC_SEQ"));
					res = update(sql); 
					
					if (res <= 0) {
						throw new Exception("[USER]"+ "데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					}
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
	 * 컴플레인  삭제
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public int delete(ActionForm form, String userId) throws Exception {
		int ret = 0;
		int res = 0;
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;
             
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			 
			sql.close();
			sql.put(svc.getQuery("DEL_DV_VOCMST")); 
			
			sql.setString(1, form.getParam("strStrCd"));
			sql.setString(2, form.getParam("strRecDt"));
			sql.setString(3, form.getParam("strRecSeq"));
			res = update(sql); 

			if (res  < 0) {
				throw new Exception("[USER]"+  "데이터의 적합성 문제로 인하여"
						+ "데이터 삭제를 하지 못했습니다.");
			}

			ret += res;
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}
    
	/**
	 * 컴플레인 처리구분 체크
	 * @param Service
	 * @param ActionForm
	 * @return List
	 * @throws Exception
	 */
	private boolean isVocmst_Chk(Service svc, MultiInput mi) throws Exception {
		SqlWrapper sql = null;
		boolean ret = false;

		sql = new SqlWrapper();
		sql.put(svc.getQuery("SEL_DV_VOCMST_CHK"));
		int i = 0;
	    sql.setString(++i, mi.getString("STR_CD")); //점코드
	    sql.setString(++i, mi.getString("REC_DT")); //접수일자
	    sql.setString(++i, mi.getString("REC_SEQ"));//접수번호  

		Map map = selectMap(sql);

		if (map.get("CNT").equals("0") || map.get("CNT").equals(0)) {
			ret = true;
		}
		return ret;
	}	
	
	/**
	 * 컴플레인  조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster_Pop(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String query = "";
		
		int i = 1; 
		
		String strStr_Cd    = String2.nvl(form.getParam("strStr_Cd"));
		String strRec_Dt   = String2.nvl(form.getParam("strRec_Dt"));
		String strRec_Seq     = String2.nvl(form.getParam("strRec_Seq"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		query = svc.getQuery("SEL_MASTER_POP");  
	    sql.setString(i++, strStr_Cd); 
        sql.setString(i++, strRec_Dt); 
        sql.setString(i++, strRec_Seq); 
		sql.put(query);
		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 컴플레인 조치결과  등록
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public int save_Pop(ActionForm form, MultiInput mi, String userId) throws Exception { 
		
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
			
			// 조치결과 저장 
			while(mi.next()){
				i = 1;				   
				sql.close();
				sql.put(svc.getQuery("UPD_DV_VOCMST_POP")); 
				
				sql.setString(i++, mi.getString("PROC_DEPT"));  
				sql.setString(i++, mi.getString("PROC_GBN"));;
				sql.setString(i++, mi.getString("PROC_DT"));
				sql.setString(i++, mi.getString("PROC_ID"));    
				sql.setString(i++, mi.getString("PROC_CONT"));  
				sql.setString(i++, mi.getString("STR_CD"));
				sql.setString(i++, mi.getString("REC_DT"));
				sql.setString(i++, mi.getString("REC_SEQ"));
				res = update(sql);				
				
				if (res == 0) {
					throw new Exception("[USER]"+  "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
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
