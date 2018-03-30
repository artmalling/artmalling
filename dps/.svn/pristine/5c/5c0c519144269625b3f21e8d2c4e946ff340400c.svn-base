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
 * <p>브랜드별수수료조회</p>
 * 
 * @created  on 1.1, 2010/06/02
 * @created  by 장형욱(FUJITSU KOREA LTD.)
 * @caused   by 브랜드별수수료조회(기간)
 *
 */

public class PSal943DAO extends AbstractDAO {

    /**
     * <p>브랜드별수수료조회 </p>
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
        
        String strStrCd  = String2.nvl(form.getParam("strStrCd"));
        String strSDt    = String2.nvl(form.getParam("strSDt"));
        String strEDt    = String2.nvl(form.getParam("strEDt"));
        
        connect("pot");
        
        sql.setString(i++, strStrCd);
        sql.setString(i++, strSDt);
        sql.setString(i++, strEDt);
        
        sql.setString(i++, strStrCd);
        sql.setString(i++, strSDt);
        sql.setString(i++, strEDt);
        
        sql.setString(i++, strStrCd);
        sql.setString(i++, strSDt);
        sql.setString(i++, strEDt);
        
        sql.setString(i++, strStrCd);
        sql.setString(i++, strSDt);
        sql.setString(i++, strEDt);
        
        sql.setString(i++, strStrCd);
        sql.setString(i++, strSDt);
        sql.setString(i++, strEDt);
        
        sql.setString(i++, strStrCd);
        sql.setString(i++, strSDt);
        sql.setString(i++, strEDt);
        
        sql.setString(i++, strStrCd);
        sql.setString(i++, strSDt);
        sql.setString(i++, strEDt);
        
        sql.setString(i++, strStrCd);
        sql.setString(i++, strSDt);
        sql.setString(i++, strEDt);  
        
        sql.setString(i++, strStrCd);
        sql.setString(i++, strSDt);
        sql.setString(i++, strEDt);   
        
        sql.setString(i++, strStrCd);
        sql.setString(i++, strSDt);
        sql.setString(i++, strEDt);        

        sql.setString(i++, strStrCd);
        sql.setString(i++, strSDt);
        sql.setString(i++, strEDt);
        
        sql.setString(i++, strStrCd);
        sql.setString(i++, strSDt);
        sql.setString(i++, strEDt);
        
        sql.setString(i++, strStrCd);
        sql.setString(i++, strSDt);
        sql.setString(i++, strEDt);
        
        sql.setString(i++, strStrCd);
        sql.setString(i++, strSDt);
        sql.setString(i++, strEDt);
        
        sql.setString(i++, strStrCd);
        sql.setString(i++, strSDt);
        sql.setString(i++, strEDt);  
        
        sql.setString(i++, strStrCd);
        sql.setString(i++, strSDt);
        sql.setString(i++, strEDt);   
        
        sql.setString(i++, strStrCd);
        sql.setString(i++, strSDt);
        sql.setString(i++, strEDt);         

        strQuery = svc.getQuery("SEL_MASTER") + "\n";
         
        sql.put(strQuery);
        ret = select2List(sql);
               
        return ret;
    }
}
