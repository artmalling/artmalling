/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dmtc.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>마감일자관리</p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 장형욱(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMtc605DAO extends AbstractDAO {

    /**
     * <p>마감일자 관리 조회</p>
     * 
     */        
    public List searchList(ActionForm form, HttpServletRequest request) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        
        String strSdt       = String2.nvl(form.getParam("strSdt"));
        String strEdt       = String2.nvl(form.getParam("strEdt"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strSdt);
        sql.setString(i++, strEdt);
        
        strQuery = svc.getQuery("SEL_MASTER") + "\n";
 
        sql.put(strQuery);
        ret = select2List(sql);
               
        return ret;
    }
    
    /**
     * <p>마감일자 관리 상세 조회</p>
     * 
     */        
    public List searchDetail(ActionForm form, HttpServletRequest request) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        
        String strCloseYM  = String2.nvl(form.getParam("strCloseYM"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strCloseYM);
        
        strQuery = svc.getQuery("SEL_CLOSING") + "\n";
        sql.put(strQuery);
        ret = select2List(sql);
               
        return ret;
    }
    
    
    /**
     * <p>마감일자 등록</p>
     * 
     * @created  on 1.0, 2010/02/16
     * @created  by 장형욱
     * 
     * @modified on 
     * @modified by 
     * @caused   by 
     */
    
    public int saveData(ActionForm form, MultiInput mi, String userId) throws Exception {
        int ret = 0;
        int res = 0;
        SqlWrapper sql = null;
        Service svc    = null;
      
        try {
        	
            connect("pot");
            begin();
            sql = new SqlWrapper();
            svc = (Service) form.getService();
            
            String strFlag  = String2.nvl(form.getParam("strFlag"));

            while (mi.next()) {  
            	
            	if("I".equals(strFlag)){
            	    //마감일자 중복체크
            	    sql.setString(1, mi.getString("CLOSE_YM"));
                    sql.put(svc.getQuery("SEL_CLOSE_YM_CHKYN"));
                     
                    Map map = selectMap( sql );
             	    String strChkYN = String2.nvl((String)map.get("CHK_YN"));
             	    
             	    if( strChkYN.equals("Y")) {
             	    	throw new Exception("[USER]"+"이미 존재하는 정보입니다. 조회 후 수정하세요.");
             	    }
             	    sql.close();
            	}
             	
            	if("I".equals(strFlag)) {         
                    int i=1;
                    sql.put(svc.getQuery("INS_CLOSING")); 
                            
                    sql.setString(i++, mi.getString("CLOSE_YM"));  //처리년월
                    sql.setString(i++, mi.getString("CLOSE_YN"));  //마감여부
                    sql.setString(i++, mi.getString("CLOSE_DT"));  //마감일자
                    sql.setString(i++, userId);                    //수정자ID
                    sql.setString(i++, userId);                    //등록자ID
                } else if ("U".equals(strFlag)) {
                    int i=1;
                    sql.put(svc.getQuery("UPD_CLOSING")); 
                    
                    sql.setString(i++, mi.getString("CLOSE_YN"));  //마감여부
                    sql.setString(i++, mi.getString("CLOSE_DT"));  //마감일자
                    sql.setString(i++, userId);                    //수정자ID
                    sql.setString(i++, mi.getString("CLOSE_YM"));  //처리년월
                }
                
                res = update(sql);
                
                if (res != 1) {
                    throw new Exception("" + "데이터의 적합성 문제로 인하여"
                            + "데이터 입력을 하지 못했습니다.");
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
