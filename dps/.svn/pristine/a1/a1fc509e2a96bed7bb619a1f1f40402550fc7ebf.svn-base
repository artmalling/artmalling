/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package psal.dao;

import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
 * <p>기부기획등록</p>
 * 
 * @created  on 1.1, 2010/05/19
 * @created  by 장형욱(FUJITSU KOREA LTD.)
 * @caused   by 청구제외 등록
 *
 */

public class PSal913DAO extends AbstractDAO {

    /**
     * <p>청구제외 조회</p>
     * 
     */        
    public List searchMaster(ActionForm form, HttpServletRequest request) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();
        
        String strStrCd       = String2.nvl(form.getParam("strStrCd"));    //-- 품번명
        String strCcompCd     = String2.nvl(form.getParam("strCcompCd"));  //-- 카드발급사
        String strBcomp       = String2.nvl(form.getParam("strBcomp"));    //-- 카드매입사
        String strSSaleDt     = String2.nvl(form.getParam("strSSaleDt"));  //-- 매출일자
        String strESaleDt     = String2.nvl(form.getParam("strESaleDt"));  //-- 매출일자
        String strRecpNo      = String2.nvl(form.getParam("strRecpNo"));   //-- 영스증번호
        String strCardNo      = String2.nvl(form.getParam("strCardNo"));   //-- 카드번호
        String strApprNo      = String2.nvl(form.getParam("strApprNo"));   //-- 승인번호
        String strBuyReqYN    = String2.nvl(form.getParam("strBuyReqYN")); //-- 조회구분
		String strGB          = String2.nvl(form.getParam("strGB")); //-- 조회구분

        connect("pot");

		if((strGB.equals("0")) || (strGB.equals("A")))  {
		
	        // 전일취소
	        strQuery += svc.getQuery("SEL_MASTER_YCAN") + "\n";
	        
	        sql.setString(i++, strStrCd);
	        sql.setString(i++, strCcompCd);
	        sql.setString(i++, strBcomp);
	        sql.setString(i++, strSSaleDt);
	        sql.setString(i++, strESaleDt);
	        sql.setString(i++, strCardNo);
	        sql.setString(i++, strApprNo);
	        sql.setString(i++, strBuyReqYN);
	        
	        if (!"".equals(strRecpNo)) {
	            sql.setString(i++, "0" + strRecpNo.substring(0, 1));
	            sql.setString(i++, "20" + strRecpNo.substring(1, 7));
	            sql.setString(i++, strRecpNo.substring(7, 11));
	            sql.setString(i++, strRecpNo.substring(11, 16));
	        } else {
	            sql.setString(i++, "");
	            sql.setString(i++, "");
	            sql.setString(i++, "");
	            sql.setString(i++, "");        	
	        }
		}
		
	    //
        if(strGB.equals("0")) {
			strQuery += svc.getQuery("SEL_UNION") + "\n";
        }
        
        if((strGB.equals("0")) || (strGB.equals("B")))  {
			// 당일취소
	        strQuery += svc.getQuery("SEL_MASTER_TCAN_1") + "\n";
	        
	        sql.setString(i++, strStrCd);
	        sql.setString(i++, strCcompCd);
	        sql.setString(i++, strBcomp);
	        sql.setString(i++, strSSaleDt);
	        sql.setString(i++, strESaleDt);
	        sql.setString(i++, strCardNo);
	        sql.setString(i++, strApprNo);
	        sql.setString(i++, strBuyReqYN);
	        
	        if (!"".equals(strRecpNo)) {
	            sql.setString(i++, "0" + strRecpNo.substring(0, 1));
	            sql.setString(i++, "20" + strRecpNo.substring(1, 7));
	            sql.setString(i++, strRecpNo.substring(7, 11));
	            sql.setString(i++, strRecpNo.substring(11, 16));
	        } else {
	            sql.setString(i++, "");
	            sql.setString(i++, "");
	            sql.setString(i++, "");
	            sql.setString(i++, "");        	
	        }

			strQuery += svc.getQuery("SEL_UNION") + "\n";
			
	        strQuery += svc.getQuery("SEL_MASTER_TCAN_2") + "\n";
	        
	        sql.setString(i++, strStrCd);
	        sql.setString(i++, strCcompCd);
	        sql.setString(i++, strBcomp);
	        sql.setString(i++, strSSaleDt);
	        sql.setString(i++, strESaleDt);
	        sql.setString(i++, strCardNo);
	        sql.setString(i++, strApprNo);
	        sql.setString(i++, strBuyReqYN);
	        
	        if (!"".equals(strRecpNo)) {
	            sql.setString(i++, "0" + strRecpNo.substring(0, 1));
	            sql.setString(i++, "20" + strRecpNo.substring(1, 7));
	            sql.setString(i++, strRecpNo.substring(7, 11));
	            sql.setString(i++, strRecpNo.substring(11, 16));
	        } else {
	            sql.setString(i++, "");
	            sql.setString(i++, "");
	            sql.setString(i++, "");
	            sql.setString(i++, "");        	
	        }
        }
	    //
        if(strGB.equals("0")) {
			strQuery += svc.getQuery("SEL_UNION") + "\n";
        }  
		
