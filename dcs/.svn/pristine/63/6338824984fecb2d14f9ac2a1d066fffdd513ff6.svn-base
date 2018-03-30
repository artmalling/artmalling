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

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import common.util.Util;
/**
 * <p>EXCEL UPLOAD 적립</p>
 * 
 * @created  on 1.0, 2010/03/29
 * @created  by jinjung.kim
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMbo628DAO extends AbstractDAO {
    
    
    public List searchMaster(ActionForm form) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        String strQuery = "";
        
        String USER_ID = String2.nvl(form.getParam("USER_ID"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService(); 
 
        connect("pot");
        
        int i = 1;
        sql.setString(i++, USER_ID); 

        strQuery = svc.getQuery("SEL_MASTER"); 
        sql.put(strQuery);
        ret = select2List(sql);  
        
        return ret; 
    }

    public int saveData(ActionForm form,MultiInput input) throws Exception {
        
        int      retCode = 0;
        SqlWrapper  sql = null;
        Service     svc = null;
        Util       util = new Util();

        try {

            begin();
            
            connect("pot");
            
            svc  = (Service) form.getService();
            String strQuery = "";

            String REG_ID = String2.nvl(form.getParam("USER_ID"));
            
            input.initNext();
            while (input.next()) 
            {
                /*
            	int i=1;
                sql  = new SqlWrapper();
                
                String BRCH_ID     =  String2.nvl(input.getString("BRCH_ID"));
                String BRCH_NAME   =  String2.nvl(input.getString("BRCH_NAME"));
                String FLAG        =  String2.nvl(input.getString("FLAG"));
                String CARD_NO     =  String2.nvl(input.getString("CARD_NO"));
                String SS_NO       =  String2.nvl(input.getString("SS_NO"));
                String RECP_NO     =  String2.nvl(input.getString("RECP_NO"));
                String SALE_DT     =  String2.nvl(input.getString("SALE_DT"));
                String ADD_POINT   =  String2.nvl(input.getString("ADD_POINT"));
                String CARD_NO_ENC =  util.encryptedStr(String2.nvl(input.getString("CARD_NO")));
                String SS_NO_ENC   =  util.encryptedStr(String2.nvl(input.getString("SS_NO")));
                String ADD_ID      =  String2.nvl(input.getString("ADD_ID"));
                System.out.println("CARD_NO:["+ CARD_NO +"]");
                System.out.println("CARD_NO_ENC:["+ CARD_NO_ENC +"]");
                //sql.setString(i++, BRCH_ID);
                //sql.setString(i++, BRCH_ID);
                sql.setString(i++, SS_NO_ENC);
                sql.setString(i++, SS_NO_ENC);
                sql.setString(i++, CARD_NO_ENC);
                sql.setString(i++, CARD_NO_ENC);
                sql.setString(i++, RECP_NO);
                sql.setString(i++, RECP_NO);
                sql.setString(i++, RECP_NO);
                sql.setString(i++, RECP_NO);
                sql.setString(i++, RECP_NO);
                
                
                strQuery = svc.getQuery("SEL_VALID"); 
                sql.put(strQuery);
                List list = select2List(sql);  
                
                List tmplist = (List) list.get(0);
                int RESULT = (int) Integer.parseInt(tmplist.get(0).toString());
                if (RESULT > 0) {
                    throw new Exception("EXCEL UPLOAD시 유효하지 않은 자료가 검색되었습니다.");
                }
                sql.close();
                */
                
                sql  = new SqlWrapper();
                
                String MOBILE_EMAIL     =  String2.nvl(input.getString("MOBILE_EMAIL"));
                
                int i = 1;
                sql.setString(i++, REG_ID);
                sql.setString(i++, MOBILE_EMAIL);

                strQuery = svc.getQuery("saveData") + "\n";

                sql.put(strQuery);
                
                int result = update(sql);     
                
                if (1 != result) {
                    throw new Exception("EXCEL SMS 미확정 자료 등록시 장애가 발생하였습니다.");
                }
            }
            
        } catch (Exception e) {
            retCode = -1;
            rollback();
            throw e;
        } finally {
            end();
        }
        
        return retCode;
    }     
    
    public int confData(ActionForm form, MultiInput input) throws Exception {
        
        ProcedureWrapper psql = null;
        SqlWrapper sql        = null; 
        Service svc           = null;
        
        ProcedureResultSet prs = null;
        
        int ret = 0;
        int O_RETURN = 0;
        
        try {
            connect("pot");
            begin();
            
            psql = new ProcedureWrapper();
            sql = new SqlWrapper();
            
            svc = (Service) form.getService();

            input.next();
            String REG_ID = input.getString("REG_ID");
            
            int i = 1;
            sql.setString(i++, REG_ID); 
            String strQuery = svc.getQuery("SEL_CONF"); 
            sql.put(strQuery);
            
            List list = select2List(sql); 
            
            for (int j = 0 ; j < list.size(); j++) {
                List tmplist = (List) list.get(j);
                //String BRCH_ID = tmplist.get(1).toString();
                
                i = 1;
                psql.close();
                psql.put("DCS.PR_DMBO628", 3);    
                psql.setString(i++, REG_ID);                       //등록자
                //psql.setString(i++, BRCH_ID);                      //가맹점ID
                psql.registerOutParameter(i++, DataTypes.INTEGER); //O_RETURN
                psql.registerOutParameter(i++, DataTypes.VARCHAR); //O_MESSAGE
                
                prs = updateProcedure(psql);
                
                O_RETURN = prs.getInt(2);        
                System.out.println("O_RETURN:" + O_RETURN);
                
                if (O_RETURN != 0) {
                    ret = -1;
                    throw new Exception("" + "데이터의 적합성 문제로 인하여" + " 데이터 입력을 하지 못했습니다.");
                }
            }
        
        } catch (Exception e) {
            ret = -1;
            rollback();
            throw e;
        } finally {
            end();
        }
        
        return ret;
    } 

  public int dataCheck(ActionForm form, MultiInput mi) throws Exception {
        
        ProcedureWrapper psql = null;
        Service svc           = null;
        ProcedureResultSet prs = null;
        
        int retCode = 0;
        
        try {
            connect("pot");
            begin();
             
            psql = new ProcedureWrapper();   
            svc = (Service) form.getService();
            
            int i = 1;
            psql.put("DCS.PR_DMBO628_CHECK", 2);    
            psql.registerOutParameter(i++, DataTypes.INTEGER); //O_RETURN
            psql.registerOutParameter(i++, DataTypes.VARCHAR); //O_MESSAGE
            
            prs = updateProcedure(psql);
            
        } catch (Exception e) {
        	retCode = -1;
            rollback();
            throw e;
        } finally {
            end();
        } 
        return retCode;
    }

}
