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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.vo.SessionInfo;

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
 * <p>회계분개실적생성</p>
 * 
 * @created  on 1.0, 2010/05/06
 * @created  by 장형욱(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMtc604DAO extends AbstractDAO {

	   /**
     * <p>회계분개실적생성 조회</p>
     * 
     */        
    public List searchMaster(ActionForm form, HttpServletRequest request) throws Exception {
    	
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        
        String strSdt = String2.nvl(form.getParam("strSdt"));
             
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strSdt);
        
        strQuery = svc.getQuery("SEL_MASTER") + "\n";
         
        sql.put(strQuery);
        ret = select2List(sql); 
               
        return ret;
    }

    /**
     * 회계기표일자를 저장 한다.
     * 
     * @param form
     * @param mi 
     * @param strID
     * @return
     * @throws Exception
     */
    public int save(ActionForm form, MultiInput mi, HttpServletRequest request, HttpServletResponse response) throws Exception {
        
    	int ret = 0; 
        int res = 0;
        ProcedureWrapper psql = null;
        Service svc    = null;
        ProcedureResultSet proset = null; 

        HttpSession session = request.getSession();
        SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
        String strUserId = sessionInfo.getUSER_ID();
        
        try {
        	
            connect("pot"); 
            begin(); 

            String strAccntMigDt = String2.nvl(form.getParam("strAccntMigDt"));
            String strSdt        = String2.nvl(form.getParam("strSdt"));
            
            while (mi.next()) {
                psql = new ProcedureWrapper();
        		int i=1;  
     
        	    psql.put("DCS.PR_DMTC601_1_SAP", 5);
        	    
        		psql.setString(i++, strSdt);                  //처리년월
        		psql.setString(i++, strAccntMigDt);           //회계기표일자
        		psql.setString(i++, strUserId);
        		psql.registerOutParameter(i++, DataTypes.INTEGER);
        		psql.registerOutParameter(i++, DataTypes.VARCHAR);
        		proset = updateProcedure(psql);
        		
        		psql.close();
        		int prsRet = proset.getInt(4);
                if (prsRet != 0) {
                	throw new Exception("[USER]" + proset.getString(5));
                }
                
                i=1;  
        	    psql.put("DCS.PR_DMTC601_2_SAP", 5);
        		psql.setString(i++, strSdt);                  //처리년월   
        		psql.setString(i++, strAccntMigDt);           //회계기표일자 
        		psql.setString(i++, strUserId);
        		psql.registerOutParameter(i++, DataTypes.INTEGER);
        		psql.registerOutParameter(i++, DataTypes.VARCHAR); 
        		proset = updateProcedure(psql);
        		
        		psql.close();
        		prsRet = proset.getInt(4);
                if (prsRet != 0) {
                	throw new Exception("[USER]" + proset.getString(5)); 
                }
                
                i=1;  
        	    psql.put("DCS.PR_DMTC601_3_SAP", 5);
        		psql.setString(i++, strSdt);                  //처리년월   
        		psql.setString(i++, strAccntMigDt);           //회계기표일자 
        		psql.setString(i++, strUserId);
        		psql.registerOutParameter(i++, DataTypes.INTEGER);
        		psql.registerOutParameter(i++, DataTypes.VARCHAR);
        		proset = updateProcedure(psql);
        		
        		psql.close();
        		prsRet = proset.getInt(4);
                if (prsRet != 0) {
                	throw new Exception("[USER]" + proset.getString(5));
                }
                 
                ret++;
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

