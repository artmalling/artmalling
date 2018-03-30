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

import com.gauce.GauceDataSet;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>기부기획등록</p>
 * 
 * @created  on 1.1, 2010/05/19
 * @created  by 장형욱(FUJITSU KOREA LTD.)
 * @caused   by 클럽코드 관리
 *
 */

public class DCtm132DAO extends AbstractDAO {

    /**
     * <p>클럽코드관리 조회</p>
     * 
     */        
    public List searchMaster(ActionForm form, HttpServletRequest request) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");
        
        String strName     = String2.nvl(form.getParam("strName"));
        String strSdt      = String2.nvl(form.getParam("strSdt"));
        String strEdt      = String2.nvl(form.getParam("strEdt"));
        String strProcFlag = String2.nvl(form.getParam("strProcFlag"));        

        sql.setString(i++, strSdt);
        sql.setString(i++, strEdt);        
        sql.setString(i++, strName);
        sql.setString(i++, strSdt);
        sql.setString(i++, strEdt);        
        sql.setString(i++, strName);
        
        strQuery = svc.getQuery("SEL_MASTER") + "\n";
         
        sql.put(strQuery);
        ret = select2List(sql);
               
        return ret;
    }
    
    /**
     * <p>가맹점 코드 상세 조회</p>
     * 
     */
    public List searchDetail(ActionForm form, GauceDataSet dSet) throws Exception {
        List       ret      = null;
        SqlWrapper sql      = null;
        Service    svc      = null;
        String     strQuery = "";
        int i = 1;
        
//        String strClubId   = String2.nvl(form.getParam("strClubId"));
//        String strName     = String2.nvl(form.getParam("strName"));
//        String strSdt      = String2.nvl(form.getParam("strSdt"));
//        String strEdt      = String2.nvl(form.getParam("strEdt"));
//        String strProcFlag = String2.nvl(form.getParam("strProcFlag"));
        
        String strClubId   	= dSet.getDataRow(0).getColumnValue(0).toString();    
        String strName   	= dSet.getDataRow(0).getColumnValue(1).toString();        
        String strSdt 		= dSet.getDataRow(0).getColumnValue(2).toString(); 
        String strEdt 		= dSet.getDataRow(0).getColumnValue(3).toString();
        String strProcFlag 	= dSet.getDataRow(0).getColumnValue(4).toString();

        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strName);
        sql.setString(i++, strClubId);
        sql.setString(i++, strSdt);
        sql.setString(i++, strEdt);
        sql.setString(i++, strProcFlag);
        
        strQuery = svc.getQuery("SEL_DETAIL"); // + "\n";
        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    }    
    
    /**
     * <p>클럽가입신청조회 등록</p>
     * 
     * @created  on 1.0, 2010/05/19
     * @created  by 장형욱
     * 
     * @modified on 
     * @modified by 
     * @caused   by 
     */
    
    public int saveData(ActionForm form, String userId) throws Exception {
        ProcedureWrapper psql = null;
        Service svc           = null;
        int ret = 0;
        int res = 0;
 
        try {
            connect("pot");
            begin();
            psql = new ProcedureWrapper();
            svc = (Service) form.getService();
            
            ProcedureResultSet prs = null;
            
            psql.close();
            
            int i=1;

            String strClubId   = String2.nvl(form.getParam("strClubId"));
            String strName     = String2.nvl(form.getParam("strName"));
            String strSdt      = String2.nvl(form.getParam("strSdt"));
            String strEdt      = String2.nvl(form.getParam("strEdt"));
            String strProcFlag = String2.nvl(form.getParam("strProcFlag"));            
              
            psql.put("DCS.PR_DCTM132", 8);    
            psql.setString(i++, strClubId);         
            psql.setString(i++, strName);            
            psql.setString(i++, strSdt);            
            psql.setString(i++, strEdt);   
            psql.setString(i++, strProcFlag);           
            psql.setString(i++, userId);                         

            psql.registerOutParameter(i++, DataTypes.INTEGER);//7
            psql.registerOutParameter(i++, DataTypes.VARCHAR);//8
            prs = updateProcedure(psql);
            
            System.out.println("7:"+ prs.getInt(7));
            System.out.println("8:"+ prs.getInt(8));
            if (prs.getInt(7) != 0) {
        //        throw new Exception("" + prs.getString(8));
            } else {
            	ret = 1;
            }
            if (res != 0) {
                throw new Exception("" + "데이터의 적합성 문제로 인하여"
                        + "데이터 입력을 하지 못했습니다.");
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
