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

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>기부내역조회</p>
 * 
 * @created  on 1.0, 2010/03/22
 * @created  by 김영진
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DCtm302DAO extends AbstractDAO {

	/**
     * <p>기부내역조회</p>
     * 
     */
    public List searchMaster(ActionForm form) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        Util       util = new Util();
        int i = 1;
        
        String strCardNo = String2.nvl(form.getParam("strCardNo"));
        String strSsNo   = String2.nvl(form.getParam("strSsNo"));
        String strCustId = String2.nvl(form.getParam("strCustId"));
        String strUseFDt = String2.nvl(form.getParam("strUseFDt"));
        String strUseTDt = String2.nvl(form.getParam("strUseTDt"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");
        
        sql.put(svc.getQuery("SEL_MASTER"));

        sql.setString(i++, strUseFDt); 
        sql.setString(i++, strUseTDt); 
        sql.setString(i++, strCustId);
        sql.setString(i++, strCardNo);
        sql.setString(i++, strSsNo);

        ret = select2List(sql);
        return ret; 
    }

}

