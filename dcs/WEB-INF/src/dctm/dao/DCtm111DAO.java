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

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p> 회원탈퇴요청이력</p>
 * 
 * @created  on 1.0, 2010/03/21
 * @created  by 장형욱(FUJITSU KOREA LTD.)
 * 
 * @modified on  
 * @modified by 
 * @caused   by 
 */

public class DCtm111DAO extends AbstractDAO {

    /**
     * <p>회원탈퇴요청이력</p>
     * 
     */        
    public List searchMaster(ActionForm form, HttpServletRequest request) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        Util util = new Util();
        int i = 1; 
        
        String strSdt = String2.nvl(form.getParam("strSdt"))+ "000000";
        String strEdt = String2.nvl(form.getParam("strEdt"))+ "240000";
        String strCompFlag = String2.nvl(form.getParam("strCompFlag"));
        String strCardNo   = String2.nvl(form.getParam("strCardNo"));
        String strSSNo     = String2.nvl(form.getParam("strSSNo"));
        String strCustId   = String2.nvl(form.getParam("strCustId"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");
        
        strQuery = svc.getQuery("SEL_MASTER") + "\n";
        
        sql.setString(i++, strSdt);
        sql.setString(i++, strEdt);
        
        if (!String2.isEmpty(String2.trim((strCustId)))){
			strQuery += svc.getQuery("SEL_MASTER_CUST_ID") + "\n";
			sql.setString(i++, strCustId);
		}	
		
		if (!String2.isEmpty(String2.trim((strSSNo)))){
			strQuery += svc.getQuery("SEL_MASTER_SS_NO") + "\n";
			sql.setString(i++, strSSNo);
		}

		if (!String2.isEmpty(String2.trim((strCardNo)))){
			strQuery += svc.getQuery("SEL_MASTER_CARD_NO") + "\n";
			sql.setString(i++, strCardNo);
		}
		
		strQuery += svc.getQuery("SEL_MASTER_END") + "\n";

        if(strCompFlag.equals("C")){
        	strQuery += ("              AND B.COMP_PERS_FLAG <> 'P'                     \n");
			strQuery += ("            ORDER BY A.SCED_REQ_DT DESC, A.REG_DATE DESC      \n");
  
        }else{
        	strQuery +=  ("             AND B.COMP_PERS_FLAG = ?                         \n");
			strQuery +=  ("           ORDER BY A.SCED_REQ_DT DESC, A.REG_DATE DESC       \n");
            sql.setString(i++, strCompFlag);
        }
        
        sql.put(strQuery);
        
        ret = select2List(sql);
        //ret = util.decryptedStr(ret, 2);
        //ret = util.decryptedStr(ret, 3);
               
        return ret;
    }
}
