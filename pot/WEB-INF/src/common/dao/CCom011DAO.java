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

public class CCom011DAO extends AbstractDAO {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
    
    /**
     * 대표 품번 조회
     *
     * @param  : 
     * @return :
     */
    public List searchOnPop(ActionForm form, MultiInput mi, boolean codeLikeGb, String userId) throws Exception {
      List list = null;
      SqlWrapper sql = null;
      Service svc = null;
      boolean authYn = false;
      String strCd = "";
      String orgCd = "";
      String buyerCd = "";
      String buySaleFlag = "";
      int i;
      try {
        connect("pot");
        
        svc = (Service) form.getService();
        sql = new SqlWrapper();
        
        i=0;
        mi.next();
        
        
        sql.put(svc.getQuery("SEL_STRPBN"));

        if( !mi.getString("PUMBUN_CD").equals("") ){
        	if(codeLikeGb)
        		sql.put(svc.getQuery("SEL_STRPBN_WHERE_LIKE_PUMBUN_CD"));
        	else
        		sql.put(svc.getQuery("SEL_STRPBN_WHERE_PUMBUN_CD"));
        	
            sql.setString(++i, mi.getString("PUMBUN_CD"));
        }
        if( !mi.getString("PUMBUN_NM").equals("") ){
            sql.put(svc.getQuery("SEL_STRPBN_WHERE_PUMBUN_NM"));
            sql.setString(++i, mi.getString("PUMBUN_NM"));
        }
        
        if( mi.getString("AUTH_GB").equals("Y") ){
            sql.put(svc.getQuery("SEL_STRPBN_WHERE_AUTHORITY"));
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
			            }
			    	    break;
				    case 1: //점코드
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				        	strCd = addConds[idx];
				        }
				    	break;
				    case 2:  //조직코드
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				        	orgCd = addConds[idx];
				        }
				    	break;
				    case 3:  //협력사코드
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_STRPBN_WHERE_VEN_CD"));
				            sql.setString(++i, addConds[idx]);
				        }
				    	break;
				    case 4:  //바이어코드
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				        	buyerCd = addConds[idx];
				        }
				    	break;
				    case 5:  //품번유형
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_STRPBN_WHERE_PUMBUN_TYPE"));
				            sql.setString(++i, addConds[idx]);
				        }
				    	break;
				    case 6:  //사용여부
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_STRPBN_WHERE_USE_YN"));
				            sql.setString(++i, addConds[idx]);
				        }
				    	break;
				    case 7:  //거래형태
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_STRPBN_WHERE_BIZ_TYPE"));
				            sql.setString(++i, addConds[idx]);
				        }
				    	break;
				    case 8:  //매입매출구분
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				        	buySaleFlag =  addConds[idx];
				        }
				    	break;
				}
			}


			if( addConds.length < 1){
				if( authYn ){
	                sql.setString(++i, userId );
	            }
			}
		}else{
			if( authYn ){
                sql.setString(++i, userId );
            }
		}	
		if(!strCd.equals("")){
            sql.put(svc.getQuery("SEL_STRPBN_WHERE_STR_CD_S"));
            sql.setString(++i, strCd );
            if(!orgCd.equals("")){
                sql.put(svc.getQuery("SEL_STRPBN_WHERE_ORG_CD"));
                sql.setString(++i, orgCd );
                sql.setString(++i, orgCd );
            	
            }
            if(!buyerCd.equals("")){
                sql.put(svc.getQuery("SEL_STRPBN_WHERE_BUYER_CD"));
                sql.setString(++i, buyerCd );
                sql.setString(++i, buyerCd );
            	
            }
            if(!buySaleFlag.equals("")){
                sql.put(svc.getQuery("SEL_STRPBN_WHERE_BUY_SALE_FLAG"));
                sql.setString(++i, buySaleFlag );
            	
            }
            sql.put(svc.getQuery("SEL_STRPBN_WHERE_STR_CD_E"));
		}
        sql.put(svc.getQuery("SEL_STRPBN_ORDER"));


        list = select2List(sql);

      } catch (Exception e) {
        throw e;
      }
      return list;
    }
}
