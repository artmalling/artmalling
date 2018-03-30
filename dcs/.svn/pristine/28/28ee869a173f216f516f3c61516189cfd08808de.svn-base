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
 * <p>포인트 양도 현황</p>
 * 
 * @created  on 1.0, 2010.03.23
 * @created  by jinjung.kim
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMbo610DAO extends AbstractDAO {

    public List searchMaster(ActionForm form) throws Exception {
        SqlWrapper sql  = null;
        Service    svc  = null;
        Util       util = new Util();
        String strQuery = "";
        
        
        String PROC_DT_FROM = String2.nvl(form.getParam("PROC_DT_FROM"));
        String PROC_DT_TO   = String2.nvl(form.getParam("PROC_DT_TO"));
         
        sql = new SqlWrapper();
        svc = (Service) form.getService(); 
 
        connect("pot");
        
        int i = 1;
        sql.setString(i++, PROC_DT_FROM); 
        sql.setString(i++, PROC_DT_TO); 

        strQuery = svc.getQuery("SEL_MASTER"); 
        sql.put(strQuery);   
        List ret = select2List(sql);  
        
      /*ret = util.decryptedStr(ret,3);    //MOBILE_PH1
        ret = util.decryptedStr(ret,4);    //MOBILE_PH2
        ret = util.decryptedStr(ret,5);    //MOBILE_PH3 */
        
        return ret; 
    }
}
