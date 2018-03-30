/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dacc.dao;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>제휴카드사포인트 검증</p>
 * 
 * @created  on 1.0, 2010/05/24
 * @created  by 김영진(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DAcc103DAO extends AbstractDAO {
	
	/**
     * <p>제휴카드사포인트 검증</p>
     * 
     */        
    public List searchList(ActionForm form, HttpServletRequest request) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        
        String strSdt       = String2.nvl(form.getParam("strSdt"));
        String strEdt       = String2.nvl(form.getParam("strEdt"));
        String strStrCd     = String2.nvl(form.getParam("strStrCd"));
        String strCardCd    = String2.nvl(form.getParam("strCardCd"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strSdt);
        sql.setString(i++, strEdt);
        sql.setString(i++, strStrCd);
        sql.setString(i++, strCardCd);
        sql.setString(i++, strSdt);
        sql.setString(i++, strEdt);
        sql.setString(i++, strStrCd);
        sql.setString(i++, strCardCd);
        sql.setString(i++, strSdt);
        sql.setString(i++, strEdt);
        sql.setString(i++, strStrCd);
        sql.setString(i++, strCardCd);
        
        strQuery = svc.getQuery("SEL_MASTER") + "\n";
        sql.put(strQuery);
        ret = select2List(sql);
               
        return ret;
    }
    
	/**
     * <p>차이내역</p>
     * 
     */        
    public List searchGapList(ActionForm form, HttpServletRequest request) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        
        String strSaleDt    = String2.nvl(form.getParam("strSaleDt"));
        String strStrCd     = String2.nvl(form.getParam("strStrCd"));
        String strPayDtl    = String2.nvl(form.getParam("strPayDtl"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strSaleDt);
        sql.setString(i++, strStrCd);
        sql.setString(i++, strPayDtl);
        
        strQuery = svc.getQuery("SEL_GAP") + "\n";
        sql.put(strQuery);
        ret = select2List(sql);
               
        return ret;
    }
}
