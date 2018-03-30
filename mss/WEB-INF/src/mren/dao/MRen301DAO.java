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

public class MRen301DAO extends AbstractDAO {

	 /**
     * <p>월 직접사용량 조회</p>
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
            String strFclCd		= String2.nvl(form.getParam("strFclCd"));	// [조회용]시설구분
            String strGoalYm	= String2.nvl(form.getParam("strGoalYm"));	// [조회용]부과년월
            String strVenCd		= String2.nvl(form.getParam("strVenCd"));	// [조회용]협력사

			sql.put(svc.getQuery("SEL_MR_GAUGMST"));
			sql.setString(++i, strGoalYm);      
			sql.setString(++i, strFclCd);         
			sql.setString(++i, strFclCd);     
			sql.setString(++i, strGoalYm);
			sql.setString(++i, strVenCd);  
            
            list = select2List(sql);
        } catch (Exception e) {
            throw e;
        }
        return list;
    } 
}
