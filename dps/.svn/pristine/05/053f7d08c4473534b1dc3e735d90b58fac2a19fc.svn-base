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
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import common.util.Util; 


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

public class POrd503DAO extends AbstractDAO {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */    	
	
	/**
	 * 규격단품 매입발주 리스트 내역 조회
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

		String strStrCd		= String2.nvl(form.getParam("strStrCd"));
		String strSOfferDt	= String2.nvl(form.getParam("strSOfferDt"));
		String strEOfferDt	= String2.nvl(form.getParam("strEOfferDt")); 
		
		String strOfferNo	= URLDecoder.decode(String2.nvl(form.getParam("strOfferNo")), "UTF-8");
		Integer intOfferNo	= 0;
		
		String strPumbun	= String2.nvl(form.getParam("strPumbun"));
		String strVen		= String2.nvl(form.getParam("strVen"));
		 
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");		
/*		
		if("".equals(strOfferNo)){
			sql.setString(i++, strStrCd);     
			sql.setString(i++, strSOfferDt);     
			sql.setString(i++, strEOfferDt);        
			sql.setString(i++, strPumbun);
			sql.setString(i++, strVen);  
			sql.setString(i++, strStrCd);     
			sql.setString(i++, strSOfferDt);     
			sql.setString(i++, strEOfferDt);        
			sql.setString(i++, strPumbun);
			sql.setString(i++, strVen);   		
			sql.setString(i++, userId);   		
			strQuery = svc.getQuery("SEL_LIST_ODD_OFFER_NO") + "\n";
			
		}else{		
*/		
//			intOfferNo	= Integer.valueOf(strOfferNo);
			sql.setString(i++, strStrCd);     
			sql.setString(i++, strSOfferDt);      
			sql.setString(i++, strEOfferDt);         
//			sql.setInt(i++, intOfferNo);      
			sql.setString(i++, strOfferNo);      
			sql.setString(i++, strPumbun);
			sql.setString(i++, strVen);  
			sql.setString(i++, strStrCd);     
			sql.setString(i++, strSOfferDt);      
			sql.setString(i++, strEOfferDt);         
//			sql.setInt(i++, intOfferNo);      
			sql.setString(i++, strOfferNo);      
			sql.setString(i++, strPumbun);
			sql.setString(i++, strVen);   	
			sql.setString(i++, strStrCd);     
			sql.setString(i++, strSOfferDt);      
			sql.setString(i++, strEOfferDt);         
//			sql.setInt(i++, intOfferNo);      
			sql.setString(i++, strOfferNo);      
			sql.setString(i++, strPumbun);
			sql.setString(i++, strVen);   		
			sql.setString(i++, userId);   		
			sql.setString(i++, org_flag);   		
			strQuery = svc.getQuery("SEL_LIST") + "\n";					
//		}

		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 규격단품 매입발주 마스터 내역 조회
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
		String strOfferYm = String2.nvl(form.getParam("strOfferYm"));
		String strOfferSeqNo = String2.nvl(form.getParam("strOfferSeqNo"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStrCd);     
		sql.setString(i++, strOfferYm);     
		sql.setString(i++, strOfferSeqNo);  
		
		strQuery = svc.getQuery("SEL_MASTER") + "\n";

		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 규격단품 매입발주  상세 내역 조회
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
		String strOfferYm = String2.nvl(form.getParam("strOfferYm"));
		String strOfferSeqNo = String2.nvl(form.getParam("strOfferSeqNo"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);   
		sql.setString(i++, strStrCd);   
		sql.setString(i++, strStrCd);     
		sql.setString(i++, strOfferYm);     
		sql.setString(i++, strOfferSeqNo);  
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";

		sql.put(strQuery);

//		System.out.println("Why?"); 
		ret = select2List(sql);
//		System.out.println("ret.size() " + ret.size());

		return ret;
	}
    
	/**
	 *  의류단품 매입발주  등록/수정한다. 
	 * 
	 * @param form
	 * @param mi1
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi1, MultiInput mi2, String userId)
			throws Exception {

		int ret 	= 0;
		int res 	= 0;
		int i   	= 0;
		int mstCnt 	= 0;	
		
		String strOfferSeqNo  = "";		// 전표번호
		
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
	
					// 2. 전표번호를 생성한다.(시퀀스사용)
					sql.put(svc.getQuery("SEL_ORD_SEQ_NO"));
					
					Map mapOfferSeqNo = (Map)selectMap(sql);
					strOfferSeqNo = mapOfferSeqNo.get("OFFER_SEQ_NO").toString();
					mi1.setString("OFFER_SEQ_NO", strOfferSeqNo);
					sql.close();
					
					
					String strOfferDt = String2.nvl(form.getParam("strOfferDt"));
					String strOfferYm = String2.nvl(form.getParam("strOfferYm"));
					String strOfferNo = String2.nvl(form.getParam("strOfferNo"));
					

					//숫자형으로 형변환
					int intOfferSeqNo  =  Integer.valueOf(strOfferSeqNo);
//					int intOfferTotQty = Integer.valueOf(mi1.getString("OFFER_TOT_QTY"));
//					int intOfferTotAmt = Integer.valueOf(mi1.getString("OFFER_TOT_AMT"));
					
//					String strOfferSheetNo = mi1.getString("STR_CD") + strOfferYm + String.format("%05d", intOfferSeqNo);
					 
					i = 1;  
					// 3. 마스터테이블에 저장
					sql.put(svc.getQuery("INS_MASTER"));
					
					sql.setString(i++, mi1.getString("STR_CD"));   
					sql.setString(i++, strOfferYm);  
					sql.setInt(i++, intOfferSeqNo);   
					sql.setString(i++, strOfferDt);     
					sql.setString(i++, mi1.getString("OFFER_SHEET_NO"));  	 
					sql.setString(i++, mi1.getString("PUMBUN_CD"));  
					sql.setString(i++, mi1.getString("VEN_CD"));      
					sql.setString(i++, mi1.getString("BUYER_CD"));  
					sql.setString(i++, mi1.getString("PRC_COND"));      
					sql.setString(i++, mi1.getString("SHIPPMENT_CD"));  
					sql.setString(i++, mi1.getString("CURRENCY_CD"));    
					sql.setString(i++, mi1.getString("OFFER_TOT_QTY"));  
					sql.setString(i++, mi1.getString("OFFER_TOT_AMT"));    
//					sql.setInt(i++, intOfferTotQty);   
//					sql.setInt(i++, intOfferTotAmt);   
					sql.setString(i++, mi1.getString("PAYMENT_COND"));  
					sql.setString(i++, mi1.getString("PAYMENT_DTL_COND"));      
					sql.setString(i++, mi1.getString("SHIP_PORT"));  
					sql.setString(i++, mi1.getString("ARRI_PORT"));      
					sql.setString(i++, mi1.getString("LC_DATE"));  
					sql.setString(i++, mi1.getString("LC_NO"));      
					sql.setString(i++, mi1.getString("LC_EFFECTIVE_DT"));  
					sql.setString(i++, mi1.getString("LC_OPEN_BANK"));      
					sql.setString(i++, mi1.getString("VENDOR_INFO"));  
					sql.setString(i++, mi1.getString("IMPORT_COUNTRY"));      
					sql.setString(i++, mi1.getString("ATTN"));  
					sql.setString(i++, mi1.getString("MESSRS"));      
					sql.setString(i++, mi1.getString("VALIDITY"));  
					sql.setString(i++, mi1.getString("SHIPPMENT"));      
					sql.setString(i++, mi1.getString("PACKING"));  
					sql.setString(i++, mi1.getString("INSURANCE"));      
					sql.setString(i++, mi1.getString("PRICE"));  
					sql.setString(i++, mi1.getString("ORIGIN"));      
					sql.setString(i++, mi1.getString("INSPECTION"));  
					sql.setString(i++, mi1.getString("DELIVERY"));      
					sql.setString(i++, mi1.getString("BL_NO"));  
					sql.setString(i++, mi1.getString("BL_DT"));      
					sql.setString(i++, mi1.getString("COMMODITY"));  
					sql.setString(i++, mi1.getString("PACKING_CHARGE"));      
					sql.setString(i++, mi1.getString("NCV"));  
					sql.setString(i++, mi1.getString("SHIPPER"));      
					sql.setString(i++, mi1.getString("EXC_APP_DT"));  
					sql.setString(i++, mi1.getString("EXC_RATE"));      
//					sql.setString(i++, mi1.getString("CLOSE_FLAG"));    
					sql.setString(i++, "N");  
					sql.setString(i++, mi1.getString("CLOSE_DT"));      
//					sql.setString(i++, mi1.getString("EXPNC_CLOSE_FLAG")); 
					sql.setString(i++, "N");  
//					sql.setString(i++, mi1.getString("COST_CLOSE_FLAG"));   
					sql.setString(i++, "N");      
					sql.setString(i++, mi1.getString("PAYMENT"));  
					sql.setString(i++, userId); 
					sql.setString(i++, userId);

				}else if(mi1.IS_UPDATE()){// 수정
					 
					i = 1;
					// 3. 마스터테이블에 수정
					sql.put(svc.getQuery("UPD_MASTER")); 
					
					sql.setString(i++, mi1.getString("BUYER_CD"));     
					sql.setString(i++, mi1.getString("PRC_COND"));        
					sql.setString(i++, mi1.getString("SHIPPMENT_CD"));
					sql.setString(i++, mi1.getString("CURRENCY_CD"));  
					sql.setString(i++, mi1.getString("OFFER_TOT_QTY"));        
					sql.setString(i++, mi1.getString("OFFER_TOT_AMT"));        
					sql.setString(i++, mi1.getString("PAYMENT_COND"));
					sql.setString(i++, mi1.getString("PAYMENT_DTL_COND"));  
					sql.setString(i++, mi1.getString("SHIP_PORT"));        
					sql.setString(i++, mi1.getString("ARRI_PORT"));        
					sql.setString(i++, mi1.getString("LC_DATE"));
					sql.setString(i++, mi1.getString("LC_NO"));  
					sql.setString(i++, mi1.getString("LC_EFFECTIVE_DT"));        
					sql.setString(i++, mi1.getString("LC_OPEN_BANK"));        
					sql.setString(i++, mi1.getString("VENDOR_INFO"));
					sql.setString(i++, mi1.getString("IMPORT_COUNTRY"));
					sql.setString(i++, mi1.getString("ATTN"));
					sql.setString(i++, mi1.getString("MESSRS"));        
					sql.setString(i++, mi1.getString("VALIDITY"));        
					sql.setString(i++, mi1.getString("SHIPPMENT"));
					sql.setString(i++, mi1.getString("PACKING"));  
					sql.setString(i++, mi1.getString("INSURANCE"));        
					sql.setString(i++, mi1.getString("PRICE"));       
					sql.setString(i++, mi1.getString("ORIGIN")); 
					sql.setString(i++, mi1.getString("INSPECTION"));  
					sql.setString(i++, mi1.getString("DELIVERY"));        
					sql.setString(i++, mi1.getString("BL_NO"));        
					sql.setString(i++, mi1.getString("BL_DT"));
					sql.setString(i++, mi1.getString("COMMODITY"));  
					sql.setString(i++, mi1.getString("PACKING_CHARGE"));   
					sql.setString(i++, mi1.getString("NCV"));   
					sql.setString(i++, mi1.getString("SHIPPER"));   
					sql.setString(i++, mi1.getString("EXC_APP_DT"));   
					sql.setString(i++, mi1.getString("EXC_RATE"));   
					System.out.println("수정타나");
//					sql.setString(i++, mi1.getString("MOD_DATE"));   
					sql.setString(i++, userId);
					sql.setString(i++, mi1.getString("STR_CD"));
					sql.setString(i++, mi1.getString("OFFER_YM"));					
					sql.setString(i++, mi1.getString("OFFER_SEQ_NO"));			
//					sql.setString(i++, mi1.getString("OFFER_SHEET_NO"));
				}
				res = update(sql);
				mstCnt = res;
				sql.close();
				
				if (mstCnt != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				ret += res;
			}

			
			// 상세
			while (mi2.next()) {
		
				sql.close();
				if (mi2.IS_INSERT()) { // 저장
					 
					if(!"".equals(strOfferSeqNo)){
						mi2.setString("OFFER_SEQ_NO", strOfferSeqNo);
					}
					
					// 1. 전표상세번호 생성
					sql.put(svc.getQuery("SEL_OFF_DTL_SEQ_NO"));
					
					sql.setString(1, mi2.getString("STR_CD"));
					sql.setString(2, mi2.getString("OFFER_YM"));
					sql.setString(3, mi2.getString("OFFER_SEQ_NO"));
		
					Map mapSeqNo = (Map)selectMap(sql);
					mi2.setString("OFFER_DTL_SEQ_NO", mapSeqNo.get("OFFER_DTL_SEQ_NO").toString());    		
					sql.close();
					
					i = 1; 					
					
					// 2. 상세테이블에 저장
					sql.put(svc.getQuery("INS_DETAIL"));					  
					sql.setString(i++, mi2.getString("STR_CD"));           
					sql.setString(i++, mi2.getString("OFFER_YM"));   				
					sql.setString(i++, mi2.getString("OFFER_SEQ_NO"));   	
					sql.setString(i++, mi2.getString("OFFER_DTL_SEQ_NO"));  
					sql.setString(i++, mi2.getString("SKU_CD"));   
					sql.setString(i++, mi2.getString("ORD_UNIT_CD"));   
					sql.setString(i++, mi2.getString("STYLE_CD"));
					sql.setString(i++, mi2.getString("COLOR_CD"));
					sql.setString(i++, mi2.getString("SIZE_CD"));
					sql.setString(i++, mi2.getString("OFFER_QTY"));
					sql.setString(i++, mi2.getString("OFFER_UNIT_AMT"));      
					sql.setString(i++, mi2.getString("OFFER_AMT"));	        
					sql.setString(i++, mi2.getString("ORDER_YM"));	 
//					sql.setString(i++, mi2.getString("ORDER_SEQ_NO"));		           
					sql.setString(i++, mi2.getString("ORDER_NO"));	   
					sql.setString(i++, userId); 
					sql.setString(i++, userId);
				}else if(mi2.IS_UPDATE()){// 수정
					
					i = 1;
					// 2. 상세테이블에 수정
					sql.put(svc.getQuery("UPD_DETAIL"));  
 
					sql.setString(i++, mi2.getString("SKU_CD"));    
					sql.setString(i++, mi2.getString("ORD_UNIT_CD"));             			
					sql.setString(i++, mi2.getString("STYLE_CD")); 
					sql.setString(i++, mi2.getString("COLOR_CD"));
					sql.setString(i++, mi2.getString("SIZE_CD"));
					sql.setString(i++, mi2.getString("OFFER_QTY"));
					sql.setString(i++, mi2.getString("OFFER_UNIT_AMT"));
					sql.setString(i++, mi2.getString("OFFER_AMT"));         
					sql.setString(i++, mi2.getString("ORDER_YM"));	 
					sql.setString(i++, mi2.getString("ORDER_SEQ_NO"));	        
					sql.setString(i++, mi2.getString("ORDER_NO"));	  	  
					sql.setString(i++, userId);
					sql.setString(i++, mi2.getString("STR_CD"));        
					sql.setString(i++, mi2.getString("OFFER_YM"));                           
					sql.setString(i++, mi2.getString("OFFER_SEQ_NO"));   				
					sql.setString(i++, mi2.getString("OFFER_DTL_SEQ_NO"));
					
				}else if(mi2.IS_DELETE()){ // 삭제
					
					// 2. 상세테이블에 삭제
					sql.put(svc.getQuery("DEL_DETAIL")); 
					
					sql.setString(1, mi2.getString("STR_CD"));
					sql.setString(2, mi2.getString("OFFER_YM"));
					sql.setString(3, mi2.getString("OFFER_SEQ_NO")); 
					sql.setString(4, mi2.getString("OFFER_DTL_SEQ_NO"));         
				}
				res = update(sql);
				
				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				ret = res;                                                   
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
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			sql.close();
			sql.put(svc.getQuery("DEL_ALL")); 

			sql.setString(1, form.getParam("strStrCd"));
			sql.setString(2, form.getParam("strOfferYm"));
			sql.setString(3, form.getParam("strOfferSeqNo"));
			res = update(sql);
			
					
			sql.close();
			sql.put(svc.getQuery("DEL_MASTER")); 

			sql.setString(1, form.getParam("strStrCd"));
			sql.setString(2, form.getParam("strOfferYm"));
			sql.setString(3, form.getParam("strOfferSeqNo"));
			res = update(sql);

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
     * ORDER NO 조회
     *
     * @param  : 
     * @return :
     */
    public List searchOfferrNo(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strOfferNo    = String2.nvl(form.getParam("strOfferNo"));
		System.out.println("00000"); 


		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strOfferNo);      
		strQuery = svc.getQuery("SEL_CHECK_OFFER_NO") + "\n";

		sql.put(strQuery);

//		System.out.println("Why?");
		ret = select2List(sql);
//		System.out.println("ret.size() " + ret.size());

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
		String strOrder    = String2.nvl(form.getParam("strOrder"));

		System.out.println("strSOrderDt = " + strSOrderDt);
		System.out.println("strEOrderDt = " + strEOrderDt);
		System.out.println("99999");

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);     
		sql.setString(i++, strSkuCd);     
		sql.setString(i++, strSOrderDt);     
		sql.setString(i++, strEOrderDt);    
		sql.setString(i++, strOrder);     
		strQuery = svc.getQuery("SEL_ORDER_INFO") + "\n";

