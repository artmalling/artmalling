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
 * <p>회원정보안내</p>
 * 
 * @created  on 1.0, 2010/03/31
 * @created  by 김영진(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMbo601DAO extends AbstractDAO {
	
	/**
     * <p>보유카드현황 - 개인/법인카드</p>
     * 
     */
    public List[] searchMaster(ActionForm form) throws Exception { 
    	List       ret[]= null;
    	List       res1 = null;
    	List       res2 = null;
    	List       res3 = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        Util       util = new Util();
        String strQuery = "";
        int i = 1;

        String strCompPersFlag = String2.nvl(form.getParam("strCompPersFlag"));
        String strCardNo       = String2.nvl(form.getParam("strCardNo"));
        String strSsNo         = String2.nvl(form.getParam("strSsNo"));
        String strCustId       = String2.nvl(form.getParam("strCustId"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();
        ret = new List[3];
        connect("pot");
        
        if(strCompPersFlag.equals("P")){
            strQuery = svc.getQuery("SEL_MASTER_P") + "\n";
        }else if(strCompPersFlag.equals("C")){
        	strQuery = svc.getQuery("SEL_MASTER_C") + "\n";
        } 
        
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
		
		if(strCompPersFlag.equals("P")){
			strQuery += svc.getQuery("SEL_MASTER_P_ORDER");
        }else if(strCompPersFlag.equals("C")){
        	strQuery = svc.getQuery("SEL_MASTER_C_ORDER");
        }

        sql.put(strQuery); 
        res1 = select2List(sql);
        //res1 = util.decryptedStr(res1,1);      //카드번호 복호화.
        //res1 = util.decryptedStr(res1,2);      //주민번호 복호화.
        res2 = this.searchPoint(form);
        res3 = this.searchClrPoint(form);
        
        ret[0] = res1;
        ret[1] = res2;
        ret[2] = res3;
        return ret;
    }
    
    /**
     * <p>포인트적립/사용 이력</p>
     * 
     */
    public List searchPoint(ActionForm form) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        Util       util = new Util();
        String strQuery = "";
        int i = 1;
        
        String strCardNo = String2.nvl(form.getParam("strCardNo"));
        String strSsNo   = String2.nvl(form.getParam("strSsNo"));
        String strCustId = String2.nvl(form.getParam("strCustId"));
        String strBrchId = String2.nvl(form.getParam("strBrchId"));
        String strUseFDt = String2.nvl(form.getParam("strUseFDt"));
        String strUseTDt = String2.nvl(form.getParam("strUseTDt"));
        String strCompPersFlag = String2.nvl(form.getParam("strCompPersFlag"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        strQuery = svc.getQuery("SEL_POINT") + "\n";
        
        sql.setString(i++, strUseFDt); 
        sql.setString(i++, strUseTDt);
        sql.setString(i++, strBrchId);
        sql.setString(i++, strCompPersFlag);
        
        if (!String2.isEmpty(String2.trim((strCustId)))){
			strQuery += svc.getQuery("SEL_POINT_CUST_ID") + "\n";
			sql.setString(i++, strCustId);
		}	
		
		if (!String2.isEmpty(String2.trim((strSsNo)))){
			strQuery += svc.getQuery("SEL_POINT_SS_NO") + "\n";
			sql.setString(i++, strSsNo);
		}

		if (!String2.isEmpty(String2.trim((strCardNo)))){
			strQuery += svc.getQuery("SEL_POINT_CARD_NO") + "\n";
			sql.setString(i++, strCardNo);
		}
		
		strQuery += svc.getQuery("SEL_POINT_END") + "\n";
		
		strQuery += svc.getQuery("SEL_POINT_UNION") + "\n";
		
		sql.setString(i++, strUseFDt); 
        sql.setString(i++, strUseTDt); 
        sql.setString(i++, strBrchId);
        sql.setString(i++, strCompPersFlag);
		
		if (!String2.isEmpty(String2.trim((strCustId)))){
			strQuery += svc.getQuery("SEL_POINT_CUST_ID") + "\n";
			sql.setString(i++, strCustId);
		}	
		
		if (!String2.isEmpty(String2.trim((strSsNo)))){
			strQuery += svc.getQuery("SEL_POINT_SS_NO") + "\n";
			sql.setString(i++, strSsNo);
		}

		if (!String2.isEmpty(String2.trim((strCardNo)))){
			strQuery += svc.getQuery("SEL_POINT_CARD_NO") + "\n";
			sql.setString(i++, strCardNo);
		}
		
		strQuery += svc.getQuery("SEL_POINT_END") + "\n";
		strQuery += svc.getQuery("SEL_POINT_ORDER") + "\n";
        
        //sql.setString(i++, strCustId);
        //sql.setString(i++, util.encryptedStr(strCardNo));
        //sql.setString(i++, util.encryptedStr(strSsNo));
        
        
        
        //sql.setString(i++, strCustId);
        //sql.setString(i++, util.encryptedStr(strCardNo));
        //sql.setString(i++, util.encryptedStr(strSsNo));
        //
        
        
        sql.put(strQuery);
        
        ret = select2List(sql);
        //ret = util.decryptedStr(ret,2);     //카드번호 복호화.
        return ret; 
    }
    
    /**
     * <p>소멸예정포인트조회</p>
     * 
     */
    public List searchClrPoint(ActionForm form) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null; 
        Service    svc  = null;
        Util       util = new Util();
        String strQuery = "";
        int i = 1;
        
        String strAddFDt    = String2.nvl(form.getParam("strAddFDt"));
        String strAddTDt    = String2.nvl(form.getParam("strAddTDt"));
        String strCustId    = String2.nvl(form.getParam("strCustId"));
        String strSrchGubun = String2.nvl(form.getParam("strSrchGubun"));

        sql = new SqlWrapper();
        svc = (Service) form.getService();
 
        connect("pot"); 
         
        if(strSrchGubun.equals("1")){
            strQuery = svc.getQuery("SEL_DAY_MASTER"); 
        }else if(strSrchGubun.equals("2")){
            strQuery = svc.getQuery("SEL_MONTH_MASTER");
        } 
                    		 
        sql.setString(i++, strAddFDt);  
        sql.setString(i++, strAddTDt);
        sql.setString(i++, strAddFDt); 
        sql.setString(i++, strAddTDt);
        sql.setString(i++, strCustId);
     
        sql.put(strQuery);
        ret = select2List(sql);
        //ret = util.decryptedStr(ret,2);     //주민등록번호 복호화.
        if(strSrchGubun.equals("1")){
            //ret = util.decryptedStr(ret,3); //카드번호 복호화.
        }
        return ret; 
    }
}
