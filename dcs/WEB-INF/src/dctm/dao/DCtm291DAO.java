/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dctm.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import common.util.Util;
//import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;



/**
 * <p></p>
 * 
 * @created  on 1.0, 2010/02/25
 * @created  by (FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DCtm291DAO extends AbstractDAO {

	/**
     * <p>개인카드  마스터 조회</p>
     * 
     */
    public List searchMaster(ActionForm form) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        Util       util = new Util();
        String strQuery = "";
        int i = 1;
         
        sql = new SqlWrapper();
        svc = (Service) form.getService(); 
 
        connect("pot");
        

		String strCardNo = String2.nvl(form.getParam("strCardNo"));
		String strSsNo = String2.nvl(form.getParam("strSsNo"));
        //String strCardNo    = util.encryptedStr(String2.nvl(form.getParam("strCardNo")));
        //String strSsNo      = util.encryptedStr(String2.nvl(form.getParam("strSsNo")));

        String strCustId = String2.nvl(form.getParam("strCustId"));
        
        strQuery = svc.getQuery("SEL_MASTER") + "\n"; 
        
        if (!String2.isEmpty(String2.trim((strCustId)))){
			strQuery += svc.getQuery("SEL_MASTER_CUST_ID") + "\n";
			sql.setString(i++, strCustId);
		}	
		
		if (!String2.isEmpty(String2.trim((strSsNo)))){
			strQuery += svc.getQuery("SEL_MASTER_SS_NO") + "\n";
			sql.setString(i++, strSsNo);
		}

		if (!String2.isEmpty(String2.trim((strCardNo)))){
			strQuery += svc.getQuery("SEL_MASTER_CARD_NO") + "\n";
			sql.setString(i++, strCardNo);
		}
		
		strQuery += svc.getQuery("SEL_MASTER_ORDER") + "\n";

        sql.put(strQuery);   
        ret = select2List(sql); 
        //ret = util.decryptedStr(ret,1);      //카드번호 복호화.
                   
        
        
        return ret; 
    }
    
    public List searchDetail(ActionForm form) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        Util       util = new Util();
        String strQuery = "";
        int i = 1;
        String strCardNo    = String2.nvl(form.getParam("strCardNo"));
         
        sql = new SqlWrapper();
        svc = (Service) form.getService(); 
 
        connect("pot");
        
        sql.setString(i++, strCardNo); 

        strQuery = svc.getQuery("SEL_DETAIL"); 

        sql.put(strQuery);   
        ret = select2List(sql); 
        //ret = util.decryptedStr(ret,0);      //카드번호 복호화.
        //ret = util.decryptedStr(ret,1);      //카드번호 복호화.
        
                   
        
        
        return ret; 
    }
    
    public int save(ActionForm form, MultiInput mi[], String strID)
			throws Exception {
   
		int ret = 0;
		int res = 0;
		int resD = 0;
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;

		int i;
		
		try {
			connect("pot");
			String flag;
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
		
			while (mi[0].next()) {
				sql.close();
				
				
				if (mi[0].IS_INSERT()) {
					flag = "I";
					i = 0;					
					
					sql.put(svc.getQuery("INS_DMLINKCARD"));					
					
					String LCNo = mi[0].getString("LINK_CARD_NO");
					String CNo  = mi[0].getString("CARD_NO");
					
					sql.setString(++i, LCNo);					
					sql.setString(++i, CNo);					
					sql.setString(++i, mi[0].getString("POCARD_PREFIX"));					
					sql.setString(++i, strID);					
					sql.setString(++i, strID);
					
					res = update(sql);
					
					
				} else if (mi[0].IS_UPDATE()) {
					flag = "U";
					i = 0;
					
					sql.put(svc.getQuery("UPD_DMLINKCARD"));
					
					String LCNo = mi[0].getString("LINK_CARD_NO");
					
					sql.setString(++i, mi[0].getString("POCARD_PREFIX"));					
					sql.setString(++i, strID);					
					sql.setString(++i, LCNo);
		
					res = update(sql);
				} else {
					flag = "D";
					i = 0;			
					sql.put(svc.getQuery("DEL_DMLINKCARD"));
					String LCNo = mi[0].getString("LINK_CARD_NO");
					
					sql.setString(++i, LCNo);
					
                    
					res = update(sql);
    				
				} 
				
				
					
				if (res != 1) {
					String msg = "데이터 입력을 하지 못했습니다.";
					if( flag.equals("D")){
						msg = "데이터 삭제을 하지 못했습니다.";
					}
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ msg);
					
				//데이터 신규 입력 및 수정 입력 시 
				}
				ret += res;
			}
			
			while (mi[1].next()) {
				sql.close();
				
				
				if (mi[1].IS_UPDATE()) {
					i = 0;					
					
					sql.put(svc.getQuery("UPD_DMCARD"));					
					
					String CNo = mi[1].getString("CARD_NO");
					
					sql.setString(++i, mi[1].getString("POCARD_PREFIX"));
					sql.setString(++i, strID);					
					sql.setString(++i, CNo);					
					
					resD = update(sql);
				}
				
				if (resD != 1) {
					String msg = "데이터 입력을 하지 못했습니다.";
					
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ msg);
					
				//데이터 신규 입력 및 수정 입력 시 
				}
				resD += resD;
				
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
