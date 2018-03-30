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

import javax.servlet.http.HttpServletRequest;

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
 * @created  on 1.0, 2010/03/29
 * @created  by 장형욱(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DCtm502DAO extends AbstractDAO {
	/**
     * <p>회원조회</p>
     * 
     */        
    public List searchList(ActionForm form, HttpServletRequest request) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        Util util = new Util();

        String strStrCd     	= String2.nvl(form.getParam("strStrCd"));
        String strFromDt     	= String2.nvl(form.getParam("strFromDt"));
        String strToDt     		= String2.nvl(form.getParam("strToDt"));

        String strSEX_CD        = String2.nvl(form.getParam("strSEX_CD"));

        String strPoint_from    = String2.nvl(form.getParam("strPoint_from"));
        String strPoint_to      = String2.nvl(form.getParam("strPoint_to"));
        String strAgeFrom    	= String2.nvl(form.getParam("strAgeFrom"));
        String strAgeTo      	= String2.nvl(form.getParam("strAgeTo"));

        String strSMs           = String2.nvl(form.getParam("strSMs"));
        String strDM           	= String2.nvl(form.getParam("strDM"));

        String strCndtnGbn		= String2.nvl(form.getParam("strCndtnGbn"));
        String strBrandCd		= String2.nvl(form.getParam("strBrandCd"));
        String strFloorCd		= String2.nvl(form.getParam("strFloorCd"));
        String strOrgCd			= String2.nvl(form.getParam("strOrgCd"));
        String strAddr			= String2.nvl(form.getParam("strAddr"));

        String strEntrFrDt     	= String2.nvl(form.getParam("strEntrFrDt"));
        String strEntrToDt     	= String2.nvl(form.getParam("strEntrToDt"));
        String strAmt_from    	= String2.nvl(form.getParam("strAmt_from"));
        String strAmt_to      	= String2.nvl(form.getParam("strAmt_to"));
        String strChkCond      	= String2.nvl(form.getParam("strChkCond"));

        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");
        
        sql.setString(i++, strEntrFrDt);
        sql.setString(i++, strEntrToDt);
        sql.setString(i++, strStrCd);
        sql.setString(i++, strFromDt);
        sql.setString(i++, strToDt);
        sql.setString(i++, strSEX_CD);
        sql.setInt(i++, Integer.parseInt(strAgeFrom));
        sql.setInt(i++, Integer.parseInt(strAgeTo));
        sql.setString(i++, strAddr);
        
        strQuery = svc.getQuery("SEL_MASTER") + "\n";
        
        if (strChkCond.equals("Y")) {
        
	        if (strCndtnGbn.equals("1")) {
	        	strQuery = strQuery + svc.getQuery("SEL_MASTER_PUMBUN") + "\n";
	        	sql.setString(i++, strBrandCd);
	        }
	        else if (strCndtnGbn.equals("2")) {
	        	strQuery = strQuery + svc.getQuery("SEL_MASTER_ORG") + "\n";
	        	sql.setString(i++, strOrgCd);
	        }
	        else if (strCndtnGbn.equals("3")) {
	        	strQuery = strQuery + svc.getQuery("SEL_MASTER_FLOOR") + "\n";
	        	sql.setString(i++, strFloorCd);
	        }
	        
        }

        if (strSMs.equals("Y"))
        	strQuery = strQuery + svc.getQuery("SEL_MASTER_SMS_DENY") + "\n";
        
        if (strDM.equals("Y"))
        	strQuery = strQuery + svc.getQuery("SEL_MASTER_DM_DENY") + "\n";
        
        sql.setInt(i++, Integer.parseInt(strAmt_from));
        sql.setInt(i++, Integer.parseInt(strAmt_to));
        sql.setInt(i++, Integer.parseInt(strPoint_from));
        sql.setInt(i++, Integer.parseInt(strPoint_to));
        
        strQuery = strQuery + svc.getQuery("SEL_MASTER_GRPORD");
        
        sql.put(strQuery);
        ret = select2List(sql);
        //ret = util.decryptedStr(ret, 2);       
        return ret;
    }
}

