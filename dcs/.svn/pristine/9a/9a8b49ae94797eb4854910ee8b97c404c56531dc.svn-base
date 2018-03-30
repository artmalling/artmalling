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
 * <p>무료주차시간조회</p>
 * 
 * @created  on 1.0, 2010/03/18
 * @created  by 김영진
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class DMbo303DAO extends AbstractDAO {

	/**
     * <p>무료주차시간조회 - 상단</p> 
     * 
     */
    public List searchMaster(ActionForm form, String strBrchId) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        Util       util = new Util();
        int i = 1;

        String strUseFDt  = String2.nvl(form.getParam("strUseFDt"));
        String strUseTDt  = String2.nvl(form.getParam("strUseTDt"));
        String strStrCd   = String2.nvl(form.getParam("strStrCd"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");
        
        sql.put(svc.getQuery("SEL_MASTER"));
        
//        sql.setString(i++, strBrchId);
        sql.setString(i++, strStrCd);
        sql.setString(i++, strUseFDt); 
        sql.setString(i++, strUseTDt);
        sql.setString(i++, strStrCd);

        ret = select2List(sql);
      //  ret = util.decryptedStr(ret,2);     //주민등록번호 복호화.
        return ret; 
    }
    
    /**
     * <p>무료주차시간조회 - 하단</p>
     * 
     */
    public List searchDetail(ActionForm form, String strBrchId) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        Util       util = new Util();
        int i = 1;
        
        String strUseFDt  = String2.nvl(form.getParam("strUseFDt"));
        String strUseTDt  = String2.nvl(form.getParam("strUseTDt"));
        String strStrCd   = String2.nvl(form.getParam("strStrCd"));
        String strCurtId  = String2.nvl(form.getParam("strCurtId"));

        sql = new SqlWrapper();
        svc = (Service) form.getService(); 

        connect("pot");

        sql.put(svc.getQuery("SEL_DETAIL"));
        
//        sql.setString(i++, strBrchId);
        sql.setString(i++, strStrCd);
        sql.setString(i++, strUseFDt); 
        sql.setString(i++, strUseTDt);
        sql.setString(i++, strStrCd);
        sql.setString(i++, strCurtId);

        ret = select2List(sql);
        //ret = util.decryptedStr(ret,2);     //주민등록번호 복호화.
        return ret; 
    }
}
