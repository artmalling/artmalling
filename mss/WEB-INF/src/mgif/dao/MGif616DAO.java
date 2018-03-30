/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mgif.dao;

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
 * <p>전자세금계산서 수정/삭제/p>
 * 
 * @created  on 1.0, 2011/05/03
 * @created  by 김경은
 * 
 * @modified on 
 * @modified by                    
 * @caused   by           
 */

public class MGif616DAO extends AbstractDAO {
	/**
	 * 전자세금계산서 수정/삭제  리스트 조회
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
		String strPayYm       = String2.nvl(form.getParam("strPayYm"));
		String strPayCyc      = String2.nvl(form.getParam("strPayCyc"));
		String strPayCnt      = String2.nvl(form.getParam("strPayCnt"));
		String strTaxSdt      = String2.nvl(form.getParam("strTaxSdt"));  
		String strTaxEdt      = String2.nvl(form.getParam("strTaxEdt"));  
		String strBizType     = String2.nvl(form.getParam("strBizType")); 
		String strTaxFlag     = String2.nvl(form.getParam("strTaxFlag")); 
		String strEdiSeaNo    = String2.nvl(form.getParam("strEdiSeaNo"));  
		String strVenCd       = String2.nvl(form.getParam("strVenCd"));
		String strTaxInvFlag  = String2.nvl(form.getParam("strTaxInvFlag"));
		String strEtaxStat    = String2.nvl(form.getParam("strEtaxStat"));
		
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_LIST"));     
		sql.setString(i++, strStrCd);  
		sql.setString(i++, strPayYm);
		sql.setString(i++, strPayCyc);
		sql.setString(i++, strPayCnt);
		sql.setString(i++, strBizType); 
		sql.setString(i++, strTaxFlag);    
		sql.setString(i++, strEdiSeaNo);  
		sql.setString(i++, strVenCd);
		sql.setString(i++, strTaxInvFlag);
		sql.setString(i++, strEtaxStat);
		
		System.out.println(strTaxSdt+"::"+strTaxSdt);
		if(!"".equals(strTaxSdt) || !"".equals(strTaxSdt) ){		
			sql.put(svc.getQuery("SEL_TAX_DT"));
			sql.setString(i++, strTaxSdt);  
			sql.setString(i++, strTaxEdt);                  
		} 
	
		sql.put(svc.getQuery("SEL_ORDER_BY"));
		
		ret = select2List(sql);
		return ret;
	}
	/**
	 * 전자세금계산서 수정/삭제  데이터 조회
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
		String strIssueDt    = String2.nvl(form.getParam("strIssueDt"));  
		String strIssueSeqNo = String2.nvl(form.getParam("strIssueSeqNo"));  
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_MASTER"));     
		sql.setString(i++, strStrCd); 
		sql.setString(i++, strIssueDt); 
		sql.setString(i++, strIssueSeqNo); 

		ret = select2List(sql);
		return ret;
	}
	

	/**
	 *  전자세금계산서 수정/삭제 한다.
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
		
		String strIssueSeqNo = "";
		
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
					// 1. 전표번호를 생성한다.(시퀀스사용)
					sql.put(svc.getQuery("SEL_TAX_ISSUE_SEQ_NO"));
					
					Map mapSlipNo = (Map)selectMap(sql);
					strIssueSeqNo = mapSlipNo.get("TAX_ISSUE_SEQ_NO").toString();
					mi1.setString("TAX_ISSUE_SEQ_NO", strIssueSeqNo);
					sql.close(); 
					
					
					i = 1; 
					// 3. 마스터테이블에 저장
					sql.put(svc.getQuery("INS_MASTER"));
					
					sql.setString(i++, mi1.getString("STR_CD"));   	 		 // 점코드 
					sql.setString(i++, mi1.getString("TAX_ISSUE_DT"));       // 세금계산서발행일자 
					sql.setString(i++, mi1.getString("TAX_ISSUE_SEQ_NO"));   // 세금계산서발행순번 
					sql.setString(i++, mi1.getString("VEN_CD"));   			 // 협력사코드 
					sql.setString(i++, mi1.getString("BIZ_TYPE"));   	 	 // 거래형태 
					sql.setString(i++, mi1.getString("TAX_FLAG"));   	 	 // 과세구분 
					sql.setString(i++, "2");   	 							 // 계산서구분 (1:매입,2:매출)
					sql.setString(i++, "");   							 	 // 전자세금계산서ID 
					sql.setString(i++, "0");   								 // 전자세금계산서상태 
					sql.setString(i++, mi1.getString("PAY_YM"));   			 // 지불년월 
					sql.setString(i++, "1");   		 						 // 지불주기 
					sql.setString(i++, "1");   		 						 // 지불회차 
					sql.setString(i++, mi1.getString("TAX_INV_TYPE"));   	 // 세금계산서종류 
					sql.setString(i++, mi1.getString("REMARK"));   			 // 비고 
					sql.setString(i++, mi1.getString("SUP_AMT"));   		 // 공급액 
					sql.setString(i++, mi1.getString("VAT_AMT"));   		 // 부가세액 
					sql.setString(i++, mi1.getString("TOT_AMT"));   		 // 합계금액 
					sql.setString(i++, mi1.getString("TAX_ITEM_DT"));   	 // 상품일자 
					sql.setString(i++, mi1.getString("TAX_ITEM_NM"));   	 // 상품 
					sql.setString(i++, mi1.getString("TAX_ITEM_SPEC"));   	 // 상품규격 
					sql.setString(i++, mi1.getString("TAX_ITEM_QTY"));   	 // 상품수량 
					sql.setString(i++, mi1.getString("TAX_ITEM_UNIT_AMT"));  // 상품단가 
					sql.setString(i++, mi1.getString("TAX_ITEM_SUP_AMT"));   // 상품공급가 
					sql.setString(i++, mi1.getString("TAX_ITEM_VAT_AMT"));   // 상품부가세 
					sql.setString(i++, mi1.getString("TAX_ITEM_REMARK"));    // 상품비고 
					sql.setString(i++, mi1.getString("CHARGE_FLAG"));   	 // 청구영수구분 
					sql.setString(i++, "N");   	 							 // SAP I/F여부 
					sql.setString(i++, "");   	 							 // SAP I/F일자 
					sql.setString(i++, "99");   	 					     // 세금계산서구분 
					sql.setString(i++, "1");   	                             // 역발행구분 
					sql.setString(i++, "1");   	                             // 통합발행구분 
					sql.setString(i++, "3");   	                             // 전자세금계산서발행구분 
					sql.setString(i++, "1");   	                             // 생성형태 
					sql.setString(i++, mi1.getString("TAX_CHAR_NAME"));   	 // 세금계산서 담당자명 
					sql.setString(i++, mi1.getString("TAX_CHAR_EMAIL"));   	 // 세금계산서 담당자메일 
					sql.setString(i++, mi1.getString("STR_CHAR_ID"));   	 // 전송자ID
					sql.setString(i++, mi1.getString("STR_CHAR_EMAIL"));   	 // 전송자메일
					sql.setString(i++, "N");   	                             // 삭제구분
					sql.setString(i++, userId); 
					sql.setString(i++, userId); 

				}else if(mi1.IS_UPDATE()){// 수정

					i = 1;        
					// 
					sql.put(svc.getQuery("UPD_MASTER"));                               
                    
					sql.setString(i++, "");   							 	           // 전자세금계산서ID 
					//sql.setString(i++, "");   								           // 전자세금계산서상태 
					sql.setString(i++, mi1.getString("TAX_INV_TYPE"));   	           // 세금계산서종류 
					sql.setString(i++, mi1.getString("REMARK"));   			           // 비고 
					sql.setString(i++, mi1.getString("SUP_AMT"));   		           // 공급액 
					sql.setString(i++, mi1.getString("VAT_AMT"));   		           // 부가세액 
					sql.setString(i++, mi1.getString("TOT_AMT"));   		           // 합계금액 
					sql.setString(i++, mi1.getString("TAX_ITEM_DT"));   	           // 상품일자 
					sql.setString(i++, mi1.getString("TAX_ITEM_NM"));   	           // 상품 
					sql.setString(i++, mi1.getString("TAX_ITEM_SPEC"));   	           // 상품규격 
					sql.setString(i++, mi1.getString("TAX_ITEM_QTY"));   	           // 상품수량 
					sql.setString(i++, mi1.getString("TAX_ITEM_UNIT_AMT"));            // 상품단가 
					sql.setString(i++, mi1.getString("TAX_ITEM_SUP_AMT"));             // 상품공급가 
					sql.setString(i++, mi1.getString("TAX_ITEM_VAT_AMT"));             // 상품부가세 
					sql.setString(i++, mi1.getString("TAX_ITEM_REMARK"));              // 상품비고 
					sql.setString(i++, mi1.getString("CHARGE_FLAG"));   	           // 청구영수구분 
					sql.setString(i++, mi1.getString("VEN_CHAR_NAME"));   	           // 세금계산서 담당자명 
					sql.setString(i++, mi1.getString("VEN_CHAR_EMAIL"));   	           // 세금계산서 담당자메일 
					sql.setString(i++, mi1.getString("STR_CHAR_ID"));   	           // 전송자ID
					sql.setString(i++, mi1.getString("STR_CHAR_EMAIL"));   	           // 전송자메일
					sql.setString(i++, userId);                                        
					sql.setString(i++, mi1.getString("STR_CD"));   	 		           // 점코드 
					sql.setString(i++, mi1.getString("TAX_ISSUE_DT"));                 // 세금계산서발행일자 
					sql.setString(i++, mi1.getString("TAX_ISSUE_SEQ_NO"));             // 세금계산서발행순번 
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
	 *  전자세금계산서를  삭제한다.
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
		String strEdiSeqNo 	= "";
		
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
				//월관리비 세금계산서 전표상태변경(전표키값 삭제)
				updateTaxInfo(form, userId, mi1.getString("STR_CD"), 
											mi1.getString("TAX_ISSUE_DT"), 
											mi1.getString("TAX_ISSUE_SEQ_NO")
											);
				
				// 세금계산서 삭제
				i = 1;        
				sql.put(svc.getQuery("DEL_MASTER"));                                            
				sql.setString(i++, mi1.getString("STR_CD"));   				// 점 
				sql.setString(i++, mi1.getString("TAX_ISSUE_DT"));   		// 발행일자 
				sql.setString(i++, mi1.getString("TAX_ISSUE_SEQ_NO"));   	// 발행순번 

				res = update(sql);
				if (res  < 0) {
					throw new Exception("[USER]"+ "데이터의 적합성 문제로 인하여"
							+ "데이터 삭제를 하지 못했습니다.");
				}
				
				// 상태가 계산서등록(0)이 아닐경우 인터페이스 테이블의 데이터도 삭제한다.
				if(!"0".equals(mi1.getString("ETAX_STAT"))){
					// IFS.TSMILETAX 테이블에 데이터 삭제
					strEdiSeqNo = mi1.getString("EDI_SEQ_NO");
					delete_IFS(form, strEdiSeqNo);
				}
				
				ret += res;
			}                      
		} catch (Exception e) {
			rollback();
			System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>> DAO : " + e);
			throw e;
		} finally {
			end();
		}
		return ret;
	}
	
	/**
	 *  IFS.TSMILETAX 인터페이스 테이블 데이터 삭제
	 * 
	 * @param form
	 * @param mi1
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int delete_IFS(ActionForm form, String strEdiSeqNo)
			throws Exception {
		int ret = 0;
		int res = 0;
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;
             
		try {
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			sql.close();
			sql.put(svc.getQuery("DEL_TSMILETAX")); 
			
			sql.setString(1, strEdiSeqNo);
			res = update(sql);
			
			if (res  < 0) {
				throw new Exception("[USER]"+ "데이터의 적합성 문제로 인하여"
						+ "데이터 삭제를 하지 못했습니다.");
			}

			ret += res;
		} catch (Exception e) {
			throw e;
		} 
		return ret;
	}
	
	/**
	 *  MSS.MR_CALMST    월관리비정산 EDI_SEQ_NO 초기화(삭제 )
	 * 
	 * @param form
	 * @param mi1
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int updateTaxInfo(ActionForm form, String userId, String strStrCd 
										    , String strTaxIssueDt
										    , String strTaxIssueSeqNo)
			throws Exception {
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;
             
		try {
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			sql.close();
			i = 1;
			sql.put(svc.getQuery("UPD_MG_VENCAL")); 
			//TAX_ISSUE_FLAG
			//TAX_FLAG
			sql.setString(i++, userId);   				// 사번
			sql.setString(i++, strTaxIssueSeqNo);   	// 발행순번 
			sql.setString(i++, strTaxIssueDt);   		// 발행일자 
			sql.setString(i++, strStrCd);   			// 점 
			
			res += update(sql);

			if (res <= 0) {
				throw new Exception("[USER]"+ "데이터의 적합성 문제로 인하여"
						+ "데이터 삭제를 하지 못했습니다.");
			}
			
		} catch (Exception e) {
			throw e;
		} 
		return res;
	}
	
	/**
	 * 협력사별 담당자명 조회(콤보)
	 *       
	 * @param form   
	 * @return
	 * @throws Exception
	 */
	public List getCharName(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;          

		String strVenCd    = String2.nvl(form.getParam("strVenCd"));   

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_CHAR_NAME"));     
		sql.setString(i++, strVenCd);  

		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 점별협력사 정보조회
	 *                  
	 * @param form   
	 * @return
	 * @throws Exception
	 */
	public List getStrVenInfo(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;          

		String strStrCd    = String2.nvl(form.getParam("strStrCd")); 
		String strVenCd    = String2.nvl(form.getParam("strVenCd"));   

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_STRVEN_INFO"));   
		sql.setString(i++, strStrCd); 
		sql.setString(i++, strVenCd);  

		ret = select2List(sql);
		return ret;
	}
}
