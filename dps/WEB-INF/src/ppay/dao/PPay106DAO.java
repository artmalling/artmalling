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
 * <p>매출 전자 세금계산서 기타발행/p>
 * 
 * @created  on 1.0, 2010/04/25
 * @created  by 김경은
 * 
 * @modified on 
 * @modified by                    
 * @caused   by           
 */

public class PPay106DAO extends AbstractDAO {
	/**
	 * 매출전자세금계산서 기타발행  리스트 조회
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

		String strStrCd    = String2.nvl(form.getParam("strStrCd"));   
		String strTaxSdt   = String2.nvl(form.getParam("strTaxSdt"));  
		String strTaxEdt   = String2.nvl(form.getParam("strTaxEdt"));  
		String strBizType  = String2.nvl(form.getParam("strBizType")); 
		String strTaxFlag  = String2.nvl(form.getParam("strTaxFlag")); 
		String strEdiSeaNo = String2.nvl(form.getParam("strEdiSeaNo"));  
		String strVenCd    = String2.nvl(form.getParam("strVenCd"));   
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_LIST"));     
		sql.setString(i++, strStrCd);    
		sql.setString(i++, strBizType); 
		sql.setString(i++, strTaxFlag);    
		sql.setString(i++, strEdiSeaNo);  
		sql.setString(i++, strVenCd);  
		
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
	 * 매출전자세금계산서 기타발행  데이터 조회
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
	 *  매출 전자세금계산서 기타발행(저장)한다.
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
		String strEdiSeqNo   = "";
		
		SqlWrapper sql 	= null;
		Service svc 	= null;

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			// 마스터
			while (mi1.next()) {
				
				sql.close();
				if (mi1.IS_INSERT()) { // 저장
					
					// 1. 전자세금계산ID를 생성한다.
					i = 1;
					sql.put(svc.getQuery("SEL_EDI_SEQ_NO"));
					
					sql.setString(i++, mi1.getString("STR_CD"));   	 		 // 점코드 
					sql.setString(i++, mi1.getString("TAX_ISSUE_DT"));       // 세금계산서발행일자 
					sql.setString(i++, mi1.getString("VEN_CD"));   			 // 협력사코드
					sql.setString(i++, "1");   			 					 // 1:백화점, 2:경영지원
					 
					Map mapEdiSeqNo = (Map)selectMap(sql);
					strEdiSeqNo = mapEdiSeqNo.get("EDI_SEQ_NO").toString();
					mi1.setString("EDI_SEQ_NO", strEdiSeqNo);
					sql.close(); 
					 
					if ("0".equals(strEdiSeqNo)) {
						throw new Exception("[USER]"+ "전자세금계산서ID를 구성하는 시퀀스가 존재하지 않습니다.");
					}
					
					strIssueSeqNo = strEdiSeqNo.substring(13, 18);
					mi1.setString("TAX_ISSUE_SEQ_NO", strIssueSeqNo);
					
					i = 1; 
					// 3. 마스터테이블에 저장
					sql.put(svc.getQuery("INS_MASTER"));
					
					sql.setString(i++, mi1.getString("STR_CD"));   	 		           // 점코드 
					sql.setString(i++, mi1.getString("TAX_ISSUE_DT"));                 // 세금계산서발행일자 
					sql.setString(i++, mi1.getString("TAX_ISSUE_SEQ_NO"));             // 세금계산서발행순번 
					sql.setString(i++, mi1.getString("VEN_CD"));   			           // 협력사코드 
					sql.setString(i++, mi1.getString("BIZ_TYPE"));   	 	           // 거래형태 
					sql.setString(i++, mi1.getString("TAX_FLAG"));   	 	           // 과세구분 
					sql.setString(i++, "2");   	 							           // 계산서구분 (1:매입,2:매출)       
					sql.setString(i++, mi1.getString("EDI_SEQ_NO"));	 	           // 전자세금계산서ID 
					sql.setString(i++, "0");   								           // 전자세금계산서상태 (0:IFS.TSMILETAX 전송전)
					sql.setString(i++, mi1.getString("TAX_ISSUE_DT").substring(0,6));  // 지불년월 
					sql.setString(i++, "1");   		 						           // 지불주기 
					sql.setString(i++, "1");   		 						           // 지불회차 
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
					sql.setString(i++, "N");   	 							           // SAP I/F여부 
					sql.setString(i++, "");   	 							           // SAP I/F일자 
					sql.setString(i++, "99");   	 					               // 세금계산서구분 
					sql.setString(i++, "1");   	                                       // 역발행구분 
					sql.setString(i++, "1");   	                                       // 통합발행구분 
					sql.setString(i++, "3");   	                                       // 전자세금계산서발행구분 
					sql.setString(i++, "1");   	                                       // 생성형태 
					sql.setString(i++, mi1.getString("VEN_CHAR_NAME"));   	           // 세금계산서 담당자명 
					sql.setString(i++, mi1.getString("VEN_CHAR_EMAIL"));   	           // 세금계산서 담당자메일 
					sql.setString(i++, mi1.getString("STR_CHAR_ID"));   	           // 전송자ID
					sql.setString(i++, mi1.getString("STR_CHAR_NAME"));   	           // 점담당자명
					sql.setString(i++, mi1.getString("STR_CHAR_EMAIL"));   	           // 전송자메일
					
					sql.setString(i++, mi1.getString("VEN_HP1_NO"));      			   // 협력사핸드폰1
					sql.setString(i++, mi1.getString("VEN_HP2_NO"));       			   // 협력사핸드폰2
					sql.setString(i++, mi1.getString("VEN_HP3_NO"));                   // 협력사핸드폰3
					sql.setString(i++, mi1.getString("VEN_SMEDI_ID"));                 // 협력사스마일EDI
					
					    
					sql.setString(i++, mi1.getString("VEN_COMP_NO"));                  // 협력사사업자번호
					sql.setString(i++, mi1.getString("VEN_COMP_NAME"));                // 협력사사업자명
					sql.setString(i++, mi1.getString("VEN_REP_NAME"));                 // 협력사대표자명
					sql.setString(i++, mi1.getString("VEN_BIZ_STAT"));                 // 협력사업태
					sql.setString(i++, mi1.getString("VEN_BIZ_CAT"));                  // 협력사업종     
					sql.setString(i++, mi1.getString("VEN_ADDR"));                     // 협력사주소            
					sql.setString(i++, mi1.getString("VEN_DTL_ADDR"));                 // 협력사상세주소      
					
					
					sql.setString(i++, mi1.getString("STR_COMP_NAME"));   			   // 점상호             
					sql.setString(i++, mi1.getString("STR_COMP_NO"));                  // 점사업자번호          
					sql.setString(i++, mi1.getString("STR_BIZ_CAT"));                  // 점업종          
					sql.setString(i++, mi1.getString("STR_BIZ_STAT"));                 // 점업태             
					sql.setString(i++, mi1.getString("STR_REP_NAME"));                 // 점대표자명           
					sql.setString(i++, mi1.getString("STR_ADDR"));                     // 점주소            
					sql.setString(i++, mi1.getString("STR_DTL_ADDR"));                 // 점상세주소           
					sql.setString(i++, mi1.getString("STR_HP1_NO"));                   // 점담당자핸드폰1        
					sql.setString(i++, mi1.getString("STR_HP2_NO"));                   // 점담당자핸드폰2        
					sql.setString(i++, mi1.getString("STR_HP3_NO"));                   // 점담당자핸드폰3        
					sql.setString(i++, "N");                    					   // 취소유무       
					sql.setString(i++, "N");                                           // 이메일재전송여부        
					sql.setString(i++, mi1.getString("NTS_SEND_YN"));                  // 국세청전송요청여부       
					sql.setString(i++, mi1.getString("STATE_FLAG"));                   // 상태구분            
					
					sql.setString(i++, "N");   	                                       // 삭제구분
					sql.setString(i++, userId);                                        
					sql.setString(i++, userId);                                        
                                                                                       
				}else if(mi1.IS_UPDATE()){// 수정                                        
                                                                                       
					i = 1;                                                             
					//                                                                 
					sql.put(svc.getQuery("UPD_MASTER"));                               
					                                                                   
					sql.setString(i++, "");   							 	           // 전자세금계산서ID 
					sql.setString(i++, "");   								           // 전자세금계산서상태 
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
	public List getStrVenInfo(ActionForm form, String userId) throws Exception {
		
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
		sql.setString(i++, userId);
		sql.setString(i++, userId);
		sql.setString(i++, userId);
		sql.setString(i++, strStrCd); 
		sql.setString(i++, strVenCd);  

		ret = select2List(sql);
		return ret;
	}
	
	/**
	 *  매출 전자세금계산서 기타발행(전송처리/EMAIL재전송/최소요청)한다.
	 * 
	 * @param form
	 * @param mi1
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int setSmileTax(ActionForm form, String userId)
			throws Exception {

		int ret  = 0;
		int res  = 0;
		int resp = 0;     //프로시저 리턴값
		int i    = 0;
		
		SqlWrapper sql 			= null;
		Service svc 			= null;
		ProcedureWrapper psql 	= null;	//프로시저 사용위함

		try {
			
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			psql = new ProcedureWrapper();	//프로시저 사용위함
			ProcedureResultSet prs = null;
System.out.println(String2.nvl(form.getParam("strStrCd")));			
			String strStrCd    		= String2.nvl(form.getParam("strStrCd"));   
			String strTaxIssueDt   	= String2.nvl(form.getParam("strTaxIssueDt"));  
			String strTaxIssueSeqNo = String2.nvl(form.getParam("strTaxIssueSeqNo"));  
			String state  			= String2.nvl(form.getParam("state"));
					
			psql.close();
				                                                            
			i = 1;            
			psql.put("DPS.PR_PPETAXAGNT_IFS", 6);     
			psql.setString(i++, strStrCd);					// 점
            psql.setString(i++, strTaxIssueDt);       		// 발행일
            psql.setString(i++, strTaxIssueSeqNo); 			// 일련번호
            psql.setString(i++, state);						// 처리구분('1':전송처리, '2':EMAIL재전송, '3':취소요청)
            
            psql.registerOutParameter(i++, DataTypes.INTEGER);//5
            psql.registerOutParameter(i++, DataTypes.VARCHAR);//6

            prs = updateProcedure(psql);
            
            resp += prs.getInt(5);    

            if (resp != 0) {
                throw new Exception("[USER]"+ prs.getString(6));
            }
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return resp;
	}
}
