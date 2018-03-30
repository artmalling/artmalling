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
 * <p>청구대비입금액조회</p>
 * 
 * @created  on 1.1, 2010/06/01
 * @created  by 장형욱(FUJITSU KOREA LTD.)   
 * @caused   by 청구대비입금액조회 
 *
 */
 
public class PSal937DAO extends AbstractDAO {

    /**
     * <p>청구대비입금액조회 </p>
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
        String strSchrgDt    = String2.nvl(form.getParam("strSchrgDt"));
        String strEchrgDt    = String2.nvl(form.getParam("strEchrgDt"));
        String strBcomp      = String2.nvl(form.getParam("strBcomp"));
        String strJbrchId    = String2.nvl(form.getParam("strJbrchId"));
        
        sql.setString(i++, strStrCd); 
        sql.setString(i++, strSchrgDt); 
        sql.setString(i++, strEchrgDt);  
        sql.setString(i++, strBcomp); 
        sql.setString(i++, strJbrchId);

        connect("pot");
        
        strQuery = svc.getQuery("SEL_MASTER");
         
        sql.put(strQuery);
        ret = select2List(sql);
               
        return ret;
    }
}
