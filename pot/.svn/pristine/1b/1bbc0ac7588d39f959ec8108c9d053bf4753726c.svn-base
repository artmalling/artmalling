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
 * @created  on 1.0, 2010/02/18
 * @created  by 정진영(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class CCom001DAO extends AbstractDAO {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
    
    /**
     * 거래선코드   조회
     *
     * @param  : 
     * @return :
     */
    public List searchOnPop(ActionForm form, MultiInput mi, boolean codeLikeGb ) throws Exception {
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
        
        sql.put(svc.getQuery("WITH_ACCVEN"));
        sql.put(svc.getQuery("SEL_ACCVEN"));
        sql.setString(++i, mi.getString("ACC_VEN_FLAG"));

        if( !mi.getString("ACC_VEN_CD").equals("") ){
        	if(codeLikeGb)
        		sql.put(svc.getQuery("SEL_ACCVEN_WHERE_LIKE_ACC_VEN_CD"));
        	else
        		sql.put(svc.getQuery("SEL_ACCVEN_WHERE_ACC_VEN_CD"));
        	
            sql.setString(++i, mi.getString("ACC_VEN_CD"));
        }
        if( !mi.getString("ACC_VEN_NAME").equals("") ){
            sql.put(svc.getQuery("SEL_ACCVEN_WHERE_NAME1"));
            sql.setString(++i, mi.getString("ACC_VEN_NAME"));
        }
        
        String addCondition = mi.getString("ADD_CONDITION");        
		if (!"".equals(addCondition)) {
			String[] addConds = addCondition.split("#G#");
			for (int idx = 0; idx < addConds.length; idx++) {
				switch(idx){
			        case 0: //사업자번호
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_ACCVEN_WHERE_STCD2"));
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
				}
			}
			
		} 

        sql.put(svc.getQuery("SEL_ACCVEN_ORDER"));


        list = select2List(sql);

      } catch (Exception e) {
        throw e;
      }
      return list;
    }
}
