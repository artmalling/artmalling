/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pord.dao;

import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import common.util.Util;

  
/**
 * <p>예제  DAO</p>
 * 
 * @created  on 1.0, 2010/03/24
 * @created  by 박래형(FKSS)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */ 
 
public class POrd505DAO extends AbstractDAO {
	  /* 
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */    	
	
	/**
	 * INVOICE 등록 리스트 내역 조회
	 *  
	 * @param form
	 * @return
	 * @throws Exception
	 */ 
	public List getList(ActionForm form, String userId, String org_flag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String  strStrCd	    = String2.nvl(form.getParam("strStrCd"));
		String  strSInvoiceDt	= String2.nvl(form.getParam("strSInvoiceDt"));
		String  strEInvoiceDt	= String2.nvl(form.getParam("strEInvoiceDt"));
		
		String  strInvoiceNo	= URLDecoder.decode(String2.nvl(form.getParam("strInvoiceNo")), "UTF-8");
		String  strOfferNo	    = URLDecoder.decode(String2.nvl(form.getParam("strOfferNo")), "UTF-8");
		Integer intInvoiceNo    = 0;
		Integer intOfferNo      = 0;
		 
		String  strPumbun	    = String2.nvl(form.getParam("strPumbun"));
		String  strVen		    = String2.nvl(form.getParam("strVen"));
		String  strSlipNo	    = String2.nvl(form.getParam("strSlipNo"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");		

		if("".equals(strSlipNo)){
			sql.put(svc.getQuery("SEL_LIST")); 
			sql.setString(i++, strStrCd);  
			sql.setString(i++, strSInvoiceDt);     
			sql.setString(i++, strEInvoiceDt);    
			sql.setString(i++, strInvoiceNo);     
			sql.setString(i++, strOfferNo);   
			sql.setString(i++, strPumbun);  
			sql.setString(i++, strVen);  
			sql.setString(i++, userId);  
			sql.setString(i++, org_flag);  
		}else{
			sql.put(svc.getQuery("SEL_LIST_SLIP_NO")); 
			sql.setString(i++, strStrCd);  
			sql.setString(i++, strSlipNo);
			sql.setString(i++, userId);  
			sql.setString(i++, org_flag); 
		}
		
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * INVOICE 등록  마스터 내역 조회
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
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strInvoiceYm = String2.nvl(form.getParam("strInvoiceYm"));
		String strInvoiceSeqNo = String2.nvl(form.getParam("strInvoiceSeqNo"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStrCd);      
		sql.setString(i++, strInvoiceYm);     
		sql.setString(i++, strInvoiceSeqNo);  
		
		strQuery = svc.getQuery("SEL_MASTER") + "\n";  

		sql.put(strQuery);
		ret = select2List(sql); 
		return ret;
	} 
	
	/**
	 * INVOICE 등록  상세 내역 조회
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
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strInvoiceYm = String2.nvl(form.getParam("strInvoiceYm"));
		String strInvoiceSeqNo = String2.nvl(form.getParam("strInvoiceSeqNo"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);     
		sql.setString(i++, strInvoiceYm);     
		sql.setString(i++, strInvoiceSeqNo);  
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";

		sql.put(strQuery);
		ret = select2List(sql);
//		System.out.println("ret.size() " + ret.size());

		return ret;
	}
    
	/**
	 *  INVOICE 등록 마스터 디테일 수정
	 * 
	 * @param form 
	 * @param mi1
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi1, MultiInput mi2, String userId, String org_flag)
			throws Exception {

		int ret 	= 0;
		int res 	= 0;
		int resp    = 0;//프로시저 리턴값
		int i   	= 0;
		int mstCnt 	= 0;	

		String strPStrCd        = "";
		String strPInvoiceYm    = "";  
		String strPInvoiceSeqNo = "";  
		String strPSlipNo       = "";  
		String strPProcFlag     = "";  
		
		String strInvoiceSeqNo  = "";		// 전표번호
		String strSlipNo        = "";       // 전표번호
		
		SqlWrapper sql = null;
		Service svc = null;
        ProcedureWrapper psql = null;	//프로시저 사용위함
 
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
            psql = new ProcedureWrapper();	//프로시저 사용위함
			svc = (Service) form.getService();
            ProcedureResultSet prs = null;
						
			// 마스터
			while (mi1.next()) {				
				sql.close();
				
				if (mi1.IS_INSERT()) { // 저장
	
					// 2.전표번호를 생성한다.(시퀀스사용)
					sql.put(svc.getQuery("SEL_INVOICE_SEQ_NO"));
					
					Map mapInvoiceSeqNo = (Map)selectMap(sql);
					strInvoiceSeqNo     = mapInvoiceSeqNo.get("INVOICE_SEQ_NO").toString();
					mi1.setString("INVOICE_SEQ_NO", strInvoiceSeqNo);
					sql.close();					
					
					// 전표번호를 생성한다.(시퀀스사용)
					sql.put(svc.getQuery("SEL_SLIP_NO"));
					sql.setString(1, mi1.getString("STR_CD"));
					sql.setString(2, mi1.getString("DELI_DT"));	
					sql.setString(3, "A");
					
					Map mapSlipNo = (Map)selectMap(sql);
					strSlipNo     = mapSlipNo.get("SLIP_NO").toString();
					mi1.setString("SLIP_NO", strSlipNo);
					sql.close();					
										
					String strInvoiceYm   = String2.nvl(form.getParam("strInvoiceYm"));
					String strInvoiceDt   = String2.nvl(form.getParam("strInvoiceDt"));
					
					//저장시 프로시저 호출위한 변수 셋팅
					strPStrCd        = mi1.getString("STR_CD");
					strPInvoiceYm    = strInvoiceYm;
					strPInvoiceSeqNo = strInvoiceSeqNo;
					strPSlipNo       = mi1.getString("SLIP_NO");
					strPProcFlag     = "SAVE";							
						
					i = 1; 
					// 3. 마스터테이블에 저장
					sql.put(svc.getQuery("INS_MASTER"));
					
					sql.setString(i++, mi1.getString("STR_CD"));  
					sql.setString(i++, strInvoiceYm);  
					sql.setString(i++, strInvoiceSeqNo);   
					sql.setString(i++, mi1.getString("OFFER_YM"));  	//임시사용
					sql.setString(i++, mi1.getString("OFFER_SEQ_NO"));    //OFFER_SEQ_NO
					sql.setString(i++, mi1.getString("OFFER_SHEET_NO"));  //OFFER NO      
					sql.setString(i++, mi1.getString("INVOICE_NO"));  
					sql.setString(i++, mi1.getString("INVOICE_DT"));      
					sql.setString(i++, mi1.getString("PUMBUN_CD"));  
					sql.setString(i++, mi1.getString("VEN_CD"));      
					sql.setString(i++, mi1.getString("BUYER_CD"));  
					sql.setString(i++, mi1.getString("PRC_COND"));      
					sql.setString(i++, mi1.getString("PAYMENT_COND"));  
					sql.setString(i++, mi1.getString("PAYMENT_DTL_COND"));      
					sql.setString(i++, mi1.getString("IMPORT_COUNTRY"));  
					sql.setString(i++, mi1.getString("SHIP_PORT"));      
					sql.setString(i++, mi1.getString("ARRI_PORT"));   
					sql.setString(i++, mi1.getString("LC_DATE"));      
					sql.setString(i++, mi1.getString("LC_NO"));  
					sql.setString(i++, mi1.getString("ETD"));      
					sql.setString(i++, mi1.getString("ETA"));  
					sql.setString(i++, mi1.getString("CURRENCY_CD"));      
					sql.setString(i++, mi1.getString("EXC_APP_DT"));  
					sql.setString(i++, mi1.getString("EXC_RATE"));      
					sql.setString(i++, mi1.getString("PACKING_CHARGE"));  
					sql.setString(i++, mi1.getString("NCV"));      
					sql.setString(i++, mi1.getString("BL_NO"));   
					sql.setString(i++, mi1.getString("ENTRY_DT"));      
					sql.setString(i++, mi1.getString("IMPORT_NO"));  
					sql.setString(i++, mi1.getString("SLIP_NO"));       
					sql.setString(i++, mi1.getString("DELI_DT"));  
					sql.setString(i++, mi1.getString("PRC_APP_DT"));      
					sql.setString(i++, mi1.getString("CHK_DT"));  
					sql.setString(i++, mi1.getString("INVOICE_TOT_QTY"));      
					sql.setString(i++, mi1.getString("INVOICE_TOT_AMT"));  
					sql.setString(i++, mi1.getString("INVOICE_WON_TOT_AMT"));   
					sql.setString(i++, mi1.getString("SALE_TOT_AMT"));              /* 매가계 */					
					sql.setString(i++, mi1.getString("REMARK"));  							
					sql.setString(i++, mi1.getString("BIZ_TYPE"));  							
					sql.setString(i++, mi1.getString("TAX_FLAG"));  							
					sql.setString(i++, mi1.getString("GAP_RATE"));  							
					sql.setString(i++, mi1.getString("GAP_TOT_AMT"));	 
					sql.setString(i++, userId); 
					sql.setString(i++, userId);
					
				}else if(mi1.IS_UPDATE()){// 수정					
					i = 1;
					
					//저장시 프로시저 호출위한 변수 셋팅
					strPStrCd        = mi1.getString("STR_CD");
					strPInvoiceYm    = mi1.getString("INVOICE_YM");
					strPInvoiceSeqNo = mi1.getString("INVOICE_SEQ_NO");
					strPSlipNo       = mi1.getString("SLIP_NO");
					strPProcFlag     = "SAVE";						
					
					// 3. 마스터테이블에 수정
					sql.put(svc.getQuery("UPD_MASTER")); 
										
					sql.setString(i++, mi1.getString("OFFER_YM"));      
					sql.setString(i++, mi1.getString("OFFER_SHEET_NO"));      
					sql.setString(i++, mi1.getString("INVOICE_NO"));      
					sql.setString(i++, mi1.getString("INVOICE_DT"));      
					sql.setString(i++, mi1.getString("PUMBUN_CD"));      
					sql.setString(i++, mi1.getString("VEN_CD"));      
					sql.setString(i++, mi1.getString("BUYER_CD"));      
					sql.setString(i++, mi1.getString("PRC_COND"));      
					sql.setString(i++, mi1.getString("PAYMENT_COND"));      
					sql.setString(i++, mi1.getString("PAYMENT_DTL_COND"));      
					sql.setString(i++, mi1.getString("IMPORT_COUNTRY"));      
					sql.setString(i++, mi1.getString("SHIP_PORT"));      
					sql.setString(i++, mi1.getString("ARRI_PORT"));      
					sql.setString(i++, mi1.getString("LC_DATE"));      
					sql.setString(i++, mi1.getString("LC_NO"));      
					sql.setString(i++, mi1.getString("ETD"));      
					sql.setString(i++, mi1.getString("ETA"));      
					sql.setString(i++, mi1.getString("CURRENCY_CD"));      
					sql.setString(i++, mi1.getString("EXC_APP_DT"));      
					sql.setString(i++, mi1.getString("EXC_RATE"));      
					sql.setString(i++, mi1.getString("PACKING_CHARGE"));      
					sql.setString(i++, mi1.getString("NCV"));      
					sql.setString(i++, mi1.getString("BL_NO"));      
					sql.setString(i++, mi1.getString("ENTRY_DT"));      
					sql.setString(i++, mi1.getString("IMPORT_NO"));     
					sql.setString(i++, mi1.getString("DELI_DT"));      
					sql.setString(i++, mi1.getString("PRC_APP_DT"));       
					sql.setString(i++, mi1.getString("CHK_DT"));      
					sql.setString(i++, mi1.getString("INVOICE_TOT_QTY"));      
					sql.setString(i++, mi1.getString("INVOICE_TOT_AMT"));      
					sql.setString(i++, mi1.getString("INVOICE_WON_TOT_AMT"));     
					sql.setString(i++, mi1.getString("SALE_TOT_AMT"));              /* 매가계 */ 
					sql.setString(i++, mi1.getString("REMARK"));      
					sql.setString(i++, mi1.getString("BIZ_TYPE"));      
					sql.setString(i++, mi1.getString("TAX_FLAG"));      
					sql.setString(i++, mi1.getString("GAP_RATE"));      
					sql.setString(i++, mi1.getString("GAP_TOT_AMT"));   
					sql.setString(i++, userId);
					sql.setString(i++, mi1.getString("STR_CD"));
					sql.setString(i++, mi1.getString("INVOICE_YM"));					
					sql.setString(i++, mi1.getString("INVOICE_SEQ_NO"));					
				}
				
				res = update(sql);
				mstCnt = res;
				sql.close();
				
				if (mstCnt != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				ret += res;
				
				// SMS전송
				sendSMS(form, mi1, userId, org_flag);
			}

			// 상세
			while (mi2.next()) {
		
				sql.close();
				if (mi2.IS_INSERT()) { // 저장
					
					if(!"".equals(strInvoiceSeqNo)){
						mi2.setString("INVOICE_SEQ_NO", strInvoiceSeqNo);
					}
					
					// 1. 전표상세번호 생성
					sql.put(svc.getQuery("SEL_INVOICE_DTL_SEQ_NO"));
					
					sql.setString(1, mi2.getString("STR_CD"));
					sql.setString(2, mi2.getString("INVOICE_YM"));
					sql.setString(3, mi2.getString("INVOICE_SEQ_NO"));
		
					Map mapSeqNo = (Map)selectMap(sql);
					mi2.setString("INVOICE_DTL_SEQ_NO", mapSeqNo.get("INVOICE_DTL_SEQ_NO").toString());    		
					sql.close();
					
					i = 1; 
					// 2. 상세테이블에 저장
					sql.put(svc.getQuery("INS_DETAIL"));

					sql.setString(i++, mi2.getString("STR_CD"));           
					sql.setString(i++, mi2.getString("INVOICE_YM"));   				
					sql.setString(i++, mi2.getString("INVOICE_SEQ_NO"));   		
					sql.setString(i++, mi2.getString("INVOICE_DTL_SEQ_NO"));   			
					sql.setString(i++, mi2.getString("SKU_CD"));   
					sql.setString(i++, mi2.getString("STYLE_CD"));
					sql.setString(i++, mi2.getString("COLOR_CD"));
					sql.setString(i++, mi2.getString("SIZE_CD"));
					sql.setString(i++, mi2.getString("ORD_UNIT_CD"));
					sql.setString(i++, mi2.getString("INVOICE_QTY"));      
					sql.setString(i++, mi2.getString("INVOICE_UNIT_AMT"));	        
					sql.setString(i++, mi2.getString("INVOICE_AMT"));	            
					sql.setString(i++, mi2.getString("INVOICE_KOR_UNIT_AMT"));	            
					sql.setString(i++, mi2.getString("INVOICE_KOR_AMT"));	            
					sql.setString(i++, mi2.getString("SALE_PRC"));	            
					sql.setString(i++, mi2.getString("SALE_AMT"));	            
					sql.setString(i++, mi2.getString("GAP_RATE"));	           
					sql.setString(i++, mi2.getString("PUMMOK_CD"));		          
					sql.setString(i++, mi2.getString("GAP_AMT"));	             
//					sql.setString(i++, "1");	       
					sql.setString(i++, userId); 
					sql.setString(i++, userId);	   
	
				}else if(mi2.IS_UPDATE()){// 수정
					
					i = 1;
					// 2. 상세테이블에 수정
					sql.put(svc.getQuery("UPD_DETAIL")); 

					sql.setString(i++, mi2.getString("SKU_CD"));  
					sql.setString(i++, mi2.getString("STYLE_CD"));       	
					sql.setString(i++, mi2.getString("COLOR_CD"));       	
					sql.setString(i++, mi2.getString("SIZE_CD"));    
					sql.setString(i++, mi2.getString("ORD_UNIT_CD"));   	
					sql.setString(i++, mi2.getString("INVOICE_QTY"));       	
					sql.setString(i++, mi2.getString("INVOICE_UNIT_AMT"));       	
					sql.setString(i++, mi2.getString("INVOICE_AMT"));       	
					sql.setString(i++, mi2.getString("INVOICE_KOR_UNIT_AMT"));       	
					sql.setString(i++, mi2.getString("INVOICE_KOR_AMT"));       	
					sql.setString(i++, mi2.getString("SALE_PRC"));       	
					sql.setString(i++, mi2.getString("SALE_AMT"));       	
					sql.setString(i++, mi2.getString("GAP_RATE")); 
					sql.setString(i++, mi2.getString("PUMMOK_CD"));           
					sql.setString(i++, mi2.getString("GAP_AMT"));	          
//					sql.setString(i++, "1");	         
					sql.setString(i++, userId);
					//조건
					sql.setString(i++, mi2.getString("STR_CD"));        
					sql.setString(i++, mi2.getString("INVOICE_YM"));                           
					sql.setString(i++, mi2.getString("INVOICE_SEQ_NO"));   				
					sql.setString(i++, mi2.getString("INVOICE_DTL_SEQ_NO"));
				}else if(mi2.IS_DELETE()){ // 삭제
					
					// 2. 상세테이블에 삭제
					sql.put(svc.getQuery("DEL_DETAIL")); 
					
					sql.setString(1, mi2.getString("STR_CD"));
					sql.setString(2, mi2.getString("INVOICE_YM"));
					sql.setString(3, mi2.getString("INVOICE_SEQ_NO")); 
					sql.setString(4, mi2.getString("INVOICE_DTL_SEQ_NO")); 
				}				

				res = update(sql);	
				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				ret = res;                                                   
			}			
			
            psql.put("DPS.PR_POINVSLP", 7);    
            psql.setString(1, strPStrCd);        //점
            psql.setString(2, strPInvoiceYm);    //인보이스 년월
            psql.setString(3, strPInvoiceSeqNo); //인보이스 순번
            psql.setString(4, strPSlipNo);       //전표번호 
            psql.setString(5, strPProcFlag);     //저장: SAVE ,삭제 : DELETE

            psql.registerOutParameter(6, DataTypes.INTEGER);//6
            psql.registerOutParameter(7, DataTypes.VARCHAR);//7
            prs = updateProcedure(psql);
            
            resp += prs.getInt(6);    

            if (resp != 0) {
                throw new Exception("[USER]" + prs.getString(7));
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
	 *  의류단품 매입발주  삭제한다.
	 * 
	 * @param form
	 * @param mi1
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int delete(ActionForm form, String userId)
			throws Exception {
		int ret = 0;
		int res = 0;
		int resp    = 0;//프로시저 리턴값
		
		ProcedureWrapper psql = null;	//프로시저 사용위함
		
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;

		String strPStrCd        = "";
		String strPInvoiceYm    = "";  
		String strPInvoiceSeqNo = "";  
		String strPSlipNo       = "";  
		String strPProcFlag     = "";
		
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			psql = new ProcedureWrapper();	//프로시저 사용위함
			svc = (Service) form.getService();			   
			ProcedureResultSet prs = null;
						
			//저장시 프로시저 호출위한 변수 셋팅
			strPStrCd        = form.getParam("strStrCd");
			strPInvoiceYm    = form.getParam("strInvoiceYm");
			strPInvoiceSeqNo = form.getParam("strInvoiceSeqNo");
			strPSlipNo       = form.getParam("strSlipNo");
			strPProcFlag     = "DELETE";	
			
			sql.close();
			sql.put(svc.getQuery("DEL_ALL")); 

			sql.setString(1, form.getParam("strStrCd"));
			sql.setString(2, form.getParam("strInvoiceYm"));
			sql.setString(3, form.getParam("strInvoiceSeqNo"));
			res = update(sql);
			
			sql.close();
			sql.put(svc.getQuery("DEL_MASTER")); 

			sql.setString(1, form.getParam("strStrCd"));
			sql.setString(2, form.getParam("strInvoiceYm"));
			sql.setString(3, form.getParam("strInvoiceSeqNo"));
			res = update(sql);
			
			//발주 헤더에 적용할 프로시저 호출
            psql.put("DPS.PR_POINVSLP", 7);    
            psql.setString(1, strPStrCd);        //점
            psql.setString(2, strPInvoiceYm);    //인보이스 년월
            psql.setString(3, strPInvoiceSeqNo); //인보이스 순번
            psql.setString(4, strPSlipNo);       //전표번호 
            psql.setString(5, strPProcFlag);     //저장: SAVE ,삭제 : DELETE

            psql.registerOutParameter(6, DataTypes.INTEGER);//6
            psql.registerOutParameter(7, DataTypes.VARCHAR);//7
            prs = updateProcedure(psql);
            
            resp += prs.getInt(6);    

            if (resp != 0) {
                throw new Exception("" + prs.getString(7));
            }
			
	
			if (res  < 0) {
				throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
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
     * 행사테마 조회
     *
     * @param  : 
     * @return :
     */
    public List searchOnPop(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd    = String2.nvl(form.getParam("strStrCd"));
		String strSkuCd    = String2.nvl(form.getParam("strSkuCd"));
		String strSOrderDt = String2.nvl(form.getParam("strSOrderDt"));
		String strEOrderDt = String2.nvl(form.getParam("strEOrderDt"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);     
		sql.setString(i++, strSkuCd);     
		sql.setString(i++, strSOrderDt);     
		sql.setString(i++, strEOrderDt);     
		strQuery = svc.getQuery("SEL_ORDER_NO") + "\n";

		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * OFFER_NO 정보 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getOfferNo(ActionForm form) throws Exception {
		
		List ret = null;            
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;           

		String strStrCd     = String2.nvl(form.getParam("strStrCd")); 
		String strOfferNo     = String2.nvl(form.getParam("strOfferNo")); 
		
		sql = new SqlWrapper();                
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(1, strStrCd); 
		sql.setString(2, strOfferNo); 		
		strQuery = svc.getQuery("SEL_OFFER_INFO") + "\n";

		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	} 
	
	/**
	 * INVOICE_NO 정보 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List checkInvoiceNo(ActionForm form) throws Exception {
		
		List ret = null;            
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = ""; 
		int i = 1;           

		String strStrCd       = String2.nvl(form.getParam("strStrCd"));
		String strInvoiceNo   = String2.nvl(form.getParam("strInvoiceNo"));

		sql = new SqlWrapper();                
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(1, strStrCd); 
		sql.setString(2, strInvoiceNo); 		
		strQuery = svc.getQuery("SEL_INVOICE_NO_INFO") + "\n";

		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	} 
	
	/**
	 * 단품코드 상세정보 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getSkuInfo(ActionForm form) throws Exception { 
		
		List ret = null;            
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;           

		String strStrCd     = String2.nvl(form.getParam("strStrCd")); 
		String strOfferNo   = String2.nvl(form.getParam("strOfferNo"));
		String strPrcAppDt  = String2.nvl(form.getParam("strPrcAppDt"));                   
		String strSkuCd  	= String2.nvl(form.getParam("strSkuCd"));
		sql = new SqlWrapper();                
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strPrcAppDt); 
		sql.setString(i++, strOfferNo); 
		sql.setString(i++, strStrCd);     
		sql.setString(i++, strSkuCd); 
		
		strQuery = svc.getQuery("SEL_SKU_INFO") + "\n";

		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
   
	/**
	 * 단품 매가원가
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getOffSkuInfo(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null; 
		Service svc = null;
		String strQuery = "";
		int i = 1; 

		String strStrCd  = String2.nvl(form.getParam("strStrCd")); 
		String strSkuCd  = String2.nvl(form.getParam("strSkuCd"));
		String strAppDt  = String2.nvl(form.getParam("strAppDt"));
		String strOfferYm    = String2.nvl(form.getParam("strOfferYm"));
		String strOfferSeqNo = String2.nvl(form.getParam("strOfferSeqNo")); 
		Double strExcRate    = Double.valueOf(form.getParam("strExcRate"));   

		sql = new SqlWrapper();
		svc = (Service) form.getService(); 
 
		connect("pot");   

		sql.setDouble(i++, strExcRate);
		sql.setDouble(i++, strExcRate);
		sql.setDouble(i++, strExcRate);
		sql.setDouble(i++, strExcRate);
		sql.setDouble(i++, strExcRate);      
		sql.setDouble(i++, strExcRate);
	 
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSkuCd);
		sql.setString(i++, strAppDt);

		sql.setString(i++, strStrCd);
		sql.setString(i++, strOfferYm);
		sql.setString(i++, strOfferSeqNo);
		sql.setString(i++, strSkuCd);		
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSkuCd);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strOfferYm);
		sql.setString(i++, strOfferSeqNo);
		
		strQuery = svc.getQuery("SEL_SKU_SALE_PRC") + "\n";
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 *  <p>
	 *  SMS발송
	 *  
	 *  </p> 
	 * @param form
	 * @param mi1
	 * @param userId
	 * @param org_flag
	 * @return
	 * @throws Exception
	 */
	public int sendSMS(ActionForm form, MultiInput mi1, String userId, String org_flag) 
						throws Exception {

		int ret  = 0;
		int res  = 0;
		int resp = 0;     //프로시저 리턴값
		SqlWrapper sql = null;
		Service svc = null;
		int i;		
		
		ProcedureWrapper psql = null;	//프로시저 사용위함
		try {
			if( getTrConnection() == null){
				connect("pot");
				begin();
			}
			
			psql = new ProcedureWrapper();	//프로시저 사용위함
			ProcedureResultSet prs = null;
			
			psql.put("DPS.PR_POSLPSMS_IFS", 8);  
		    
			i = 1;
            psql.setString(i++, mi1.getString("STR_CD")); 				// 점코드
            psql.setString(i++, mi1.getString("SLIP_NO")); 				// 전표번호
            psql.setString(i++, mi1.getString("SLIP_PROC_STAT"));		// 전표상태
            psql.setString(i++, userId);								// 처리자
            psql.setString(i++, org_flag);							    // 조직구분
            psql.setString(i++, "0");							        // 처리구분(0:승인, 1:반려, 2:검품취소)   

            psql.registerOutParameter(i++, DataTypes.INTEGER);//7
            psql.registerOutParameter(i++, DataTypes.VARCHAR);//8


            prs = updateProcedure(psql);             
            
            resp += prs.getInt(7);    
           // if (resp <= 0) {
           //     throw new Exception("[USER]"+ prs.getString(8));
           // }                                          
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
	 * INVOICE 체크사항
	 *  
	 * @param form
	 * @return
	 * @throws Exception
	 */ 
	public List chkInvoiceStat(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String  strStrCd	= String2.nvl(form.getParam("strStrCd"));
		String  strOfferNo	= URLDecoder.decode(String2.nvl(form.getParam("strOfferNo")), "UTF-8");
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");		

		sql.setString(i++, strStrCd);  
		sql.setString(i++, strOfferNo);  
		sql.put(svc.getQuery("CHK_INVOICE_STAT")); 
		
		ret = select2List(sql);
		return ret;
	}
}
