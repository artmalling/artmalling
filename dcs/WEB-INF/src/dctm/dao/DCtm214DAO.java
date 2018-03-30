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
/**
 * <p>카드중지이력조회</p>
 * 
 * @created  on 1.0, 2010/03/18 
 * @created  by jinjung.kim
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DCtm214DAO extends AbstractDAO {

    public List searchCust(ActionForm form) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        Util       util = new Util();
        String strQuery = "";
        
        String BRCH_ID        = String2.nvl(form.getParam("BRCH_ID"));
        String CUST_ID        = String2.nvl(form.getParam("CUST_ID"));
        String SS_NO          = String2.nvl(form.getParam("SS_NO"));
        String CARD_NO        = String2.nvl(form.getParam("CARD_NO"));
        String COMP_PERS_FLAG = String2.nvl(form.getParam("COMP_PERS_FLAG"));
         
        sql = new SqlWrapper();
        svc = (Service) form.getService(); 
 
        connect("pot");
        
        int i = 1;
        sql.setString(i++, BRCH_ID); 

        strQuery = svc.getQuery("SEL_CUST") + "\n"; 
        
        if (!String2.isEmpty(String2.trim((CUST_ID)))){
			strQuery += svc.getQuery("SEL_CUST_CUST_ID") + "\n";
			sql.setString(i++, CUST_ID);
		}	
		
		if (!String2.isEmpty(String2.trim((SS_NO)))){
			strQuery += svc.getQuery("SEL_CUST_SS_NO") + "\n";
			sql.setString(i++, SS_NO);
		}

		if (!String2.isEmpty(String2.trim((CARD_NO)))){
			strQuery += svc.getQuery("SEL_CUST_CARD_NO") + "\n";
			sql.setString(i++, CARD_NO);
		}
		
		strQuery += svc.getQuery("SEL_CUST_ROWUNM") + "\n";
        
        if(COMP_PERS_FLAG.equals("C")){ 
        	strQuery += ("              AND A.COMP_PERS_FLAG  <> 'P'                   \n");
  
        }else{
        	strQuery +=  ("             AND A.COMP_PERS_FLAG = ?                      \n");
            sql.setString(i++, COMP_PERS_FLAG);
        }
        
        sql.put(strQuery);   
        ret = select2List(sql);  
        
        //ret = util.decryptedStr(ret,2);    //집전화1
        //ret = util.decryptedStr(ret,3);    //집전화2
        //ret = util.decryptedStr(ret,4);    //집전화3
        if(COMP_PERS_FLAG.equals("P")){
            //ret = util.decryptedStr(ret,5);    //휴대전화1
            //ret = util.decryptedStr(ret,6);    //휴대전화2
            //ret = util.decryptedStr(ret,7);    //휴대전화3
        }
        //ret = util.decryptedStr(ret,8);    //주민번호
        //ret = util.decryptedStr(ret,10);   //EMAIL1
        //ret = util.decryptedStr(ret,11);   //EMAIL1
        
        return ret; 
    }
    
    public List searchMaster(ActionForm form) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        Util       util = new Util();
        String strQuery = "";
        
        
        String COMP_PERS_FLAG = String2.nvl(form.getParam("COMP_PERS_FLAG"));
        String LOSS_DT_FROM   = String2.nvl(form.getParam("LOSS_DT_FROM"));
        String LOSS_DT_TO     = String2.nvl(form.getParam("LOSS_DT_TO")); 
        String CUST_ID        = String2.nvl(form.getParam("CUST_ID"));
        String SS_NO          = String2.nvl(form.getParam("SS_NO"));
        String CARD_NO        = String2.nvl(form.getParam("CARD_NO"));
        String BRCH_ID        = String2.nvl(form.getParam("BRCH_ID"));
        
         
        sql = new SqlWrapper();
        svc = (Service) form.getService(); 
 
        connect("pot");
        
        int i = 1;
        //sql.setString(i++, BRCH_ID); 
        sql.setString(i++, LOSS_DT_FROM);
        sql.setString(i++, LOSS_DT_TO);

        strQuery = svc.getQuery("SEL_MASTER") + "\n"; 
        
        if (!String2.isEmpty(String2.trim((CUST_ID)))){
			strQuery += svc.getQuery("SEL_MASTER_CUST_ID") + "\n";
			sql.setString(i++, CUST_ID);
		}	
		
		if (!String2.isEmpty(String2.trim((SS_NO)))){
			strQuery += svc.getQuery("SEL_MASTER_SS_NO") + "\n";
			sql.setString(i++, SS_NO);
		}

		if (!String2.isEmpty(String2.trim((CARD_NO)))){
			strQuery += svc.getQuery("SEL_MASTER_CARD_NO") + "\n";
			sql.setString(i++, CARD_NO);
		}
		
		strQuery += svc.getQuery("SEL_MASTER_END") + "\n";
        
        if(COMP_PERS_FLAG.equals("C")){ 
        	strQuery += ("              AND C.COMP_PERS_FLAG  <> 'P'                   \n");
        	strQuery +=  ("           ORDER BY A.REG_DATE DESC                         \n");
  
        }else{
        	strQuery +=  ("             AND C.COMP_PERS_FLAG(+) = ?                       \n");
        	strQuery +=  ("           ORDER BY A.REG_DATE DESC                         \n");
            sql.setString(i++, COMP_PERS_FLAG);
        }
        sql.put(strQuery);   
        ret = select2List(sql);  
        
        //ret = util.decryptedStr(ret,0);     //카드번호 
        return ret; 
    }
}
