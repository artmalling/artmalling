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

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;

/**
 * <p>최종발번번호조회</p>
 * 
 * @created  on 1.0, 2010/03/23
 * @created  by 김영진
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class DCtm212DAO extends AbstractDAO {

	/**
     * <p>초기 Prefix 조회</p>
     * 
     */
    public List getPrefix(ActionForm form) throws Exception {
    	
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();
 
        connect("pot"); 
        sql.put(svc.getQuery("SEL_PREFIX"));
        ret = select2List(sql);
        return ret; 
    }
    
    /**
     * <p>최종발번번호조회</p>
     * 
     */
    public List searchMaster(ActionForm form) throws Exception {

        ProcedureWrapper  psql = null;
        ProcedureResultSet prs = null;
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;

        connect("pot"); 
        begin();
        psql = new ProcedureWrapper();     
        sql  = new SqlWrapper();
        svc  = (Service) form.getService();
        
        //임시테이블 생성
        psql.put("DCS.PR_DCTM212", 2);   
        psql.registerOutParameter(1, DataTypes.INTEGER);   
        psql.registerOutParameter(2, DataTypes.VARCHAR);   
        
        prs = updateProcedure(psql);

        //임시테이블 조회
        sql.put(svc.getQuery("SEL_MASTER")); 
     
        ret = select2List(sql);
        
        return ret; 
    }
}

