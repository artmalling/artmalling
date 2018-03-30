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

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>기부적립 조회</p>
 * 
 * @created  on 1.0, 2010/02/18
 * @created  by 장형욱(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMtc702DAO extends AbstractDAO {

    /**
     * <p>기부적립 조회</p>
     * 
     */    
    public List searchMaster(ActionForm form) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        
        String strSdt    = String2.nvl(form.getParam("strSdt"));
        String strEdt    = String2.nvl(form.getParam("strEdt"));       
        //String strDonNm  = String2.nvl(form.getParam("strDonNm"));
        String strDonId  = String2.nvl(form.getParam("strDonId"));
        String strStatus = String2.nvl(form.getParam("strStatus"));
        
        String toDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date()); 
             
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strEdt); 
        sql.setString(i++, strSdt);
        sql.setString(i++, strDonId);        
        //sql.setString(i++, strDonNm);
        
        strQuery = svc.getQuery("SEL_DC_DON_PLAN"); 
         
        if (!"".equals(strStatus)) {
            if ("0".equals(strStatus))    // 활성
                strQuery += "            AND A.E_DT >= " + toDate + "\n";
            else if ("1".equals(strStatus))    // 비활성
                strQuery += "            AND A.E_DT < "  + toDate + "\n";
        }        
        strQuery += "             GROUP BY A.DON_NAME, A.DON_ID, A.S_DT, A.E_DT \n";
        strQuery += "             ORDER BY A.DON_ID, A.S_DT   ";
                         
        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    }
    
    /**
     * <p>기부적립 상세조회</p>
     * 
     */
    public List searchDetail(ActionForm form) throws Exception {
        List       ret      = null;
        SqlWrapper sql      = null;
        Service    svc      = null;
        String     strQuery = "";
        Util util = new Util();
        int i = 1;
        
        String strDonId   = String2.nvl(form.getParam("strDonId"));

        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strDonId);
        
        strQuery = svc.getQuery("SEL_DETAIL"); // + "\n";
        sql.put(strQuery);
        ret = select2List(sql);
        
        //ret = util.decryptedStr(ret,2);        //주민등록번호 복호화.
        //ret = util.decryptedStr(ret,3);        //주민등록번호 복호화.
        //ret = util.decryptedStr(ret,4);        //주민등록번호 복호화.
        
        
        return ret;
    }        
}
