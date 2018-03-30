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
 * <p>카드분실해제등록</p>
 * 
 * @created  on 1.0, 2010/03/21
 * @created  by 장형욱(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DCtm210DAO extends AbstractDAO {

    /**
     * <p>카드분실해제등록 조회</p>
     * 
     */        
    public List searchMaster(ActionForm form, HttpServletRequest request) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        Util util = new Util();
        int i = 1;
        
        String strSdt      = String2.nvl(form.getParam("strSdt"))+ "000000";
        String strEdt      = String2.nvl(form.getParam("strEdt"))+ "240000";
        String strCompFlag = String2.nvl(form.getParam("strCompFlag"));
        String strCardNo   = String2.nvl(form.getParam("strCardNo"));
        String strSSNo     = String2.nvl(form.getParam("strSSNo"));
        String strCustId   = String2.nvl(form.getParam("strCustId"));

        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

//        sql.setString(i++, strSdt);        
//        sql.setString(i++, strEdt); 
        
        strQuery = svc.getQuery("SEL_MASTER") + "\n";
        
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
        	strQuery += ("              AND D.COMP_PERS_FLAG  <> 'P'                   \n");
  
        }else{
        	strQuery +=  ("             AND D.COMP_PERS_FLAG  = ?                       \n");
            sql.setString(i++, strCompFlag);
        }
        
        sql.put(strQuery);
        
        ret = select2List(sql);
       // ret = util.decryptedStr(ret,3);
               
        return ret;
    }
    
    /**
     * <p>카드분실해제등록 조회</p>
     * 
     */    
    public int saveData(ActionForm form, MultiInput mi, String userId) throws Exception {
        int ret = 0;
        int res = 0;
        SqlWrapper sql = null;
        Service svc    = null;
        Util util      = new Util();
        
        try {
            connect("pot");
            begin();
            sql = new SqlWrapper();
            svc = (Service) form.getService();
            sql.close();
            
            while (mi.next()) {
                if(mi.IS_INSERT()){// 수정 
                	
                	sql.close();
                	
                    int i=1;
                    sql.put(svc.getQuery("UPD_CARD")); 
                    
                    sql.setString(i++, userId);                               //수정자ID
                    sql.setString(i++, mi.getString("CARD_NO"));     //카드번호
                    res = update(sql);
                    
                    sql.close();
                    
                    i = 1;
                    sql.put(svc.getQuery("INS_CARDLOSS")); 
                    sql.setString(i++, mi.getString("CARD_NO"));     //카드번호
                    sql.setString(i++, userId);                      //수정자ID
                    res = update(sql);
                }
                
                if (res != 1) {
                    throw new Exception("" + "데이터의 적합성 문제로 인하여" + "데이터 입력을 하지 못했습니다.");
                }                          
                
                ret += res;       
            }
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }        
        return ret;
    }    
}
