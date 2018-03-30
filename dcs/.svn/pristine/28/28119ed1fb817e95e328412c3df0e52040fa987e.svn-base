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

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import common.util.Util;

/**
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2010/03/30
 * @created  by 장형욱(FUJITSU KOREA LTD.)
 * @caused   by 데이터변경이력조회
 * 
 * @modified on 
 * @modified by 
 */

public class DCtm432DAO extends AbstractDAO {
	/**
     * <p>데이터조회 이력 조회</p>
     * 
     */        
    public List searchList(ActionForm form, HttpServletRequest request) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        Util util = new Util();
        
        String strSdt     = String2.nvl(form.getParam("strSdt"));
        String strEdt     = String2.nvl(form.getParam("strEdt"));
        String strTableId = String2.nvl(form.getParam("strTableId"));
       
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");
   
        sql.setString(i++, strSdt);
        sql.setString(i++, strEdt);
        sql.setString(i++, strTableId);
        
        strQuery = svc.getQuery("SEL_MASTER") + "\n"; 
        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    }
    
    /**
     * 변경 테이블명 콤보박스 처리
     *
     * @param  : 
     * @return :
     */
    public List getEtcCode(ActionForm form, MultiInput mi) throws Exception {
        List list = null;
        SqlWrapper sql = null;
        Service svc = null;
        String      getSql = "";

        try {
            connect("pot");
            svc = (Service) form.getService();
            sql = new SqlWrapper();
        
            mi.next();
            String allGb   = mi.getString("ALL_GB");
            String nulGb   = mi.getString("NUL_GB");
        
            getSql = getSql + svc.getQuery("SEL_ETC_CODE");
      
            sql.put(getSql);

            list = select2List(sql);

        } catch (Exception e) {
            throw e;
        }
        return list;
    }        
}