		sql.put(strQuery);

//		System.out.println("Why?");
		ret = select2List(sql);
//		System.out.println("ret.size() " + ret.size());

		return ret;
	}
	   
    /**
     * ORDER NO 조회
     *
     * @param  : 
     * @return :
     */
    public List searchOrderNo(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strStrCd    = String2.nvl(form.getParam("strStrCd"));
		String strSkuCd    = String2.nvl(form.getParam("strSkuCd"));
		String strOrder    = String2.nvl(form.getParam("strOrder"));
		System.out.println("88888");


		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);   
		sql.setString(i++, strSkuCd);        
		sql.setString(i++, strOrder);     
		strQuery = svc.getQuery("SEL_ORDER_NO") + "\n";

		sql.put(strQuery);

//		System.out.println("Why?");
		ret = select2List(sql);
//		System.out.println("ret.size() " + ret.size());

		return ret;
	}
    

	/**
	 * 단품 매가원가
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

		String strStrCd	= String2.nvl(form.getParam("strStrCd"));
		String strSkuCd	= String2.nvl(form.getParam("strSkuCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strSkuCd);

		strQuery = svc.getQuery("SEL_SKU_SALE_PRC") + "\n";
//		System.out.println("strquery : "+ strQuery);
		sql.put(strQuery);
		ret = select2List(sql);
		//System.out.println("Mret.size()= " + ret.size());
		return ret;

	}
	
	/**
	 * offer_no 삭제가능여부
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List checkTreatmentOffNo(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strOfferYm = String2.nvl(form.getParam("strOfferYm"));
		String strOfferSeqNo = String2.nvl(form.getParam("strOfferSeqNo"));
		//String strOfferSheetNo = String2.nvl(form.getParam("strOfferSheetNo"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);     
		sql.setString(i++, strOfferYm);     
		sql.setString(i++, strOfferSeqNo);  
		
		sql.setString(i++, strStrCd);     
		sql.setString(i++, strOfferYm);     
		sql.setString(i++, strOfferSeqNo);  
		
		sql.setString(i++, strStrCd);     
		sql.setString(i++, strOfferYm);     
		sql.setString(i++, strOfferSeqNo);  
		
		strQuery = svc.getQuery("CHK_TREATMENT_OFF_NO") + "\n";

		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
}
