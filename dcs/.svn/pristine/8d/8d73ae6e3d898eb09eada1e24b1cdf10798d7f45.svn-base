/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dctm.dao;

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

public class DCtm131DAO extends AbstractDAO {

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
        
        String strClubId   = String2.nvl(form.getParam("strClubId"));

        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strClubId);
        
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
        String clubId  = null;
        Util util      = new Util();
      
        try {
        	
            connect("pot");
            begin();
            sql = new SqlWrapper();
            svc = (Service) form.getService();
            sql.close();
            
            while (mi.next()) {
                if (mi.IS_INSERT()) { // 저장
                    sql.put("SELECT COUNT(*) AS CNT FROM DCS.DM_CLUB WHERE CLUB_ID = '" + mi.getString("CLUB_ID")+"'");
                    Map map = selectMap(sql);            
                    clubId = (String)map.get("CNT");   
                    
                    sql.close();
                    if(0 < Integer.parseInt(clubId)){
                    	return ret;
                    }                    
                    
                    int i=1;
                    sql.put(svc.getQuery("INS_CLUB")); 
                       
                    sql.setString(i++, mi.getString("CLUB_ID"));                          //클럽ID
                    sql.setString(i++, mi.getString("CLUB_NAME"));       //클럽명
                    sql.setString(i++, mi.getString("CLUB_INFO"));       //클럽설명
                    sql.setString(i++, userId);                          //등록자ID
                    sql.setString(i++, userId);                          //등록자ID
                    
                }else if(mi.IS_UPDATE()){// 수정
                    int i=1;
                    sql.put(svc.getQuery("UPD_CLUB")); 
                    
                    sql.setString(i++, mi.getString("CLUB_NAME"));       //클럽명
                    sql.setString(i++, mi.getString("CLUB_INFO"));       //클럽설명
                    sql.setString(i++, userId);                          //수정자ID
                    sql.setString(i++, mi.getString("CLUB_ID"));         //기부ID
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
