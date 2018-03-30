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
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>공제등록</p>
 * 
 * @created  on 1.0, 2010/05/31
 * @created  by 박래형
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PPay204DAO extends AbstractDAO { 

	/**
	 * 공제등록 조회 
	 *        
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMaster(ActionForm form, String userId, String org_flag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;               
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strYyyymm     = String2.nvl(form.getParam("strYyyymm"));
		String strPayCyc     = String2.nvl(form.getParam("strPayCyc"));
		String strPayCnt     = String2.nvl(form.getParam("strPayCnt"));
		String strPayFlag    = String2.nvl(form.getParam("strPayFlag"));
		String strVenCd      = String2.nvl(form.getParam("strVenCd"));
		String strPumCd   	 = String2.nvl(form.getParam("strPumCd"));
		String strTeam   	 = String2.nvl(form.getParam("strTeam"));
		
		sql = new SqlWrapper(); 
		svc = (Service) form.getService();
		connect("pot");
	
		strQuery += svc.getQuery("SEL_MASTER") + "\n ";
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strYyyymm);          
		sql.setString(i++, strPayCyc);
		sql.setString(i++, strPayCnt);
		sql.setString(i++, strVenCd);
		sql.setString(i++, strPumCd);
		sql.setString(i++, "2");		/*1 : 보류  2 : 공제만 */
		sql.setString(i++, strPayFlag);
		sql.setString(i++, userId);
		
		System.out.println(strQuery);
		
		if(!strTeam.equals("%"))
		{
			strQuery += svc.getQuery("SEL_TEAM") + "\n ";
			sql.setString(i++, strTeam);
		}
		
		strQuery += svc.getQuery("SEL_ORDER") + "\n ";
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		//System.out.println("search::"+ret);
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
		System.out.println("1");
		int ret 	= 0;
		int res 	= 0;
		int i   	= 0; 

		SqlWrapper sql = null;
		Service svc = null;

		String strSeqNo   = "";		// 순번
		String strSlipNo  = "";     // 전표번호		
		String strYYYYMM  = String2.nvl(form.getParam("strYYYYMM"));
		try {
			System.out.println("2");
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			// 마스터
			while (mi1.next()) {
				System.out.println("3");
				sql.close();
				if (mi1.IS_INSERT()) { // 저장
					System.out.println("4");
					// 2.전표번호를 생성한다.(MAX+1 이용)
					sql.put(svc.getQuery("SEL_SEQ_NO"));	
					sql.setString(1, mi1.getString("STR_CD"));
					sql.setString(2, mi1.getString("PAY_YM"));	
					sql.setString(3, mi1.getString("PAY_CYC"));	
					sql.setString(4, mi1.getString("PAY_CNT"));	
					sql.setString(5, mi1.getString("VEN_CD"));
					sql.setString(6, mi1.getString("PUMBUN_CD"));	
					
					
					System.out.println("5");
					
					Map mapSeqNo = (Map)selectMap(sql);
					strSeqNo= mapSeqNo.get("SEQ_NO").toString();
					mi1.setString("SEQ_NO", strSeqNo);
					
					//전표번호 조합
					strSlipNo = "93" + strYYYYMM + "000" + strSeqNo;
					
					sql.close();		
					i = 1; 
					// 1. 마스터테이블에 저장
					System.out.println("6");
					sql.put(svc.getQuery("INS_MASTER"));
					 
					sql.setString(i++, mi1.getString("STR_CD"));  
					sql.setString(i++, mi1.getString("PAY_YM"));             
					sql.setString(i++, mi1.getString("PAY_CYC"));     
					sql.setString(i++, mi1.getString("PAY_CNT"));     
					sql.setString(i++, mi1.getString("VEN_CD"));
					sql.setString(i++, mi1.getString("DED_VEN_CD"));
					sql.setString(i++, mi1.getString("PUMBUN_CD"));
					sql.setString(i++, mi1.getString("SEQ_NO"));        // 순번만들기
					sql.setString(i++, strSlipNo);                      // 전표번호 조합하기
					sql.setString(i++, mi1.getString("REASON_CD"));     
					sql.setString(i++, mi1.getString("INPUT_DT"));     
					sql.setString(i++, mi1.getString("INPUT_AMT"));    
					sql.setString(i++, mi1.getString("VAT_YN"));    
					sql.setString(i++, mi1.getString("SUP_AMT"));    
					sql.setString(i++, mi1.getString("VAT_AMT"));     
					sql.setString(i++, mi1.getString("REMARK"));
					sql.setString(i++, mi1.getString("CASH_IN_YN"));					
					sql.setString(i++, userId);
					sql.setString(i++, userId);

				}else if(mi1.IS_UPDATE()){// 수정 
					System.out.println("7");
					i = 1;
					// 1. 마스터테이블에 수정
					sql.put(svc.getQuery("UPD_MASTER")); 
				      
					sql.setString(i++, mi1.getString("DED_VEN_CD"));
					sql.setString(i++, mi1.getString("INPUT_AMT"));  
					sql.setString(i++, mi1.getString("VAT_YN"));    
					sql.setString(i++, mi1.getString("SUP_AMT"));    
					sql.setString(i++, mi1.getString("VAT_AMT")); 
					sql.setString(i++, mi1.getString("CASH_IN_YN")); 
					sql.setString(i++, mi1.getString("REMARK"));  
					sql.setString(i++, userId);
					sql.setString(i++, mi1.getString("STR_CD"));  
					sql.setString(i++, mi1.getString("PAY_YM"));             
					sql.setString(i++, mi1.getString("PAY_CYC"));     
					sql.setString(i++, mi1.getString("PAY_CNT"));      
					sql.setString(i++, mi1.getString("VEN_CD"));
					sql.setString(i++, mi1.getString("PUMBUN_CD"));
					sql.setString(i++, mi1.getString("SEQ_NO"));

				}else if (mi1.IS_DELETE()) { // 삭제 
					i = 1;  
					// 1. 마스터테이블에 저장
					sql.put(svc.getQuery("DEL_MASTER"));            
					sql.setString(i++, mi1.getString("STR_CD"));  
					sql.setString(i++, mi1.getString("PAY_YM"));             
					sql.setString(i++, mi1.getString("PAY_CYC"));     
					sql.setString(i++, mi1.getString("PAY_CNT"));      
					sql.setString(i++, mi1.getString("VEN_CD"));
					sql.setString(i++, mi1.getString("DED_VEN_CD"));
					sql.setString(i++, mi1.getString("PUMBUN_CD"));
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
					sql.setString(i++, mi1.getString("PUMBUN_CD"));
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
		
		String strKeyValue = String2.nvl(form.getParam("strKeyValue"));

		sql = new SqlWrapper(); 
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_KEYVALUE"));
		sql.setString(i++, strKeyValue);		
      	                      
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
	
	public String savecopy(ActionForm form, MultiInput mi1, String userId)
	throws Exception {


		int resp    		= 0;     //프로시저 리턴값
		int i   			= 0;
		String res          = "";
		
		SqlWrapper sql        = null;
		Service svc           = null;
		ProcedureWrapper psql = null;	//프로시저 사용위함
		String S_YYYYMM 		= String2.nvl(form.getParam("S_YYYYMM"));
		String I_YYYYMM 		= String2.nvl(form.getParam("I_YYYYMM"));
		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		
		try {
			
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			psql = new ProcedureWrapper();	//프로시저 사용위함
			ProcedureResultSet prs = null;
		
			
			System.out.println(userId);
			System.out.println(strStrCd);
			
			i = 1;
			psql.put("DPS.PR_PREDEFDED_COPY", 5); 
			psql.setString(i++, strStrCd);
		    psql.setString(i++, S_YYYYMM); 	
		    psql.setString(i++, I_YYYYMM);
		    psql.setString(i++, userId);		
		    
		
		    psql.registerOutParameter(i++, DataTypes.VARCHAR);
		    prs = updateProcedure(psql);
		
		
		
		    if (resp != 0) {
		        throw new Exception("[USER-처리되었습니다.]");
		    }else{
		    	res = prs.getString(5);
		    }
			
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return res;
		}
}
