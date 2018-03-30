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
import java.util.Map;

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
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DCtm108DAO extends AbstractDAO {

    /**
     * <p>카드분실등록 조회</p>
     * 
     */        
    public List searchMaster(ActionForm form, HttpServletRequest request) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        Util util = new Util();
        int i = 1;
        
        String strCompFlag = String2.nvl(form.getParam("strCompFlag"));
        String strCardNo   = String2.nvl(form.getParam("strCardNo"));
        String strSSNo     = String2.nvl(form.getParam("strSSNo"));
        String strCustId   = String2.nvl(form.getParam("strCustId"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

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
        	strQuery += ("              AND A.COMP_PERS_FLAG <> 'P'         \n");
			strQuery += ("            ORDER BY A.CUST_ID, B.REG_DATE DESC   \n");
  
        }else{
        	strQuery +=  ("              AND A.COMP_PERS_FLAG = ?            \n");
			strQuery +=  ("            ORDER BY A.CUST_ID, B.REG_DATE DESC   \n");
            sql.setString(i++, strCompFlag);
        }
        sql.put(strQuery);
        ret = select2List(sql);
        //ret = util.decryptedStr(ret, 8);
               
        return ret;
    }
    
    public int saveData(ActionForm form, MultiInput mi, String userId) throws Exception {
        int ret = 0;
        int res = 0;
        SqlWrapper sql = null;
        Service svc    = null;
        Util util      = new Util();
        
        try {
        	
        	String qty = "";
            connect("pot");
            begin();
            sql = new SqlWrapper();
            svc = (Service) form.getService();
            sql.close();
            
            while (mi.next()) {
                if(mi.IS_INSERT()){// 수정 
                	sql.close();
                	//제휴사 카드조회
                	sql.put("SELECT COUNT(*) QTY FROM DCS.DM_CARD WHERE CUST_ID ='"+ mi.getString("CUST_ID") +"' AND CARD_TYPE_CD IN ('21', '31') AND CARD_STAT_CD IN ('0', '1', '3')" );

                    Map map = selectMap(sql);            
                    qty = (String)map.get("QTY");   
                    sql.close();                	
                	
                    if (Integer.parseInt(qty) > 0)
                    	throw new Exception("[USER]"+"제휴사를 먼저 탈퇴한후 회원탈퇴가 가능합니다.");
                    	
                    int i=1;
                    sql.put(svc.getQuery("UPD_CARD")); 
                    
                    sql.setString(i++, userId);                                         //수정자ID
                    sql.setString(i++, mi.getString("CUST_ID"));     //카드번호
                    res = update(sql);
                    
                    sql.close();
                    
                    i = 1;
                    sql.put(svc.getQuery("UPD_CUSTOMER")); 
                    sql.setString(i++, userId);                                         //수정자ID
                    sql.setString(i++, mi.getString("CUST_ID"));     //ID
                    res = update(sql);                    
                    
                    sql.close();
                    
                    i = 1;
                    sql.put(svc.getQuery("INS_SCEDHIST")); 
                    sql.setString(i++, mi.getString("CUST_ID"));   //ID
                    sql.setString(i++, mi.getString("REASON_CD")); //탈퇴사유
                    sql.setInt(i++, Integer.parseInt(mi.getString("POINT")));     //포인트
                    sql.setString(i++, userId);                                       //수정자ID
                    sql.setString(i++, mi.getString("REMARK")); //비고
                    sql.setString(i++, mi.getString("SCED_REQ_TYPE")); //탈퇴유형(요청)
                    sql.setString(i++, mi.getString("REMARK_SCED_REQ_TYPE")); //비고(탈퇴요청유형)
                    res = update(sql);
                }
                
                if (res != 1) {
                    throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여" + "데이터 입력을 하지 못했습니다.");
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