        if((strGB.equals("0")) || (strGB.equals("C")))  {
			// 수기입력
	        strQuery += svc.getQuery("SEL_MASTER_K") + "\n";
	        
	        sql.setString(i++, strStrCd);
	        sql.setString(i++, strCcompCd);
	        sql.setString(i++, strBcomp);
	        sql.setString(i++, strSSaleDt);
	        sql.setString(i++, strESaleDt);
	        sql.setString(i++, strCardNo);
	        sql.setString(i++, strApprNo);
	        sql.setString(i++, strBuyReqYN);
	        
	        if (!"".equals(strRecpNo)) {
	            sql.setString(i++, "0" + strRecpNo.substring(0, 1));
	            sql.setString(i++, "20" + strRecpNo.substring(1, 7));
	            sql.setString(i++, strRecpNo.substring(7, 11));
	            sql.setString(i++, strRecpNo.substring(11, 16));
	        } else {
	            sql.setString(i++, "");
	            sql.setString(i++, "");
	            sql.setString(i++, "");
	            sql.setString(i++, "");        	
	        }
        }
	    //
        if(strGB.equals("0")) {
			strQuery += svc.getQuery("SEL_UNION") + "\n";
        } 
        
        if((strGB.equals("0")) || (strGB.equals("D")))  {
	
			// 승인번호 중복1
	        strQuery += svc.getQuery("SEL_MASTER_DUP_APPR_NO_1") + "\n";
	        
	        sql.setString(i++, strStrCd);
	        sql.setString(i++, strCcompCd);
	        sql.setString(i++, strBcomp);
	        sql.setString(i++, strSSaleDt);
	        sql.setString(i++, strESaleDt);
	        sql.setString(i++, strCardNo);
	        sql.setString(i++, strApprNo);
	        sql.setString(i++, strBuyReqYN);
	        
	        if (!"".equals(strRecpNo)) {
	            sql.setString(i++, "0" + strRecpNo.substring(0, 1));
	            sql.setString(i++, "20" + strRecpNo.substring(1, 7));
	            sql.setString(i++, strRecpNo.substring(7, 11));
	            sql.setString(i++, strRecpNo.substring(11, 16));
	        } else {
	            sql.setString(i++, "");
	            sql.setString(i++, "");
	            sql.setString(i++, "");
	            sql.setString(i++, "");        	
	        }
	
			//
			strQuery += svc.getQuery("SEL_UNION") + "\n";	
	
			// 승인번호중복2
	        strQuery += svc.getQuery("SEL_MASTER_DUP_APPR_NO_2") + "\n";
	        
	        sql.setString(i++, strStrCd);
	        sql.setString(i++, strCcompCd);
	        sql.setString(i++, strBcomp);
	        sql.setString(i++, strSSaleDt);
	        sql.setString(i++, strESaleDt);
	        sql.setString(i++, strCardNo);
	        sql.setString(i++, strApprNo);
	        sql.setString(i++, strBuyReqYN);
	        
	        if (!"".equals(strRecpNo)) {
	            sql.setString(i++, "0" + strRecpNo.substring(0, 1));
	            sql.setString(i++, "20" + strRecpNo.substring(1, 7));
	            sql.setString(i++, strRecpNo.substring(7, 11));
	            sql.setString(i++, strRecpNo.substring(11, 16));
	        } else {
	            sql.setString(i++, "");
	            sql.setString(i++, "");
	            sql.setString(i++, "");
	            sql.setString(i++, "");        	
	        }
        }
	    //
        if(strGB.equals("0")) {
			strQuery += svc.getQuery("SEL_UNION") + "\n";
        }  
	
