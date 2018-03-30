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
 * <p>회원 매출 순위 현황</p>
 * 
 * @created  on 1.0, 2010.05.30
 * @created  by 강진
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class DBri322DAO extends AbstractDAO {

    /**
     * <p>회원 매출 순위 현황</p>
     * 
     */
    public List searchMaster(ActionForm form) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        
        String strStrCd     = String2.nvl(form.getParam("strStrCd"));
        String strFromDt    = String2.nvl(form.getParam("strFromDt"));
        String strToDt      = String2.nvl(form.getParam("strToDt"));
        String strRank      = String2.nvl(form.getParam("strRank"));
        String str_from_amt = String2.nvl(form.getParam("str_from_amt"));  
        String str_to_amt   = String2.nvl(form.getParam("str_to_amt"));  
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();        
        
        connect("pot");
        
//        sql.setString(i++, strStrCd);
//        sql.setString(i++, strFromDt);
//        sql.setString(i++, strToDt);
//        sql.setString(i++, str_from_amt);
//        sql.setString(i++, str_to_amt);
//        sql.setString(i++, strRank);       

        sql.setString(i++, strStrCd);
        sql.setString(i++, strFromDt);
        sql.setString(i++, strToDt);
        sql.setString(i++, strStrCd);
        sql.setString(i++, strFromDt);
        sql.setString(i++, strToDt);
        sql.setString(i++, str_from_amt);
        sql.setString(i++, str_to_amt);
        sql.setString(i++, strRank);    
        
        strQuery = svc.getQuery("SEL_MASTER");
        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    }
}
