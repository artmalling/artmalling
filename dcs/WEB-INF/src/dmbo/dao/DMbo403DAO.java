/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dmbo.dao;

import java.util.List;

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>전자쿠폰사용조회</p>
 * 
 * @created  on 1.0, 2010/03/21
 * @created  by 김영진
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMbo403DAO extends AbstractDAO {

	/**
     * <p>전자쿠폰사용조회 - 상단</p> 
     * 
     */
    public List searchMaster(ActionForm form) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        Util       util = new Util();
        String strQuery = "";
        int i = 1;

        String strBrchId  = String2.nvl(form.getParam("strBrchId"));
        String strCardNo  = String2.nvl(form.getParam("strCardNo"));
        String strSsNo    = String2.nvl(form.getParam("strSsNo"));
        String strCustId  = String2.nvl(form.getParam("strCustId"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");
        
        strQuery = svc.getQuery("SEL_MASTER") + "\n";
        //sql.setString(i++, strAppYM);                               		 
        //sql.setString(i++, strBrchId); 
        
        if (!String2.isEmpty(String2.trim((strCustId)))){
			strQuery += svc.getQuery("SEL_MASTER_CUST_ID") + "\n";
			sql.setString(i++, strCustId);
		}	
		
		if (!String2.isEmpty(String2.trim((strSsNo)))){
			strQuery += svc.getQuery("SEL_MASTER_SS_NO") + "\n";
			sql.setString(i++, strSsNo);
		}

		if (!String2.isEmpty(String2.trim((strCardNo)))){
			strQuery += svc.getQuery("SEL_MASTER_CARD_NO") + "\n";
			sql.setString(i++, strCardNo);
		}
		
		strQuery += svc.getQuery("SEL_MASTER_GROUP");
		
		sql.put(strQuery);

        ret = select2List(sql);
        //ret = util.decryptedStr(ret,2);     //주민등록번호 복호화.
        return ret; 
    }
    
    /**
     * <p>전자쿠폰사용조회 - 하단</p>
     * 
     */
    public List searchDetail(ActionForm form) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        Util       util = new Util();
        int i = 1;
        
        String strStrCd   = String2.nvl(form.getParam("strStrCd"));
        String strCustId  = String2.nvl(form.getParam("strCustId"));

        sql = new SqlWrapper(); 
        svc = (Service) form.getService();

        connect("pot"); 
        
        sql.put(svc.getQuery("SEL_DETAIL"));
        
        //sql.setString(i++, strAppYM);                               		 
        sql.setString(i++, strStrCd); 
        sql.setString(i++, strCustId);

        ret = select2List(sql);
        //ret = util.decryptedStr(ret,2);     //주민등록번호 복호화.
        return ret; 
    }
}

