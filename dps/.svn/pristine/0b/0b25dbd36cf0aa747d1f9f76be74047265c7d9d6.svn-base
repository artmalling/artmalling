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
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>VAN사 승인내역 조회</p>
 * 
 * @created  on 1.1, 2010/06/02
 * @created  by 장형욱(FUJITSU KOREA LTD.)
 * @caused   by VAN사 승인내역 조회
 *
 */

public class PSal954DAO extends AbstractDAO {

    /**
     * <p>VAN사 승인내역 조회 </p>
     * 
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
        String strSapprDt  = String2.nvl(form.getParam("strSapprDt"));
        String strEapprDt  = String2.nvl(form.getParam("strEapprDt"));
        String strBcomp    = String2.nvl(form.getParam("strBcomp"));
        String strJbrchId  = String2.nvl(form.getParam("strJbrchId"));
        String strApprNo   = String2.nvl(form.getParam("strApprNo"));   
        String strVanGubun = String2.nvl(form.getParam("strVanGubun"));   
        
        strQuery = svc.getQuery("SEL_MASTER") + "\n";
        
        sql.setString(i++, strStrCd);
        sql.setString(i++, strSapprDt);
        sql.setString(i++, strEapprDt);
        sql.setString(i++, strBcomp);
        sql.setString(i++, strJbrchId);
        sql.setString(i++, strApprNo);
        sql.setString(i++, strVanGubun);
        
        strQuery += "                       ) X                                                      \n";
        strQuery += "                  GROUP BY X.APPR_DT, X.BCOMP_CD, X.JBRCH_ID, X.PAY_TYPE        \n";
        strQuery += "                  ORDER BY X.APPR_DT, X.BCOMP_CD, X.JBRCH_ID, X.PAY_TYPE        \n";
         
        sql.put(strQuery);
        ret = select2List(sql);
               
        return ret;
    }
    
    /**
     * <p>VAN사 승인내역  상세 조회</p>
     * 
     */
    public List searchDetail(ActionForm form) throws Exception {
        List       ret      = null;
        SqlWrapper sql      = null;
        Service    svc      = null;
        String     strQuery = "";
        int i = 1;
        
        String strApprDt   = String2.nvl(form.getParam("strApprDt"));
        String strStrCd    = String2.nvl(form.getParam("strStrCd"));
        String strApprNo   = String2.nvl(form.getParam("strApprNo"));
        String strBcompCd  = String2.nvl(form.getParam("strBcompCd"));
        String strJbrchId  = String2.nvl(form.getParam("strJbrchId"));
        String strVanGubun = String2.nvl(form.getParam("strVanGubun"));   
        String strPayType  = String2.nvl(form.getParam("strPayType"));   

        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strStrCd);
        sql.setString(i++, strApprDt);
        sql.setString(i++, strApprNo);
        sql.setString(i++, strBcompCd);
        sql.setString(i++, strJbrchId);
        sql.setString(i++, strVanGubun);    
        sql.setString(i++, strPayType);     

        strQuery = svc.getQuery("SEL_DETAIL") + "\n";
                
        strQuery += "                       ) X                                                         \n";
        strQuery += "                  ORDER BY X.RECP_NO                                               \n";

        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    }        
}
