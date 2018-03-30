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
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>캠페인 조회</p>
 * 
 * @created  on 1.0, 2010/03/17
 * @created  by 김영진
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class DMbo201DAO extends AbstractDAO {
	
	/**
     * <p>캠페인 조회</p>
     * 
     */
    public List searchMaster(ActionForm form) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        
        String strSDt   = String2.nvl(form.getParam("strSDt"));
        String strEDt   = String2.nvl(form.getParam("strEDt"));

        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strSDt);
        sql.setString(i++, strEDt);
        sql.setString(i++, strSDt);
        sql.setString(i++, strEDt);
 
        strQuery = svc.getQuery("SEL_MASTER"); 
        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    }
    
    /**
     * <p>캠페인 상세 조회</p>
     * 
     */
    public List searchDetail(ActionForm form) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        
        String strCamId   = String2.nvl(form.getParam("strCamId"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService(); 

        connect("pot");

        sql.setString(i++, strCamId);

        strQuery = svc.getQuery("SEL_DETAIL"); 
        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    }
    
    /**
     * <p>인원수 POPUP 조회</p>
     * 
     */
    public List popCustSearch(ActionForm form) throws Exception {
    	
    	Util util       = new Util();
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        int i = 1;
        
        String strCamId   = String2.nvl(form.getParam("strCamId"));
        String strStrCd   = String2.nvl(form.getParam("strStrCd"));
        String strCustNm  = String2.nvl(form.getParam("strCustNm"));

        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");
        sql.setString(i++, strCamId);
        sql.setString(i++, strStrCd);
        sql.setString(i++, strCustNm);
        
        sql.put(svc.getQuery("SEL_POPCUST"));
        ret = select2List(sql);
        //ret = util.decryptedStr(ret,5);     //이동전화1복호화.
		//ret = util.decryptedStr(ret,6);     //이동전화2 복호화.
		//ret = util.decryptedStr(ret,7);     //이동전화3 복호화.
        return ret;
    }
    
    /**
     * <p>적용가맹점수 상세 조회</p>
     * 
     */
    public List popBrchSearch(ActionForm form) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        int i = 1;
        
        String strCamId   = String2.nvl(form.getParam("strCamId"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");
 
        sql.setString(i++, strCamId);
        
        sql.put(svc.getQuery("SEL_POPBRCH"));
        ret = select2List(sql);
        return ret;
    }
    
    /**
     * <p>점코드 콤보 처리</p>
     * 
     */
    public List getEtcCode(ActionForm form, MultiInput mi) throws Exception {
        List list      = null;
        SqlWrapper sql = null;
        Service svc    = null; 
        String  getSql = "";

        try {
            connect("pot");
            svc = (Service) form.getService();
            sql = new SqlWrapper();
            mi.next();
            String allGb      = mi.getString("ALL_GB");
            String nulGb      = mi.getString("NUL_GB");
            String strStrCd   = mi.getString("STR_CD");
             
            getSql = getSql + svc.getQuery("SEL_ETC_CODE");
      
            sql.setString(1, strStrCd);
            sql.put(getSql);
            
            list = select2List(sql);

        } catch (Exception e) {
            throw e;
        }
        return list;
    }  
}
