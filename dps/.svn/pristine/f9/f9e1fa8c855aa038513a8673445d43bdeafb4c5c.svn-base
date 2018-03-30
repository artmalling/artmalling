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
 * <p>입금현황조회</p>
 * 
 * @created  on 1.1, 2010/06/01
 * @created  by 장형욱(FUJITSU KOREA LTD.)   
 * @caused   by 입금현황조회 
 *
 */
 
public class PSal938DAO extends AbstractDAO {

    /**
     * <p>입금현황 마스터 조회 </p>
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
        String strInOut      = String2.nvl(form.getParam("strInOut"));
        String strSDt        = String2.nvl(form.getParam("strSDt"));
        String strEDt        = String2.nvl(form.getParam("strEDt"));
        String strBcomp      = String2.nvl(form.getParam("strBcomp"));
        String strJbrchId    = String2.nvl(form.getParam("strJbrchId"));
        
        sql.setString(i++, strStrCd); 

        connect("pot");
        
        strQuery = svc.getQuery("SEL_MASTER") + "\n";
        
        if(strInOut.equals("1")){
        	strQuery += svc.getQuery("SEL_MASTER_WHERE_PEXPT_DT") + "\n";
        	sql.setString(i++, strSDt); 
            sql.setString(i++, strEDt);
        }else if(strInOut.equals("2")){
        	strQuery += svc.getQuery("SEL_MASTER_WHERE_SEND_DT") + "\n";
        	sql.setString(i++, strSDt); 
            sql.setString(i++, strEDt);
        }else if(strInOut.equals("3")){
        	strQuery += svc.getQuery("SEL_MASTER_WHERE_PAY_DT") + "\n";
        	sql.setString(i++, strSDt); 
            sql.setString(i++, strEDt);
        }
        
        if(!strBcomp.equals("%")){
        	strQuery += svc.getQuery("SEL_MASTER_WHERE_BCOMP_CD") + "\n";
        	sql.setString(i++, strBcomp); 
        }
        
        if(!strJbrchId.equals("")){
        	strQuery += svc.getQuery("SEL_MASTER_WHERE_JBRCH_ID") + "\n";
        	sql.setString(i++, strJbrchId);
        }
         
        sql.put(strQuery);
        ret = select2List(sql);
               
        return ret;
    }
    
    /**
     * <p>입금현황 디테일 조회 </p>
     * 
     */        
    public List searchDetail(ActionForm form, HttpServletRequest request) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null; 
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        
        sql = new SqlWrapper();   
        svc = (Service) form.getService();
        
        String strPayDt      = String2.nvl(form.getParam("strPayDt"));
        String strPexptDt    = String2.nvl(form.getParam("strPexptDt"));
        String strChrgDt     = String2.nvl(form.getParam("strChrgDt"));
        String strJbrchId    = String2.nvl(form.getParam("strJbrchId"));
        
        sql.setString(i++, strPayDt);
        sql.setString(i++, strPexptDt);
        sql.setString(i++, strChrgDt);
        sql.setString(i++, strJbrchId);
        
        strQuery = svc.getQuery("SEL_DETAIL");
        
        connect("pot");
         
        sql.put(strQuery);
        ret = select2List(sql);
               
        return ret;
    }
}
