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
 * @created  on 1.0, 2010/02/16
 * @created  by 정진영(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class CCom222DAO extends AbstractDAO {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
    
    /**
     * 품목코드( 품목별) 조회
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
        
        
        sql.put(svc.getQuery("SEL_PBNPMK_SRT"));
        sql.setString(++i, mi.getString("PUMBUN_CD"));
        
        if( !mi.getString("PUMMOK_SRT_CD").equals("") ){
        	if(codeLikeGb)
        		sql.put(svc.getQuery("SEL_PBNPMK_SRT_WHERE_LIKE_PUMMOK_SRT_CD"));
        	else
        		sql.put(svc.getQuery("SEL_PBNPMK_SRT_WHERE_PUMMOK_SRT_CD"));
        	
            sql.setString(++i, mi.getString("PUMMOK_SRT_CD"));
        }
        if( !mi.getString("PUMMOK_NM").equals("") ){
            sql.put(svc.getQuery("SEL_PBNPMK_SRT_WHERE_PUMMOK_NM"));
            sql.setString(++i, mi.getString("PUMMOK_NM"));
        }
        
        String addCondition = mi.getString("ADD_CONDITION");

		if (!"".equals(addCondition)) {
			String[] addConds = addCondition.split("#G#");
			for (int idx = 0; idx < addConds.length; idx++) {
				switch(idx){
				    case 0: //신선제품여부
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_PBNPMK_SRT_WHERE_FRESH_YN"));
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
				    case 1:  //사용여부
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_PBNPMK_SRT_WHERE_USE_YN"));
				            sql.setString(++i, addConds[idx]);
				            sql.setString(++i, addConds[idx]);
				        }
				    	break;
					
				}
			}
			
		}

        sql.put(svc.getQuery("SEL_PBNPMK_SRT_ORDER"));


        list = select2List(sql);

      } catch (Exception e) {
        throw e;
      }
      return list;
    }
    

    /**
     * 품목코드( 품번별)콤보 조회
     *
     * @param  : 
     * @return :
     */
    public List searchCombo(ActionForm form, MultiInput mi) throws Exception {
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
        
        sql.put(svc.getQuery("SEL_PBNPMK_SRT_COMBO"));
        sql.setString(++i, mi.getString("PUMBUN_CD"));
        if( !mi.getString("USE_YN").equals("")){
            sql.put(svc.getQuery("SEL_PBNPMK_SRT_COMBO_WHERE_USE_YN"));
            sql.setString(++i, mi.getString("USE_YN"));        	
        }
        sql.put(svc.getQuery("SEL_PBNPMK_SRT_COMBO_ORDER"));        
        list = select2List(sql);

      } catch (Exception e) {
        throw e;
      }
      return list;
    }
}
