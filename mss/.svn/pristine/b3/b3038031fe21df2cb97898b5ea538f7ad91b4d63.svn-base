/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mpro.dao;

import java.util.List;

import common.util.Util;
//import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MPro203DAO extends AbstractDAO {
	
	/**
	 * <p>조회</p>
	 * 
	 */
	
	public List getMaster(ActionForm form) throws Exception {

        List       list = null;
        SqlWrapper  sql = null;
        Service     svc = null;        
        int i = 0;
        
        try {
            
        	connect("pot");
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
            

            String strCd		    = String2.nvl(form.getParam("strCd"));	//점코드
            String em_sDate         = String2.nvl(form.getParam("em_sDate"));	//기간 시작일
            String em_eDate	        = String2.nvl(form.getParam("em_eDate"));	//기간 종료일
            String userid			= String2.nvl(form.getParam("userid"));	//사용자
            
            sql.put(svc.getQuery("SEL_DAY_PROMISS"));
            sql.setString(++i, strCd);   
            sql.setString(++i, em_sDate);
            sql.setString(++i, em_eDate);
            sql.setString(++i, userid); 
            sql.setString(++i, strCd);   
            sql.setString(++i, em_sDate);
            sql.setString(++i, em_eDate);
            sql.setString(++i, userid);
             
            list = select2List(sql); 
           

        } catch (Exception e) {
            throw e;
        }
        return list;
    }
	

}
