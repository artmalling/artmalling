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

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;

/**
 * <p>포인트 승인테스트</p>
 * 
 * @created  on 1.0, 2010/04/06
 * @created  by jinjung.kim
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMbo615DAO extends AbstractDAO {
    
    
    public List searchMaster(ActionForm form) throws Exception {

        SqlWrapper sql  = null;
        Service    svc  = null;
        String strQuery = "";

        sql = new SqlWrapper();
        svc = (Service) form.getService(); 
 
        connect("pot");
        
        strQuery = svc.getQuery(form.getParam("sqlId")); 
        sql.put(strQuery);
        
        return select2List(sql); 
    }
}
