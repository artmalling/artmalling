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

public class CCom019DAO extends AbstractDAO {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
    
    /**
     * POS번호 조회
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
        
        
        sql.put(svc.getQuery("SEL_POSMST"));

        if( !mi.getString("POS_NO").equals("") ){
        	if(codeLikeGb)
        		sql.put(svc.getQuery("SEL_POSMST_WHERE_LIKE_POS_NO"));
        	else
        		sql.put(svc.getQuery("SEL_POSMST_WHERE_POS_NO"));
        	
            sql.setString(++i, mi.getString("POS_NO"));
        }
        if( !mi.getString("POS_NAME").equals("") ){
            sql.put(svc.getQuery("SEL_POSMST_WHERE_POS_NAME"));
            sql.setString(++i, mi.getString("POS_NAME"));
        }

        String addCondition = mi.getString("ADD_CONDITION");

		if (!"".equals(addCondition)) {
			String[] addConds = addCondition.split("#G#");
			for (int idx = 0; idx < addConds.length; idx++) {
				switch(idx){
			        case 0: //점코드
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_POSMST_WHERE_STR_CD"));
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
			        case 1: //층
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_POSMST_WHERE_FLOR_CD"));
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
			        case 2: //POS구분
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_POSMST_WHERE_POS_FLAG"));
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
			        case 3: //사용여부
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_POSMST_WHERE_USE_YN"));
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
				}
			}
			
		}

        sql.put(svc.getQuery("SEL_POSMST_ORDER"));


        list = select2List(sql);

      } catch (Exception e) {
        throw e;
      }
      return list;
    }
}