        if((strGB.equals("0")) || (strGB.equals("E")))  {
			// 발급사중복
	        strQuery += svc.getQuery("SEL_MASTER_DUP_CCOMP") + "\n";
	        
	        sql.setString(i++, strStrCd);
	        sql.setString(i++, strCcompCd);
	        sql.setString(i++, strBcomp);
	        sql.setString(i++, strSSaleDt);
	        sql.setString(i++, strESaleDt);
	        sql.setString(i++, strCardNo);
	        sql.setString(i++, strApprNo);
	        sql.setString(i++, strBuyReqYN);
	        
	        if (!"".equals(strRecpNo)) {
	            sql.setString(i++, "0" + strRecpNo.substring(0, 1));
	            sql.setString(i++, "20" + strRecpNo.substring(1, 7));
	            sql.setString(i++, strRecpNo.substring(7, 11));
	            sql.setString(i++, strRecpNo.substring(11, 16));
	        } else {
	            sql.setString(i++, "");
	            sql.setString(i++, "");
	            sql.setString(i++, "");
	            sql.setString(i++, "");        	
	        }
        }
	    //
        if(strGB.equals("0")) {
			strQuery += svc.getQuery("SEL_UNION") + "\n";
        }  
        
        if((strGB.equals("0")) || (strGB.equals("F")))  {
			// 매입사중복
	        strQuery += svc.getQuery("SEL_MASTER_DUP_BCOMP") + "\n";
	        
	        sql.setString(i++, strStrCd);
	        sql.setString(i++, strCcompCd);
	        sql.setString(i++, strBcomp);
	        sql.setString(i++, strSSaleDt);
	        sql.setString(i++, strESaleDt);
	        sql.setString(i++, strCardNo);
	        sql.setString(i++, strApprNo);
	        sql.setString(i++, strBuyReqYN);
	        
	        if (!"".equals(strRecpNo)) {
	            sql.setString(i++, "0" + strRecpNo.substring(0, 1));
	            sql.setString(i++, "20" + strRecpNo.substring(1, 7));
	            sql.setString(i++, strRecpNo.substring(7, 11));
	            sql.setString(i++, strRecpNo.substring(11, 16));
	        } else {
	            sql.setString(i++, "");
	            sql.setString(i++, "");
	            sql.setString(i++, "");
	            sql.setString(i++, "");        	
	        }
        }

	    //
        if(strGB.equals("0")) {
			strQuery += svc.getQuery("SEL_UNION") + "\n";
        }  
        
        if((strGB.equals("0")) || (strGB.equals("G")))  {
			// 카드빈 없음
	        strQuery += svc.getQuery("SEL_MASTER_BIN_NEXISTS") + "\n";
	        
	        sql.setString(i++, strStrCd);
	        sql.setString(i++, strCcompCd);
	        sql.setString(i++, strBcomp);
	        sql.setString(i++, strSSaleDt);
	        sql.setString(i++, strESaleDt);
	        sql.setString(i++, strCardNo);
	        sql.setString(i++, strApprNo);
	        sql.setString(i++, strBuyReqYN);
	        
	        if (!"".equals(strRecpNo)) {
	            sql.setString(i++, "0" + strRecpNo.substring(0, 1));
	            sql.setString(i++, "20" + strRecpNo.substring(1, 7));
	            sql.setString(i++, strRecpNo.substring(7, 11));
	            sql.setString(i++, strRecpNo.substring(11, 16));
	        } else {
	            sql.setString(i++, "");
	            sql.setString(i++, "");
	            sql.setString(i++, "");
	            sql.setString(i++, "");        	
	        }
        }

