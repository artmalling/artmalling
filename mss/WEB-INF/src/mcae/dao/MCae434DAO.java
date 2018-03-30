/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mcae.dao;

import java.util.ArrayList;
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
 * <p>
 * 사은품 지급등록
 * </p>
 * 
 * @created on 1.0, 2016/11/15
 * @created by KHJ(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MCae434DAO extends AbstractDAO {
	
	/**
	 * 사은행사 정보 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getEventCombo(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strPrsntDt = String2.nvl(form.getParam("strPrsntDt"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strPrsntDt);

		strQuery = svc.getQuery("SEL_EVENT_COMBO") + "\n";

		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	
	/**
	 * 사은행사 정보 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getEventInfo(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strPrsntDt = String2.nvl(form.getParam("strPrsntDt"));
		String strEventCd = String2.nvl(form.getParam("strEventCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strPrsntDt);
		//sql.setString(i++, strEventCd);

		strQuery = svc.getQuery("SEL_EVENT_INFO") + "\n";

		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}



	/**
	 * 영수증 브랜드 사은 합산/개별 정보 조회 <= 영수증번호사용
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List[] getPbSaleInfo_all(ActionForm form, MultiInput mi) throws Exception {

		List ret[] = new List[4];
		List rtn[] = new List[4];
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		List retArr_a = null;
		List retArr_b = null;
		
	    String strEventCd_a = "";
	    String strEventCd_b = "";
	    
	    int SALE_AMT_TAX_a = 0;
	    int SALE_AMT_TAX_b = 0;
	    int APP_RATE_AMT_a = 0;
	    int APP_RATE_AMT_b = 0;
	    
	    String strF_RECEIPT_NO_a = "";
	    int ECEIPT_CNT_a = 0;
	    String strF_RECEIPT_NO_b = "";
	    int ECEIPT_CNT_b = 0;
	    
		String strgbn = "1";    
	    
		String strPrsntDt = String2.nvl(form.getParam("strPrsntDt"));   // 등록일자, 사은품 지급일자.

		System.out.println("getPbSaleInfo_all------- : " +strPrsntDt);
		rtn[0]  = new ArrayList();
		rtn[1]  = new ArrayList();
		rtn[2]  = new ArrayList();
		rtn[3]  = new ArrayList();

		connect("pot");
		
		//-- 영수증 번호만큼 돌면서 조회
		while (mi.next()) {
			if (!mi.IS_DELETE()) {
				i = 1;
	
				String strStrCd = mi.getString("STR_CD");
				String strSaleDt = mi.getString("SALE_DT");                       //--영수증 매출일자
				String strPosNo = mi.getString("RECEIPT_NO").substring(8, 12);    //--영수증 pos번호
				String strTranNo = mi.getString("RECEIPT_NO").substring(12, 17);  //--영수증 tran번호
				String strRECEIPT_NO = strStrCd + mi.getString("RECEIPT_NO");
	
				sql = new SqlWrapper();
				svc = (Service) form.getService();
						
				// KSH 20120727 
				sql.setString(i++, strRECEIPT_NO);
				sql.setString(i++, strStrCd);
				sql.setString(i++, strPrsntDt);     //지급일자- 행사기간을 조회
				sql.setString(i++, strStrCd);
				sql.setString(i++, strPrsntDt);     //지급일자- 행사기간을 조회
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strSaleDt);
				sql.setString(i++, strPosNo);
				sql.setString(i++, strTranNo);
				
				sql.setString(i++, strStrCd);
				sql.setString(i++, strSaleDt);
				sql.setString(i++, strPosNo);
				sql.setString(i++, strTranNo);
				
				//-- 당일 영수증(지급일기준)
				if (strPrsntDt.equals(strSaleDt)) {
					System.out.println("브랜드사은행사------당일영수증");
					strQuery =  svc.getQuery("SEL_PB_SALE_INFO");     // 브랜드사은행사
					sql.put(strQuery);
					ret[0] = select2List(sql);
			
					sql.close();   		
			        for(int a = 0; a < ret[0].size(); a++) {
	
			            System.out.println("a 1----------" + a + " : value " +  ret[0].get(a));
			            
			            retArr_a  = (List)ret[0].get(a);
						strEventCd_a = retArr_a.get(1).toString();
	
					    SALE_AMT_TAX_a = Integer.parseInt(retArr_a.get(2).toString());
					    APP_RATE_AMT_a = Integer.parseInt(retArr_a.get(3).toString());
	
					    ECEIPT_CNT_a = Integer.parseInt(retArr_a.get(5).toString());
					    strF_RECEIPT_NO_a = retArr_a.get(6).toString();				    
					    
					    if (rtn[0].size() > 0){
							for(int b = 0; b < rtn[0].size(); b++) {
								strgbn = "1";
		
					            System.out.println("b 1----------" + b + " : value " +  rtn[0].get(b));
					            
					            retArr_b  = (List)rtn[0].get(b);
								strEventCd_b = retArr_b.get(1).toString();
		
							    SALE_AMT_TAX_b = Integer.parseInt(retArr_b.get(2).toString());
							    APP_RATE_AMT_b = Integer.parseInt(retArr_b.get(3).toString());
	
							    ECEIPT_CNT_b      = Integer.parseInt(retArr_b.get(5).toString());
							    strF_RECEIPT_NO_b = retArr_b.get(6).toString();
							    
								System.out.println("strEventCd_a-------" + strEventCd_a); 
								System.out.println("strEventCd_b------ " + strEventCd_b);  
								System.out.println("SALE_AMT_TAX_a-------" + SALE_AMT_TAX_a); 
								System.out.println("APP_RATE_AMT_a------ " + APP_RATE_AMT_a); 
								System.out.println("SALE_AMT_TAX_b-------" + SALE_AMT_TAX_b); 
								System.out.println("APP_RATE_AMT_b------ " + APP_RATE_AMT_b); 
								
								
								if (strEventCd_b.equals(strEventCd_a)) {
						            System.out.println("flus 1----------" + b + " : value " +  rtn[0].get(b));
						            
									retArr_b.set(2, Integer.toString(SALE_AMT_TAX_a + SALE_AMT_TAX_b));
									retArr_b.set(3, Integer.toString(APP_RATE_AMT_a + APP_RATE_AMT_b));	
									retArr_b.set(5, Integer.toString(ECEIPT_CNT_a + ECEIPT_CNT_b));
									retArr_b.set(6, (strF_RECEIPT_NO_a + strF_RECEIPT_NO_b));
									
									strgbn = "0";	
									break;								
								} 
							}	
	
							if (!strgbn.equals("0")) {
								System.out.println("add 1---------- " +  ret[0].get(a));
								rtn[0].add(ret[0].get(a));	
								strgbn = "1";
							}
					    } else {
					    	System.out.println("add 1----------" );
					    	rtn[0].add(ret[0].get(a));
					    }
			        }
	
					System.out.println("결제유형별행사매출------당일영수증");
					strQuery = "";
					strQuery =  svc.getQuery("SEL_PAID_SALE_INFO");    //결제유형별행사매출
					sql.put(strQuery);
					
					i = 1;
					sql.setString(i++, strRECEIPT_NO);

					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDt);
					sql.setString(i++, strPosNo);
					sql.setString(i++, strTranNo);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDt);
					sql.setString(i++, strPosNo);
					sql.setString(i++, strTranNo);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDt);
					sql.setString(i++, strPosNo);
					sql.setString(i++, strTranNo);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strPrsntDt);            //지급일자- 행사기간을 조회
					sql.setString(i++, strStrCd);
					sql.setString(i++, strPrsntDt);            //지급일자- 행사기간을 조회
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDt);
					sql.setString(i++, strPosNo);
					sql.setString(i++, strTranNo);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDt);
					sql.setString(i++, strPosNo);
					sql.setString(i++, strTranNo);
					
					ret[1] = select2List(sql); 
					sql.close();   	           
		    		
			        for(int a = 0; a < ret[1].size(); a++) {
			            System.out.println("a 2----------" + a + " : value " + ret[1].get(a));
	
			            retArr_a  = (List)ret[1].get(a);
						strEventCd_a = retArr_a.get(1).toString();
	
					    SALE_AMT_TAX_a = Integer.parseInt(retArr_a.get(5).toString());
	
					    ECEIPT_CNT_a = Integer.parseInt(retArr_a.get(7).toString());
					    strF_RECEIPT_NO_a = retArr_a.get(8).toString();	
					    
					    if (rtn[1].size() > 0){
							for(int b = 0; b < rtn[1].size(); b++) {
								strgbn = "1";
					            System.out.println("b 2----------" + b + " : value " +  rtn[1].get(b));
					            
					            retArr_b  = (List)rtn[1].get(b);
								strEventCd_b = retArr_b.get(1).toString();
		
							    SALE_AMT_TAX_b = Integer.parseInt(retArr_b.get(5).toString());
	
							    ECEIPT_CNT_b      = Integer.parseInt(retArr_b.get(7).toString());
							    strF_RECEIPT_NO_b = retArr_b.get(8).toString();
							    
								System.out.println("strEventCd_a-------" + strEventCd_a); 
								System.out.println("strEventCd_b------ " + strEventCd_b);  
								System.out.println("SALE_AMT_TAX_a-------" + SALE_AMT_TAX_a); 
								System.out.println("SALE_AMT_TAX_b-------" + SALE_AMT_TAX_b); 
								
								if (strEventCd_b.equals(strEventCd_a)) {
	
						            System.out.println("flus 2----------" + b + " : value " +  rtn[1].get(b));								
									retArr_b.set(5, Integer.toString(SALE_AMT_TAX_a + SALE_AMT_TAX_b));
									retArr_b.set(7, Integer.toString(ECEIPT_CNT_a + ECEIPT_CNT_b));
									retArr_b.set(8, (strF_RECEIPT_NO_a + strF_RECEIPT_NO_b));
									strgbn = "0";	
									break;								
								} 		            
					        }
							
							if (!strgbn.equals("0")) {
								System.out.println("add 2---------- " +  ret[1].get(a));
								rtn[1].add(ret[1].get(a));
								strgbn = "1";		
							}	
							
					    } else {
					    	System.out.println("add 2----------" );
					    	rtn[1].add(ret[1].get(a));
					    }
			        }
			        
	
					System.out.println("제휴카드사은행사------당일영수증");
					strQuery = "";
					strQuery =  svc.getQuery("SEL_CARD_SALE_INFO");    //제휴카드사은행사매출
					sql.put(strQuery);
					
					i = 1;
					sql.setString(i++, strRECEIPT_NO);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDt);
					sql.setString(i++, strPosNo);
					sql.setString(i++, strTranNo);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strPrsntDt);        //지급일자- 행사기간을 조회
					sql.setString(i++, strStrCd);
					sql.setString(i++, strPrsntDt);        //지급일자- 행사기간을 조회
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDt);
					sql.setString(i++, strPosNo);
					sql.setString(i++, strTranNo);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDt);
					sql.setString(i++, strPosNo);
					sql.setString(i++, strTranNo);
					
					ret[2] = select2List(sql);         
					sql.close();
			        for(int a = 0; a < ret[2].size(); a++) {
			            System.out.println("a 3----------" + a + " : value " + ret[2].get(a));
	
			            retArr_a  = (List)ret[2].get(a);
						strEventCd_a = retArr_a.get(1).toString();
	
					    SALE_AMT_TAX_a = Integer.parseInt(retArr_a.get(3).toString());
					    
					    ECEIPT_CNT_a = Integer.parseInt(retArr_a.get(5).toString());
					    strF_RECEIPT_NO_a = retArr_a.get(6).toString();	
					    
					    if (rtn[2].size() > 0){
							for(int b = 0; b < rtn[2].size(); b++) {
								strgbn = "1";
		
					            System.out.println("b 3----------" + b + " : value " +  rtn[2].get(b));
					            
					            retArr_b  = (List)rtn[2].get(b);
								strEventCd_b = retArr_b.get(1).toString();
		
							    SALE_AMT_TAX_b = Integer.parseInt(retArr_b.get(3).toString());
							    
							    ECEIPT_CNT_b      = Integer.parseInt(retArr_b.get(5).toString());
							    strF_RECEIPT_NO_b = retArr_b.get(6).toString();
		
								System.out.println("strEventCd_a-------" + strEventCd_a); 
								System.out.println("strEventCd_b------ " + strEventCd_b);  
								System.out.println("SALE_AMT_TAX_a-------" + SALE_AMT_TAX_a); 
								System.out.println("SALE_AMT_TAX_b-------" + SALE_AMT_TAX_b); 
								
								if (strEventCd_b.equals(strEventCd_a)) {
	
						            System.out.println("flus 3----------" + b + " : value " +  rtn[2].get(b));								
									retArr_b.set(3, Integer.toString(SALE_AMT_TAX_a + SALE_AMT_TAX_b));
									retArr_b.set(5, Integer.toString(ECEIPT_CNT_a + ECEIPT_CNT_b));
									retArr_b.set(6, (strF_RECEIPT_NO_a + strF_RECEIPT_NO_b));
									strgbn = "0";	
									break;
									
								} 		            
					        }
							if (!strgbn.equals("0")) {
								System.out.println("add 3---------- " +  ret[2].get(a));
								rtn[2].add(ret[2].get(a));
								strgbn = "1";					
							}	
							
					    } else {
					    	System.out.println("add 3----------" );
					    	rtn[2].add(ret[2].get(a));
					    }
			        }
			        
			        
			        System.out.println("회원대상 ------당일영수증");
					strQuery = "";
					strQuery =  svc.getQuery("SEL_MEMB_INFO");    //제휴카드사은행사매출
					sql.put(strQuery);
					
					i = 1;
					sql.setString(i++, strRECEIPT_NO);
					
				
					sql.setString(i++, strStrCd);
					sql.setString(i++, strPrsntDt);        //지급일자- 행사기간을 조회
					sql.setString(i++, strStrCd);
					sql.setString(i++, strPrsntDt);        //지급일자- 행사기간을 조회
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDt);
					sql.setString(i++, strPosNo);
					sql.setString(i++, strTranNo);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDt);
					sql.setString(i++, strPosNo);
					sql.setString(i++, strTranNo);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDt);
					sql.setString(i++, strPosNo);
					sql.setString(i++, strTranNo);
					
					sql.setString(i++, strPrsntDt);
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDt);
					sql.setString(i++, strPosNo);
					sql.setString(i++, strTranNo);
					
					ret[3] = select2List(sql);         
		    		
			        for(int a = 0; a < ret[3].size(); a++) {
			            System.out.println("a 3----------" + a + " : value " + ret[3].get(a));
	
			            retArr_a  = (List)ret[3].get(a);
						strEventCd_a = retArr_a.get(1).toString();
	
					    SALE_AMT_TAX_a = Integer.parseInt(retArr_a.get(3).toString());
					    
					    ECEIPT_CNT_a = Integer.parseInt(retArr_a.get(5).toString());
					    strF_RECEIPT_NO_a = retArr_a.get(6).toString();	
					    
					    if (rtn[3].size() > 0){
							for(int b = 0; b < rtn[3].size(); b++) {
								strgbn = "1";
		
					            System.out.println("b 3----------" + b + " : value " +  rtn[3].get(b));
					            
					            retArr_b  = (List)rtn[3].get(b);
								strEventCd_b = retArr_b.get(1).toString();
		
							    SALE_AMT_TAX_b = Integer.parseInt(retArr_b.get(3).toString());
							    
							    ECEIPT_CNT_b      = Integer.parseInt(retArr_b.get(5).toString());
							    strF_RECEIPT_NO_b = retArr_b.get(6).toString();
		
								System.out.println("strEventCd_a-------" + strEventCd_a); 
								System.out.println("strEventCd_b------ " + strEventCd_b);  
								System.out.println("SALE_AMT_TAX_a-------" + SALE_AMT_TAX_a); 
								System.out.println("SALE_AMT_TAX_b-------" + SALE_AMT_TAX_b); 
								
								if (strEventCd_b.equals(strEventCd_a)) {
	
						            System.out.println("flus 3----------" + b + " : value " +  rtn[3].get(b));								
									retArr_b.set(3, Integer.toString(SALE_AMT_TAX_a + SALE_AMT_TAX_b));
									retArr_b.set(5, Integer.toString(ECEIPT_CNT_a + ECEIPT_CNT_b));
									retArr_b.set(6, (strF_RECEIPT_NO_a + strF_RECEIPT_NO_b));
									strgbn = "0";	
									break;
									
								} 		            
					        }
							if (!strgbn.equals("0")) {
								System.out.println("add 3---------- " +  ret[3].get(a));
								rtn[3].add(ret[3].get(a));
								strgbn = "1";					
							}	
							
					    } else {
					    	System.out.println("add 3----------" );
					    	rtn[3].add(ret[3].get(a));
					    }
			        }
				} else {     
	
					System.out.println("getPbSaleInfo_all-------44");
					System.out.println("브랜드사은행사------지난영수증");
	
					strQuery =  svc.getQuery("SEL_PB_SALE_INFO_PER");     // 브랜드사은행사
					sql.put(strQuery);
					ret[0] = select2List(sql);
			
					sql.close();    		
			        for(int a = 0; a < ret[0].size(); a++) {
			            System.out.println("a 3----------" + a + " : value " +  ret[0].get(a));
	
			            retArr_a  = (List)ret[0].get(a);
						strEventCd_a = retArr_a.get(1).toString();
	
					    SALE_AMT_TAX_a = Integer.parseInt(retArr_a.get(2).toString());
					    APP_RATE_AMT_a = Integer.parseInt(retArr_a.get(3).toString());
					    
					    ECEIPT_CNT_a = Integer.parseInt(retArr_a.get(5).toString());
					    strF_RECEIPT_NO_a = retArr_a.get(6).toString();				    
					    
					    if (rtn[0].size() > 0){
							for(int b = 0; b < rtn[0].size(); b++) {
								strgbn = "1";
		
					            System.out.println(" 3----------" + b + " : value " +  rtn[0].get(b));
					            
					            retArr_b  = (List)rtn[0].get(b);
								strEventCd_b = retArr_b.get(1).toString();
		
							    SALE_AMT_TAX_b = Integer.parseInt(retArr_b.get(2).toString());
							    APP_RATE_AMT_b = Integer.parseInt(retArr_b.get(3).toString());
							    
							    ECEIPT_CNT_b      = Integer.parseInt(retArr_b.get(5).toString());
							    strF_RECEIPT_NO_b = retArr_b.get(6).toString();
		
								System.out.println("strEventCd_a-------" + strEventCd_a); 
								System.out.println("strEventCd_b------ " + strEventCd_b);  
								System.out.println("SALE_AMT_TAX_a-------" + SALE_AMT_TAX_a); 
								System.out.println("APP_RATE_AMT_a------ " + APP_RATE_AMT_a); 
								System.out.println("SALE_AMT_TAX_b-------" + SALE_AMT_TAX_b); 
								System.out.println("APP_RATE_AMT_b------ " + APP_RATE_AMT_b); 
								
								
								if (strEventCd_b.equals(strEventCd_a)) {
									//rtn[0].set(b, SALE_AMT_TAX_a+SALE_AMT_TAX_b);
	
						            System.out.println("flus 3--------" + b + " : value " + Integer.toString(SALE_AMT_TAX_a + SALE_AMT_TAX_b));
									retArr_b.set(2, Integer.toString(SALE_AMT_TAX_a + SALE_AMT_TAX_b));
									retArr_b.set(3, Integer.toString(APP_RATE_AMT_a + APP_RATE_AMT_b));
	
									retArr_b.set(5, Integer.toString(ECEIPT_CNT_a + ECEIPT_CNT_b));
									retArr_b.set(6, (strF_RECEIPT_NO_a + strF_RECEIPT_NO_b));
								
									strgbn = "0";	
									break;
									
								}        
					        }
							
							if (!strgbn.equals("0")) {
								System.out.println("add 3---------- "  +  ret[0].get(a));
								rtn[0].add(ret[0].get(a));
								strgbn = "1";				
							} 
							
					    } else {
	
					    	System.out.println("add 3----------" );
					    	rtn[0].add(ret[0].get(a));
					    }
			        }
			        
					System.out.println("결제유형별행사매출------지난영수증");
					
					strQuery = "";
					strQuery =  svc.getQuery("SEL_PAID_SALE_INFO_PER");    //결제유형별행사매출
					sql.put(strQuery);
					
					i = 1;
					sql.setString(i++, strRECEIPT_NO);	
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDt);
					sql.setString(i++, strPosNo);
					sql.setString(i++, strTranNo);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDt);
					sql.setString(i++, strPosNo);
					sql.setString(i++, strTranNo);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDt);
					sql.setString(i++, strPosNo);
					sql.setString(i++, strTranNo);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strPrsntDt);        //지급일자- 행사기간을 조회
					sql.setString(i++, strStrCd);
					sql.setString(i++, strPrsntDt);        //지급일자- 행사기간을 조회
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDt);
					sql.setString(i++, strPosNo);
					sql.setString(i++, strTranNo);
					
					ret[1] = select2List(sql);	  
					sql.close();   	              
		    		
			        for(int a = 0; a < ret[1].size(); a++) {
			            System.out.println("a 4----------" + a + " : value " + ret[1].get(a));
	
			            retArr_a  = (List)ret[1].get(a);
						strEventCd_a = retArr_a.get(1).toString();
	
					    SALE_AMT_TAX_a = Integer.parseInt(retArr_a.get(5).toString());
					    
					    ECEIPT_CNT_a = Integer.parseInt(retArr_a.get(7).toString());
					    strF_RECEIPT_NO_a = retArr_a.get(8).toString();	
					    
					    if (rtn[1].size() > 0){
							for(int b = 0; b < rtn[1].size(); b++) {
								strgbn = "1";
		
					            System.out.println("b 4----------" + b + " : value " +  rtn[1].get(b));
					            
					            retArr_b  = (List)rtn[1].get(b);
								strEventCd_b = retArr_b.get(1).toString();
	
							    SALE_AMT_TAX_b = Integer.parseInt(retArr_b.get(5).toString());
							    
							    ECEIPT_CNT_b      = Integer.parseInt(retArr_b.get(7).toString());
							    strF_RECEIPT_NO_b = retArr_b.get(8).toString();
	
								System.out.println("strEventCd_a-------" + strEventCd_a); 
								System.out.println("strEventCd_b------ " + strEventCd_b);  
								System.out.println("SALE_AMT_TAX_a-------" + SALE_AMT_TAX_a); 
								System.out.println("SALE_AMT_TAX_b-------" + SALE_AMT_TAX_b); 							
								
								if (strEventCd_b.equals(strEventCd_a)) {
									//rtn[0].set(b, SALE_AMT_TAX_a+SALE_AMT_TAX_b);
									System.out.println("flus 4--------" + b + " : value " + Integer.toString(SALE_AMT_TAX_a + SALE_AMT_TAX_b));
									
									retArr_b.set(5, Integer.toString(SALE_AMT_TAX_a + SALE_AMT_TAX_b));
									retArr_b.set(7, Integer.toString(ECEIPT_CNT_a + ECEIPT_CNT_b));
									retArr_b.set(8, (strF_RECEIPT_NO_a + strF_RECEIPT_NO_b));
									strgbn = "0";	
									break;
									
								} 	            
					        }
							
							if (!strgbn.equals("0")) {
								System.out.println("add 4----------"  +  ret[1].get(a));
								rtn[1].add(ret[1].get(a));
								strgbn = "1";				
							} 
							
					    } else {
					    	System.out.println("add 4----------" );
					    	rtn[1].add(ret[1].get(a));
					    }
			        }
			        
	
					System.out.println("제휴카드사은행사------지난영수증");
					strQuery = "";
					strQuery =  svc.getQuery("SEL_CARD_SALE_INFO_PER");    //제휴카드사은행사매출
					sql.put(strQuery);
					
					i = 1;
					sql.setString(i++, strRECEIPT_NO);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDt);
					sql.setString(i++, strPosNo);
					sql.setString(i++, strTranNo);
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strPrsntDt);        //지급일자- 행사기간을 조회
					sql.setString(i++, strStrCd);
					sql.setString(i++, strPrsntDt);        //지급일자- 행사기간을 조회
					
					sql.setString(i++, strStrCd);
					sql.setString(i++, strSaleDt);
					sql.setString(i++, strPosNo);
					sql.setString(i++, strTranNo);
					
					ret[2] = select2List(sql);             
		    		
			        for(int a = 0; a < ret[2].size(); a++) {
			            System.out.println("a 4----------" + a + " : value " + ret[2].get(a));
	
			            retArr_a  = (List)ret[2].get(a);
						strEventCd_a = retArr_a.get(1).toString();
	
					    SALE_AMT_TAX_a = Integer.parseInt(retArr_a.get(3).toString());
					    ECEIPT_CNT_a = Integer.parseInt(retArr_a.get(5).toString());
					    strF_RECEIPT_NO_a = retArr_a.get(6).toString();	
					    
					    if (rtn[2].size() > 0){
							for(int b = 0; b < rtn[2].size(); b++) {
								strgbn = "1";
		
					            System.out.println("b 4----------" + b + " : value " +  rtn[2].get(b));
					            
					            retArr_b  = (List)rtn[2].get(b);
								strEventCd_b = retArr_b.get(1).toString();
								
								SALE_AMT_TAX_b = Integer.parseInt(retArr_b.get(3).toString());
	
							    ECEIPT_CNT_b      = Integer.parseInt(retArr_b.get(5).toString());
							    strF_RECEIPT_NO_b = retArr_b.get(6).toString();
							    
								System.out.println("strEventCd_a-------" + strEventCd_a); 
								System.out.println("strEventCd_b------ " + strEventCd_b);  
								System.out.println("SALE_AMT_TAX_a-------" + SALE_AMT_TAX_a); 
								System.out.println("SALE_AMT_TAX_b-------" + SALE_AMT_TAX_b); 							
								
								if (strEventCd_b.equals(strEventCd_a)) {
									//rtn[0].set(b, SALE_AMT_TAX_a+SALE_AMT_TAX_b);
									System.out.println("flus 4--------" + b + " : value " + Integer.toString(SALE_AMT_TAX_a + SALE_AMT_TAX_b));
									
									retArr_b.set(5, Integer.toString(SALE_AMT_TAX_a + SALE_AMT_TAX_b));
	
									retArr_b.set(5, Integer.toString(ECEIPT_CNT_a + ECEIPT_CNT_b));
									retArr_b.set(6, (strF_RECEIPT_NO_a + strF_RECEIPT_NO_b));
									
									strgbn = "0";	
									break;
									
								} 	            
					        }
							
							if (!strgbn.equals("0")) {
								System.out.println("add 4----------" +  ret[2].get(a));
								rtn[2].add(ret[2].get(a));
								strgbn = "1";				
							} 
							
					    } else {
					    	System.out.println("add 4----------" );
					    	rtn[2].add(ret[2].get(a));
					    }
			        }		        
	
				}
			}
		}
		//return ret;
		return rtn;
	}
	
	
	/**
	 * 영수증 브랜드 사은 합산/개별 정보 조회 <= 영수증번호사용
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List[] getPbSaleInfo(ActionForm form, MultiInput mi) throws Exception {

		List ret[] = new List[2];
		List rtn[] = new List[2];
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strSaleDt = String2.nvl(form.getParam("strSaleDt"));
		String strPosNo = String2.nvl(form.getParam("strPosNo"));
		String strTranNo = String2.nvl(form.getParam("strTranNo"));

		System.out.println("getPbSaleInfo-------1" +strSaleDt);
		rtn[0]  = new ArrayList();
		rtn[1]  = new ArrayList();

		connect("pot");
				
		while (mi.next()) {
	           
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			// KSH 20120727 
			sql.setString(i++, strSaleDt);
			sql.setString(i++, strSaleDt);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDt);
			sql.setString(i++, strPosNo);
			sql.setString(i++, strTranNo);

			System.out.println("getPbSaleInfo-------33");
			strQuery =  svc.getQuery("SEL_PB_SALE_INFO");
			sql.put(strQuery);
			ret[0] = select2List(sql);
	
			sql.close();   		
	        for(int a = 0; a < ret[0].size(); a++) {
	            System.out.println("1----------" + a + " : value " +  ret[0].get(a));

	            rtn[0].add(ret[0].get(a));
	        }
	        
			strQuery = "";
			strQuery =  svc.getQuery("SEL_PB_SALE_EACH_INFO");
			sql.put(strQuery);
			
			i = 1;
			sql.setString(i++, strSaleDt);
			sql.setString(i++, strSaleDt);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDt);
			sql.setString(i++, strPosNo);
			sql.setString(i++, strTranNo);
			
			ret[1] = select2List(sql);            
    		
	        for(int a = 0; a < ret[1].size(); a++) {
	            System.out.println("1----------" + a + " : value " + ret[1].get(a));

	            rtn[1].add(ret[1].get(a));
	        }
		}
		//return ret;
		return rtn;
	}
	

	/**
	 * 지난 영수증 브랜드 사은 합산/개별 정보 조회 <= 영수증번호사용
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List[] getPbSaleInfo_Per(ActionForm form, MultiInput mi) throws Exception {

		List ret[] = new List[2];
		List rtn[] = new List[2];
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strSaleDt = String2.nvl(form.getParam("strSaleDt"));
		String strPosNo = String2.nvl(form.getParam("strPosNo"));
		String strTranNo = String2.nvl(form.getParam("strTranNo"));

		System.out.println("getPbSaleInfo_Per-------1" +strSaleDt);
		rtn[0]  = new ArrayList();
		rtn[1]  = new ArrayList();
        
		connect("pot");
					
		while (mi.next()) {
			i = 1;
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			  	 
			// KSH 20120727 
			sql.setString(i++, strSaleDt);
			sql.setString(i++, strSaleDt);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDt);
			sql.setString(i++, strPosNo);
			sql.setString(i++, strTranNo);
			
			strQuery =  svc.getQuery("SEL_PB_SALE_INFO_PER");
			sql.put(strQuery);
			ret[0] = select2List(sql);
	
			sql.close();    		
	        for(int a = 0; a < ret[0].size(); a++) {
	           System.out.println("getPbSaleInfo_Per-------" + a + " : value " + ret[0].get(a));
	            rtn[0].add(ret[0].get(a));
	        }
	        
			strQuery = "";
			strQuery =  svc.getQuery("SEL_PB_SALE_EACH_INFO_PER");
			sql.put(strQuery);
			
			i = 1;
			sql.setString(i++, strSaleDt);
			sql.setString(i++, strSaleDt);
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strSaleDt);
			sql.setString(i++, strPosNo);
			sql.setString(i++, strTranNo);
			
			ret[1] = select2List(sql);	            
    		
	        for(int a = 0; a < ret[1].size(); a++) {
	            System.out.println("getPbSaleInfo_Per-------" + a + " : value " + ret[1].get(a));
	        	rtn[1].add(ret[1].get(a));
	        }
	        
		}
		
		//return ret;
		return rtn;
	}

	/**
	 * 영수증 정보 조회 <= 영수증번호사용
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List[] getSaleInfo(ActionForm form) throws Exception {

		List ret[] = new List[2];
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strEventCd = String2.nvl(form.getParam("strEventCd"));
		String strSaleDt = String2.nvl(form.getParam("strSaleDt"));
		String strPosNo = String2.nvl(form.getParam("strPosNo"));
		String strTranNo = String2.nvl(form.getParam("strTranNo"));
		String strAllBrand = "";
		String strRecpStrCd = String2.nvl(form.getParam("strRecpStrCd"));
		String strCardNo = String2.nvl(form.getParam("strCardNo"));
		String strCustId = String2.nvl(form.getParam("strCustId"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");

		sql.close();
		sql.put(svc.getQuery("SEL_CHK_ALLBRAND"));
		sql.setString(1, strStrCd);
		//sql.setString(1, strRecpStrCd);
		sql.setString(2, strEventCd);
		Map map = (Map) selectMap(sql);
		strAllBrand = map.get("PUMBUN_CD").toString();

		sql.close();

		if (strAllBrand.equals("") || strAllBrand.equals("0")) {
			sql.put(svc.getQuery("SEL_SALE_INFO_ALL"));
		} else {
			sql.put(svc.getQuery("SEL_SALE_INFO"));
		}
		// KSH 20120727 
		sql.setString(i++, strStrCd);
		sql.setString(i++, strRecpStrCd);
		sql.setString(i++, strEventCd);
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSaleDt);
		sql.setString(i++, strPosNo);
		sql.setString(i++, strTranNo);

		sql.setString(i++, strStrCd);
		sql.setString(i++, strEventCd);
		
		if (!strAllBrand.equals("0")) {
			//sql.setString(i++, strStrCd);
			sql.setString(i++, strRecpStrCd);
			sql.setString(i++, strEventCd);
		}
		//sql.setString(i++, strStrCd);
		sql.setString(i++, strRecpStrCd);
		sql.setString(i++, strSaleDt);
		sql.setString(i++, strPosNo);
		sql.setString(i++, strTranNo);
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strRecpStrCd);
		sql.setString(i++, strSaleDt);
		sql.setString(i++, strPosNo);
		sql.setString(i++, strTranNo);

		ret[0] = select2List(sql);
		
		sql.close();
		i = 1;
		sql.put(svc.getQuery("SEL_SALECHK"));
		//sql.setString(i++, strStrCd);
		sql.setString(i++, strRecpStrCd);
		sql.setString(i++, strSaleDt);
		sql.setString(i++, strPosNo);
		sql.setString(i++, strTranNo);
		
		ret[1] = select2List(sql);
		return ret;
	}
	
	

	/**
	 * 영수증 정보 조회 <= 고객번호사용
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getSaleInfo2(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strEventCd = String2.nvl(form.getParam("strEventCd"));
		String strCustId = String2.nvl(form.getParam("strCustId"));
		String strAllBrand = "";

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");

		sql.close();
		sql.put(svc.getQuery("SEL_CHK_ALLBRAND"));
		sql.setString(1, strStrCd);
		sql.setString(2, strEventCd);
		Map map = (Map) selectMap(sql);
		strAllBrand = map.get("PUMBUN_CD").toString();

		sql.close();

		if (strAllBrand.equals("") || strAllBrand.equals("0")) {
			sql.put(svc.getQuery("SEL_SALE_INFO_ALL2"));
		} else {
			sql.put(svc.getQuery("SEL_SALE_INFO2"));
		}

		//KSH 20120727
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEventCd);
		sql.setString(i++, strCustId);
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEventCd);
		
		if (!strAllBrand.equals("0")) {
			sql.setString(i++, strStrCd);
			sql.setString(i++, strEventCd);
		}
		sql.setString(i++, strStrCd);
		sql.setString(i++, strCustId);
		sql.setString(i++, strEventCd);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strCustId);
		sql.setString(i++, strEventCd);

		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 지급품 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getSkuList_back(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, String2.nvl(form.getParam("strStrCd")));
		sql.setString(i++, String2.nvl(form.getParam("strEventCd")));
		sql.setString(i++, String2.nvl(form.getParam("strSaleAmtSum")));
		sql.setString(i++, String2.nvl(form.getParam("strSaleAmtSum")));

		strQuery = svc.getQuery("SEL_SKU_LIST") + "\n";

		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 지급품 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List[] getSkuList(ActionForm form, MultiInput mi[]) throws Exception {


		List ret[] = new List[4];
		List rtn[] = new List[4];
		
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 0;

		List retArr_a = null;
		List retArr_b = null;
		
		rtn[0]  = new ArrayList();    //중복지급 list
		rtn[1]  = new ArrayList();    //중복지급불가능 list
		rtn[2]  = new ArrayList();    //제휴카드지급내역
		rtn[3]  = new ArrayList();    //제휴카드지급내역
		
		connect("pot");
		
		String strDBL_PAID_YN = "";
		String strCHK_a = "";
		
		while (mi[0].next()) {
           
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
            i = 0;           
            strDBL_PAID_YN = mi[0].getString("DBL_PAID_YN");   //중복지급여부

			System.out.println(" mi[0]strDBL_PAID_YN------- " + strDBL_PAID_YN);
			
    		strQuery = svc.getQuery("SEL_SKU_LIST") + "\n";
    		sql.put(strQuery);
            sql.setString(++i, mi[0].getString("SALE_AMT_TAX"));   //매출금액
            sql.setString(++i, mi[0].getString("APP_RATE_AMT"));   //인정금액
            sql.setString(++i, mi[0].getString("RECEIPT_CNT"));    //영수증갯수
            sql.setString(++i, mi[0].getString("F_RECEIPT_NO"));   //영수증list         
           
			sql.setString(++i, String2.nvl(form.getParam("strStrCd")));
            sql.setString(++i, mi[0].getString("EVENT_CD"));
            sql.setString(++i, mi[0].getString("APP_RATE_AMT"));   //인정금액
            sql.setString(++i, mi[0].getString("APP_RATE_AMT"));   //인정금액

			ret[0] = select2List(sql);

            sql.close();
            
	        for(int a = 0; a < ret[0].size(); a++) {
	            System.out.println("1----------" + a + " : value " + ret[0].get(a));
	            
	            retArr_a  = (List)ret[0].get(a);
				strCHK_a = retArr_a.get(1).toString();
				
	        	if (strDBL_PAID_YN.equals("T")){    //종복지급 가능

		            /*----"T"
		            System.out.println("aaaaaaaa----------" + a);
	        		if (a == 0){	
			            System.out.println("aaaaaaaa----------" + a);       			
	        			retArr_a.set(0, "T");
	        		}*/
	        		
		            System.out.println("add all----------" + a + " : value " + ret[0].get(a));
		            rtn[0].add(ret[0].get(a));
	        	} else {

		            System.out.println("add ----------" + a + " : value " + ret[0].get(a));
		            
	        		rtn[1].add(ret[0].get(a));
	        	}
	        }
   		}

		while (mi[1].next()) {

			sql = new SqlWrapper();
			svc = (Service) form.getService();

            i = 0;           
            strDBL_PAID_YN = mi[1].getString("DBL_PAID_YN");   //중복지급여부

			System.out.println("mi[1]strDBL_PAID_YN------- " + strDBL_PAID_YN);
			
    		strQuery = svc.getQuery("SEL_SKU_LIST") + "\n";

    		sql.put(strQuery);
            sql.setString(++i, mi[1].getString("SALE_AMT_TAX"));    //매출금액
            sql.setString(++i, mi[1].getString("SALE_AMT_TAX"));    //인정금액
            sql.setString(++i, mi[1].getString("RECEIPT_CNT"));    //영수증갯수
            sql.setString(++i, mi[1].getString("F_RECEIPT_NO"));   //영수증list  
            
			sql.setString(++i, String2.nvl(form.getParam("strStrCd")));
            sql.setString(++i, mi[1].getString("EVENT_CD"));
            sql.setString(++i, mi[1].getString("SALE_AMT_TAX"));
            sql.setString(++i, mi[1].getString("SALE_AMT_TAX"));

			ret[1] = select2List(sql);

            sql.close();
            
	        for(int a = 0; a < ret[1].size(); a++) {
	            System.out.println("1----------" + a + " : value " + ret[1].get(a));

	            retArr_a  = (List)ret[1].get(a);
				strCHK_a = retArr_a.get(1).toString();
				
	        	if (strDBL_PAID_YN.equals("T")){

	        		/*----"T"
		            System.out.println("2222aaaaaaaa----------" + a);
	        		if (a == 0){	        		
			            System.out.println("2222aaaaaaaa----------" + a);	
	        			retArr_a.set(0, "T");
	        		}*/
	        		
		            System.out.println("add 2----------" + a + " : value " + ret[1].get(a));
		            rtn[0].add(ret[1].get(a));
	        	} else {

		            System.out.println("add all3----------" + a + " : value " + ret[1].get(a));
	        		rtn[1].add(ret[1].get(a));
	        	}
	        }
   		}

		while (mi[2].next()) {

			sql = new SqlWrapper();
			svc = (Service) form.getService();

            i = 0;           
            strDBL_PAID_YN = mi[2].getString("DBL_PAID_YN");   //중복지급여부

			System.out.println("mi[2]strDBL_PAID_YN------- " + strDBL_PAID_YN);
			
    		strQuery = svc.getQuery("SEL_SKU_LIST") + "\n";

    		sql.put(strQuery);
            sql.setString(++i, mi[2].getString("SALE_AMT_TAX"));   //매출금액
            sql.setString(++i, mi[2].getString("SALE_AMT_TAX"));   //인정금액
            sql.setString(++i, mi[2].getString("RECEIPT_CNT"));    //영수증갯수
            sql.setString(++i, mi[2].getString("F_RECEIPT_NO"));   //영수증list  
            
			sql.setString(++i, String2.nvl(form.getParam("strStrCd")));
            sql.setString(++i, mi[2].getString("EVENT_CD"));
            sql.setString(++i, mi[2].getString("SALE_AMT_TAX"));
            sql.setString(++i, mi[2].getString("SALE_AMT_TAX"));

			ret[2] = select2List(sql);

            sql.close();
            
	        for(int a = 0; a < ret[2].size(); a++) {
	            System.out.println("rtn[2] add ----------" + a + " : value " + ret[2].get(a));
	            rtn[2].add(ret[2].get(a));
	        	
	        }
   		}
		
		
		while (mi[3].next()) {

			sql = new SqlWrapper();
			svc = (Service) form.getService();

            i = 0;           
            strDBL_PAID_YN = mi[3].getString("DBL_PAID_YN");   //중복지급여부

			System.out.println("mi[3]strDBL_PAID_YN------- " + strDBL_PAID_YN);
			
    		strQuery = svc.getQuery("SEL_SKU_LIST") + "\n";

    		sql.put(strQuery);
            sql.setString(++i, mi[3].getString("SALE_AMT_TAX"));   //매출금액
            sql.setString(++i, mi[3].getString("SALE_AMT_TAX"));   //인정금액
            sql.setString(++i, mi[3].getString("RECEIPT_CNT"));    //영수증갯수
            sql.setString(++i, mi[3].getString("F_RECEIPT_NO"));   //영수증list  
            
			sql.setString(++i, String2.nvl(form.getParam("strStrCd")));
            sql.setString(++i, mi[3].getString("EVENT_CD"));
            sql.setString(++i, mi[3].getString("SALE_AMT_TAX"));
            sql.setString(++i, mi[3].getString("SALE_AMT_TAX"));

			ret[3] = select2List(sql);

            sql.close();
            
	        for(int a = 0; a < ret[3].size(); a++) {
	            System.out.println("rtn[3] add ----------" + a + " : value " + ret[3].get(a));
	            rtn[3].add(ret[3].get(a));
	        	
	        }
   		}

		return rtn;
	}


	/**
	 * 영수증 반품여부 체크
	 * @param Service
	 * @param ActionForm
	 * @return List
	 * @throws Exception
	 */
	public List getRECEIPT_Check(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		String strReceiptNo = String2.nvl(form.getParam("strReceiptNo"));
				
		strQuery = svc.getQuery("SEL_TRHEADER_CHK") + "\n";
		sql.put(strQuery);
		
		int i = 0;
	    sql.setString(++i, strReceiptNo); //영수증번호 
	    sql.setString(++i, strReceiptNo);  
	    sql.setString(++i, strReceiptNo);  
	    sql.setString(++i, strReceiptNo);  

		ret = select2List(sql);
		return ret;
	}
	


	/**
	 * 영수증의 사은품 지급여부 체크
	 * */
	public List getRECEIPT_CHK(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strSaleDt = String2.nvl(form.getParam("strSaleDt"));
		String strPosNo = String2.nvl(form.getParam("strPosNo"));
		String strTranNo = String2.nvl(form.getParam("strTranNo"));		

		sql.setString(i++, String2.nvl(form.getParam("strStrCd")));
		sql.setString(i++, String2.nvl(form.getParam("strSaleDt")));
		sql.setString(i++, String2.nvl(form.getParam("strPosNo")));
		sql.setString(i++, String2.nvl(form.getParam("strTranNo")));

		strQuery = svc.getQuery("SEL_CHECK_RECEIPT") + "\n";

		sql.put(strQuery);
		
		
		ret = select2List(sql);
		return ret;
	}
	

	public List getRECEIPT_list(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strSaleDt = String2.nvl(form.getParam("strSaleDt"));
		String strPosNo = String2.nvl(form.getParam("strPosNo"));
		String strTranNo = String2.nvl(form.getParam("strTranNo"));
				
		strQuery = svc.getQuery("SEL_RECEIPT_LIST") + "\n";
		sql.put(strQuery);

		sql.setString(i++, String2.nvl(form.getParam("strStrCd")));
		sql.setString(i++, String2.nvl(form.getParam("strSaleDt")));
		sql.setString(i++, String2.nvl(form.getParam("strPosNo")));
		sql.setString(i++, String2.nvl(form.getParam("strTranNo")));

		ret = select2List(sql);
		return ret;
	}
	
	public List chkGiftCardNo(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 0;
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_CHECK_GIFTCARD_NO") + "\n";
		
		sql.put(strQuery);
		String strGiftCardNo = String2.nvl(form.getParam("strGiftCardNo"));	//상품권번호
		sql.setString(++i, strGiftCardNo); 
		ret = select2List(sql);
		return ret;
	}

    public List getGiftCardNo(ActionForm form) throws Exception {

        List		ret = null;
        SqlWrapper	sql = null;
        Service		svc = null;
		String strQuery = "";
		int i = 1;

        connect("pot");
        svc  = (Service)form.getService();
        sql  = new SqlWrapper();

        //화면(JSP)에서 입력된 (조회)파라미터(Paramater)
        strQuery = svc.getQuery("SEL_GIFTCARD_NO") + "\n";
        sql.put(strQuery);
                     
             
        ret = select2List(sql);

        return ret;
    }
	
	/**
	 * 지급품 정보(원가, 대상코드)조회
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

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, String2.nvl(form.getParam("strStrCd")));
		sql.setString(i++, String2.nvl(form.getParam("strEventCd")));
		sql.setString(i++, String2.nvl(form.getParam("strSkuCd")));

		strQuery = svc.getQuery("SEL_SKU_INFO") + "\n";

		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 고객카드 정보 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getCardInfo(ActionForm form, String userId) throws Exception {
		List<String> ret = new ArrayList<String>(); 
		ProcedureWrapper psql = null;
		Util util = new Util();
		int i = 1;
		connect("pot");
		psql = new ProcedureWrapper();
		ProcedureResultSet prs = null;
		ArrayList<List> list 	= new ArrayList<List>();
		psql.put("DCS.PR_CUST_QUERY", 57);
		psql.setString(i++, "C"); // P_IN_FLAG 1
		psql.setString(i++, util.encryptedStr(form.getParam("strCardCustId"))); // , P_IN_PARA 2
		psql.setString(i++, userId); // , P_USER_ID 3
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_CUST_NAME 회원성명
															// 4
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_SS_NO 주민번호 5
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_ALIEN_YN 외국인여부  6
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_I_PIN I-PIN 번호  7
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_HOME_ZIP_CD1   자택우편번호1 8
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_HOME_ZIP_CD2 9
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_HOME_ADDR1   자택주소1 10
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_HOME_ADDR2 11
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_HOME_PH1  자택전화번호 12
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_HOME_PH2 13
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_HOME_PH3 14
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_MOBILE_PH1  이동전화번호 15
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_MOBILE_PH2 16
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_MOBILE_PH3 17
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_OFFI_NM 직장명 18
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_OFFI_ZIP_CD1    직장우편번호1 19
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_OFFI_ZIP_CD2
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_OFFI_ADDR1  직장주소1  21
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_OFFI_ADDR2 22
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_OFFI_PH1 직장전화번호 23
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_OFFI_PH2 24
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_OFFI_PH3  25
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_BIRTH_DT 26
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_LUNAR_FLAG 27
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_CUST_ID 회원ID  28
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_EMAIL_YN  이메일수신동의 29
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_EMAIL_AGREE_DT  이메일수신동의일자   30
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_SMS_YN  SMS수신동의 31
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_SMS_AGREE_DT  SMS수신동의일자  32
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_ENTR_DT  가입일자  33
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_SCED_YN 회원탈퇴여부 34
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_SCED_PROC_DT 회원탈퇴일시 35
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_EMAIL1 이메일주소  36
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_EMAIL2  37
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_WED_YN  38
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_WED_DT  39
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_NOCLS_REQ_YN 이메일주소 1 40
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_HOME_CLS_YN 41
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_OFFI_CLS_YN 42
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_HNEW_ZIP_CD1 43
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_HNEW_ZIP_CD2 44
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_HNEW_ADDR1  45
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_HNEW_ADDR2 46
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_HOME_NEW_YN 47
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_ONEW_ZIP_CD1  48
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_ONEW_ZIP_CD2 49
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_ONEW_ADDR1 50
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_ONEW_ADDR2  51
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_OFFI_NEW_YN 52
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_POST_RCV_CD  53
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_CUST_GRADE 54
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , P_SEX_CD   55
		psql.registerOutParameter(i++, DataTypes.INTEGER); // , O_RETURN 0: 정상   ELSE 오류 56
		psql.registerOutParameter(i++, DataTypes.VARCHAR); // , O_MESSAGE 57
		prs = selectProcedure(psql);
		
		ret.add(prs.getString(34));
		ret.add(prs.getString(56));
		ret.add(prs.getString(57));
		ret.add(prs.getString(28));
		list.add(0, ret);
		return list;
	}

	/**
	 * 사은품 지급 내역을 등록 한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	
	public int save(ActionForm form, MultiInput[] mi, String userId)
			throws Exception {
		int ret = 0;
		int res = 0;
		int i = 1;
		SqlWrapper sql = null;
		String strQuery = "";
		
		Service svc = null;
		String strPrsntGbn = "";
		String strPrsntNo = "";
		
		int RECEIPT_CNT = 0;
		int GIFTCARD_CNT = 0;
		
		int rec_cnt = 0;
		int gift_cnt = 0;
		
		String F_RECEIPT_NO = "";
		Map  map_grp = null;
		Map  map = null;
		Map map_GIFTCERT_AMT = null;
		
		String strGIFTCERT_AMT = "";
		String strGIFTCARDNO = "";

		List retno = null;
		List retnoArr = null;
		
		try {
			connect("pot");
			begin();
			
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
            			
			sql.put(svc.getQuery("SEL_PRSNT_GRP"));    //사은품지급그룹            
			map_grp = selectMap(sql);
			
			strPrsntGbn = map_grp.get("PRSNT_GBP").toString(); 
			
            System.out.println("strPrsntGbn----------" + strPrsntGbn);   
            
			while (mi[0].next()) {

				rec_cnt = 0;
				gift_cnt = 0;
				
	            System.out.println("mi[0]----------"); 
	            
				sql.close();
				
				sql.put(svc.getQuery("SEL_PRSNT_NO"));    //사은품지급번
				
			    map = selectMap(sql);
				strPrsntNo = map.get("PRSNT_NO").toString();

	            System.out.println("strPrsntNo----------" + strPrsntNo);   
	            									
				i = 1;
				sql.close();
				// 사은품 지급 등록
				sql.put(svc.getQuery("INS_EVTSKUPRSNT"));

				RECEIPT_CNT = Integer.parseInt(mi[0].getString("RECEIPT_CNT"));
				GIFTCARD_CNT = Integer.parseInt(mi[0].getString("GIFTCARD_CNT"));
	            System.out.println("RECEIPT_CNT----------" + RECEIPT_CNT); 
	            System.out.println("GIFTCARD_CNT----------" + GIFTCARD_CNT); 
	            
	            
				F_RECEIPT_NO = mi[0].getString("F_RECEIPT_NO");  
	            System.out.println("F_RECEIPT_NO----------" + F_RECEIPT_NO);    
	            System.out.println("STR_CD----------" + F_RECEIPT_NO.substring(0,2));  
	            System.out.println("sale date----------" + F_RECEIPT_NO.substring(2,10));  
	            System.out.println("pos----------" + F_RECEIPT_NO.substring(10,14)); 
	            System.out.println("tran----------" + F_RECEIPT_NO.substring(14,19));  	            
	            
				sql.setString(i++, String2.nvl(form.getParam("strPrsntDt"))); 		// 지급일
				sql.setString(i++, F_RECEIPT_NO.substring(0,2)); 				    // 점코드
				sql.setString(i++, strPrsntNo); 									// 지급번호
				sql.setString(i++, mi[0].getString("EVENT_CD"));					// 행사코드	
				sql.setString(i++, mi[0].getString("SKU_CD")); 					    // 단품코드	
				sql.setString(i++, "1"); 										    // 지급구분 1:정상, 2:예외	(D-M004)
				//-- 지급시간
				sql.setString(i++, mi[0].getString("APP_RATE_AMT")); 	           	// 총인정매출금액
				sql.setString(i++, "1"); 											// 지급 수량
				sql.setString(i++, mi[0].getString("BUY_COST_PRC")); 			    // 지급금액(매입원가)
				sql.setString(i++, ""); 										    // 예외지급 승인자
				sql.setString(i++, ""); 										    // 예외지급 사유
				sql.setString(i++, ""); 										    // 카드회원번호	
				sql.setString(i++, mi[0].getString("TRG_CD")); 					    // 대상범위코드
				//--취소원거래전표번호 생략					
				//sql.setString(i++, String2.nvl(form.getParam("strCardCustId"))); 	// 카드회원번호	생략
				sql.setString(i++, "1"); 											// 취소구분 1: 정상, 2:취소
				//--비고생략
				sql.setString(i++, userId); 										// 등록자
				sql.setString(i++, userId); 										// 등록자
				sql.setString(i++, strPrsntGbn); 									// 지급그룹번 MSS.SQ_MC_EVTSKUPRSNTGRP

				res = update(sql);
				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
			
				for(int a = 0; a < RECEIPT_CNT; a++) {
					i = 1;
					sql.close();
					// 사은품 지급 영수증 등록
					sql.put(svc.getQuery("INS_PRSNTRECP"));
					sql.setString(i++, String2.nvl(form.getParam("strPrsntDt")));   // 지급일
					sql.setString(i++, F_RECEIPT_NO.substring(0+rec_cnt,2+rec_cnt)); 				// 점코드
					sql.setString(i++, strPrsntNo); 						    	// 지급번호
					sql.setString(i++, String2.nvl(form.getParam("strPrsntDt")));   // 지급일
					sql.setString(i++, F_RECEIPT_NO.substring(0+rec_cnt,2+rec_cnt)); 				// 점코드
					sql.setString(i++, strPrsntNo); 							    // 지급번호
					sql.setString(i++, F_RECEIPT_NO.substring(2+rec_cnt,10+rec_cnt)); 			    // 매출일자
					sql.setString(i++, F_RECEIPT_NO.substring(10+rec_cnt,14+rec_cnt)); 			    // 포스번호
					sql.setString(i++, F_RECEIPT_NO.substring(14+rec_cnt,19+rec_cnt));			    // 거래번호
					sql.setString(i++, mi[0].getString("APP_RATE_AMT"));		    // 인정매출금액
					sql.setString(i++, userId); 								    // 등록자
					sql.setString(i++, userId); 								    // 수정자
					sql.setString(i++, strPrsntGbn); 							    // 지급그룹번 MSS.SQ_MC_EVTSKUPRSNTGRP	
					
					res = update(sql);

					rec_cnt = rec_cnt + 19;
					
					if (res != 1) {
						throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					}
				}
				
				/*----------*/
				i = 1;
				sql.close();
				// 사은품 지급 브랜드집계 데이터 생성
				sql.put(svc.getQuery("INS_PRSNTPBN"));
				sql.setString(i++, userId); 										// 등록자
				sql.setString(i++, userId); 										// 등록자
				sql.setString(i++, F_RECEIPT_NO.substring(0,2)); 						// 점코드
				sql.setString(i++, String2.nvl(form.getParam("strPrsntDt"))); 		// 지급일
				sql.setString(i++, strPrsntNo); 									// 지급번호
				
				res = update(sql);
				if (res == 0) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				/*----------*/

	            System.out.println("SKU_GB----------" + mi[0].getString("SKU_GB")); 
				//사은품종류가 상품권이면
				if (mi[0].getString("SKU_GB").equals("2")) {
					
					for(int a = 0; a < GIFTCARD_CNT; a++) {		

						retno = null;
						retnoArr = null;
						i = 1;
						sql.close();
						//-- 상품권의 가격정보 가져오기

						strGIFTCARDNO = mi[0].getString("GIFTCARD_LIST").substring(0+gift_cnt, 12+gift_cnt);
						System.out.println("strGIFTCARDNO----------" + strGIFTCARDNO);
						
						strQuery = svc.getQuery("SEL_GIFTCERT_AMT") + "\n";
						sql.put(strQuery);                                     //상품권금액조회     
						sql.setString(i++, strGIFTCARDNO);
						
						retno = select2List(sql);
						
						retnoArr  = (List)retno.get(0);
						System.out.println("retArr_a----------" + retnoArr); 
						
						strGIFTCERT_AMT = retnoArr.get(0).toString();						
						System.out.println("strGIFTCERT_AMT----------" + strGIFTCERT_AMT); 
						
						i = 1;
						sql.close();
						// 상품권 지급 내역 등록
						sql.put(svc.getQuery("INS_EVTSKUGIFTPRSNT"));
						sql.setString(i++, String2.nvl(form.getParam("strPrsntDt")));	// 지급일
						sql.setString(i++, F_RECEIPT_NO.substring(0,2));				// 점코드
						sql.setString(i++, strPrsntNo);									// 지급번호
						// SEQ_NO INSERT시 MAX값 저장
						sql.setString(i++, String2.nvl(form.getParam("strPrsntDt")));	// 지급일
						sql.setString(i++, F_RECEIPT_NO.substring(0,2));				// 점코드
						sql.setString(i++, strPrsntNo);									// 지급번호
						
						//sql.setString(i++, mi[0].getString("GIFTCARD_NO"));			// 상품권번호
						sql.setString(i++, mi[0].getString("GIFTCARD_LIST").substring(0+gift_cnt, 12+gift_cnt));	// 상품권번호
												
						sql.setString(i++, mi[0].getString("EVENT_CD"));				// 행사코드
						sql.setString(i++, mi[0].getString("SKU_CD"));					// 단품코드
						sql.setString(i++, userId);										// 등록자
						sql.setString(i++, userId);										// 수정자
						//sql.setString(i++, mi[0].getString("GIFTCERT_AMT"));			// 상품권금액
						sql.setString(i++, strGIFTCERT_AMT);			                // 상품권금액
							
						res = update(sql);						
			
						if (res != 1) {
							throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
									+ "데이터 입력을 하지 못했습니다.");
						}
						
						i=1;
						sql.close();
						sql.put(svc.getQuery("UPD_GIFTMST"));
						sql.setString(i++, F_RECEIPT_NO.substring(0,2));				 	// 판매점
						sql.setString(i++, String2.nvl(form.getParam("strPrsntDt")));		// 판매일
						sql.setString(i++, userId); 								    	// 판매자
						//sql.setString(i++, mi[0].getString("GIFTCERT_AMT"));				// 금액
						sql.setString(i++, strGIFTCERT_AMT);		                 		// 금액
						sql.setString(i++, userId); 									    // 수정자
						sql.setString(i++, mi[0].getString("GIFTCARD_LIST").substring(0+gift_cnt, 12+gift_cnt));   // 상품권번호
						res = update(sql);

						gift_cnt = gift_cnt + 12;
						
			            System.out.println("res---------- " + res); 
						if (res == 0) {
							throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
									+ "데이터 입력을 하지 못했습니다.");
						}
					}	
										
				}
				ret += res;
			}

            System.out.println("end---------- 0" ); 


			while (mi[1].next()) {

				rec_cnt = 0;
				gift_cnt = 0;
				
	            System.out.println("mi[1---------- 1" ); 
	            
				sql.close();

				sql.put(svc.getQuery("SEL_PRSNT_NO"));    //사은품지급번
				
			    map = selectMap(sql);
				strPrsntNo = map.get("PRSNT_NO").toString();
	            									
				i = 1;
				sql.close();
				// 사은품 지급 영수증 등록
				sql.put(svc.getQuery("INS_EVTSKUPRSNT"));

				RECEIPT_CNT = Integer.parseInt(mi[1].getString("RECEIPT_CNT"));
				GIFTCARD_CNT = Integer.parseInt(mi[1].getString("GIFTCARD_CNT"));
	            System.out.println("RECEIPT_CNT----------" + RECEIPT_CNT); 
	            System.out.println("GIFTCARD_CNT----------" + GIFTCARD_CNT); 
	            
				F_RECEIPT_NO = mi[1].getString("F_RECEIPT_NO");  
	            System.out.println("F_RECEIPT_NO----------" + F_RECEIPT_NO); 
	            
				sql.setString(i++, String2.nvl(form.getParam("strPrsntDt"))); 		// 지급일

				sql.setString(i++, F_RECEIPT_NO.substring(0,2)); 						// 점코드
				sql.setString(i++, strPrsntNo); 									// 지급번호
				sql.setString(i++, mi[1].getString("EVENT_CD"));					// 행사코드	
				sql.setString(i++, mi[1].getString("SKU_CD")); 					    // 단품코드	
				sql.setString(i++, "1"); 										    // 지급구분 1:정상, 2:예외	(D-M004)
				//-- 지급시간
				sql.setString(i++, mi[1].getString("APP_RATE_AMT")); 	           	// 총인정매출금액
				sql.setString(i++, "1"); 											// 지급 수량
				sql.setString(i++, mi[1].getString("BUY_COST_PRC")); 			    // 지급금액(매입원가)
				sql.setString(i++, ""); 										    // 예외지급 승인자
				sql.setString(i++, ""); 										    // 예외지급 사유
				sql.setString(i++, ""); 										    // 카드회원번호	
				sql.setString(i++, mi[1].getString("TRG_CD")); 					    // 대상범위코드
				//--취소원거래전표번호 생략					
				sql.setString(i++, "1"); 											// 취소구분 1: 정상, 2:취소
				//--비고생략
				sql.setString(i++, userId); 										// 등록자
				sql.setString(i++, userId); 										// 등록자
				sql.setString(i++, strPrsntGbn); 									// 지급그룹번 MSS.SQ_MC_EVTSKUPRSNTGRP

	            System.out.println("strPrsntNo---------- 2" ); 
				res = update(sql);
				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
			
				for(int a = 0; a < RECEIPT_CNT; a++) {
					i = 1;
					sql.close();
					// 사은품 지급 영수증 등록
		            System.out.println("INS_PRSNTRECP---------- 1" ); 
		            
					sql.put(svc.getQuery("INS_PRSNTRECP"));
		            System.out.println("INS_PRSNTRECP---------- 2" ); 
					sql.setString(i++, String2.nvl(form.getParam("strPrsntDt")));   // 지급일
		            System.out.println("INS_PRSNTRECP---------- 3" ); 
					sql.setString(i++, F_RECEIPT_NO.substring(0+rec_cnt,2+rec_cnt)); 				// 점코드
		            System.out.println("INS_PRSNTRECP---------- 4" ); 
					sql.setString(i++, strPrsntNo); 						    	// 지급번호
		            System.out.println("INS_PRSNTRECP---------- 5" ); 
					sql.setString(i++, String2.nvl(form.getParam("strPrsntDt")));   // 지급일
		            System.out.println("INS_PRSNTRECP---------- 6" ); 
					sql.setString(i++, F_RECEIPT_NO.substring(0+rec_cnt,2+rec_cnt)); 				// 점코드
		            System.out.println("INS_PRSNTRECP---------- 7" ); 
					sql.setString(i++, strPrsntNo); 							    // 지급번호
		            System.out.println("INS_PRSNTRECP---------- 8" ); 
					sql.setString(i++, F_RECEIPT_NO.substring(2+rec_cnt,10+rec_cnt)); 			    // 매출일자
		            System.out.println("INS_PRSNTRECP---------- 9" ); 
					sql.setString(i++, F_RECEIPT_NO.substring(10+rec_cnt,14+rec_cnt)); 			    // 포스번호
		            System.out.println("INS_PRSNTRECP---------- 10" ); 
					sql.setString(i++, F_RECEIPT_NO.substring(14+rec_cnt,19+rec_cnt));			    // 거래번호
		            System.out.println("INS_PRSNTRECP---------- 11" ); 
					sql.setString(i++, mi[1].getString("APP_RATE_AMT"));		    // 인정매출금액
		            System.out.println("INS_PRSNTRECP---------- 12" ); 
					sql.setString(i++, userId); 								    // 등록자
		            System.out.println("INS_PRSNTRECP---------- 13" ); 
					sql.setString(i++, userId); 								    // 수정자
		            System.out.println("INS_PRSNTRECP---------- 14" ); 
					sql.setString(i++, strPrsntGbn); 							    // 지급그룹번 MSS.SQ_MC_EVTSKUPRSNTGRP	
		            System.out.println("INS_PRSNTRECP---------- 15" ); 
					
					res = update(sql);

		            System.out.println("INS_PRSNTRECP---------- 16" ); 
					rec_cnt = rec_cnt + 19;

		            System.out.println("INS_PRSNTRECP---------- 17" ); 
					if (res != 1) {
						throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					}
				}

				/*----------*/
				i = 1;
				sql.close();
				// 사은품 지급 브랜드집계 데이터 생성
				sql.put(svc.getQuery("INS_PRSNTPBN"));
				sql.setString(i++, userId); 										// 등록자
				sql.setString(i++, userId); 										// 등록자
				sql.setString(i++, F_RECEIPT_NO.substring(0,2)); 						// 점코드
				sql.setString(i++, String2.nvl(form.getParam("strPrsntDt"))); 		// 지급일
				sql.setString(i++, strPrsntNo); 									// 지급번호
				
				res = update(sql);
				if (res == 0) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				/*----------*/

	            System.out.println("SKU_GB----------" + mi[1].getString("SKU_GB")); 
				//사은품종류가 상품권이면
				if (mi[1].getString("SKU_GB").equals("2")) {
					
					gift_cnt = 0;
					for(int a = 0; a < GIFTCARD_CNT; a++) {		

						retno = null;
						retnoArr = null;
						
						i = 1;
						sql.close();
						//-- 상품권의 가격정보 가져오기

						strGIFTCARDNO = mi[1].getString("GIFTCARD_LIST").substring(0+gift_cnt, 12+gift_cnt);
						System.out.println("strGIFTCARDNO----------" + strGIFTCARDNO);
						
						strQuery = svc.getQuery("SEL_GIFTCERT_AMT") + "\n";
						sql.put(strQuery);                                     //상품권금액조회     
						sql.setString(i++, strGIFTCARDNO);
						
						retno = select2List(sql);
						
						retnoArr  = (List)retno.get(0);
						System.out.println("retArr_a----------" + retnoArr); 
						
						strGIFTCERT_AMT = retnoArr.get(0).toString();						
						System.out.println("strGIFTCERT_AMT----------" + strGIFTCERT_AMT); 
																			
						i = 1;
						sql.close();
						// 상품권 지급 내역 등록
						sql.put(svc.getQuery("INS_EVTSKUGIFTPRSNT"));
						sql.setString(i++, String2.nvl(form.getParam("strPrsntDt")));	// 지급일
						sql.setString(i++, F_RECEIPT_NO.substring(0,2));				// 점코드
						sql.setString(i++, strPrsntNo);									// 지급번호
						// SEQ_NO INSERT시 MAX값 저장
						sql.setString(i++, String2.nvl(form.getParam("strPrsntDt")));	// 지급일
						sql.setString(i++, F_RECEIPT_NO.substring(0,2));				// 점코드
						sql.setString(i++, strPrsntNo);									// 지급번호
						
						//sql.setString(i++, mi[1].getString("GIFTCARD_NO"));				// 상품권번호
						sql.setString(i++, mi[1].getString("GIFTCARD_LIST").substring(0+gift_cnt, 12+gift_cnt));	// 상품권번호
						
						sql.setString(i++, mi[1].getString("EVENT_CD"));				// 행사코드
						sql.setString(i++, mi[1].getString("SKU_CD"));					// 단품코드
						sql.setString(i++, userId);										// 등록자
						sql.setString(i++, userId);										// 수정자
						//sql.setString(i++, mi[1].getString("GIFTCERT_AMT"));			// 상품권금액
						sql.setString(i++, strGIFTCERT_AMT);			                // 상품권금액
	
						res = update(sql);
			
						if (res != 1) {
							throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
									+ "데이터 입력을 하지 못했습니다.");
						}
						
						i=1;
						sql.close();
						sql.put(svc.getQuery("UPD_GIFTMST"));
						sql.setString(i++, F_RECEIPT_NO.substring(0,2));				 	// 판매점
						sql.setString(i++, String2.nvl(form.getParam("strPrsntDt")));		// 판매일
						sql.setString(i++, userId); 								    	// 판매자
						//sql.setString(i++, mi[1].getString("GIFTCERT_AMT"));				// 금액
						sql.setString(i++, strGIFTCERT_AMT);			                 	// 금액
						sql.setString(i++, userId); 									    // 수정자
						//sql.setString(i++, mi[1].getString("GIFTCARD_NO"));			    // 상품권번호
						sql.setString(i++, mi[1].getString("GIFTCARD_LIST").substring(0+gift_cnt, 12+gift_cnt));	// 상품권번호
						res = update(sql);
						
						gift_cnt = gift_cnt + 12;
						
			            System.out.println("res---------- " + res); 
						if (res == 0) {
							throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
									+ "데이터 입력을 하지 못했습니다.");
						}				
					}
				}
				ret += res;
			}
			
            System.out.println("end---------- 1" ); 

			while (mi[2].next()) {
				rec_cnt = 0;
				gift_cnt = 0;
				
	            System.out.println("mi[2]---------- 2" ); 
				sql.close();
				
				sql.put(svc.getQuery("SEL_PRSNT_NO"));    //사은품지급번
				
			    map = selectMap(sql);
				strPrsntNo = map.get("PRSNT_NO").toString();
	            									
				i = 1;
				sql.close();
				// 사은품 지급 등록
				sql.put(svc.getQuery("INS_EVTSKUPRSNT"));

				RECEIPT_CNT = Integer.parseInt(mi[2].getString("RECEIPT_CNT"));
				GIFTCARD_CNT = Integer.parseInt(mi[2].getString("GIFTCARD_CNT"));
	            System.out.println("RECEIPT_CNT----------" + RECEIPT_CNT); 
	            System.out.println("GIFTCARD_CNT----------" + GIFTCARD_CNT); 
	            
				F_RECEIPT_NO = mi[2].getString("F_RECEIPT_NO");  
	            System.out.println("F_RECEIPT_NO----------" + F_RECEIPT_NO); 
	            
				sql.setString(i++, String2.nvl(form.getParam("strPrsntDt"))); 		// 지급일

				sql.setString(i++, F_RECEIPT_NO.substring(0,2)); 				    // 점코드
				sql.setString(i++, strPrsntNo); 									// 지급번호
				sql.setString(i++, mi[2].getString("EVENT_CD"));					// 행사코드	
				sql.setString(i++, mi[2].getString("SKU_CD")); 					    // 단품코드	
				sql.setString(i++, "1"); 										    // 지급구분 1:정상, 2:예외	(D-M004)
				//-- 지급시간
				sql.setString(i++, mi[2].getString("APP_RATE_AMT")); 	           	// 총인정매출금액
				sql.setString(i++, "1"); 											// 지급 수량
				sql.setString(i++, mi[2].getString("BUY_COST_PRC")); 			    // 지급금액(매입원가)
				sql.setString(i++, ""); 										    // 예외지급 승인자
				sql.setString(i++, ""); 										    // 예외지급 사유
				sql.setString(i++, ""); 										    // 카드회원번호	
				sql.setString(i++, mi[2].getString("TRG_CD")); 					    // 대상범위코드
				//--취소원거래전표번호 생략					
				sql.setString(i++, "1"); 											// 취소구분 1: 정상, 2:취소
				//--비고생략
				sql.setString(i++, userId); 										// 등록자
				sql.setString(i++, userId); 										// 등록자
				sql.setString(i++, strPrsntGbn); 									// 지급그룹번 MSS.SQ_MC_EVTSKUPRSNTGRP

	            System.out.println("strPrsntNo---------- 2" ); 
				res = update(sql);
				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
			
				for(int a = 0; a < RECEIPT_CNT; a++) {
					i = 1;
					sql.close();
					// 사은품 지급 영수증 등록
					sql.put(svc.getQuery("INS_PRSNTRECP"));
					sql.setString(i++, String2.nvl(form.getParam("strPrsntDt")));   // 지급일
					sql.setString(i++, F_RECEIPT_NO.substring(0+rec_cnt,2+rec_cnt)); 				// 점코드
					sql.setString(i++, strPrsntNo); 						    	// 지급번호
					sql.setString(i++, String2.nvl(form.getParam("strPrsntDt")));   // 지급일
					sql.setString(i++, F_RECEIPT_NO.substring(0+rec_cnt,2+rec_cnt)); 				// 점코드
					sql.setString(i++, strPrsntNo); 							    // 지급번호
					sql.setString(i++, F_RECEIPT_NO.substring(2+rec_cnt,10+rec_cnt)); 			    // 매출일자
					sql.setString(i++, F_RECEIPT_NO.substring(10+rec_cnt,14+rec_cnt)); 			    // 포스번호
					sql.setString(i++, F_RECEIPT_NO.substring(14+rec_cnt,19+rec_cnt));			    // 거래번호
					sql.setString(i++, mi[2].getString("APP_RATE_AMT"));		    // 인정매출금액
					sql.setString(i++, userId); 								    // 등록자
					sql.setString(i++, userId); 								    // 수정자
					sql.setString(i++, strPrsntGbn); 							    // 지급그룹번 MSS.SQ_MC_EVTSKUPRSNTGRP	
					
					res = update(sql);

					rec_cnt = rec_cnt + 19;
					
					if (res != 1) {
						throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					}
				}

				/*----------*/
				i = 1;
				sql.close();
				// 사은품 지급 브랜드집계 데이터 생성
				sql.put(svc.getQuery("INS_PRSNTPBN"));
				sql.setString(i++, userId); 										// 등록자
				sql.setString(i++, userId); 										// 등록자
				sql.setString(i++, F_RECEIPT_NO.substring(0,2)); 						// 점코드
				sql.setString(i++, String2.nvl(form.getParam("strPrsntDt"))); 		// 지급일
				sql.setString(i++, strPrsntNo); 									// 지급번호
				
				res = update(sql);
				if (res == 0) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				/*----------*/

	            System.out.println("SKU_GB----------" + mi[2].getString("SKU_GB")); 
				//사은품종류가 상품권이면
				if (mi[2].getString("SKU_GB").equals("2")) {

					gift_cnt = 0;
					for(int a = 0; a < GIFTCARD_CNT; a++) {		

						retno = null;
						retnoArr = null;
						
						i = 1;
						sql.close();
						//-- 상품권의 가격정보 가져오기

						strGIFTCARDNO = mi[2].getString("GIFTCARD_LIST").substring(0+gift_cnt, 12+gift_cnt);
						System.out.println("strGIFTCARDNO----------" + strGIFTCARDNO);
						
						strQuery = svc.getQuery("SEL_GIFTCERT_AMT") + "\n";
						sql.put(strQuery);                                     //상품권금액조회     
						sql.setString(i++, strGIFTCARDNO);
						
						retno = select2List(sql);
						
						retnoArr  = (List)retno.get(0);
						System.out.println("retArr_a----------" + retnoArr); 
						
						strGIFTCERT_AMT = retnoArr.get(0).toString();						
						System.out.println("strGIFTCERT_AMT----------" + strGIFTCERT_AMT); 
							
						i = 1;
						sql.close();
						// 상품권 지급 내역 등록
						sql.put(svc.getQuery("INS_EVTSKUGIFTPRSNT"));
						sql.setString(i++, String2.nvl(form.getParam("strPrsntDt")));	// 지급일
						sql.setString(i++, F_RECEIPT_NO.substring(0,2));				// 점코드
						sql.setString(i++, strPrsntNo);									// 지급번호
						// SEQ_NO INSERT시 MAX값 저장
						sql.setString(i++, String2.nvl(form.getParam("strPrsntDt")));	// 지급일
						sql.setString(i++, F_RECEIPT_NO.substring(0,2));				// 점코드
						sql.setString(i++, strPrsntNo);									// 지급번호
						
						//sql.setString(i++, mi[2].getString("GIFTCARD_NO"));				// 상품권번호
						sql.setString(i++, mi[2].getString("GIFTCARD_LIST").substring(0+gift_cnt, 12+gift_cnt));	// 상품권번호
						
						sql.setString(i++, mi[2].getString("EVENT_CD"));				// 행사코드
						sql.setString(i++, mi[2].getString("SKU_CD"));					// 단품코드
						sql.setString(i++, userId);										// 등록자
						sql.setString(i++, userId);										// 수정자
						//sql.setString(i++, mi[2].getString("GIFTCERT_AMT"));			// 상품권금액
						sql.setString(i++, strGIFTCERT_AMT);			                // 상품권금액
	
						res = update(sql);
			
						if (res != 1) {
							throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
									+ "데이터 입력을 하지 못했습니다.");
						}
	
						i=1;
						sql.close();
						sql.put(svc.getQuery("UPD_GIFTMST"));
						sql.setString(i++, F_RECEIPT_NO.substring(0,2));				 	// 판매점
						sql.setString(i++, String2.nvl(form.getParam("strPrsntDt")));		// 판매일
						sql.setString(i++, userId); 								    	// 판매자
						//sql.setString(i++, mi[2].getString("GIFTCERT_AMT"));				// 금액
						sql.setString(i++, strGIFTCERT_AMT);			                    // 금액
						sql.setString(i++, userId); 									    // 수정자
						//sql.setString(i++, mi[2].getString("GIFTCARD_NO"));				    // 상품권번호
						sql.setString(i++, mi[2].getString("GIFTCARD_LIST").substring(0+gift_cnt, 12+gift_cnt));	// 상품권번호
						res = update(sql);
						
						gift_cnt = gift_cnt + 12;
	
			            System.out.println("res---------- " + res); 
						if (res == 0) {
							throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
									+ "데이터 입력을 하지 못했습니다.");
						}		
					}
				}
				ret += res;
			}			

            System.out.println("end---------- 3" ); 
        
            while (mi[3].next()) {
				rec_cnt = 0;
				gift_cnt = 0;
				
	            System.out.println("mi[3]---------- 3" ); 
				sql.close();
				
				sql.put(svc.getQuery("SEL_PRSNT_NO"));    //사은품지급번
				
			    map = selectMap(sql);
				strPrsntNo = map.get("PRSNT_NO").toString();
	            									
				i = 1;
				sql.close();
				// 사은품 지급 등록
				sql.put(svc.getQuery("INS_EVTSKUPRSNT"));

				RECEIPT_CNT = Integer.parseInt(mi[3].getString("RECEIPT_CNT"));
				GIFTCARD_CNT = Integer.parseInt(mi[3].getString("GIFTCARD_CNT"));
	            System.out.println("RECEIPT_CNT----------" + RECEIPT_CNT); 
	            System.out.println("GIFTCARD_CNT----------" + GIFTCARD_CNT); 
	            
				F_RECEIPT_NO = mi[3].getString("F_RECEIPT_NO");  
	            System.out.println("F_RECEIPT_NO----------" + F_RECEIPT_NO); 
	            
				sql.setString(i++, String2.nvl(form.getParam("strPrsntDt"))); 		// 지급일

				sql.setString(i++, F_RECEIPT_NO.substring(0,2)); 				    // 점코드
				sql.setString(i++, strPrsntNo); 									// 지급번호
				sql.setString(i++, mi[3].getString("EVENT_CD"));					// 행사코드	
				sql.setString(i++, mi[3].getString("SKU_CD")); 					    // 단품코드	
				sql.setString(i++, "1"); 										    // 지급구분 1:정상, 2:예외	(D-M004)
				//-- 지급시간
				sql.setString(i++, mi[3].getString("APP_RATE_AMT")); 	           	// 총인정매출금액
				sql.setString(i++, "1"); 											// 지급 수량
				sql.setString(i++, mi[3].getString("BUY_COST_PRC")); 			    // 지급금액(매입원가)
				sql.setString(i++, ""); 										    // 예외지급 승인자
				sql.setString(i++, ""); 										    // 예외지급 사유
				sql.setString(i++, ""); 										    // 카드회원번호	
				sql.setString(i++, mi[3].getString("TRG_CD")); 					    // 대상범위코드
				//--취소원거래전표번호 생략					
				sql.setString(i++, "1"); 											// 취소구분 1: 정상, 2:취소
				//--비고생략
				sql.setString(i++, userId); 										// 등록자
				sql.setString(i++, userId); 										// 등록자
				sql.setString(i++, strPrsntGbn); 									// 지급그룹번 MSS.SQ_MC_EVTSKUPRSNTGRP

	            System.out.println("strPrsntNo---------- 2" ); 
				res = update(sql);
				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
			
				for(int a = 0; a < RECEIPT_CNT; a++) {
					i = 1;
					sql.close();
					// 사은품 지급 영수증 등록
					sql.put(svc.getQuery("INS_PRSNTRECP"));
					sql.setString(i++, String2.nvl(form.getParam("strPrsntDt")));   // 지급일
					sql.setString(i++, F_RECEIPT_NO.substring(0+rec_cnt,2+rec_cnt)); 				// 점코드
					sql.setString(i++, strPrsntNo); 						    	// 지급번호
					sql.setString(i++, String2.nvl(form.getParam("strPrsntDt")));   // 지급일
					sql.setString(i++, F_RECEIPT_NO.substring(0+rec_cnt,2+rec_cnt)); 				// 점코드
					sql.setString(i++, strPrsntNo); 							    // 지급번호
					sql.setString(i++, F_RECEIPT_NO.substring(2+rec_cnt,10+rec_cnt)); 			    // 매출일자
					sql.setString(i++, F_RECEIPT_NO.substring(10+rec_cnt,14+rec_cnt)); 			    // 포스번호
					sql.setString(i++, F_RECEIPT_NO.substring(14+rec_cnt,19+rec_cnt));			    // 거래번호
					sql.setString(i++, mi[3].getString("APP_RATE_AMT"));		    // 인정매출금액
					sql.setString(i++, userId); 								    // 등록자
					sql.setString(i++, userId); 								    // 수정자
					sql.setString(i++, strPrsntGbn); 							    // 지급그룹번 MSS.SQ_MC_EVTSKUPRSNTGRP	
					
					res = update(sql);

					rec_cnt = rec_cnt + 19;
					
					if (res != 1) {
						throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					}
				}

				/*----------*/
				i = 1;
				sql.close();
				// 사은품 지급 브랜드집계 데이터 생성
				sql.put(svc.getQuery("INS_PRSNTPBN"));
				sql.setString(i++, userId); 										// 등록자
				sql.setString(i++, userId); 										// 등록자
				sql.setString(i++, F_RECEIPT_NO.substring(0,2)); 						// 점코드
				sql.setString(i++, String2.nvl(form.getParam("strPrsntDt"))); 		// 지급일
				sql.setString(i++, strPrsntNo); 									// 지급번호
				
				res = update(sql);
				if (res == 0) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				/*----------*/

	            System.out.println("SKU_GB----------" + mi[3].getString("SKU_GB")); 
				//사은품종류가 상품권이면
				if (mi[3].getString("SKU_GB").equals("2")) {

					gift_cnt = 0;
					for(int a = 0; a < GIFTCARD_CNT; a++) {		

						retno = null;
						retnoArr = null;
						
						i = 1;
						sql.close();
						//-- 상품권의 가격정보 가져오기

						strGIFTCARDNO = mi[3].getString("GIFTCARD_LIST").substring(0+gift_cnt, 12+gift_cnt);
						System.out.println("strGIFTCARDNO----------" + strGIFTCARDNO);
						
						strQuery = svc.getQuery("SEL_GIFTCERT_AMT") + "\n";
						sql.put(strQuery);                                     //상품권금액조회     
						sql.setString(i++, strGIFTCARDNO);
						
						retno = select2List(sql);
						
						retnoArr  = (List)retno.get(0);
						System.out.println("retArr_a----------" + retnoArr); 
						
						strGIFTCERT_AMT = retnoArr.get(0).toString();						
						System.out.println("strGIFTCERT_AMT----------" + strGIFTCERT_AMT); 
							
						i = 1;
						sql.close();
						// 상품권 지급 내역 등록
						sql.put(svc.getQuery("INS_EVTSKUGIFTPRSNT"));
						sql.setString(i++, String2.nvl(form.getParam("strPrsntDt")));	// 지급일
						sql.setString(i++, F_RECEIPT_NO.substring(0,2));				// 점코드
						sql.setString(i++, strPrsntNo);									// 지급번호
						// SEQ_NO INSERT시 MAX값 저장
						sql.setString(i++, String2.nvl(form.getParam("strPrsntDt")));	// 지급일
						sql.setString(i++, F_RECEIPT_NO.substring(0,2));				// 점코드
						sql.setString(i++, strPrsntNo);									// 지급번호
						
						//sql.setString(i++, mi[2].getString("GIFTCARD_NO"));				// 상품권번호
						sql.setString(i++, mi[3].getString("GIFTCARD_LIST").substring(0+gift_cnt, 12+gift_cnt));	// 상품권번호
						
						sql.setString(i++, mi[3].getString("EVENT_CD"));				// 행사코드
						sql.setString(i++, mi[3].getString("SKU_CD"));					// 단품코드
						sql.setString(i++, userId);										// 등록자
						sql.setString(i++, userId);										// 수정자
						//sql.setString(i++, mi[2].getString("GIFTCERT_AMT"));			// 상품권금액
						sql.setString(i++, strGIFTCERT_AMT);			                // 상품권금액
	
						res = update(sql);
			
						if (res != 1) {
							throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
									+ "데이터 입력을 하지 못했습니다.");
						}
	
						i=1;
						sql.close();
						sql.put(svc.getQuery("UPD_GIFTMST"));
						sql.setString(i++, F_RECEIPT_NO.substring(0,2));				 	// 판매점
						sql.setString(i++, String2.nvl(form.getParam("strPrsntDt")));		// 판매일
						sql.setString(i++, userId); 								    	// 판매자
						//sql.setString(i++, mi[2].getString("GIFTCERT_AMT"));				// 금액
						sql.setString(i++, strGIFTCERT_AMT);			                    // 금액
						sql.setString(i++, userId); 									    // 수정자
						//sql.setString(i++, mi[2].getString("GIFTCARD_NO"));				    // 상품권번호
						sql.setString(i++, mi[3].getString("GIFTCARD_LIST").substring(0+gift_cnt, 12+gift_cnt));	// 상품권번호
						res = update(sql);
						
						gift_cnt = gift_cnt + 12;
	
			            System.out.println("res---------- " + res); 
						if (res == 0) {
							throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
									+ "데이터 입력을 하지 못했습니다.");
						}		
					}
				}
				ret += res;
			}			

            System.out.println("end---------- 3" ); 
          
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}	
	
}
