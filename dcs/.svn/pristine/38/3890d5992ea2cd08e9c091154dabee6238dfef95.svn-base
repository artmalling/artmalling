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
 * <p>지역별 회원 매출 현황(월)</p>
 * 
 * @created  on 1.0, 2010.05.30
 * @created  by 강진
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class DBri312DAO extends AbstractDAO {

    /**
     * <p>지역별 회원 매출 현황(월)</p>
     * 
     */
    public List searchMaster(ActionForm form) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        
        String strFromBSDate   = String2.nvl(form.getParam("strFromBSDate"));
        String strToBSDate= String2.nvl(form.getParam("strToBSDate"));
        String strFromCSDate   = String2.nvl(form.getParam("strFromCSDate"));
        String strToCSDate= String2.nvl(form.getParam("strToCSDate"));  
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strFromBSDate);
        sql.setString(i++, strToBSDate);
        sql.setString(i++, strFromBSDate);
        sql.setString(i++, strToBSDate);
        sql.setString(i++, strFromCSDate);
        sql.setString(i++, strToCSDate);
        sql.setString(i++, strFromCSDate);
        sql.setString(i++, strToCSDate);         
        
        strQuery = svc.getQuery("SEL_MASTER");
        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    }
}
