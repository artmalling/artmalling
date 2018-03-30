/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */
package mren.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>전력요금표관리(주택용)</p>
 * 
 * @created  on 1.0, 2010/03/21
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MRen104DAO extends AbstractDAO {

	 /**
     * <p>전력요금표 내역조회</p>
     */
    @SuppressWarnings("rawtypes")
    public List getMaster(ActionForm form) throws Exception {

    	List       list = null;
        SqlWrapper  sql = null;
        Service     svc = null;
        try {
            connect("pot");
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
            int i = 0;
            //parameters
            String strPwrType	= String2.nvl(form.getParam("strPwrType"));	// [조회용]전압구분

            sql.put(svc.getQuery("SEL_MR_POWERPRCH"));
            sql.setString(++i, strPwrType);              
            list = select2List(sql);
        } catch (Exception e) {
            throw e;
        }
        return list;
    }
    
    /**
     * <p>중복키값조회</p>
     */
    @SuppressWarnings("rawtypes")
    public List getDupKeyValue(ActionForm form, MultiInput mi) throws Exception {
    	
    	List       list = null;
    	SqlWrapper  sql = null;
    	Service     svc = null;
    	try {
    		connect("pot");
    		svc  = (Service)form.getService();
    		sql  = new SqlWrapper();
    		int loopCnt = 0;
    		int i = 0;
    		
    	    while (mi.next()) {
                if (mi.IS_INSERT() || mi.IS_UPDATE()) {
                	if (loopCnt == 0)  {
                		sql.put(svc.getQuery("SEL_DUP_KEYVALUE"));
                	} else {
                		sql.put(svc.getQuery("SEL_DUP_UNIONALL"));
                	}
                	sql.put(svc.getQuery("SEL_SUB_DUP_KEYVALUE"));
            		sql.setString(++i ,mi.getString("USE_S_QTY"));     
            		sql.setString(++i ,mi.getString("USE_S_QTY"));     
            		sql.setString(++i ,mi.getString("USE_S_QTY"));     
            		sql.setString(++i ,mi.getString("USE_E_QTY"));     
            		sql.setString(++i ,mi.getString("USE_E_QTY"));     
            		sql.setString(++i ,mi.getString("PWR_TYPE")); 
            		
                	if ( mi.IS_UPDATE()) {
                		sql.put(svc.getQuery("SEL_SUB_DUP_KEYVALUE_UPDATE"));
                		sql.setString(++i ,mi.getString("SEQ")); 
                	}
                	loopCnt++;
                } 
    	    }
    	    
    	    if (sql != null) sql.put(svc.getQuery("SEL_DUP_CLOSE"));
    	    list = select2List(sql);
    	} catch (Exception e) {
    		throw e;
    	}
    	return list;
    }
    
    /**
     * <p>전력요금표 저장</p>
     */
    public int save(ActionForm form, MultiInput mi, String userID)
    throws Exception {
        int ret = 0;
        int res = 0;
        SqlWrapper sql = null;
        Service svc = null;
        try {
            connect("pot");
            begin(); //DB트렌젝션 시작
            sql = new SqlWrapper();
            svc = (Service) form.getService();
            while (mi.next()) {
            	sql.close();
                if (mi.IS_INSERT()) {
                	sql.put(svc.getQuery("INS_MR_POWERPRCH"));
                	int i = 0;
                    sql.setString(++i, mi.getString("PWR_TYPE"));
                    sql.setString(++i, mi.getString("PWR_TYPE"));
                    sql.setString(++i, mi.getString("USE_S_QTY"));
                    sql.setString(++i, mi.getString("USE_E_QTY"));
                    sql.setString(++i, mi.getString("BAS_PRC"));
                    sql.setString(++i, mi.getString("UNIT_PRC"));
                    sql.setString(++i, mi.getString("REMARK"));
                    //session의 사용자 ID
                    sql.setString(++i, userID);   
                    sql.setString(++i, userID);
                    res = update(sql);
                } else if (mi.IS_UPDATE()) {
                	sql.put(svc.getQuery("UPD_MR_POWERPRCH"));
                	int i = 0;
                	sql.setString(++i, mi.getString("USE_S_QTY"));
                    sql.setString(++i, mi.getString("USE_E_QTY"));
                    sql.setString(++i, mi.getString("BAS_PRC"));
                    sql.setString(++i, mi.getString("UNIT_PRC"));
                    sql.setString(++i, mi.getString("REMARK"));
                    sql.setString(++i, userID); 
                    sql.setString(++i, mi.getString("PWR_TYPE"));
                    sql.setString(++i, mi.getString("SEQ"));
                    res = update(sql);
                } else {
                	sql.put(svc.getQuery("DEL_MR_POWERPRCH"));
                	int i = 0;
                    sql.setString(++i, mi.getString("PWR_TYPE"));
                    sql.setString(++i, mi.getString("SEQ"));
                    res = update(sql);
                }
                
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
