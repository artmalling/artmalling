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
 * <p>재청구 데이터 조회</p>
 * 
 * @created  on 1.1, 2010/06/01
 * @created  by 장형욱(FUJITSU KOREA LTD.)
 * @caused   by 재청구 데이터 조회
 *
 */

public class PSal935DAO extends AbstractDAO {

    /**
     * <p>재청구 데이터 조회</p>
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
        
        String strStrCd      = String2.nvl(form.getParam("strStrCd"));
        String strSpayDt     = String2.nvl(form.getParam("strSpayDt"));
        String strEpayDt     = String2.nvl(form.getParam("strEpayDt"));
        String strVrtnCd     = String2.nvl(form.getParam("strVrtnCd"));
        String strCcompCd    = String2.nvl(form.getParam("strCcompCd"));
        String strBcomp      = String2.nvl(form.getParam("strBcomp"));
        String strJbrchId    = String2.nvl(form.getParam("strJbrchId"));
        String strCardNo     = String2.nvl(form.getParam("strCardNo"));        
        String strApprNo     = String2.nvl(form.getParam("strApprNo"));
        String strBuyReqYN   = String2.nvl(form.getParam("strBuyReqYN"));
        
        sql.setString(i++, strStrCd); 
        sql.setString(i++, strSpayDt);
        sql.setString(i++, strEpayDt);
        sql.setString(i++, strVrtnCd);
        sql.setString(i++, strCcompCd);
        sql.setString(i++, strBcomp);
        sql.setString(i++, strJbrchId);
        sql.setString(i++, strCardNo);      
        sql.setString(i++, strApprNo);    
        sql.setString(i++, strBuyReqYN);       
        
        connect("pot");
        
        strQuery = svc.getQuery("SEL_MASTER") + "\n";
         
        sql.put(strQuery);
        ret = select2List(sql);
               
        return ret;
    }
}
