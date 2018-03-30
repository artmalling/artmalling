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
 * <p>포인트조회</p>
 * 
 * @created  on 1.0, 2010/03/22
 * @created  by 김영진
 * 
 * @modified on 
 * @modified by 
 * @caused   by  
 */
public class DCtm304DAO extends AbstractDAO {
	
	/**
     * <p>포인트조회</p>
     * 
     */
    public List searchMaster(ActionForm form) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        Util       util = new Util();
        String strQuery = "";
        int i = 1;
        
        String strCardNo = String2.nvl(form.getParam("strCardNo"));
        String strSsNo   = String2.nvl(form.getParam("strSsNo"));
        String strCustId = String2.nvl(form.getParam("strCustId"));
        String strUseFDt = String2.nvl(form.getParam("strUseFDt"));
        String strUseTDt = String2.nvl(form.getParam("strUseTDt"));
        String strCompPersFlag = String2.nvl(form.getParam("strCompPersFlag"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        if(strCompPersFlag.equals("C")){                        //법인회원
            strQuery = svc.getQuery("SEL_MASTER_COMP") + "\n"; 
            strCompPersFlag = "P";
        }else{
            strQuery = svc.getQuery("SEL_MASTER_PERS") + "\n";  //개인회원
        }
        
        sql.setString(i++, strUseFDt); 
        sql.setString(i++, strUseTDt);
        sql.setString(i++, strCompPersFlag); 
        
        if (!String2.isEmpty(String2.trim((strCustId)))){
			strQuery += svc.getQuery("SEL_MASTER_PERS_CUST_ID") + "\n";
			sql.setString(i++, strCustId);
		}	
        
		if (!String2.isEmpty(String2.trim((strSsNo)))){
			strQuery += svc.getQuery("SEL_MASTER_PERS_SS_NO") + "\n";
			sql.setString(i++, strSsNo);
		}
		
		if (!String2.isEmpty(String2.trim((strCardNo)))){
			strQuery += svc.getQuery("SEL_MASTER_PERS_CARD_NO") + "\n";
			sql.setString(i++, strCardNo);
		}
		
		strQuery += svc.getQuery("SEL_MASTER_PERS_END") + "\n";
		
		//UNION ALL
        
		if(strCompPersFlag.equals("C")){  
            strQuery += svc.getQuery("SEL_MASTER_COMP_UNION") + "\n"; //법인회원
        }else{
            strQuery += svc.getQuery("SEL_MASTER_PERS_UNION") + "\n"; //개인회원
        }
		
		sql.setString(i++, strUseFDt); 
        sql.setString(i++, strUseTDt); 
        sql.setString(i++, strCompPersFlag);
		
		if (!String2.isEmpty(String2.trim((strCustId)))){
			strQuery += svc.getQuery("SEL_MASTER_PERS_CUST_ID") + "\n";
			sql.setString(i++, strCustId);
		}	
		
		if (!String2.isEmpty(String2.trim((strSsNo)))){
			strQuery += svc.getQuery("SEL_MASTER_PERS_SS_NO") + "\n";
			sql.setString(i++, strSsNo);
		}

		if (!String2.isEmpty(String2.trim((strCardNo)))){
			strQuery += svc.getQuery("SEL_MASTER_PERS_CARD_NO") + "\n";
			sql.setString(i++, strCardNo);
		}
		
		strQuery += svc.getQuery("SEL_MASTER_PERS_END") + "\n";
		
		strQuery += svc.getQuery("SEL_MASTER_PERS_ORDER");
        
        sql.put(strQuery);
        
        ret = select2List(sql);
        //ret = util.decryptedStr(ret,2);     //카드번호 복호화.
        return ret; 
    }
 
}
