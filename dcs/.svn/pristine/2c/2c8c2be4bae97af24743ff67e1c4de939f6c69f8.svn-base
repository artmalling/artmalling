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
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import common.util.Util;

/**
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2014.05.14
 * @created  by 강진실
 * @caused   by 영업지원관리>사은행사관리>사은품지급>VIP 커피 증정 조회
 * 
 * @modified on 
 * @modified by 
 */

public class DCtm436DAO extends AbstractDAO {
	/**
     VIP 커피 증정 조회 리스트
     * 
     */        
    public List searchList(ActionForm form, HttpServletRequest request) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        Util util = new Util();
        int i = 1;

        String strSdt     = String2.nvl(form.getParam("strSdt"));
        String strEdt     = String2.nvl(form.getParam("strEdt"));
        String strPlaceNm = String2.nvl(form.getParam("strPlaceNm"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");
   
        sql.setString(i++, strSdt);
        sql.setString(i++, strEdt);
        sql.setString(i++, strPlaceNm);
        
        strQuery = svc.getQuery("SEL_MASTER") + "\n"; 
        sql.put(strQuery);
        ret = select2List(sql);
        //ret = util.decryptedStr(ret, 2);  
      
        return ret;
    }
    
    /**
     * 증정장소 콤보박스 처리
     *
     * @param  : 
     * @return : 
     */
  
    public List getEtcCode(ActionForm form) throws Exception {
        List list = null;
        SqlWrapper sql = null;
        Service svc = null;
        String  getSql = "";

        try {
            connect("pot");
            svc = (Service) form.getService();
            sql = new SqlWrapper();

            getSql = getSql + svc.getQuery("SEL_ETC_CODE");
      
            sql.put(getSql);

            list = select2List(sql);

        } catch (Exception e) {
            throw e;
        }
        return list;
    }
}
