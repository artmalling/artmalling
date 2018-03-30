/*
 * Copyright (c) 2010 대성디큐브. All rights reserved.
 *
 * This software is the confidential and proprietary information of 대성디큐브.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 대성디큐브
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

public class PSal514DAO extends AbstractDAO {

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
		

		
		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strPosNoS 	    = String2.nvl(form.getParam("strPosNoS"));
		String strSaleDtS 		= String2.nvl(form.getParam("strSaleDtS"));
		
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");

	    sql.put(svc.getQuery("SEL_SALE_POS"));

	    sql.setString(i++, strStrCd);
	    sql.setString(i++, strPosNoS);
	    sql.setString(i++, strSaleDtS);
		 
		ret = select2List(sql);
		
		return ret;
	}

	
	/**
	 * POS별 상품권 현황조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchGift(ActionForm form, String OrgFlag, String userid) throws Exception {
		
		List ret 		= null;
		SqlWrapper sql 	= null;
		SqlWrapper sql2 = null;
		Service svc 	= null;
		String strQuery = "";
		String strQuery2 = "";
		int i 			= 1;
		

		
		String strStrCd 		= String2.nvl(form.getParam("strStrCd"));
		String strPosNoS 	    = String2.nvl(form.getParam("strPosNoS"));
		String strSaleDtS 		= String2.nvl(form.getParam("strSaleDtS"));
		
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");

	    sql.put(svc.getQuery("SEL_GIFT_LIST"));

	    sql.setString(i++, strStrCd);
	    sql.setString(i++, strPosNoS);
	    sql.setString(i++, strSaleDtS);
		 
		ret = select2List(sql);
		
		return ret;
	}
	
	
    /**
     * <p>POS별 시재저정관리</p>
     * 
     * @created  on 1.0, 2011/07/28
     * @created  by 안형철
     * 
     * @modified on 
     * @modified by 
     * @caused   by 
     */
    
    public int saveData(ActionForm form, MultiInput mi, String userId, String userNm) throws Exception {
        int ret = 0;
        int res = 0;
        SqlWrapper sql = null;
        Service svc    = null;
      
        try {
        	
            connect("pot");
            begin();
            sql = new SqlWrapper();
            svc = (Service) form.getService();
            sql.close();
            
            String strCd  = ""; 
            String saleDt = "";
            String posNo  = "";
            String totFg  = "";
            String tramAmt = "";
            String tranNo = "";
            String strQuery = "";
            
            while (mi.next()) {
                if(mi.IS_UPDATE()){// 수정

                	if (strCd.equals("")) {
                    	strCd  = mi.getString("STR_CD");
                    	saleDt = mi.getString("SALE_DT");
                    	posNo  = mi.getString("POS_NO"); 	
                    	totFg  = mi.getString("TOTAL_FLAG");
                    	
    					sql.close();
    					sql.put(svc.getQuery("SEL_TRTOTALLOG"));
    					sql.setString(1, strCd);
    					
    					Map map = selectMap( sql );
    					tranNo = String2.nvl((String)map.get("TRAN_NO"));
    					sql.close();
    					
    					int j=1;
    					sql.put(svc.getQuery("INS_TRTOTALLOG"));
    					
                        sql.setString(j++, strCd);    
                        sql.setString(j++, tranNo);    
                        sql.setString(j++, saleDt);    
                        sql.setString(j++, posNo);    
                        sql.setString(j++, userId);    
                        sql.setString(j++, userNm);   
                        sql.setString(j++, userId);    
                        sql.setString(j++, userId);    
                        
                        res = update(sql);
                        sql.close();
                        if (res != 1) {
                            throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
                                    + "데이터 입력을 하지 못했습니다.");
                        }
                         
                	}  // if (strCd.equals("")) {
                		
                    int i=1;
                    sql.put(svc.getQuery("UPT_TRTOTAL")); 
                    // UPDATE DATA
                    sql.setInt(i++, mi.getInt      ("NORM_TRAN_AMT"));   
                    sql.setString(i++, userId);    
                    // UPDATE 조건
                    sql.setString(i++, mi.getString("STR_CD"));      
                    sql.setString(i++, mi.getString("SALE_DT"));
                    sql.setString(i++, mi.getString("POS_NO"));
                    sql.setString(i++, mi.getString("TOTAL_FLAG"));
                    sql.setString(i++, mi.getString("BALANCE_FLAG"));
                    
                    res = update(sql);
                    sql.close();
                    if (res != 1) {
                        throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
                                + "데이터 입력을 하지 못했습니다.");
                    }
                    ret = ret + res;     
                    
                    // log테이블 생성
                    int k=1;
                    strQuery = svc.getQuery("UPD_TRTOTALLOG") + "\n";
                    
                    if (mi.getString("BALANCE_FLAG").equals("101")) {
                    	strQuery = strQuery.replaceAll("@@upColum1",    ",  COL_101_N = " + mi.getInt  ("NORM_TRAN_AMT") );
                    	strQuery = strQuery.replaceAll("@@upColum2",    ",  COL_101_O = " + mi.getInt  ("NORM_TRAN_AMT_O") );
                    } else if (mi.getString("BALANCE_FLAG").equals("102")) {
                    	strQuery = strQuery.replaceAll("@@upColum1",    ",  COL_102_N = " + mi.getInt  ("NORM_TRAN_AMT") );
                    	strQuery = strQuery.replaceAll("@@upColum2",    ",  COL_102_O = " + mi.getInt  ("NORM_TRAN_AMT_O") );
                    } else if (mi.getString("BALANCE_FLAG").equals("111")) {
                    	strQuery = strQuery.replaceAll("@@upColum1",    ",  COL_111_N = " + mi.getInt  ("NORM_TRAN_AMT") );
                    	strQuery = strQuery.replaceAll("@@upColum2",    ",  COL_111_O = " + mi.getInt  ("NORM_TRAN_AMT_O") );
                    } else if (mi.getString("BALANCE_FLAG").equals("112")) {
                    	strQuery = strQuery.replaceAll("@@upColum1",    ",  COL_112_N = " + mi.getInt  ("NORM_TRAN_AMT") );
                    	strQuery = strQuery.replaceAll("@@upColum2",    ",  COL_112_O = " + mi.getInt  ("NORM_TRAN_AMT_O") );
                    } else if (mi.getString("BALANCE_FLAG").equals("113")) {
                    	strQuery = strQuery.replaceAll("@@upColum1",    ",  COL_113_N = " + mi.getInt  ("NORM_TRAN_AMT") );
                    	strQuery = strQuery.replaceAll("@@upColum2",    ",  COL_113_O = " + mi.getInt  ("NORM_TRAN_AMT_O") );
                    } else if (mi.getString("BALANCE_FLAG").equals("114")) {
                    	strQuery = strQuery.replaceAll("@@upColum1",    ",  COL_114_N = " + mi.getInt  ("NORM_TRAN_AMT") );
                    	strQuery = strQuery.replaceAll("@@upColum2",    ",  COL_114_O = " + mi.getInt  ("NORM_TRAN_AMT_O") );
                    } else if (mi.getString("BALANCE_FLAG").equals("115")) {
                    	strQuery = strQuery.replaceAll("@@upColum1",    ",  COL_115_N = " + mi.getInt  ("NORM_TRAN_AMT") );
                    	strQuery = strQuery.replaceAll("@@upColum2",    ",  COL_115_O = " + mi.getInt  ("NORM_TRAN_AMT_O") );
                    } else if (mi.getString("BALANCE_FLAG").equals("116")) {
                    	strQuery = strQuery.replaceAll("@@upColum1",    ",  COL_116_N = " + mi.getInt  ("NORM_TRAN_AMT") );
                    	strQuery = strQuery.replaceAll("@@upColum2",    ",  COL_116_O = " + mi.getInt  ("NORM_TRAN_AMT_O") );
                    } else if (mi.getString("BALANCE_FLAG").equals("302")) {
                    	strQuery = strQuery.replaceAll("@@upColum1",    ",  COL_302_N = " + mi.getInt  ("NORM_TRAN_AMT") );
                    	strQuery = strQuery.replaceAll("@@upColum2",    ",  COL_302_O = " + mi.getInt  ("NORM_TRAN_AMT_O") );
                    } else if (mi.getString("BALANCE_FLAG").equals("402")) {
                    	strQuery = strQuery.replaceAll("@@upColum1",    ",  COL_402_N = " + mi.getInt  ("NORM_TRAN_AMT") );
                    	strQuery = strQuery.replaceAll("@@upColum2",    ",  COL_402_O = " + mi.getInt  ("NORM_TRAN_AMT_O") );
                    }                  
                    
                    sql.put(strQuery); 
                    sql.setString(k++, userId);    
                    sql.setString(k++, mi.getString("STR_CD"));      
                    sql.setString(k++, tranNo);
                    
                    res = update(sql);
                    sql.close();
                    if (res != 1) {
                         throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
                                 + "데이터 입력을 하지 못했습니다.");
                    }  
                } 
            }

            if (ret > 0){
            	// 각종 계 산출
                // 결재 내역계
            	System.out.println("결재 내역계");
				int i=1;
                sql.put(svc.getQuery("UPD_189_TRTOTAL"));
                 
                // UPDATE DATA
                sql.setString(i++, mi.getString("STR_CD"));      
                sql.setString(i++, mi.getString("SALE_DT"));
                sql.setString(i++, mi.getString("POS_NO"));
                sql.setString(i++, mi.getString("TOTAL_FLAG"));
                sql.setString(i++, userId);    
                // UPDATE 조건
                sql.setString(i++, mi.getString("STR_CD"));      
                sql.setString(i++, mi.getString("SALE_DT"));
                sql.setString(i++, mi.getString("POS_NO"));
                sql.setString(i++, mi.getString("TOTAL_FLAG"));
                sql.setString(i++, "189");            	 
            	 
                res = update(sql);
                sql.close();
                if (res != 1) {
                     throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
                             + "데이터 입력을 하지 못했습니다.");
                }                   
                
                // 현금매출시
            	System.out.println("현금매출시 정산지  번생성(매출 - 반품)");
				i=1;
                sql.put(svc.getQuery("UPD_202_TRTOTAL"));
                 
                // UPDATE DATA
                sql.setString(i++, mi.getString("STR_CD"));      
                sql.setString(i++, mi.getString("SALE_DT"));
                sql.setString(i++, mi.getString("POS_NO"));
                sql.setString(i++, mi.getString("TOTAL_FLAG"));
                sql.setString(i++, userId);    
                // UPDATE 조건
                sql.setString(i++, mi.getString("STR_CD"));      
                sql.setString(i++, mi.getString("SALE_DT"));
                sql.setString(i++, mi.getString("POS_NO"));
                sql.setString(i++, mi.getString("TOTAL_FLAG"));
                sql.setString(i++, "202");            	 
            	 
                res = update(sql);
                sql.close();
                if (res != 1) {
                     throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
                             + "데이터 입력을 하지 못했습니다.");
                }                   
                
                // 현금매출시 정산지 200 번생성(현금입금(준비금 + 현금매출 + PDA입금)) -->
            	System.out.println("현금매출시 정산지 200");
            	
			    i=1;
                sql.put(svc.getQuery("UPD_200_TRTOTAL"));
                 
                // UPDATE DATA
                sql.setString(i++, mi.getString("STR_CD"));      
                sql.setString(i++, mi.getString("SALE_DT"));
                sql.setString(i++, mi.getString("POS_NO"));
                sql.setString(i++, mi.getString("TOTAL_FLAG"));
                sql.setString(i++, userId);    
                // UPDATE 조건
                sql.setString(i++, mi.getString("STR_CD"));      
                sql.setString(i++, mi.getString("SALE_DT"));
                sql.setString(i++, mi.getString("POS_NO"));
                sql.setString(i++, mi.getString("TOTAL_FLAG"));
                sql.setString(i++, "200");            	 
            	
                 
                res = update(sql);
                sql.close();
                if (res != 1) {
                     throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
                             + "데이터 입력을 하지 못했습니다.");
                }                 
				      
                // -- 현금환불 계산처리 
            	System.out.println("현금환불 계산처리");
				i=1;
                sql.put(svc.getQuery("UPD_303_TRTOTAL"));
                 
                // UPDATE DATA
                sql.setString(i++, mi.getString("STR_CD"));      
                sql.setString(i++, mi.getString("SALE_DT"));
                sql.setString(i++, mi.getString("POS_NO"));
                sql.setString(i++, mi.getString("TOTAL_FLAG"));
                sql.setString(i++, userId);    
                // UPDATE 조건
                sql.setString(i++, mi.getString("STR_CD"));      
                sql.setString(i++, mi.getString("SALE_DT"));
                sql.setString(i++, mi.getString("POS_NO"));
                sql.setString(i++, mi.getString("TOTAL_FLAG"));
                sql.setString(i++, "303");            	 
            	
                 
                res = update(sql);
                sql.close();
                if (res != 1) {
                     throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
                             + "데이터 입력을 하지 못했습니다.");
                }   
                // -- 현금출금 계산처리 
            	System.out.println("현금출금 계산처리");
				i=1;
                sql.put(svc.getQuery("UPD_300_TRTOTAL"));
                 
                // UPDATE DATA
                sql.setString(i++, mi.getString("STR_CD"));      
                sql.setString(i++, mi.getString("SALE_DT"));
                sql.setString(i++, mi.getString("POS_NO"));
                sql.setString(i++, mi.getString("TOTAL_FLAG"));
                sql.setString(i++, userId);    
                // UPDATE 조건
                sql.setString(i++, mi.getString("STR_CD"));      
                sql.setString(i++, mi.getString("SALE_DT"));
                sql.setString(i++, mi.getString("POS_NO"));
                sql.setString(i++, mi.getString("TOTAL_FLAG"));
                sql.setString(i++, "300");            	 
            	
                 
                res = update(sql);
                sql.close();
                if (res != 1) {
                     throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
                             + "데이터 입력을 하지 못했습니다.");
                }                 
                                 
                
                // -- 현금잔액 계산처리  
            	System.out.println("현금잔액 계산처리");
				i=1;
                sql.put(svc.getQuery("UPD_401_TRTOTAL"));
                 
                // UPDATE DATA
                sql.setString(i++, mi.getString("STR_CD"));      
                sql.setString(i++, mi.getString("SALE_DT"));
                sql.setString(i++, mi.getString("POS_NO"));
                sql.setString(i++, mi.getString("TOTAL_FLAG"));
                sql.setString(i++, userId);    
                // UPDATE 조건
                sql.setString(i++, mi.getString("STR_CD"));      
                sql.setString(i++, mi.getString("SALE_DT"));
                sql.setString(i++, mi.getString("POS_NO"));
                sql.setString(i++, mi.getString("TOTAL_FLAG"));
                sql.setString(i++, "401");            	 
            	
                 
                res = update(sql);
                sql.close();
                if (res != 1) {
                     throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
                             + "데이터 입력을 하지 못했습니다.");
                }
                                
                
                // -- 과부족 계산처리 
            	System.out.println("과부족 계산처리");
				i=1;
                sql.put(svc.getQuery("UPD_403_TRTOTAL"));
                 
                // UPDATE DATA
                sql.setString(i++, mi.getString("STR_CD"));      
                sql.setString(i++, mi.getString("SALE_DT"));
                sql.setString(i++, mi.getString("POS_NO"));
                sql.setString(i++, mi.getString("TOTAL_FLAG"));
                sql.setString(i++, userId);    
                // UPDATE 조건
                sql.setString(i++, mi.getString("STR_CD"));      
                sql.setString(i++, mi.getString("SALE_DT"));
                sql.setString(i++, mi.getString("POS_NO"));
                sql.setString(i++, mi.getString("TOTAL_FLAG"));
                sql.setString(i++, "403");            	 
            	 
                res = update(sql);
                sql.close();
                if (res != 1) {
                     throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
                             + "데이터 입력을 하지 못했습니다.");
                }                   
               
                // 매출외 입금계산  -- > 변경될일이 절대 없음 하여 제외함
                // 결재 대상액계      -- > 변경될일이 절대 없음 하여 제외함.
                 
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
     * <p>상품권 정보 update</p>
     * 
     * @created  on 1.0, 2011/07/28
     * @created  by 안형철
     * 
     * @modified on 
     * @modified by 
     * @caused   by 
     */
    
    public int saveGfData(ActionForm form, MultiInput mi, String userId, String userNm) throws Exception {
        int ret = 0;
        int res = 0;
        SqlWrapper sql = null;
        Service svc    = null;
      
        try {
        	
            connect("pot");
            begin();
            sql = new SqlWrapper();
            svc = (Service) form.getService();
            sql.close();
            
            String strCd  = ""; 
            String saleDt = "";
            String posNo  = "";
            String totFg  = "";
            String tranNo = "";
            String strQuery = "";
            
            while (mi.next()) {
                if(mi.IS_UPDATE()){// 수정

                	if (strCd.equals("")) {
                       // logtable seq 채번
                    	strCd  = mi.getString("STR_CD");
                    	saleDt = mi.getString("SALE_DT");
                    	posNo  = mi.getString("POS_NO"); 	
                    	totFg  = mi.getString("TOTAL_FLAG");
/*                    	
                    	System.out.println("saveGfData(SEL_TRTOTALGLOG) STR_CD=[" + strCd + "]");
                    	System.out.println("saveGfData(SEL_TRTOTALGLOG) SALE_DT=[" + saleDt + "]");
                    	System.out.println("saveGfData(SEL_TRTOTALGLOG) POS_NO=[" + posNo + "]");
                    	System.out.println("saveGfData(SEL_TRTOTALGLOG) TOTAL_FLAG=[" + totFg + "]");
*/                    	
    					sql.close();
    					sql.put(svc.getQuery("SEL_TRTOTALGLOG"));
    					sql.setString(1, strCd);
    					
    					Map map = selectMap( sql );
    					tranNo = String2.nvl((String)map.get("TRAN_NO"));
    					sql.close();
    					
/*
                    	System.out.println("saveGfData(SEL_TRTOTALGLOG) TRAN_NO=[" + tranNo + "]");
*/
                 	   // logtable insert    					
    					int j=1;
    					sql.put(svc.getQuery("INS_TRTOTALGLOG"));
    					
                        sql.setString(j++, strCd);    
                        sql.setString(j++, tranNo);    
                        sql.setString(j++, saleDt);    
                        sql.setString(j++, posNo);    
                        sql.setString(j++, userId);    
                        sql.setString(j++, userNm);   
                        sql.setString(j++, userId);    
                        sql.setString(j++, userId);    
                        
                        res = update(sql);
                        sql.close();
                        if (res != 1) {
                            throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
                                    + "데이터 입력을 하지 못했습니다.");
                        }
                           
                		
                	}  // if (strCd.equals("")) {
                		
                    // 상품권 테이블 update
                    int i=1;
                    sql.put(svc.getQuery("UPT_TRTOTALGIFT")); 
                    // UPDATE DATA
                    sql.setInt   (i++, mi.getInt      ("USE_AMT"));   
                    sql.setString(i++, userId);    
                    // UPDATE 조건
                    sql.setString(i++, mi.getString("STR_CD"));      
                    sql.setString(i++, mi.getString("SALE_DT"));
                    sql.setString(i++, mi.getString("POS_NO"));
                    sql.setString(i++, mi.getString("TOTAL_FLAG"));
                    sql.setString(i++, mi.getString("BALANCE_FLAG"));
                    
/*
                    System.out.println("saveGfData(UPT_TRTOTALGIFT) STR_CD=[" + mi.getString("STR_CD") + "]");
                    System.out.println("saveGfData(UPT_TRTOTALGIFT) SALE_DT=[" + mi.getString("SALE_DT") + "]");
                    System.out.println("saveGfData(UPT_TRTOTALGIFT) POS_NO=[" + mi.getString("POS_NO") + "]");
                    System.out.println("saveGfData(UPT_TRTOTALGIFT) TOTAL_FLAG=[" + mi.getString("TOTAL_FLAG") + "]");
                    System.out.println("saveGfData(UPT_TRTOTALGIFT) BALANCE_FLAG=[" + mi.getString("BALANCE_FLAG") + "]");
                    System.out.println("saveGfData(UPT_TRTOTALGIFT) USE_AMT=[" + mi.getInt      ("USE_AMT") + "]");
*/                  
                    
                    res = update(sql);
                    sql.close();
                    if (res != 1) {
                        throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
                                + "데이터 입력을 하지 못했습니다.");
                    }
                    ret = ret + res;   
                    // log테이블 생성
                    int k=1;
                    strQuery = svc.getQuery("UPD_TRTOTALGLOG") + "\n";
                    if (mi.getString("BALANCE_FLAG").equals("001")) {
                    	strQuery = strQuery.replaceAll("@@upColum1",    ",  COL_G001_N = " + mi.getInt  ("USE_AMT") );
                    	strQuery = strQuery.replaceAll("@@upColum2",    ",  COL_G001_O = " + mi.getInt  ("USE_AMT_O") );
                    } else if (mi.getString("BALANCE_FLAG").equals("002")) {
                    	strQuery = strQuery.replaceAll("@@upColum1",    ",  COL_G002_N = " + mi.getInt  ("USE_AMT") );
                    	strQuery = strQuery.replaceAll("@@upColum2",    ",  COL_G002_O = " + mi.getInt  ("USE_AMT_O") );
                    } else if (mi.getString("BALANCE_FLAG").equals("003")) {
                    	strQuery = strQuery.replaceAll("@@upColum1",    ",  COL_G003_N = " + mi.getInt  ("USE_AMT") );
                    	strQuery = strQuery.replaceAll("@@upColum2",    ",  COL_G003_O = " + mi.getInt  ("USE_AMT_O") );
                    } else if (mi.getString("BALANCE_FLAG").equals("004")) {
                    	strQuery = strQuery.replaceAll("@@upColum1",    ",  COL_G004_N = " + mi.getInt  ("USE_AMT") );
                    	strQuery = strQuery.replaceAll("@@upColum2",    ",  COL_G004_O = " + mi.getInt  ("USE_AMT_O") );
                    } else if (mi.getString("BALANCE_FLAG").equals("005")) {
                    	strQuery = strQuery.replaceAll("@@upColum1",    ",  COL_G005_N = " + mi.getInt  ("USE_AMT") );
                    	strQuery = strQuery.replaceAll("@@upColum2",    ",  COL_G005_O = " + mi.getInt  ("USE_AMT_O") );
                    } else if (mi.getString("BALANCE_FLAG").equals("006")) {
                    	strQuery = strQuery.replaceAll("@@upColum1",    ",  COL_G006_N = " + mi.getInt  ("USE_AMT") );
                    	strQuery = strQuery.replaceAll("@@upColum2",    ",  COL_G006_O = " + mi.getInt  ("USE_AMT_O") );
                    } else if (mi.getString("BALANCE_FLAG").equals("020")) {
                    	strQuery = strQuery.replaceAll("@@upColum1",    ",  COL_G020_N = " + mi.getInt  ("USE_AMT") );
                    	strQuery = strQuery.replaceAll("@@upColum2",    ",  COL_G020_O = " + mi.getInt  ("USE_AMT_O") );
                    } else if (mi.getString("BALANCE_FLAG").equals("030")) {
                    	strQuery = strQuery.replaceAll("@@upColum1",    ",  COL_G030_N = " + mi.getInt  ("USE_AMT") );
                    	strQuery = strQuery.replaceAll("@@upColum2",    ",  COL_G030_O = " + mi.getInt  ("USE_AMT_O") );
                    } else if (mi.getString("BALANCE_FLAG").equals("040")) {
                    	strQuery = strQuery.replaceAll("@@upColum1",    ",  COL_G040_N = " + mi.getInt  ("USE_AMT") );
                    	strQuery = strQuery.replaceAll("@@upColum2",    ",  COL_G040_O = " + mi.getInt  ("USE_AMT_O") );
                    } else if (mi.getString("BALANCE_FLAG").equals("050")) {
                    	strQuery = strQuery.replaceAll("@@upColum1",    ",  COL_G050_N = " + mi.getInt  ("USE_AMT") );
                    	strQuery = strQuery.replaceAll("@@upColum2",    ",  COL_G050_O = " + mi.getInt  ("USE_AMT_O") );
                    }                  
                    
                    sql.put(strQuery); 
                    sql.setString(k++, userId);    
                    sql.setString(k++, mi.getString("STR_CD"));      
                    sql.setString(k++, tranNo);
/*
                    System.out.println("saveGfData(UPD_TRTOTALGLOG) STR_CD=[" + mi.getString("STR_CD") + "]");
                    System.out.println("saveGfData(UPD_TRTOTALGLOG) userId=[" + userId + "]");
                    System.out.println("saveGfData(UPD_TRTOTALGLOG) tranNo=[" + tranNo + "]");
*/                  
                    res = update(sql);
                    sql.close();
                    if (res != 1) {
                         throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
                                 + "데이터 입력을 하지 못했습니다.");
                    }  
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