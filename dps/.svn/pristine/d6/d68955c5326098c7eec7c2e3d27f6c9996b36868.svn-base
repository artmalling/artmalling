/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pcod.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>기부기획등록</p>
 * 
 * @created  on 1.1, 2012.07.16
 * @created  by 강진(FUJITSU KOREA LTD.)
 * @caused   by 카드별현장할인내역등록
 *
 */

public class PCodD01DAO extends AbstractDAO {

    /**
     * <p>카드별현장할인내역 조회</p>
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
        
        String strStrCd    	= String2.nvl(form.getParam("strStrCd"));
        String strCcomp    	= String2.nvl(form.getParam("strCcomp"));
        String strAppSDt   	= String2.nvl(form.getParam("strAppSDt"));
        String strAppEDt   	= String2.nvl(form.getParam("strAppEDt"));        
        String strSBinNo    = String2.nvl(form.getParam("strSBinNo"));
        String strEBinNo    = String2.nvl(form.getParam("strEBinNo"));
        
        if ("".equals(strSBinNo))
        	strSBinNo = "000000";
        
        if ("".equals(strEBinNo))
        	strEBinNo = "999999";        
        
        sql.setString(i++, strStrCd);
        sql.setString(i++, strCcomp);
        sql.setString(i++, strAppSDt);
        sql.setString(i++, strAppEDt);
        sql.setString(i++, strSBinNo);
        sql.setString(i++, strEBinNo);

        connect("pot");
        
        strQuery = svc.getQuery("SEL_MASTER") + "\n";
         
        sql.put(strQuery);
        ret = select2List(sql);
               
        return ret;
    }
    
    /**
     * <p>카드별현장할인내역 상세 조회</p>
     * 
     */
    public List searchDetail(ActionForm form) throws Exception {
        List       ret      = null;
        SqlWrapper sql      = null;
        Service    svc      = null;
        String     strQuery = "";
        int i = 1;
        
        String strStrCd    	= String2.nvl(form.getParam("strStrCd"));
        String strBinNo     = String2.nvl(form.getParam("strBinNo"));
        String strAppSDt   	= String2.nvl(form.getParam("strAppSDt"));
        String strSeqNo     = String2.nvl(form.getParam("strSeqNo"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strStrCd);
        sql.setString(i++, strBinNo);
        sql.setString(i++, strAppSDt);
        sql.setString(i++, strSeqNo);
        
        strQuery = svc.getQuery("SEL_DETAIL"); // + "\n";
        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    }    
    
    /**
     * <p>카드별현장할인내역 등록/수정</p>
     * 
     * @created  on 1.0, 2012.07.16
     * @created  by 강진
     * 
     * @modified on 
     * @modified by 
     * @caused   by 
     */
    
    public int saveData(ActionForm form, MultiInput mi, String userId) throws Exception {
        int ret = 0;
        int res = 0;
        SqlWrapper sql 	= null;
        Service svc    	= null;
        String cnt1  	= null;
        String cnt2  	= null;
        Util util      	= new Util();
      
        try {
        	
            connect("pot");
            begin();
            sql = new SqlWrapper();
            svc = (Service) form.getService();
            sql.close();
            
            while (mi.next()) {                
                if (mi.IS_INSERT()) { // 저장
                	
                    if(searchSaveChk(form, mi) > 0){
                    	return ret;
                    }
                    
                    sql.put("SELECT COUNT(*)+1 AS CNT FROM DPS.PC_FLDDCMST WHERE STR_CD = '" + mi.getString("STR_CD")+"' AND BIN_NO = '" + mi.getString("BIN_NO")+"' AND APP_E_DT = '" + mi.getString("APP_E_DT")+"'");
                    Map map2 = selectMap(sql);            
                    cnt2 = (String)map2.get("CNT");   
                    sql.close();
                    
                    int i=1;
                    sql.put(svc.getQuery("INS_CARDBIN")); 
                    
                    sql.setString(i++, mi.getString("STR_CD"));
                    sql.setString(i++, mi.getString("BIN_NO")); 
                    sql.setString(i++, mi.getString("APP_S_DT")); 
                    sql.setString(i++, cnt2);       
                    sql.setString(i++, mi.getString("APP_E_DT"));      
                    sql.setString(i++, mi.getString("CCOMP_CD"));  
                    sql.setString(i++, mi.getString("USE_BAS_FR_AMT"));  
                    sql.setString(i++, mi.getString("USE_BAS_TO_AMT"));
                    sql.setString(i++, mi.getString("REDU_AMT"));
                    sql.setString(i++, userId);                           
                    sql.setString(i++, userId);                          
                    
                } else if(mi.IS_UPDATE()){// 수정

                    if(searchSaveChk(form, mi) > 1){
                       	return ret;
                    }
                    
                    int i=1;
                    sql.put(svc.getQuery("UPD_CARDBIN")); 
                    
                    sql.setString(i++, mi.getString("APP_S_DT"));       
                    sql.setString(i++, mi.getString("APP_E_DT"));   
                    sql.setString(i++, mi.getString("USE_BAS_FR_AMT"));  
                    sql.setString(i++, mi.getString("USE_BAS_TO_AMT"));  
                    sql.setString(i++, mi.getString("REDU_AMT"));  
                    sql.setString(i++, userId);                          
                    sql.setString(i++, mi.getString("STR_CD"));
                    sql.setString(i++, mi.getString("BIN_NO"));
                    sql.setString(i++, mi.getString("APP_S_DT"));
                    sql.setString(i++, mi.getString("SEQ_NO"));
                    
                } else if (mi.IS_DELETE()) {
                    int i=1;
                    sql.put(svc.getQuery("DTL_CARDBIN")); 
                    
                    sql.setString(i++, mi.getString("STR_CD"));
                    sql.setString(i++, mi.getString("BIN_NO"));
                    sql.setString(i++, mi.getString("APP_S_DT"));
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
     * <p>기간체크</p>
     * 
     */
    public int searchSaveChk(ActionForm form, MultiInput mi) throws Exception {
    	int ret 		= 0;
        SqlWrapper sql  = null;
        Service svc     = null;

        sql = new SqlWrapper();
        svc = (Service) form.getService();
        
        connect("pot");
        
    	int i=1;
   		sql.put(svc.getQuery("SAVE_YN"));
    	
    	sql.setString(i++, mi.getString("STR_CD"));
    	sql.setString(i++, mi.getString("BIN_NO"));
    	sql.setString(i++, mi.getString("APP_E_DT"));
    	sql.setString(i++, mi.getString("APP_S_DT"));
    	sql.setString(i++, mi.getString("USE_BAS_TO_AMT"));
    	sql.setString(i++, mi.getString("USE_BAS_FR_AMT"));
    	
        Map map = selectMap(sql);            
        ret = Integer.parseInt((String)map.get("CNT"));  
    	
        return ret;
    }    
}
