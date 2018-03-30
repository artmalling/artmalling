/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package psal.dao;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>수기승인등록</p>
 * 
 * @created  on 1.1, 2011/08/12
 * @created  by 김영진(FUJITSU KOREA LTD.)
 * @caused   by 수기승인등록
 *
 */

public class PSal914DAO extends AbstractDAO {

    /**
     * <p>수기승인등록 조회</p>
     */        
    public List searchMaster(ActionForm form, HttpServletRequest request) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        
        connect("pot");
        sql = new SqlWrapper();
        svc = (Service) form.getService();
        
        String strStrCd    = String2.nvl(form.getParam("strStrCd"));
        String strApprDt1  = String2.nvl(form.getParam("strApprDt1"));
        String strApprDt2  = String2.nvl(form.getParam("strApprDt2"));
        String strBcompCd  = String2.nvl(form.getParam("strBcompCd"));
        
        sql.setString(i++, strStrCd);
        sql.setString(i++, strApprDt1);
        sql.setString(i++, strApprDt2);
        sql.setString(i++, strBcompCd);   

        strQuery = svc.getQuery("SEL_MASTER");
       
        sql.put(strQuery);
        ret = select2List(sql);
               
        return ret;
    }
    
    /**
     * <p>수기승인등록 상세 조회</p>
     */
    public List searchDetail(ActionForm form) throws Exception {
        List       ret      = null;
        SqlWrapper sql      = null;
        Service    svc      = null;
        String     strQuery = "";
        int i = 1;
        
        connect("pot");

        sql = new SqlWrapper();
        svc = (Service) form.getService();
        
        String strReqDt    = String2.nvl(form.getParam("strReqDt"));
        String strFclFlag  = String2.nvl(form.getParam("strFclFlag"));
        String strSeqNo    = String2.nvl(form.getParam("strSeqNo"));

        sql.setString(i++, strReqDt);
        sql.setString(i++, strFclFlag);
        sql.setString(i++, strSeqNo); 
        
        strQuery = svc.getQuery("SEL_DETAIL");  
        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    }    
    
    /**
     * <p>수기승인등록/수정</p>
     */
    public int saveData(ActionForm form, MultiInput mi, String userId) throws Exception {
        int ret = 0;
        int res = 0;
        SqlWrapper sql = null;
        Service svc    = null;
      
        try {
        	
            connect("pot");
            begin();
            sql = new SqlWrapper();
            svc = (Service) form.getService();

            String strStrCd = String2.nvl(form.getParam("strStrCd"));
            
            while (mi.next()) {
                if (mi.IS_INSERT()) { //등록

                    int i=1;
                    sql.put(svc.getQuery("INS_BUYREQPREP")); 

                    sql.setString(i++, strStrCd);
                    sql.setString(i++, mi.getString("WORK_FLAG"));
                    sql.setString(i++, strStrCd);
                    sql.setString(i++, mi.getString("CARD_NO")); 
                    sql.setString(i++, mi.getString("EXP_DT"));
                    sql.setString(i++, mi.getString("DIV_MONTH"));
                    sql.setString(i++, mi.getString("APPR_AMT"));
                    sql.setString(i++, mi.getString("APPR_NO")); 
                    sql.setString(i++, mi.getString("APPR_DT"));
                    sql.setString(i++, mi.getString("APPR_TIME"));
                    sql.setString(i++, mi.getString("CAN_DT"));
                    sql.setString(i++, mi.getString("CAN_TIME"));
                    sql.setString(i++, mi.getString("CCOMP_CD"));
                    sql.setString(i++, mi.getString("BCOMP_CD"));
                    sql.setString(i++, mi.getString("JBRCH_ID"));
                    sql.setString(i++, strStrCd);
                    sql.setString(i++, userId);   
                    sql.setString(i++, userId);   
                    
                } else if(mi.IS_UPDATE()){// 수정
                    int i=1;
                    sql.put(svc.getQuery("UPD_BUYREQPREP")); 
                    
                    sql.setString(i++, mi.getString("WORK_FLAG"));
                    sql.setString(i++, mi.getString("CARD_NO"));
                    sql.setString(i++, mi.getString("EXP_DT"));
                    sql.setString(i++, mi.getString("DIV_MONTH"));
                    sql.setString(i++, mi.getString("APPR_AMT"));
                    sql.setString(i++, mi.getString("APPR_NO")); 
                    sql.setString(i++, mi.getString("APPR_DT"));
                    sql.setString(i++, mi.getString("APPR_TIME")); 
                    sql.setString(i++, mi.getString("CAN_DT"));
                    sql.setString(i++, mi.getString("CAN_TIME"));
                    sql.setString(i++, mi.getString("CCOMP_CD")); 
                    sql.setString(i++, mi.getString("BCOMP_CD")); 
                    sql.setString(i++, mi.getString("JBRCH_ID"));   
                    sql.setString(i++, userId);                    
                    sql.setString(i++, mi.getString("REQ_DT"));    
                    sql.setString(i++, mi.getString("FCL_FLAG"));
                    sql.setString(i++, mi.getString("SEQ_NO"));  
                } else if (mi.IS_DELETE()) {
                    int i=1;
                    sql.put(svc.getQuery("DEL_BUYREQPREP")); 
                    
                    sql.setString(i++, mi.getString("REQ_DT"));  
                    sql.setString(i++, mi.getString("FCL_FLAG"));
                    sql.setString(i++, mi.getString("SEQ_NO"));                	
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
     * <p>카드빈- 카드발급사, 카드매입사 조회</p>
     */        
    public List searchCardBin(ActionForm form) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null; 
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        
        connect("pot");
        sql = new SqlWrapper();
        svc = (Service) form.getService();
         
        String strCardNo = String2.nvl(form.getParam("strCardNo")).substring(0,6);
        
        sql.setString(i++, strCardNo);

        strQuery = svc.getQuery("SEL_CARDBIN");
       
        sql.put(strQuery);
        ret = select2List(sql);
               
        return ret;
    }
}
