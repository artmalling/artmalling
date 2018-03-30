/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package psal.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
 
/**
 * <p>반송건 재청구 생성</p>
 * 
 * @created  on 1.1, 2010/05/26
 * @created  by 김영진(FUJITSU KOREA LTD.)
 * @caused   by 반송건 재청구 생성
 *
 */
public class PSal934DAO extends AbstractDAO {

    /**
     * <p>반송건 재청구 생성</p>
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
        
        connect("pot");
        
        String strRegDtS   = String2.nvl(form.getParam("strRegDtS"));   
        String strRegDtE   = String2.nvl(form.getParam("strRegDtE"));
        String strCcompCd  = String2.nvl(form.getParam("strCcompCd"));
        String strApprNo   = String2.nvl(form.getParam("strApprNo"));
        String strCardNo   = String2.nvl(form.getParam("strCardNo"));
        String strJbrchId  = String2.nvl(form.getParam("strJbrchId"));  
        String strStrCd    = String2.nvl(form.getParam("strStrCd"));	
        String strBcompCd  = String2.nvl(form.getParam("strBcompCd"));
        String strVrtnCd   = String2.nvl(form.getParam("strVrtnCd"));  
        //String strBuyReqYn = String2.nvl(form.getParam("strBuyReqYn"));	
        
        strQuery = svc.getQuery("SEL_MASTER");
        
        sql.setString(i++, strStrCd);
        sql.setString(i++, strRegDtS);  
        sql.setString(i++, strRegDtE);
        sql.setString(i++, strVrtnCd); 
        sql.setString(i++, strCcompCd); 
        sql.setString(i++, strBcompCd);
        sql.setString(i++, strJbrchId);
        sql.setString(i++, strCardNo);
        sql.setString(i++, strApprNo);
        //sql.setString(i++, strBuyReqYn); 
        
        sql.put(strQuery);
        ret = select2List(sql);
               
        return ret;
    }
     
    /**
     * <p>반송건 재청구 생성 상세 조회</p>
     * 
     */
    public List searchDetail(ActionForm form) throws Exception {
        List       ret      = null;
        SqlWrapper sql      = null;
        Service    svc      = null;
        String     strQuery = "";
        int i = 1;
        
        String strSaleDt   = String2.nvl(form.getParam("strSaleDt"));
        String strApprNo   = String2.nvl(form.getParam("strApprNo"));
        String strCardNo   = String2.nvl(form.getParam("strCardNo"));
        String strJbrchId  = String2.nvl(form.getParam("strJbrchId"));
        String strDivMonth  = String2.nvl(form.getParam("strDivMonth"));
        String strApprAmt 	= String2.nvl(form.getParam("strApprAmt"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");
        
        //KEY값  구하기     
        strQuery = svc.getQuery("SEL_DETAIL1"); 
        sql.setString(i++, strSaleDt);
        sql.setString(i++, strCardNo);
        sql.setString(i++, strApprNo);
        sql.setString(i++, strJbrchId);
        sql.setString(i++, strDivMonth);
        sql.setString(i++, strApprAmt);
        sql.put(strQuery);

        Map map = selectMap(sql);            
        String  reqChrgDt  = (String)map.get("CHRG_DT");
        String  reqChrgSeq = (String)map.get("CHRG_SEQ");
        String  reqSeqNo   = (String)map.get("SEQ_NO");
        sql.close();
        
        i=1;
        sql.put(svc.getQuery("SEL_DETAIL2"));
        sql.setString(i++, reqChrgDt);
        sql.setString(i++, reqChrgSeq);
        sql.setString(i++, reqSeqNo);

        ret = select2List(sql);
        return ret;
    }   
    

    public List searchRebyReq(ActionForm form) throws Exception {
        List       ret      = null;
        SqlWrapper sql      = null;
        Service    svc      = null;
        String     strQuery = "";
        int i = 1;
        
        String strPayDt    = String2.nvl(form.getParam("strPayDt"));
        String strPaySeq  = String2.nvl(form.getParam("strPaySeq"));
        String strSeqNo    = String2.nvl(form.getParam("strSeqNo"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        i=1;
        sql.put(svc.getQuery("SEL_REBUYREQ"));
        sql.setString(i++, strPayDt);
        sql.setString(i++, strPaySeq);
        sql.setString(i++, strSeqNo);

        ret = select2List(sql);
        return ret;
    }   
    
    /**
     * 재청구 정보를  일괄 저장 한다.
     * 
     * @param form
     * @param mi 
     * @param strID
     * @return
     * @throws Exception
     */
    public int saveBatch(ActionForm form, MultiInput mi, String userId)
    throws Exception {
        
    	int ret = 0; 
        int res = 0;
        int i   = 1;
        SqlWrapper sql = null;
        Service svc    = null;
        
        try {
        	
            connect("pot");
            begin();
            
            Map rtndKeyMap = new HashMap();
            while (mi.next()) {
            	
                sql = new SqlWrapper();
                svc = (Service) form.getService();
                
                String strSaleDt   = mi.getString("SALE_DT");
                String strApprNo   = mi.getString("APPR_NO");
                String strCardNo   = mi.getString("CARD_NO");
                String strJbrchId  = mi.getString("JBRCH_ID");
                String strDivMonth = mi.getString("DIV_MONTH");
                String strApprAmt  = mi.getString("TRADE_AMT");
                
                String strPayDt  	= mi.getString("PAY_DT");
                String strPaySeq  	= mi.getString("PAY_SEQ");
                String strSeqNo  	= mi.getString("SEQ_NO");
                
                i   = 1;
                //KEY값  구하기     
                sql.setString(i++, strSaleDt);
                sql.setString(i++, strCardNo);
                sql.setString(i++, strApprNo);
                sql.setString(i++, strJbrchId);
                sql.setString(i++, strDivMonth);
                sql.setString(i++, strApprAmt);
                sql.put(svc.getQuery("SEL_DETAIL1")); 
                
                Map map = selectMap(sql);            
                String  reqChrgDt  = (String)map.get("CHRG_DT");
                String  reqChrgSeq = (String)map.get("CHRG_SEQ");
                String  reqSeqNo   = (String)map.get("SEQ_NO");
                sql.close();
                
                /* 반송정보 키 조회 */
//				i=1;
//				sql.put(svc.getQuery("SEL_RTND_KEY"));   
//				sql.setString(i++, strSaleDt);
//				sql.setString(i++, strCardNo);
//				sql.setString(i++, strApprNo);
//				sql.setString(i++, strJbrchId);
//				rtndKeyMap = selectMap(sql);  				
//				String strChrgDt1  = (String)rtndKeyMap.get("CHRG_DT");
//				String strChrgSeq1 = (String)rtndKeyMap.get("CHRG_SEQ");
//				String strSeqNo1   = (String)rtndKeyMap.get("SEQ_NO");
//				sql.close();
                
                i=1;
                sql.put(svc.getQuery("SEL_REBUYREQ_CHK"));   
                sql.setString(i++, strPayDt);
                sql.setString(i++, strPaySeq);
                sql.setString(i++, strSeqNo); 
                map = selectMap(sql);  
                String  strFlag  = (String)map.get("FLAG");
                sql.close();
   
                i=1;
                if(strFlag.equals("I")){   	
                    sql.put(svc.getQuery("SEL_DETAIL2"));
                    sql.setString(i++, reqChrgDt);
                    sql.setString(i++, reqChrgSeq);
                    sql.setString(i++, reqSeqNo);
                    map = selectMap(sql);  
                    sql.close();  
                    
                	i=1;
                    sql.put(svc.getQuery("INS_REBUYREQ")); 
                    sql.setString(i++, strPayDt);  
                    sql.setString(i++, strPaySeq);    
                    sql.setString(i++, strSeqNo);        
                    sql.setString(i++, (String)map.get("REC_FLAG"));    
                    sql.setString(i++, (String)map.get("DEVICE_ID"));   
                    sql.setString(i++, (String)map.get("WORK_FLAG"));   
                    sql.setString(i++, (String)map.get("COMP_NO"));     
                    sql.setString(i++, (String)map.get("CARD_NO"));     
                    sql.setString(i++, (String)map.get("EXP_DT"));      
                    sql.setString(i++, (String)map.get("DIV_MONTH"));   
                    sql.setString(i++, (String)map.get("APPR_AMT"));    
                    sql.setString(i++, (String)map.get("SVC_AMT"));     
                    sql.setString(i++, (String)map.get("APPR_NO"));     
                    sql.setString(i++, (String)map.get("APPR_DT"));     
                    sql.setString(i++, (String)map.get("APPR_TIME"));   
                    sql.setString(i++, (String)map.get("CAN_DT"));      
                    sql.setString(i++, (String)map.get("CAN_TIME"));    
                    sql.setString(i++, (String)map.get("CCOMP_CD"));    
                    sql.setString(i++, (String)map.get("BCOMP_CD"));    
                    sql.setString(i++, (String)map.get("JBRCH_ID"));    
                    sql.setString(i++, (String)map.get("DOLLAR_FLAG"));  
                    sql.setString(i++, (String)map.get("FILLER"));      
                    String buyReqYn = (String) map.get("BUYREQ_YN");
                    sql.setString(i++, buyReqYn == null || buyReqYn.length() <1? "Y": buyReqYn);
                    sql.setString(i++, (String)map.get("REASON_CD"));   
                    sql.setString(i++, (String)map.get("MEMO"));    
                    sql.setString(i++, userId);      
                    sql.setString(i++, userId);      
                }else{
                    sql.put(svc.getQuery("SEL_REBUYREQ"));
                    sql.setString(i++, strPayDt);
                    sql.setString(i++, strPaySeq);
                    sql.setString(i++, strSeqNo);
                    map = selectMap(sql);  
                    sql.close();
                    
                	i=1;
                	sql.put(svc.getQuery("UPD_REBUYREQ"));    
                    sql.setString(i++, (String)map.get("REC_FLAG"));    
                    sql.setString(i++, (String)map.get("DEVICE_ID"));   
                    sql.setString(i++, (String)map.get("WORK_FLAG"));   
                    sql.setString(i++, (String)map.get("COMP_NO"));     
                    sql.setString(i++, (String)map.get("CARD_NO"));     
                    sql.setString(i++, (String)map.get("EXP_DT"));      
                    sql.setString(i++, (String)map.get("DIV_MONTH"));   
                    sql.setString(i++, (String)map.get("APPR_AMT"));    
                    sql.setString(i++, (String)map.get("SVC_AMT"));     
                    sql.setString(i++, (String)map.get("APPR_NO"));     
                    sql.setString(i++, (String)map.get("APPR_DT"));     
                    sql.setString(i++, (String)map.get("APPR_TIME"));   
                    sql.setString(i++, (String)map.get("CAN_DT"));      
                    sql.setString(i++, (String)map.get("CAN_TIME"));    
                    sql.setString(i++, (String)map.get("CCOMP_CD"));    
                    sql.setString(i++, (String)map.get("BCOMP_CD"));    
                    sql.setString(i++, (String)map.get("JBRCH_ID"));    
                    sql.setString(i++, (String)map.get("DOLLAR_FLAG"));  
                    sql.setString(i++, (String)map.get("FILLER"));      
                    sql.setString(i++, (boolean)map.get("BUYREQ_YN").equals("Y")?"N":"Y");   
                    sql.setString(i++, (String)map.get("REASON_CD"));   
                    sql.setString(i++, (String)map.get("MEMO"));
                    sql.setString(i++, userId);          
                    sql.setString(i++, strPayDt); 
                    sql.setString(i++, strPaySeq);   
                    sql.setString(i++, strSeqNo);  
                }
                res = update(sql);
                if (res != 1) {
                	throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
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
     *  재청구 정보를  저장 한다.
     * 
     * @param form
     * @param mi 
     * @param strID
     * @return
     * @throws Exception
     */
    public int save(ActionForm form, MultiInput mi, String userId)
    throws Exception {
        
    	int ret = 0;
        int res = 0;
        SqlWrapper sql = null;
        Service svc    = null;
        
        String strFlag   = String2.nvl(form.getParam("strFlag"));
        String strPayDt  = String2.nvl(form.getParam("strPayDt"));
        String strPaySeq = String2.nvl(form.getParam("strPaySeq"));
        String strSeqNo  = String2.nvl(form.getParam("strSeqNo"));
        try {
        	
            connect("pot");
            begin();
            sql = new SqlWrapper();
            svc = (Service) form.getService();
            
            while (mi.next()) {
                
                sql.close();
                int i=1;
                if(strFlag.equals("I")){
                    sql.put(svc.getQuery("INS_REBUYREQ")); 
                    sql.setString(i++, strPayDt);  
                    sql.setString(i++, strPaySeq);    
                    sql.setString(i++, strSeqNo);      
                    sql.setString(i++, mi.getString("REC_FLAG"));    
                    sql.setString(i++, mi.getString("DEVICE_ID"));   
                    sql.setString(i++, mi.getString("WORK_FLAG"));   
                    sql.setString(i++, mi.getString("COMP_NO"));     
                    sql.setString(i++, mi.getString("CARD_NO"));     
                    sql.setString(i++, mi.getString("EXP_DT"));      
                    sql.setString(i++, mi.getString("DIV_MONTH"));   
                    sql.setString(i++, mi.getString("APPR_AMT"));    
                    sql.setString(i++, mi.getString("SVC_AMT"));     
                    sql.setString(i++, mi.getString("APPR_NO"));     
                    sql.setString(i++, mi.getString("APPR_DT"));     
                    sql.setString(i++, mi.getString("APPR_TIME"));   
                    sql.setString(i++, mi.getString("CAN_DT"));      
                    sql.setString(i++, mi.getString("CAN_TIME"));    
                    sql.setString(i++, mi.getString("CCOMP_CD"));    
                    sql.setString(i++, mi.getString("BCOMP_CD"));    
                    sql.setString(i++, mi.getString("JBRCH_ID"));    
                    sql.setString(i++, mi.getString("DOLLAR_FLAG"));  
                    sql.setString(i++, mi.getString("FILLER"));      
                    sql.setString(i++, mi.getString("BUYREQ_YN"));   
                    sql.setString(i++, mi.getString("REASON_CD"));   
                    sql.setString(i++, mi.getString("MEMO"));        
                    sql.setString(i++, userId);      
                    sql.setString(i++, userId);     
                }else{
                	  sql.put(svc.getQuery("UPD_REBUYREQ"));    
                      sql.setString(i++, mi.getString("REC_FLAG"));    
                      sql.setString(i++, mi.getString("DEVICE_ID"));   
                      sql.setString(i++, mi.getString("WORK_FLAG"));   
                      sql.setString(i++, mi.getString("COMP_NO"));     
                      sql.setString(i++, mi.getString("CARD_NO"));     
                      sql.setString(i++, mi.getString("EXP_DT"));      
                      sql.setString(i++, mi.getString("DIV_MONTH"));   
                      sql.setString(i++, mi.getString("APPR_AMT"));    
                      sql.setString(i++, mi.getString("SVC_AMT"));     
                      sql.setString(i++, mi.getString("APPR_NO"));     
                      sql.setString(i++, mi.getString("APPR_DT"));     
                      sql.setString(i++, mi.getString("APPR_TIME"));   
                      sql.setString(i++, mi.getString("CAN_DT"));      
                      sql.setString(i++, mi.getString("CAN_TIME"));    
                      sql.setString(i++, mi.getString("CCOMP_CD"));    
                      sql.setString(i++, mi.getString("BCOMP_CD"));    
                      sql.setString(i++, mi.getString("JBRCH_ID"));    
                      sql.setString(i++, mi.getString("DOLLAR_FLAG"));  
                      sql.setString(i++, mi.getString("FILLER"));      
                      sql.setString(i++, mi.getString("BUYREQ_YN"));   
                      sql.setString(i++, mi.getString("REASON_CD"));   
                      sql.setString(i++, mi.getString("MEMO"));        
                      sql.setString(i++, userId);          
                      sql.setString(i++, mi.getString("CHRG_DT"));  
                      sql.setString(i++, mi.getString("CHRG_SEQ"));    
                      sql.setString(i++, mi.getString("SEQ_NO"));   
                }

                res = update(sql);
                
                if (res != 1) {
                	throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
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
