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

public class CCom003DAO extends AbstractDAO {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
    
    /**
     * 단품코드(의류단품B) 조회
     *
     * @param  : 
     * @return :
     */
    public List searchOnPop(ActionForm form, MultiInput mi, boolean codeLikeGb , String userId, String orgFlag ) throws Exception {
      List list = null;
      SqlWrapper sql = null;
      Service svc = null;
      boolean authYn = false;
      String strCd = "";
      String buyDt = "";
      int i;
      try {
        connect("pot");
        
        svc = (Service) form.getService();
        sql = new SqlWrapper();
        
        i=0;
        mi.next();
        
        
        sql.put(svc.getQuery("SEL_BTYPESKUMST"));

        if( !mi.getString("SKU_CD").equals("") ){
        	if(codeLikeGb)
        		sql.put(svc.getQuery("SEL_BTYPESKUMST_WHERE_LIKE_SKU_CD"));
        	else
        		sql.put(svc.getQuery("SEL_BTYPESKUMST_WHERE_SKU_CD"));
        	
            sql.setString(++i, mi.getString("SKU_CD"));
        }
        if( !mi.getString("SKU_NAME").equals("") ){
            sql.put(svc.getQuery("SEL_BTYPESKUMST_WHERE_SKU_NAME"));
            sql.setString(++i, mi.getString("SKU_NAME"));
        }
        
        if( mi.getString("AUTH_GB").equals("Y") ){
            authYn = true;
        }

        String addCondition = mi.getString("ADD_CONDITION");

		if (!"".equals(addCondition)) {
			String[] addConds = addCondition.split("#G#");
			for (int idx = 0; idx < addConds.length; idx++) {
				switch(idx){
			        case 0: //사원번호
			            if( authYn ){
			            	userId = addConds[idx].equals("") ? userId : addConds[idx];
			            }
				    	break;
			        case 1: //점코드
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				        	strCd = addConds[idx] ;
				        }
				    	break;
			        case 2: //품번코드
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_BTYPESKUMST_WHERE_PUMBUN_CD"));
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
			        case 3: //관리항목1
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_BTYPESKUMST_WHERE_MNG_CD1"));
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
			        case 4: //관리항목2
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_BTYPESKUMST_WHERE_MNG_CD2"));
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
			        case 5: //관리항목3
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_BTYPESKUMST_WHERE_MNG_CD3"));
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
			        case 6: //관리항목4
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_BTYPESKUMST_WHERE_MNG_CD4"));
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
			        case 7: //관리항목5
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_BTYPESKUMST_WHERE_MNG_CD5"));
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
			        case 8: //품번유형
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_BTYPESKUMST_WHERE_PUMBUN_TYPE"));
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
			        case 9: //거래형태
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_BTYPESKUMST_WHERE_BIZ_TYPE"));
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
			        case 10: //사용여부
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_BTYPESKUMST_WHERE_USE_YN"));
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
			        case 11: //매입일자
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				        	buyDt = addConds[idx] ;
				        }
				    	break;
			        case 12: //협력사코드
			        	if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_BTYPESKUMST_WHERE_VEN_CD"));
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
			        case 13: //스타일코드
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_BTYPESKUMST_WHERE_STYLE_CD"));
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
			        case 14: //칼라코드
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_BTYPESKUMST_WHERE_COLOR_CD"));
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
			        case 15: //사이즈코드
			        	if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_BTYPESKUMST_WHERE_SIZE_CD"));
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
				}
			}
			
		} 
		
		if(!strCd.equals("")){
            sql.put(svc.getQuery("SEL_BTYPESKUMST_WHERE_STR_CD_S"));
            sql.setString(++i, strCd );
            if(!buyDt.equals("")){
                sql.put(svc.getQuery("SEL_BTYPESKUMST_WHERE_BUY_DT"));
                sql.setString(++i, buyDt );
                sql.setString(++i, buyDt );
            	
            }
            sql.put(svc.getQuery("SEL_BTYPESKUMST_WHERE_STR_CD_E"));
            
			if( authYn ){
	            sql.put(svc.getQuery("SEL_BTYPESKUMST_WHERE_AUTHORITY_STR"));
	            sql.setString(++i, strCd );
                sql.setString(++i, userId );
                sql.setString(++i, orgFlag );
            }
		}else{
			if( authYn ){
	            sql.put(svc.getQuery("SEL_BTYPESKUMST_WHERE_AUTHORITY"));
                sql.setString(++i, userId );
                sql.setString(++i, orgFlag );
            }
		}

        sql.put(svc.getQuery("SEL_BTYPESKUMST_ORDER"));


        list = select2List(sql);

      } catch (Exception e) {
        throw e;
      }
      return list;
    }
}
