/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package psal.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.util.Util;
//import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by (FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PSal522DAO extends AbstractDAO {

	/**
     * <p>마스터 조회</p>
     * 
     */
    public List searchMaster(ActionForm form) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        int i = 1;
        
        String strStrCd    = String2.nvl(form.getParam("strStrCd"));
        String strDeptCd    = String2.nvl(form.getParam("strDeptCd"));
        String strTeamCd    = String2.nvl(form.getParam("strTeamCd"));
        String strPcCd    = String2.nvl(form.getParam("strPcCd"));
        String strSaleDtS    = String2.nvl(form.getParam("strSaleDtS"));
        String strSaleDtE    = String2.nvl(form.getParam("strSaleDtE"));
        String strAppDtS    = String2.nvl(form.getParam("strAppDtS"));
        String strAppDtE    = String2.nvl(form.getParam("strAppDtE"));
        String strPumbunCd    = String2.nvl(form.getParam("strPumbunCd"));
        String strCheck    = String2.nvl(form.getParam("strCheck"));
        
         
        sql = new SqlWrapper();
        svc = (Service) form.getService(); 
 
        connect("pot");
        
        String strSql = svc.getQuery("SEL_MASTER") + "\n"; // 기본
        
        if (strCheck.equals("1")) {
        	strSql += svc.getQuery("SEL_MG_DATE") + "\n";
        }
        strSql += svc.getQuery("SEL_GROUP") + "\n";
        sql.put(strSql);
        
        sql.setString(i++, strStrCd); 
        sql.setString(i++, strDeptCd);
        sql.setString(i++, strTeamCd);
        sql.setString(i++, strPcCd); 
        sql.setString(i++, strSaleDtS);
        sql.setString(i++, strSaleDtE);
        sql.setString(i++, strPumbunCd);
        if (strCheck.equals("1")) {
        	sql.setString(i++, strAppDtS);
        	sql.setString(i++, strAppDtE);
        }

        ret = select2List(sql);
        
		return ret;
        
         
    }
    
   


}
