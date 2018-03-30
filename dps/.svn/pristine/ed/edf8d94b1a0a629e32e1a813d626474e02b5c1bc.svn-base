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
 * <p>청구제외조회</p>
 * 
 * @created  on 1.1, 2010/05/25
 * @created  by 김영진(FUJITSU KOREA LTD.)
 * @caused   by 청구제외조회
 *
 */
public class PSal912DAO extends AbstractDAO {

    /**
     * <p>청구제외 조회</p>
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

        String strRegDtS    = String2.nvl(form.getParam("strRegDtS"));
        String strRegDtE    = String2.nvl(form.getParam("strRegDtE"));
        String strDueDtS    = String2.nvl(form.getParam("strDueDtS"));
        String strDueDtE    = String2.nvl(form.getParam("strDueDtE"));
        String strCondStrCd = String2.nvl(form.getParam("strCondStrCd"));
        String strBcompCd   = String2.nvl(form.getParam("strBcompCd"));  
        String strChrgYn    = String2.nvl(form.getParam("strChrgYn"));	
        
        strQuery = svc.getQuery("SEL_MASTER");
        
        sql.setString(i++, strCondStrCd);
        sql.setString(i++, strRegDtS);
        sql.setString(i++, strRegDtE);
        sql.setString(i++, strDueDtS);
        sql.setString(i++, strDueDtE);
        sql.setString(i++, strChrgYn);
        
        if(!strBcompCd.equals("%")){
			strQuery += svc.getQuery("SEL_MASTER_WHERE_BCOMP_CD") + "\n";
			sql.setString(i++, strBcompCd);
		}
        
        strQuery += svc.getQuery("SEL_MASTER_GROUP") + "\n";
         
        sql.put(strQuery);
        ret = select2List(sql);
               
        return ret;
    }
     
    /**
     * <p>청구제외 상세 조회</p>
     * 
     */
    public List searchDetail(ActionForm form) throws Exception {
        List       ret      = null;
        SqlWrapper sql      = null;
        Service    svc      = null;
        String     strQuery = "";
        int i = 1;
        
        String strRegDt     = String2.nvl(form.getParam("strRegDt"));
        String strDueDt     = String2.nvl(form.getParam("strDueDt"));
        String strCondStrCd = String2.nvl(form.getParam("strCondStrCd"));
        String strBcompCd   = String2.nvl(form.getParam("strBcompCd"));

        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strCondStrCd);
        sql.setString(i++, strRegDt);
        sql.setString(i++, strDueDt);
        sql.setString(i++, strBcompCd);
        
        strQuery = svc.getQuery("SEL_DETAIL");
        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    }    
}
