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
 * <p>포인트승인내역조회</p>
 * 
 * @created  on 1.0, 2010/03/23
 * @created  by 김영진
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMbo612DAO extends AbstractDAO {
	
	/**
     * <p>포인트승인내역조회</p>
     * 
     */
    public List searchMaster(ActionForm form) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        Util       util = new Util();
        String strQuery = "";
        int i = 1;
        
        String strSaleFDt = String2.nvl(form.getParam("strSaleFDt"));
        String strSaleTDt = String2.nvl(form.getParam("strSaleTDt"));
        String strCardNo  = String2.nvl(form.getParam("strCardNo"));
        String strBrchId  = String2.nvl(form.getParam("strBrchId"));

        sql = new SqlWrapper();
        svc = (Service) form.getService();
 
        connect("pot"); 
	 
        strQuery = svc.getQuery("SEL_MASTER") + "\n";
        
        sql.setString(i++, strSaleFDt); 
        sql.setString(i++, strSaleTDt);
        
        if (!String2.isEmpty(String2.trim((strCardNo)))){
			strQuery += svc.getQuery("SEL_MASTER_CARD_NO") + "\n";
			sql.setString(i++, strCardNo);
		}	
		
		if (!String2.isEmpty(String2.trim((strBrchId)))){
			strQuery += svc.getQuery("SEL_MASTER_BRCH_ID") + "\n";
			sql.setString(i++, strBrchId);
		}
		

		strQuery += svc.getQuery("SEL_ORDERBY") + "\n";
     
		sql.put(strQuery);
		
        ret = select2List(sql);
        //ret = util.decryptedStr(ret,2);     //카드번호 복호화.
        return ret; 
    }
}

