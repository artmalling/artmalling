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
 * @created  on 1.0, 2010/02/15
 * @created  by 정진영(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class CCom007DAO extends AbstractDAO {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
    
    /**
     * 조직코드 조회
     *
     * @param  : 
     * @return :
     */
    public List searchOnPop(ActionForm form, MultiInput mi, boolean codeLikeGb, String userId, String orgFlag) throws Exception {
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
        
        sql.put(svc.getQuery("SEL_ORGMST"));
        if( !mi.getString("ORG_CD").equals("") ){
        	if(codeLikeGb)
        		sql.put(svc.getQuery("SEL_ORGMST_WHERE_LIKE_ORG_CD"));
        	else
        		sql.put(svc.getQuery("SEL_ORGMST_WHERE_ORG_CD"));
        	
            sql.setString(++i, mi.getString("ORG_CD"));
        }
        if( !mi.getString("ORG_NM").equals("") ){
            sql.put(svc.getQuery("SEL_ORGMST_WHERE_ORG_NM"));
            sql.setString(++i, mi.getString("ORG_NM"));
        }

        if( mi.getString("AUTH_GB").equals("Y") ){
            sql.put(svc.getQuery("SEL_ORGMST_WHERE_AUTHORITY"));
            authYn = true;
        }

        String addCondition = mi.getString("ADD_CONDITION");

		if (!"".equals(addCondition)) {
			boolean pOrgCdYn = false;
			String[] addConds = addCondition.split("#G#");
			if (addConds.length >= 2){
				orgFlag = addConds[2];
			}
            
			for (int idx = 0; idx < addConds.length; idx++) {
				switch(idx){
				    case 0: //사원번호
			            if( authYn ){
			            	sql.setString(++i, addConds[idx].equals("") ? userId : addConds[idx] );
			            	sql.setString(++i, addConds.length > 1 ? (addConds[idx+1].equals("") ? orgFlag : addConds[idx+1]):orgFlag );
			            }
				    	break;
				    case 1: //상위조직
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_ORGMST_START_WITH"));
				            sql.setString(++i, addConds[idx] );
				            pOrgCdYn = true;
				        }
				    	break;
				    case 2:  //조직구분
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_ORGMST_WHERE_ORG_FLAG"));
				            sql.setString(++i, addConds[idx]);
				        }
				    	break;
				    case 3: //조직레벨
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_ORGMST_WHERE_ORG_LVL"));
				            sql.setString(++i, addConds[idx]);
				        }
				    	break;
				    case 4: //사용여부
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_ORGMST_WHERE_USE_YN"));
				            sql.setString(++i, addConds[idx]);
				        }
				    	break;
				    case 5: //점코드
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_ORGMST_WHERE_STR_CD"));
				            sql.setString(++i, addConds[idx]);
				        }
				    	break;
				    case 6: //코스트센터 코드
				        if( (addConds[3].equals("4") || addConds[3].equals("5")) && !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_ORGMST_WHERE_KOSTL_CD"));
				            sql.setString(++i, addConds[idx]);
				        }
				    	break;
				    	
				}
			}
			if(pOrgCdYn)
	            sql.put(svc.getQuery("SEL_ORGMST_CONNECT_BY"));

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

        sql.put(svc.getQuery("SEL_ORGMST_ORDER"));


        list = select2List(sql);

      } catch (Exception e) {
        throw e;
      }
      return list;
    }
}
