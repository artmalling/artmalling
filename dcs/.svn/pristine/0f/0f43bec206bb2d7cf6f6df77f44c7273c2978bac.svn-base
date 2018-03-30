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
import java.util.Map;

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>특별포인트적립기준</p>
 * 
 * @created  on 1.0, 2012.06.05
 * @created  by 강진
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class DMbo632DAO extends AbstractDAO {

	/**
     * <p>특별포인트적립기준  마스터 조회</p>
     * 
     */
    public List searchMaster(ActionForm form) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        String strQuery = "";
        int i = 1;
        String strMemoDateF = String2.nvl(form.getParam("strMemoDateF"));
        String strMemoDateT = String2.nvl(form.getParam("strMemoDateT"));
        String strPointPlusGb = String2.nvl(form.getParam("strPointPlusGb"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strPointPlusGb);
        sql.setString(i++, strMemoDateT);
        sql.setString(i++, strMemoDateF); 
        
        strQuery = svc.getQuery("SEL_MASTER") + "\n";
        
        sql.put(strQuery);
        ret = select2List(sql);
        return ret; 
    }
 
    /**
     * <p>특별포인트적립기준  상세 조회</p>
     * 
     */
    public List searchDetail(ActionForm form) throws Exception {
        List       ret      = null;
        SqlWrapper sql      = null;
        Service    svc      = null;
        String     strQuery = "";
        int i = 1;
        
        String strBrchId 		= String2.nvl(form.getParam("strBrchId"));
        String strPointPlusGb 	= String2.nvl(form.getParam("strPointPlusGb"));
        String strMemoDateF 	= String2.nvl(form.getParam("strMemoDateF"));

        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");
 
        sql.setString(i++, strBrchId);
        sql.setString(i++, strPointPlusGb);
        sql.setString(i++, strMemoDateF);
        
        strQuery = svc.getQuery("SEL_DETAIL"); 
        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    } 
    
    /**
     *  특별포인트적립기준을  저장, 수정 처리한다.
     * 
     * @param form
     * @param mi
     * @param strID
     * @return
     * @throws Exception
     */
    public String save(ActionForm form, MultiInput mi, String userId)
    throws Exception {
        
        String ret = null;
        //int ret = 0;
        int res = 0;
        SqlWrapper sql = null;
        Service svc    = null;
        
        try {
            connect("pot");
            begin();
            sql = new SqlWrapper();
            svc = (Service) form.getService();
            
            while (mi.next()) {
                if (mi.IS_INSERT()) { // 저장
                	
                	if( searchTermChk(form, mi) > 0) {
                		throw new Exception("[USER]"+"기간을 확인하세요.");
                	}                  	
                	
                    int i=1;
                    sql.put(svc.getQuery("INS_DO_PADD_PLUS_RULE")); 
                    sql.setString(i++, mi.getString("BRCH_ID"));       	//가맹점번호
                    sql.setString(i++, mi.getString("POINT_PLUS_GB")); 	//포인트구분
                    sql.setString(i++, mi.getString("START_DT"));      	//시작일자
                    sql.setString(i++, mi.getString("END_DT"));        	//종료일자
                    sql.setString(i++, mi.getString("PLUS_POINT"));     //적립포인트                 
                    sql.setString(i++, userId);                         //로그인ID
                    
                }else if(mi.IS_UPDATE()){// 수정
                	
                	if( searchTermChk(form, mi) > 1) {
                		throw new Exception("[USER]"+"기간을 확인하세요.");
                	}   
                	
                    int i=1;
                    sql.put(svc.getQuery("UPD_DO_PADD_PLUS_RULE")); 
                    sql.setString(i++, mi.getString("END_DT"));        	//종료일자
                    sql.setString(i++, mi.getString("PLUS_POINT"));     //적립포인트                               
                    sql.setString(i++, userId);                         //로그인ID                    
                    sql.setString(i++, mi.getString("BRCH_ID"));       	//가맹점번호
                    sql.setString(i++, mi.getString("POINT_PLUS_GB")); 	//포인트구분
                    sql.setString(i++, mi.getString("START_DT"));      	//시작일자
                }
                res = update(sql);
                if (res != 1) {
                	throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
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
     * <p>특별포인트적립기준 기간체크</p>
     * 
     */
    public int searchTermChk(ActionForm form, MultiInput mi) throws Exception {
    	int ret 		= 0;
        SqlWrapper sql  = null;
        Service svc     = null;

        sql = new SqlWrapper();
        svc = (Service) form.getService();
        
        connect("pot");
        
        sql.put(svc.getQuery("SEL_DO_PADD_PLUS_RULE"));
        sql.setString(1, mi.getString("BRCH_ID"));
        sql.setString(2, mi.getString("POINT_PLUS_GB"));
        sql.setString(3, mi.getString("END_DT"));
        sql.setString(4, mi.getString("START_DT"));
        
        Map map = selectMap( sql );
    	ret = Integer.parseInt(map.get("CNT").toString());
    	
        return ret;
    }   
}
