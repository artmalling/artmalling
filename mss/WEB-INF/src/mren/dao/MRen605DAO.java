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
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>메인계량기사용량조회</p>
 * 
 * @created  on 1.0, 2010/03/21
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MRen605DAO extends AbstractDAO {

	 /**
     * <p>조회</p>
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
            String strGaugTp	= String2.nvl(form.getParam("strGaugTp"));	// [조회용]계량기구분
            String strSYmd		= String2.nvl(form.getParam("strSYmd"));	// [조회용]조회시작일
            String strEYmd		= String2.nvl(form.getParam("strEYmd"));	// [조회용]조회시작일
            String strGbn		= String2.nvl(form.getParam("strGbn"));		// [조회용]조회구분

            if (strGaugTp.equals("10")) { //전력
            	if (strGbn.equals("1")) { //시간
            		sql.put(svc.getQuery("SEL_MR_MGAUGUSED_PW_TIME"));
            	} else if (strGbn.equals("2")) { //일
            		sql.put(svc.getQuery("SEL_MR_MGAUGUSED_PW_DAY"));
            	} else { //월
            		sql.put(svc.getQuery("SEL_MR_MGAUGUSED_PW_MONTH"));
            	}
            } else if (strGaugTp.equals("20")) { //온수
            	if (strGbn.equals("1")) { //시간
            		sql.put(svc.getQuery("SEL_MR_MGAUGUSED_WW_TIME"));
            	} else if (strGbn.equals("2")) { //일
            		sql.put(svc.getQuery("SEL_MR_MGAUGUSED_WW_DAY"));
            	} else { //월
            		sql.put(svc.getQuery("SEL_MR_MGAUGUSED_WW_MONTH"));
            	}
            } else { //30: 증기 / 40: 냉수
            	if (strGbn.equals("1")) { //시간
            		sql.put(svc.getQuery("SEL_MR_MGAUGUSED_ST_TIME"));
            	} else if (strGbn.equals("2")) { //일
            		sql.put(svc.getQuery("SEL_MR_MGAUGUSED_ST_DAY"));
            	} else { //월
            		sql.put(svc.getQuery("SEL_MR_MGAUGUSED_ST_MONTH"));
            	}
            }
            
			sql.setString(++i, strSYmd);      
			sql.setString(++i, strEYmd);
			sql.setString(++i, strGaugTp);  
            
            list = select2List(sql);
        } catch (Exception e) {
            throw e;
        }
        return list;
    } 
}
