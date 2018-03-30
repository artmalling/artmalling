/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dmtc.dao;

import java.util.List;

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
 * @created  on 1.0, 2010/02/25
 * @created  by 장형욱(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMtc704DAO extends AbstractDAO {

    /**
     * <p>기부적립금기부공지 조회 조회</p>
     * 
     * @created  on 1.0, 2010/03/02
     * @created  by 장형욱
     * 
     * @modified on 
     * @modified by 
     * @caused   by 
     */   	
    public List searchMaster(ActionForm form) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        
        String strSdt       = String2.nvl(form.getParam("strSdt"));
        String strEdt       = String2.nvl(form.getParam("strEdt"));
        String strDonNm     = String2.nvl(form.getParam("strDonNm"));
        String strDonId     = String2.nvl(form.getParam("strDonId"));
        String strStatus    = String2.nvl(form.getParam("strStatus"));
        
        String toDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date()); 
             
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strSdt);
        sql.setString(i++, strEdt); 
        sql.setString(i++, strDonId);        

        
        strQuery = svc.getQuery("SEL_DC_DON_TARGET"); // + "\n";
         
        if (!"".equals(strStatus)) {
            if ("0".equals(strStatus))    // 활성
                strQuery += " AND A.E_DT >= " + toDate ;
            else if ("1".equals(strStatus))    // 비활성
                strQuery += " AND A.E_DT < " + toDate ;
        }        
        strQuery += " ORDER BY A.DON_ID";
        sql.put(strQuery);
        ret = select2List(sql);
        
        return ret;
    }    
    
    /**
     * <p>기부적립금기부공지 상세 조회</p>
     * 
     * @created  on 1.0, 2010/03/02
     * @created  by 장형욱
     * 
     * @modified on 
     * @modified by 
     * @caused   by 
     */    
    public List searchDetail(ActionForm form) throws Exception {
        List       ret      = null;
        SqlWrapper sql      = null;
        Service    svc      = null;
        String     strQuery = "";
        int i = 1;
        
        String strDonId   = String2.nvl(form.getParam("strDonId"));
        String strDonDt   = String2.nvl(form.getParam("strDonDt"));

        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strDonId);
        sql.setString(i++, strDonDt);
        
        strQuery = svc.getQuery("SEL_DETAIL");  
        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    }      
    
    /**
     * <p>기부적립금기부공지 수정</p>
     * 
     * @created  on 1.0, 2010/03/02
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
        Util util      = new Util();

        try {
        	
            connect("pot");
            begin();
            sql = new SqlWrapper();
            svc = (Service) form.getService();
            sql.close();
            while (mi.next()) {
               if(mi.IS_UPDATE()){// 수정
                    int i=1;
                    sql.put(svc.getQuery("UPD_DC_DON_TARGET")); 
                    
                    sql.setString(i++, mi.getString("PORTAL_NOTE"));     //공지
                    sql.setString(i++, userId);                          //수정자ID
                    sql.setString(i++, mi.getString("DON_ID"));          //기부ID
                    sql.setString(i++, mi.getString("DON_DT"));            //메모
                }
                                
                res = update(sql);
                if (res != 1) {
                    throw new Exception("" + "데이터의 적합성 문제로 인하여"
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