	    //
        if(strGB.equals("0")) {
			strQuery += svc.getQuery("SEL_UNION") + "\n";
        }  
        
        if((strGB.equals("0")) || (strGB.equals("H")))  {
			// 카드빈 발급사차이
	        strQuery += svc.getQuery("SEL_MASTER_BIN_CCOMP") + "\n";
	        
	        sql.setString(i++, strStrCd);
	        sql.setString(i++, strCcompCd);
	        sql.setString(i++, strBcomp);
	        sql.setString(i++, strSSaleDt);
	        sql.setString(i++, strESaleDt);
	        sql.setString(i++, strCardNo);
	        sql.setString(i++, strApprNo);
	        sql.setString(i++, strBuyReqYN);
	        
	        if (!"".equals(strRecpNo)) {
	            sql.setString(i++, "0" + strRecpNo.substring(0, 1));
	            sql.setString(i++, "20" + strRecpNo.substring(1, 7));
	            sql.setString(i++, strRecpNo.substring(7, 11));
	            sql.setString(i++, strRecpNo.substring(11, 16));
	        } else {
	            sql.setString(i++, "");
	            sql.setString(i++, "");
	            sql.setString(i++, "");
	            sql.setString(i++, "");        	
	        }
        }
        
	    //
        if(strGB.equals("0")) {
			strQuery += svc.getQuery("SEL_UNION") + "\n";
        }  
        
        if((strGB.equals("0")) || (strGB.equals("I")))  {
			// 카드빈 매입사차이
	        strQuery += svc.getQuery("SEL_MASTER_BIN_BCOMP") + "\n";
	        
	        sql.setString(i++, strStrCd);
	        sql.setString(i++, strCcompCd);
	        sql.setString(i++, strBcomp);
	        sql.setString(i++, strSSaleDt);
	        sql.setString(i++, strESaleDt);
	        sql.setString(i++, strCardNo);
	        sql.setString(i++, strApprNo);
	        sql.setString(i++, strBuyReqYN);
	        
	        if (!"".equals(strRecpNo)) {
	            sql.setString(i++, "0" + strRecpNo.substring(0, 1));
	            sql.setString(i++, "20" + strRecpNo.substring(1, 7));
	            sql.setString(i++, strRecpNo.substring(7, 11));
	            sql.setString(i++, strRecpNo.substring(11, 16));
	        } else {
	            sql.setString(i++, "");
	            sql.setString(i++, "");
	            sql.setString(i++, "");
	            sql.setString(i++, "");        	
	        }
        }

	    //
        if(strGB.equals("0")) {
			strQuery += svc.getQuery("SEL_UNION") + "\n";
        }
        
