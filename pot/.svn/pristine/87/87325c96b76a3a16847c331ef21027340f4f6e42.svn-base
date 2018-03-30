/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package common.dao;

import java.util.List;


import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;


/**
 * <p>공통으로 사용되는  DAO</p>
 * 
 * @created  on 1.0, 2010/02/17
 * @created  by 정진영(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class CCom014DAO extends AbstractDAO {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
    
    /**
     * 행사테마 조회
     *
     * @param  : 
     * @return :
     */
    public List searchOnPop(ActionForm form, MultiInput mi, boolean codeLikeGb) throws Exception {
      List list = null;
      SqlWrapper sql = null;
      Service svc = null;
      int i;
      try {
        connect("pot");
        
        svc = (Service) form.getService();
        sql = new SqlWrapper();
        
        i=0;
        mi.next();
        
        
        sql.put(svc.getQuery("SEL_EVTTHEM"));

        if( !mi.getString("EVENT_THME_CD").equals("") ){
        	if(codeLikeGb)
        		sql.put(svc.getQuery("SEL_EVTTHEM_WHERE_LIKE_EVENT_THME_CD"));
        	else
        		sql.put(svc.getQuery("SEL_EVTTHEM_WHERE_EVENT_THME_CD"));
        	
            sql.setString(++i, mi.getString("EVENT_THME_CD"));
        }
        if( !mi.getString("EVENT_THME_NAME").equals("") ){
            sql.put(svc.getQuery("SEL_EVTTHEM_WHERE_EVENT_THME_NAME"));
            sql.setString(++i, mi.getString("EVENT_THME_NAME"));
        }

        String addCondition = mi.getString("ADD_CONDITION");

		if (!"".equals(addCondition)) {
			String[] addConds = addCondition.split("#G#");
			for (int idx = 0; idx < addConds.length; idx++) {
				switch(idx){
			        case 0: //사용여부
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_EVTTHEM_WHERE_USE_YN"));
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
			        case 1: //테마레벨
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_EVTTHEM_WHERE_EVENT_THME_LEVEL"));
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
				}
			}
			
		}

        sql.put(svc.getQuery("SEL_EVTTHEM_ORDER"));


        list = select2List(sql);

      } catch (Exception e) {
        throw e;
      }
      return list;
    }
}
