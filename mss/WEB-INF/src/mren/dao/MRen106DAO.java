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
 * <p></p>
 * 
 * @created  on 1.0, 2010.03.25
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MRen106DAO extends AbstractDAO {

	 /**
     * <p>도시가스요금표 내역조회</p>
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
            sql.put(svc.getQuery("SEL_MR_GASPRC"));
            sql.setString(++i, String2.nvl(form.getParam("strGasKind")));	// [조회용]용도구분       	       
            sql.setString(++i, String2.nvl(form.getParam("strGasKindDtl")));// [조회용]용도구분상세              
            sql.setString(++i, String2.nvl(form.getParam("strAreaFlag"))); 	// [조회용]지역구분             
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
                //if (mi.IS_INSERT()||mi.IS_UPDATE()) {
            	if (mi.IS_INSERT()) {
                	if (loopCnt == 0)  {
                		sql.put(svc.getQuery("SEL_DUP_KEYVALUE"));
                	} else {
                		sql.put(svc.getQuery("SEL_DUP_UNIONALL"));
                	}
                	sql.put(svc.getQuery("SEL_SUB_DUP_KEYVALUE"));
            		sql.setString(++i ,mi.getString("APP_S_MM")); 
            		sql.setString(++i ,mi.getString("AREA_FLAG")); 
            		sql.setString(++i ,mi.getString("GAS_KIND_CD")); 
            		sql.setString(++i ,mi.getString("GAS_KIND_DTL_CD")); 
            		sql.setString(++i ,mi.getString("APP_S_MM"));
            		sql.setString(++i ,mi.getString("APP_S_MM")); 
            		sql.setString(++i ,mi.getString("APP_E_MM"));
            		sql.setString(++i ,mi.getString("APP_E_MM"));
            		/*
            		if (mi.IS_UPDATE()) {
            			sql.put(svc.getQuery("SEL_DUP_UPDATE"));
            			sql.setString(++i ,mi.getString("SEQ")); 
            		}
            		*/
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
     * <p>도시가스요금표 저장</p>
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
                	sql.put(svc.getQuery("INS_MR_GASPRC"));
                	int i = 0;
                    sql.setString(++i, mi.getString("AREA_FLAG"));
                    sql.setString(++i, mi.getString("GAS_KIND_CD"));
                    sql.setString(++i, mi.getString("GAS_KIND_DTL_CD"));
                    sql.setString(++i, mi.getString("AREA_FLAG"));
                    sql.setString(++i, mi.getString("GAS_KIND_CD"));
                    sql.setString(++i, mi.getString("GAS_KIND_DTL_CD"));
                    sql.setString(++i, mi.getString("APP_S_MM"));
                    sql.setString(++i, mi.getString("APP_E_MM"));
                    sql.setString(++i, mi.getString("BAS_PRC"));
                    sql.setString(++i, mi.getString("UNIT_PRC"));
                    sql.setString(++i, mi.getString("GAS_REDU1_PRC"));
                    sql.setString(++i, mi.getString("GAS_REDU2_PRC"));
                    //session의 사용자 ID
                    sql.setString(++i, userID);   
                    sql.setString(++i, userID);
                    res = update(sql);
                } else if (mi.IS_UPDATE()) {
                	sql.put(svc.getQuery("UPD_MR_GASPRC"));
                	int i = 0;
                    sql.setString(++i, mi.getString("APP_S_MM"));
                    sql.setString(++i, mi.getString("APP_E_MM"));
                    sql.setString(++i, mi.getString("BAS_PRC"));
                    sql.setString(++i, mi.getString("UNIT_PRC"));
                    sql.setString(++i, mi.getString("GAS_REDU1_PRC"));
                    sql.setString(++i, mi.getString("GAS_REDU2_PRC"));
                    sql.setString(++i, userID); 
                    sql.setString(++i, mi.getString("AREA_FLAG"));
                    sql.setString(++i, mi.getString("GAS_KIND_CD"));
                    sql.setString(++i, mi.getString("GAS_KIND_DTL_CD"));
                    sql.setString(++i, mi.getString("SEQ"));
                    res = update(sql);
                } else {
                	sql.put(svc.getQuery("DEL_MR_GASPRC"));
                	int i = 0;
                    sql.setString(++i, mi.getString("AREA_FLAG"));
                    sql.setString(++i, mi.getString("GAS_KIND_CD"));
                    sql.setString(++i, mi.getString("GAS_KIND_DTL_CD"));
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
    
	/**
	 * <p>공통코드</p>
	 */
	@SuppressWarnings("rawtypes")
	public List getEtcCodeSub(ActionForm form) throws Exception {
		
		List       list = null;
		SqlWrapper  sql = null;
		Service     svc = null;
		try {
			connect("pot");
			svc  = (Service)form.getService();
			sql  = new SqlWrapper();
			int i = 0;
			String strEtcCode	= String2.nvl(form.getParam("strEtcCode"));	// 공통코드(코드)
			
			sql.put(svc.getQuery("SEL_TC_COMMCODE"));
			sql.setString(++i, strEtcCode);              
			list = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return list;
	}
}