        if((strGB.equals("0")) || (strGB.equals("J")))  {
			// 당일수기취소
	        strQuery += svc.getQuery("SEL_MASTER_TCAN_SUJI") + "\n";
	        
	        sql.setString(i++, strStrCd);
	        sql.setString(i++, strCcompCd);
	        sql.setString(i++, strBcomp);
	        sql.setString(i++, strSSaleDt);
	        sql.setString(i++, strESaleDt);
	        sql.setString(i++, strCardNo);
	        sql.setString(i++, strApprNo);
	        sql.setString(i++, strBuyReqYN);
	        
	        if (!"".equals(strRecpNo)) {
	            sql.setString(i++, "0" + strRecpNo.substring(0, 1));
	            sql.setString(i++, "20" + strRecpNo.substring(1, 7));
	            sql.setString(i++, strRecpNo.substring(7, 11));
	            sql.setString(i++, strRecpNo.substring(11, 16));
	        } else {
	            sql.setString(i++, "");
	            sql.setString(i++, "");
	            sql.setString(i++, "");
	            sql.setString(i++, "");        	
	        }

			strQuery += svc.getQuery("SEL_UNION") + "\n";

	        strQuery += svc.getQuery("SEL_MASTER_TCAN_NO_ORG") + "\n";

	        sql.setString(i++, strStrCd);
	        sql.setString(i++, strSSaleDt);
	        sql.setString(i++, strESaleDt);
	        sql.setString(i++, strStrCd);
	        sql.setString(i++, strSSaleDt);
	        sql.setString(i++, strESaleDt);
	        
	        sql.setString(i++, strStrCd);
	        sql.setString(i++, strCcompCd);
	        sql.setString(i++, strBcomp);
	        sql.setString(i++, strSSaleDt);
	        sql.setString(i++, strESaleDt);
	        sql.setString(i++, strCardNo);
	        sql.setString(i++, strApprNo);
	        sql.setString(i++, strBuyReqYN);
	        
	        if (!"".equals(strRecpNo)) {
	            sql.setString(i++, "0" + strRecpNo.substring(0, 1));
	            sql.setString(i++, "20" + strRecpNo.substring(1, 7));
	            sql.setString(i++, strRecpNo.substring(7, 11));
	            sql.setString(i++, strRecpNo.substring(11, 16));
	        } else {
	            sql.setString(i++, "");
	            sql.setString(i++, "");
	            sql.setString(i++, "");
	            sql.setString(i++, "");        	
	        }
	        
        }

        if(strGB.equals("0")) {
			strQuery += svc.getQuery("SEL_UNION") + "\n";
        }
        
		if((strGB.equals("0")) || (strGB.equals("K")))  {
		
	        // 전일수기취소
	        strQuery += svc.getQuery("SEL_MASTER_YCAN_SUJI") + "\n";
	        
	        sql.setString(i++, strStrCd);
	        sql.setString(i++, strCcompCd);
	        sql.setString(i++, strBcomp);
	        sql.setString(i++, strSSaleDt);
	        sql.setString(i++, strESaleDt);
	        sql.setString(i++, strCardNo);
	        sql.setString(i++, strApprNo);
	        sql.setString(i++, strBuyReqYN);
	        
	        if (!"".equals(strRecpNo)) {
	            sql.setString(i++, "0" + strRecpNo.substring(0, 1));
	            sql.setString(i++, "20" + strRecpNo.substring(1, 7));
	            sql.setString(i++, strRecpNo.substring(7, 11));
	            sql.setString(i++, strRecpNo.substring(11, 16));
	        } else {
	            sql.setString(i++, "");
	            sql.setString(i++, "");
	            sql.setString(i++, "");
	            sql.setString(i++, "");        	
	        }
		}        
	    //
        
		//
        strQuery += svc.getQuery("SEL_MASTER_ORDER_UNION");
        
        sql.put(strQuery);
        ret = select2List(sql);
               
