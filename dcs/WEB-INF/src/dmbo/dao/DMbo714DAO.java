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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
 
/**
 * <p>회원별 방문횟수조회</p>
 * 
 * @created  on 1.0, 2010/06/30  
 * @created  by 김영진
 * 
 * @modified on 
 * @modified by  
 * @caused   by  
 */
public class DMbo714DAO extends AbstractDAO {

	/**
     * <p>회원별 방문횟수조회</p>
     * 
     */
    public List searchMaster(ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        List       ret  = null; 
        SqlWrapper sql  = null; 
        Service    svc  = null; 
        String strQuery = "";
        int i = 1;
        
        String strVisitInDtS = String2.nvl(form.getParam("strVisitInDtS"));
        String strVisitInDtE = String2.nvl(form.getParam("strVisitInDtE"));
        String strBrchId     = String2.nvl(form.getParam("strBrchId"));
        String strVisitQty   = String2.nvl(form.getParam("strVisitQty"));
        
        sql = new SqlWrapper(); 
        svc = (Service) form.getService();

        connect("pot");
                                        		
        sql.setString(i++, strBrchId); 
        sql.setString(i++, strBrchId);
        sql.setString(i++, strVisitInDtS);
        sql.setString(i++, strVisitInDtE);
        sql.setString(i++, strVisitQty);

        strQuery = svc.getQuery("SEL_MASTER");
        
        sql.put(strQuery); 
        ret = select2List(sql);
        return ret; 
    }

    /** 
     * <p>회원별 방문횟수 상세 조회</p>
     * 
     */
    public List searchDetail(ActionForm form) throws Exception {
        List       ret      = null;
        SqlWrapper sql      = null;   
        Service    svc      = null;
         
        int i = 1;
        String strCustId     = String2.nvl(form.getParam("strCustId"));
        String strVisitInDtS = String2.nvl(form.getParam("strVisitInDtS"));
        String strVisitInDtE = String2.nvl(form.getParam("strVisitInDtE"));
        String strBrchId     = String2.nvl(form.getParam("strBrchId"));

        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");
 
        sql.setString(i++, strVisitInDtS);
        sql.setString(i++, strVisitInDtE);
        sql.setString(i++, strCustId);
        sql.setString(i++, strBrchId);
        sql.put(svc.getQuery("SEL_DETAIL"));
        
        ret = select2List(sql);
        return ret;
    } 
}
