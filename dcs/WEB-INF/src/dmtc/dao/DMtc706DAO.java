/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dmtc.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>기부세금공제대상조회</p>
 * 
 * @created  on 1.0, 2010/06/17
 * @created  by 김영진(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMtc706DAO extends AbstractDAO {

    /**
     * <p>기부세금공제대상조회</p>
     * 
     */    
    public List searchMaster(ActionForm form) throws Exception {
    	
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null; 
        int i = 1;

        String strDonSDt   = String2.nvl(form.getParam("strDonSDt"));
        String strDonEDt   = String2.nvl(form.getParam("strDonEDt"));
        String strDonId    = String2.nvl(form.getParam("strDonId"));
        String strDonPoint = String2.nvl(form.getParam("strDonPoint"));

        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");
        sql.setString(i++, strDonSDt);
        sql.setString(i++, strDonEDt);
        sql.setString(i++, strDonId); 
        sql.setInt(i++, Integer.parseInt(strDonPoint));        
        sql.put(svc.getQuery("SEL_DON_PLAN"));
        ret = select2List(sql);
        return ret;
    }
}