        return ret;
    }
    
    /**
     * <p>청구제외 상세 조회</p>
     * 
     */
    public List searchDetail(ActionForm form) throws Exception {
        List       ret      = null;
        SqlWrapper sql      = null;
        Service    svc      = null;
        String     strQuery = "";
        int i = 1;
        
        String strStrCd       = String2.nvl(form.getParam("strStrCd"));
        String strSaleDt      = String2.nvl(form.getParam("strSaleDt"));
        String strPosNo       = String2.nvl(form.getParam("strPosNo"));
        String strTranNo      = String2.nvl(form.getParam("strTranNo"));
        String strSeqNo       = String2.nvl(form.getParam("strSeqNo")); 
        String strPayType     = String2.nvl(form.getParam("strPayType"));
         
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strStrCd);
        sql.setString(i++, strSaleDt);      
        sql.setString(i++, strPosNo);
        sql.setString(i++, strTranNo);
        sql.setString(i++, strSeqNo);
        sql.setString(i++, strPayType);        
        
        strQuery = svc.getQuery("SEL_DETAIL");  
        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    }    
    
    /**
     * <p>청구제외 등록/수정</p>
     * 
     * @created  on 1.0, 2010/05/19
     * @created  by 장형욱
     * 
     * @modified on 
     * @modified by 
     * @caused   by 
     */
    
    public int saveData(ActionForm form, MultiInput mi, String userId) throws Exception {
        int ret = 0;
        int res = 0;
        SqlWrapper sql = null;
        Service svc    = null;
        String ccompCd  = null;
        Util util      = new Util();
      
        try {
        	
            connect("pot");
            begin();
            sql = new SqlWrapper();
            svc = (Service) form.getService();
            sql.close();
            
            while (mi.next()) {
//                if (mi.IS_INSERT()) { // 저장
//            	String dueDt       = mi.getString("POS_SEQ_NO"); 
            	String dueDt = String2.nvl(form.getParam("strPosSeqNo"));
            	System.out.println("########strSeqNo"+ dueDt);
                if (dueDt.length() == 0) { // 저장                   
                    sql.close();
           
                    
                    int i=1;
                    sql.put(svc.getQuery("INS_POSTPONE")); 
                       
                    String strStrCd       = String2.nvl(form.getParam("strStrCd"));
                    String strSaleDt      = String2.nvl(form.getParam("strSaleDt"));
                    String strPosNo       = String2.nvl(form.getParam("strPosNo"));
                    String strTranNo      = String2.nvl(form.getParam("strTranNo"));
                    String strSeqNo       = String2.nvl(form.getParam("strSeqNo")); 
                    String strPayType     = String2.nvl(form.getParam("strPayType"));
                    
                    sql.setString(i++, mi.getString("APPR_AMT")); //-- 총 매출
                    sql.setString(i++, mi.getString("CARD_NO"));  //-- 카드번호
                    sql.setString(i++, mi.getString("APPR_NO"));  //-- 승인번호
                    sql.setString(i++, mi.getString("BCOMP_CD")); //-- 카드매입사
                    sql.setString(i++, mi.getString("CHRG_YN"));  //-- 상태
                    //sql.setString(i++, mi.getString("REG_DT"));   //-- 청구제외일자
                    sql.setString(i++, mi.getString("DUE_DT"));   //-- 청구예정일자
                    sql.setString(i++, mi.getString("REASON_CD"));//-- 청구제외사유  
                    
                    sql.setString(i++, strStrCd);
                    sql.setString(i++, strSaleDt);      
                    sql.setString(i++, strPosNo);
                    sql.setString(i++, strTranNo);
                    sql.setString(i++, strSeqNo);
                    sql.setString(i++, strPayType); 
                    
                    sql.setString(i++, userId);   
                    sql.setString(i++, userId);   
                    
                } else if(dueDt.length() > 0){// 수정
                    int i=1;
                    sql.put(svc.getQuery("UPD_POSTPONE")); 
                    
                    String strStrCd       = String2.nvl(form.getParam("strStrCd"));
                    String strSaleDt      = String2.nvl(form.getParam("strSaleDt"));
                    String strPosNo       = String2.nvl(form.getParam("strPosNo"));
                    String strTranNo      = String2.nvl(form.getParam("strTranNo"));
                    String strSeqNo       = String2.nvl(form.getParam("strSeqNo")); 
                    String strPayType     = String2.nvl(form.getParam("strPayType"));
                    
                    sql.setString(i++, mi.getString("CHRG_YN"));       
                    sql.setString(i++, mi.getString("DUE_DT"));      
                    sql.setString(i++, mi.getString("REASON_CD"));   
                    sql.setString(i++, userId);   
                    
                    sql.setString(i++, strStrCd);
                    sql.setString(i++, strSaleDt);      
                    sql.setString(i++, strPosNo);
                    sql.setString(i++, strTranNo);
                    sql.setString(i++, dueDt);
                    sql.setString(i++, strPayType);                      
                    
                       
                    
                } else if (mi.IS_DELETE()) {
                    int i=1;
                    sql.put(svc.getQuery("DTL_CARDBIN")); 
                    
                    sql.setString(i++, mi.getString("BIN_NO"));    
                    sql.setString(i++, mi.getString("DCARD_TYPE"));                  	
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
}
