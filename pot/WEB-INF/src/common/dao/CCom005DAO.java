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

public class CCom005DAO extends AbstractDAO {
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
        
        
        sql.put(svc.getQuery("SEL_BUYERMST"));

        if( !mi.getString("BUYER_CD").equals("") ){
        	if(codeLikeGb)
        		sql.put(svc.getQuery("SEL_BUYERMST_WHERE_LIKE_BUYER_CD"));
        	else
        		sql.put(svc.getQuery("SEL_BUYERMST_WHERE_BUYER_CD"));
        	
            sql.setString(++i, mi.getString("BUYER_CD"));
        }
        if( !mi.getString("BUYER_NAME").equals("") ){
            sql.put(svc.getQuery("SEL_BUYERMST_WHERE_BUYER_NAME"));
            sql.setString(++i, mi.getString("BUYER_NAME"));
        }
        
        if( mi.getString("AUTH_GB").equals("Y") ){
            sql.put(svc.getQuery("SEL_BUYERMST_WHERE_AUTHORITY"));
            authYn = true;
        }

        String addCondition = mi.getString("ADD_CONDITION");

		if (!"".equals(addCondition)) {
			String[] addConds = addCondition.split("#G#");
			for (int idx = 0; idx < addConds.length; idx++) {
				switch(idx){
			        case 0: //사원번호
			            if( authYn ){
			            	sql.setString(++i, addConds[idx].equals("") ? userId : addConds[idx] );
			            	sql.setString(++i, addConds.length > 1 ? (addConds[idx+1].equals("") ? orgFlag : addConds[idx+1]):orgFlag );
			            }
				    	break;
			        case 1: //조직구분
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_BUYERMST_WHERE_ORG_FLAG"));
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
			        case 2: //조직코드
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_BUYERMST_WHERE_ORG_CD"));
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
			        case 3: //정부구분
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_BUYERMST_WHERE_MAIN_FLAG"));
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
			        case 4: //사용여부
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_BUYERMST_WHERE_USE_YN"));
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
			        case 5: //바이어구분
			        	if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
			        		sql.put(svc.getQuery("SEL_BUYERMST_WHERE_BUYER_FLAG"));
			        		sql.setString(++i, addConds[idx] );
			        	}
			        	break;
				}
			}

			if( addConds.length < 1){
				if( authYn ){
	                sql.setString(++i, userId );
	                sql.setString(++i, orgFlag );
	            }
			}
			
		}else{
			if( authYn ){
                sql.setString(++i, userId );
                sql.setString(++i, orgFlag );
            }
		}

        sql.put(svc.getQuery("SEL_BUYERMST_ORDER"));


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
