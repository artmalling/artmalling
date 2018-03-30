/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package common.dao;

import java.net.URLDecoder;
import java.util.List;


import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;


/**
 * <p>도움말팝업 DAO</p>
 * 
 * @created  on 1.0, 2010/06/21
 * @created  by HSEON(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class CCom913DAO extends AbstractDAO {
    /**
     * <p>도움말을 조회한다.</p>
     * 
     */
	public List searchOnPop(ActionForm form) throws Exception {

		List	   	list 	= null;
        SqlWrapper	sql 	= null;
        Service 	svc 	= null;
        int 		i 		= 0;
        try {
        	String strPid = String2.nvl(form.getParam("strPid"));	// 시스템구분
        	
    		sql = new SqlWrapper();
    		svc = (Service) form.getService();
            
            sql.put(svc.getQuery("SEL_HELPMSG"));  

            sql.setString(++i, "jsp/selectClob.jsp?iSelId="+strPid+"&iTable=COM.TC_HELPMSG&iColumn=HELP_MSG&iSelColumn=PID");
            sql.setString(++i, "jsp/selectClob.jsp?iSelId="+strPid+"&iTable=COM.TC_HELPMSG&iColumn=HELP_MSG&iSelColumn=PID");
            sql.setString(++i, strPid);
            
    		connect("pot");	
            list = select2List(sql);
        } catch (Exception e) {
            throw e;
        }
        return list;
	}
}
