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
 * <p>카드발급사 코드관리</p>
 * 
 * @created  on 1.1, 2010/05/19
 * @created  by 장형욱(FUJITSU KOREA LTD.)
 * @caused   by 카드발급사 코드관리
 *
 */

public class PSal901DAO extends AbstractDAO {

    /**
     * <p>카드발급사 코드관리 조회</p>
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
        
        strQuery = svc.getQuery("SEL_MASTER") + "\n";
         
        sql.put(strQuery);
        ret = select2List(sql);
               
        return ret;
    }
    
    /**
     * <p>카드발급사 코드관리 상세 조회</p>
     * 
     */
    public List searchDetail(ActionForm form) throws Exception {
        List       ret      = null;
        SqlWrapper sql      = null;
        Service    svc      = null;
        String     strQuery = "";
        int i = 1;
        
        String strCcompCd   = String2.nvl(form.getParam("strCcompCd"));

        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strCcompCd);
        
        strQuery = svc.getQuery("SEL_DETAIL"); // + "\n";
        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    }    
    
    /**
     * <p>카드발급사 코드관리 등록/수정</p>
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
                    sql.put("SELECT COUNT(*) AS CNT FROM DPS.PD_CARDCOMP WHERE CCOMP_CD = '" + mi.getString("CCOMP_CD")+"'");
                    Map map = selectMap(sql);            
                    ccompCd = (String)map.get("CNT");   
                     
                    sql.close();
                    if(0 < Integer.parseInt(ccompCd)){
                    	return ret;
                    }                    
                    
                    int i=1;
                    sql.put(svc.getQuery("INS_CARDCOMP")); 
                       
                    sql.setString(i++, mi.getString("CCOMP_CD"));                        
                    sql.setString(i++, mi.getString("CCOMP_NM"));       
                    sql.setString(i++, mi.getString("BCOMP_CD"));      
                    sql.setString(i++, mi.getString("BCOMP_YN"));   
                    sql.setString(i++, userId);                           
                    sql.setString(i++, userId);                          
                    
                }else if(mi.IS_UPDATE()){// 수정
                    int i=1;
                    sql.put(svc.getQuery("UPD_CARDCOMP")); 
                    
                    sql.setString(i++, mi.getString("CCOMP_NM"));       
                    sql.setString(i++, mi.getString("BCOMP_CD"));      
                    sql.setString(i++, mi.getString("BCOMP_YN"));   
                    sql.setString(i++, userId);                          
                    sql.setString(i++, mi.getString("CCOMP_CD"));         
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
