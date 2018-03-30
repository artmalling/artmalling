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
import kr.fujitsu.ffw.util.String2;


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

public class CCom026DAO extends AbstractDAO {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
    
    /**
     * 바이어(SM)코드 조회
     *
     * @param  : 
     * @return :
     */
    public List searchOnPop(ActionForm form, MultiInput mi, boolean codeLikeGb, String userId, String orgFlag ) throws Exception {
      List list = null;
      SqlWrapper sql = null;
      Service svc = null;
      boolean authYn = false;
      int i;
      try {
        connect("pot");
        
        svc = (Service) form.getService();
        sql = new SqlWrapper();
        
        i=0;
        mi.next();
        
        System.out.println("orgFlag:::"+orgFlag);
        if("1".equals(orgFlag))			// 판매조직일 경우 
        	sql.put(svc.getQuery("SEL_BUYERMST_SALE"));
        else if("2".equals(orgFlag))	// 매입조직일 경우
        	sql.put(svc.getQuery("SEL_BUYERMST_BUY"));


        String addCondition = mi.getString("ADD_CONDITION");

		if (!"".equals(addCondition)) {
			String[] addConds = addCondition.split("#G#");
			for (int idx = 0; idx < addConds.length; idx++) {
				System.out.println("addConds:"+addConds.length+"::idx:"+idx);
				switch(idx){
			        case 2: //조직코드
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
			     }
			}
		}
        
		sql.setString(++i, userId);
		sql.setString(++i, orgFlag);
        sql.setString(++i, mi.getString("BUYER_CD"));
        sql.setString(++i, mi.getString("BUYER_NAME"));
        list = select2List(sql);

      } catch (Exception e) {
        throw e;
      }
      return list;
    }

    /**
     * 정 바이어(SM)코드 조회
     *
     * @param  : 
     * @return :
     */
    public List searchMainBuyer(ActionForm form) throws Exception {
      List list = null;
      SqlWrapper sql = null;
      Service svc = null;
      int i;
      try {
        connect("pot");
        
        svc = (Service) form.getService();
        sql = new SqlWrapper();
		String strOrgCd = String2.nvl(form.getParam("strOrgCd"));
		String orgFlag = String2.nvl(form.getParam("orgFlag"));
        
        i=0;
        
        sql.put(svc.getQuery("SEL_MAIN_BUYER"));
        sql.setString(++i, orgFlag );
        sql.setString(++i, strOrgCd );
        
        list = select2List(sql);

      } catch (Exception e) {
        throw e;
      }
      return list;
    }
}
