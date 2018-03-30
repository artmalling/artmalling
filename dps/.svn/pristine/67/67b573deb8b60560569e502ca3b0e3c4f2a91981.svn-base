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
 * @created  on 1.1, 2010/05/19
 * @created  by 장형욱(FUJITSU KOREA LTD.)
 * @caused   by 클럽코드 관리
 *
 */

public class PSal904DAO extends AbstractDAO {

    /**
     * <p>클럽코드관리 조회</p>
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
        
        String strSBinNo      = String2.nvl(form.getParam("strSBinNo"));
        String strEBinNo      = String2.nvl(form.getParam("strEBinNo"));
        
        if ("".equals(strSBinNo))
        	strSBinNo = "000000";
        
        if ("".equals(strEBinNo))
        	strEBinNo = "999999";        
        
        String strDcardType   = String2.nvl(form.getParam("strDcardType"));
        String strCcomp       = String2.nvl(form.getParam("strCcomp"));
        
        sql.setString(i++, strSBinNo);
        sql.setString(i++, strEBinNo);
        sql.setString(i++, strCcomp);
        sql.setString(i++, strDcardType);

        connect("pot");
        
        strQuery = svc.getQuery("SEL_MASTER") + "\n";
         
        sql.put(strQuery);
        ret = select2List(sql);
               
        return ret;
    }
    
    /**
     * <p>가맹점 코드 상세 조회</p>
     * 
     */
    public List searchDetail(ActionForm form) throws Exception {
        List       ret      = null;
        SqlWrapper sql      = null;
        Service    svc      = null;
        String     strQuery = "";
        int i = 1;
        
        String strBinNo       = String2.nvl(form.getParam("strBinNo"));
        String strDcardType   = String2.nvl(form.getParam("strDcardType"));
        String strCcomp       = String2.nvl(form.getParam("strCcomp"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strBinNo);
        sql.setString(i++, strDcardType);
        
        strQuery = svc.getQuery("SEL_DETAIL"); // + "\n";
        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    }    
    
    /**
     * <p>클럽코드관리 등록/수정</p>
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
                if (mi.IS_INSERT()) { // 저장
                    sql.put("SELECT COUNT(*) AS CNT FROM DPS.PD_CARDBIN WHERE BIN_NO = '" + mi.getString("CCOMP_CD")+"' AND DCARD_TYPE = '" + mi.getString("DCARD_TYPE")+"'");
                    Map map = selectMap(sql);            
                    ccompCd = (String)map.get("CNT");   
                     
                    sql.close();
                    if(0 < Integer.parseInt(ccompCd)){
                    	return ret;
                    }                    
                    
                    int i=1;
                    sql.put(svc.getQuery("INS_CARDBIN")); 
                       
                    sql.setString(i++, mi.getString("BIN_NO")); 
                    sql.setString(i++, mi.getString("DCARD_TYPE")); 
                    sql.setString(i++, mi.getString("CCOMP_CD"));       
                    sql.setString(i++, mi.getString("CARD_NAME"));      
                    sql.setString(i++, mi.getString("VCARD_TYPE"));  
                    sql.setString(i++, mi.getString("APP_DT"));  
                    sql.setString(i++, mi.getString("DEL_YN"));                    
                    sql.setString(i++, userId);                           
                    sql.setString(i++, userId);
                    sql.setString(i++, mi.getString("REF_CODE1"));
                    
                } else if(mi.IS_UPDATE()){// 수정
                    int i=1;
                    sql.put(svc.getQuery("UPD_CARDBIN")); 
                    
                    sql.setString(i++, mi.getString("CCOMP_CD"));       
                    sql.setString(i++, mi.getString("CARD_NAME"));   
                    sql.setString(i++, mi.getString("DCARD_TYPE"));  
                    sql.setString(i++, mi.getString("VCARD_TYPE"));  
                    sql.setString(i++, mi.getString("APP_DT"));  
                    sql.setString(i++, mi.getString("DEL_YN"));
                    sql.setString(i++, mi.getString("REF_CODE1"));
                    sql.setString(i++, userId);                          
                    sql.setString(i++, mi.getString("BIN_NO"));  
                    sql.setString(i++, mi.getString("DCARD_TYPE"));
                    
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
