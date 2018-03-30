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

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>회원가입신청서이미지조회</p>
 * 
 * @created  on 1.0, 2010/04/05
 * @created  by 장형욱(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DCtm114DAO extends AbstractDAO {

    /**
     * <p>회원가입신청서이미지 조회</p>
     * 
     */    
    public List searchMaster(ActionForm form) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        Util util = new Util();
        int i = 1;
        
        String strCompFlag    = String2.nvl(form.getParam("strCompFlag"));
        String strCustId      = String2.nvl(form.getParam("strCustId"));
        String strCardNo      = String2.nvl(form.getParam("strCardNo"));
        String strSSNo        = String2.nvl(form.getParam("strSSNo"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();
        connect("pot");

        sql.setString(i++, strCardNo);
        sql.setString(i++, strCustId);
        sql.setString(i++, strSSNo);

        strQuery = svc.getQuery("SEL_MASTER"); // + "\n";
         
        if(strCompFlag.equals("C")){ 
        	strQuery += ("     AND A.COMP_PERS_FLAG <> 'P'                     \n");
  
        }else{
        	strQuery +=  ("     AND A.COMP_PERS_FLAG = ?                       \n");
            sql.setString(i++, strCompFlag);
        }
        
        sql.put(strQuery);
        ret = select2List(sql);
        
        //ret = util.decryptedStr(ret, 2);   
        
        return ret;
    }
}
