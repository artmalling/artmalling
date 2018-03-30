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

import javax.servlet.http.HttpServletRequest;

import common.util.Util;
//import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
import sun.nio.cs.ext.DoubleByteEncoder;
/**
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2010/03/29
 * @created  by 장형욱(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DCtm504DAO extends AbstractDAO {
	/**
     * <p>회원조회</p>
     * 
     */        
    public List searchList(ActionForm form, HttpServletRequest request) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        
        Util util = new Util();

       
        String strFromDt     	= String2.nvl(form.getParam("strFromDt"));
        String strChkGrp     	= String2.nvl(form.getParam("strChkGrp"));
        //int nFromDt 			= Integer.parseInt(strFromDt);
     
      
                
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

     
        //sql.setInt(i++, nFromDt);
     
        if ("T".equals(strChkGrp)) {
        	strQuery = svc.getQuery("SEL_MASTER_GRP") + "\n";
            
            sql.put(strQuery);
        }
        
        strQuery = svc.getQuery("SEL_MASTER") + "\n";
        
        sql.put(strQuery);
        
        sql.put(" FROM EM_LOG_"+strFromDt +"@SMS_ART A"  + "\n");
        
        strQuery = svc.getQuery("SEL_MASTER2") + "\n";

        sql.put(strQuery);
        
        if ("T".equals(strChkGrp)) {
        	strQuery = svc.getQuery("SEL_MASTER_GRP2") + "\n";
            
            sql.put(strQuery);	
        }
        
        ret = select2List(sql);
        //ret = util.decryptedStr(ret, 2);       
        return ret;
    }
}

