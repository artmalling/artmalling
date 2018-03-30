/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dbri.dao;

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

/** 
 * <p>가맹점 입금 관리</p> 
 * 
 * @created  on 1.0, 2010/02/17
 * @created  by 김영진
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class DBri203DAO extends AbstractDAO {
    /**
     * <p>가맹점 입금 관리 조회</p>
     * 
     */
    public List searchMaster(ActionForm form) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        
        String strBrchId   = String2.nvl(form.getParam("strBrchId"));
        String strMonth    = String2.nvl(form.getParam("strMonth"));
        String strCompNo   = String2.nvl(form.getParam("strCompNo"));
        String strFlag     = String2.nvl(form.getParam("strFlag"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strMonth);
        sql.setString(i++, strMonth);
        sql.setString(i++, strMonth);
        sql.setString(i++, strMonth);
        sql.setString(i++, strBrchId);
        sql.setString(i++, strCompNo);  
        
        if(strFlag.equals("%")){
            sql.setString(i++, strMonth);
            sql.setString(i++, strMonth); 
            sql.setString(i++, strMonth);
            sql.setString(i++, strMonth);
            sql.setString(i++, strBrchId);
            sql.setString(i++, strCompNo);
        	strQuery = svc.getQuery("SEL_MASTER_ALL");
        }else if(strFlag.equals("1")){
        	strQuery = svc.getQuery("SEL_MASTER_NO");
        }else if(strFlag.equals("2")){
            strQuery = svc.getQuery("SEL_MASTER_YES");
        }
        
        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    }

    /**
     * <p>가맹점입금관리 저장 - 프로시져 콜</p>
     * 
     */
    public int save(ActionForm form, MultiInput mi, String userId) throws Exception {
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
            
            while (mi.next()) {
                
                psql.close();
                if (mi.IS_INSERT()) { // 저장
                    int i=1;
                    psql.put("DCS.PR_DBRI203", 7);    
                    psql.setString(i++, mi.getString("BRCH_ID"));   //가맹점ID
                    psql.setString(i++, mi.getString("S_DT"));      //적립시작일
                    psql.setString(i++, mi.getString("E_DT"));      //적립종료일
                    psql.setString(i++, mi.getString("REAL_DT"));   //실입금일자 
                    psql.setString(i++, userId);                    //로그인ID

                    psql.registerOutParameter(i++, DataTypes.INTEGER);//6
                    psql.registerOutParameter(i++, DataTypes.VARCHAR);//7
                    prs = updateProcedure(psql);
                    
                    res += prs.getInt(6);        
                }
                if (res != 0) {
                	throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
                            + "데이터 입력을 하지 못했습니다.");
                }
                ret = mi.getRowNum();        
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
