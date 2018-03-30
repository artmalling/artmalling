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

public class DCtm501DAO extends AbstractDAO {
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
        String strCUST_GRADE    = String2.nvl(form.getParam("strCUST_GRADE"));
        String strSEX_CD        = String2.nvl(form.getParam("strSEX_CD"));

        String strPoint_from    = String2.nvl(form.getParam("strPoint_from"));
        String strPoint_to      = String2.nvl(form.getParam("strPoint_to"));
        
        String strSMs           = String2.nvl(form.getParam("strSMs"));
        String strDM           = String2.nvl(form.getParam("strDM"));
        String strBIR_MONTH_S   = String2.nvl(form.getParam("strBIR_MONTH_S"));
        String strHOME_ADDR     = String2.nvl(form.getParam("strHOME_ADDR"));
        
                
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strStrCd);
        sql.setString(i++, strFromDt);
        sql.setString(i++, strToDt);
        sql.setString(i++, strCUST_GRADE);
        sql.setString(i++, strSEX_CD);
        sql.setString(i++, strPoint_from);
        sql.setString(i++, strPoint_to);
        sql.setString(i++, strSMs);
        sql.setString(i++, strBIR_MONTH_S);
        sql.setString(i++, strHOME_ADDR);
        sql.setString(i++, strHOME_ADDR);
        sql.setString(i++, strDM);
        
        strQuery = svc.getQuery("SEL_MASTER") + "\n"; 
        sql.put(strQuery);
        ret = select2List(sql);
        //ret = util.decryptedStr(ret, 2);       
        return ret;
    }
}

