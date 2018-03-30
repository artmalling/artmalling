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
 * @created  on 1.0, 2010/02/16
 * @created  by 정진영(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class CCom012DAO extends AbstractDAO {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
    
    /**
     * 점별 품번 조회
     *
     * @param  : 
     * @return :
     */
    public List searchOnPop(ActionForm form, MultiInput mi, boolean codeLikeGb, String userId, String orgFlag) throws Exception {
      List list = null;
      SqlWrapper sql = null;
      Service svc = null;
      boolean authYn = false;
      boolean checkStrYn = false;
      int i;
      try {
        connect("pot");
        
        svc = (Service) form.getService();
        sql = new SqlWrapper();
        
        i=0;
        mi.next();
        
        
        sql.put(svc.getQuery("SEL_STRPBN"));


        String addCondition = mi.getString("ADD_CONDITION");
        String[] addConds = null;
        String strCd = "";
		if (!"".equals(addCondition)) {
			addConds = addCondition.split("#G#");
			if(addConds.length > 1){
		        if( !addConds[1].equals("") && !addConds[1].equals("%") ){
		            sql.put(svc.getQuery("SEL_STRPBN_WHERE_STR_CD"));
		            sql.setString(++i, addConds[1] );
		            checkStrYn = true;
		            strCd = addConds[1];
		        }
			}
		}
		if(!checkStrYn){
	        sql.put(svc.getQuery("SEL_STRPBN_WHERE_NOT_STR_CD"));
		}
		
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
            authYn = true;
        }

		if (!"".equals(addCondition)) {
			for (int idx = 0; idx < addConds.length; idx++) {
				switch(idx){
			        case 0: //사원번호
			            if( authYn ){
			            	userId = addConds[idx].equals("") ? userId : addConds[idx];
			            }
			    	    break;
				    case 1: //점코드
				    	break;
				    case 2:  //조직코드
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_STRPBN_WHERE_ORG_CD"));
				            sql.setString(++i, addConds[idx]);
				            sql.setString(++i, addConds[idx]);
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
				            sql.put(svc.getQuery("SEL_STRPBN_WHERE_BUYER_CD"));
				            sql.setString(++i, addConds[idx]);
				            sql.setString(++i, addConds[idx]);
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
				    case 7:  //단품구분
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_STRPBN_WHERE_SKU_FLAG"));
				            sql.setString(++i, addConds[idx]);
				        }
				    	break;
				    case 8:  //단품종류
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_STRPBN_WHERE_SKU_TYPE"));
				            sql.setString(++i, addConds[idx]);
				        }
				    	break;
				    case 9:  //통합발주여부
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_STRPBN_WHERE_ITG_ORD_FLAG"));
				            sql.setString(++i, addConds[idx]);
				        }
				    	break;
				    case 10:  //거래형태
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_STRPBN_WHERE_BIZ_TYPE"));
				            sql.setString(++i, addConds[idx]);
				        }
				    	break;
				    case 11:  //매입매출구분
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_STRPBN_WHERE_BUY_SALE_FLAG"));
				            sql.setString(++i, addConds[idx]);
				        }
				    	break;
				    case 12:  //의류단품코드구분
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_STRPBN_WHERE_STYLE_TYPE"));
				            sql.setString(++i, addConds[idx]);
				        }
				    	break;
				    case 13:  //층코드
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_STRPBN_WHERE_FLOR_CD"));
				            sql.setString(++i, addConds[idx]);
				        }
				    	break;
					
				}
			}
			
		}
		
		/*
		if( authYn ){
			
			
			if( checkStrYn){
	            sql.put(svc.getQuery("SEL_STRPBN_WHERE_AUTHORITY_STR"));
	            sql.setString(++i, strCd );				
			}else{
	            sql.put(svc.getQuery("SEL_STRPBN_WHERE_AUTHORITY"));				
			}
			
            sql.setString(++i, userId );
            sql.setString(++i, orgFlag );
        }
        */
		
        sql.put(svc.getQuery("SEL_STRPBN_ORDER"));


        list = select2List(sql);

      } catch (Exception e) {
        throw e;
      }
      return list;
    }
    
    
    /**
     * 점별 품번 조회(조회조건에 사용유무 추가)
     *
     * @param  : 
     * @return :
     */
    public List searchOnPop2(ActionForm form, MultiInput mi, boolean codeLikeGb, String userId, String orgFlag) throws Exception {
      List list = null;
      SqlWrapper sql = null;
      Service svc = null;
      boolean authYn = false;
      boolean checkStrYn = false;
      int i;
      try {
        connect("pot");
        
        svc = (Service) form.getService();
        sql = new SqlWrapper();
        
        i=0;
        mi.next();
        
        
        sql.put(svc.getQuery("SEL_STRPBN"));


        String addCondition = mi.getString("ADD_CONDITION");
        String[] addConds = null;
        String strCd = "";
        
        
        
		if (!"".equals(addCondition)) {
			addConds = addCondition.split("#G#");
			if(addConds.length > 1){
		        if( !addConds[1].equals("") && !addConds[1].equals("%") ){
		            sql.put(svc.getQuery("SEL_STRPBN_WHERE_STR_CD"));
		            sql.setString(++i, addConds[1] );
		            checkStrYn = true;
		            strCd = addConds[1];
		        }
			}
		}
		if(!checkStrYn){
	        sql.put(svc.getQuery("SEL_STRPBN_WHERE_NOT_STR_CD"));
		}
		
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
        
        // MARIO OUTLET
        if( !mi.getString("USE_YN").equals("%") && !mi.getString("USE_YN").equals("")){
            sql.put(svc.getQuery("SEL_STRPBN_WHERE_USE_YN"));
            sql.setString(++i, mi.getString("USE_YN"));
        }
        // MARIO OUTLET

        if( mi.getString("AUTH_GB").equals("Y") ){
            authYn = true;
        }

		if (!"".equals(addCondition)) {
			for (int idx = 0; idx < addConds.length; idx++) {
				switch(idx){
			        case 0: //사원번호
			            if( authYn ){
			            	userId = addConds[idx].equals("") ? userId : addConds[idx];
			            }
			    	    break;
				    case 1: //점코드
				    	break;
				    case 2:  //조직코드
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_STRPBN_WHERE_ORG_CD"));
				            sql.setString(++i, addConds[idx]);
				            sql.setString(++i, addConds[idx]);
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
				            sql.put(svc.getQuery("SEL_STRPBN_WHERE_BUYER_CD"));
				            sql.setString(++i, addConds[idx]);
				            sql.setString(++i, addConds[idx]);
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
				    case 7:  //단품구분
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_STRPBN_WHERE_SKU_FLAG"));
				            sql.setString(++i, addConds[idx]);
				        }
				    	break;
				    case 8:  //단품종류
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_STRPBN_WHERE_SKU_TYPE"));
				            sql.setString(++i, addConds[idx]);
				        }
				    	break;
				    case 9:  //통합발주여부
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_STRPBN_WHERE_ITG_ORD_FLAG"));
				            sql.setString(++i, addConds[idx]);
				        }
				    	break;
				    case 10:  //거래형태
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_STRPBN_WHERE_BIZ_TYPE"));
				            sql.setString(++i, addConds[idx]);
				        }
				    	break;
				    case 11:  //매입매출구분
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_STRPBN_WHERE_BUY_SALE_FLAG"));
				            sql.setString(++i, addConds[idx]);
				        }
				    	break;
				    case 12:  //의류단품코드구분
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_STRPBN_WHERE_STYLE_TYPE"));
				            sql.setString(++i, addConds[idx]);
				        }
				    	break;
				    case 13:  //층코드
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_STRPBN_WHERE_FLOR_CD"));
				            sql.setString(++i, addConds[idx]);
				        }
				    	break;
					
				}
			}
			
		}
		
		/*
		if( authYn ){
			
			if( checkStrYn){
	            sql.put(svc.getQuery("SEL_STRPBN_WHERE_AUTHORITY_STR"));
	            sql.setString(++i, strCd );				
			}else{
	            sql.put(svc.getQuery("SEL_STRPBN_WHERE_AUTHORITY"));				
			}
			
            sql.setString(++i, userId );
            sql.setString(++i, orgFlag );
        }
        */
		
        sql.put(svc.getQuery("SEL_STRPBN_ORDER"));


        list = select2List(sql);

      } catch (Exception e) {
        throw e;
      }
      return list;
    }

    /**
     * 품번 정보조회
     *
     * @param  : 
     * @return :
     */
    public List searchPbnInfo(ActionForm form) throws Exception {
      List list = null;
      SqlWrapper sql = null;
      Service svc = null;
      int i;
      try {
        connect("pot");
        
        svc = (Service) form.getService();
        sql = new SqlWrapper();
		String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));
        
        i=0;
        
        sql.put(svc.getQuery("SEL_PBNMST_INFO"));
        sql.setString(++i, strPumbunCd);
        
        list = select2List(sql);
      } catch (Exception e) {
        throw e;
      }
      return list;
    }
}
