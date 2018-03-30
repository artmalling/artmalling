/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dbri.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>월단위 포인트 현황 조회</p>
 * 
 * @created  on 1.0, 2010/02/17
 * @created  by 김영진
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class DBri202DAO extends AbstractDAO {

    /**
     * <p>월단위 포인트 현황 조회</p>
     * 
     */
    public List searchMaster(ActionForm form) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        
        String strBrchId   = String2.nvl(form.getParam("strBrchId"));
        String strSumSMonth= String2.nvl(form.getParam("strSumSMonth"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strSumSMonth);
        sql.setString(i++, strBrchId);
        
        strQuery = svc.getQuery("SEL_MASTER");
        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    }
}
