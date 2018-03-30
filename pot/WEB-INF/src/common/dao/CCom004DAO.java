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

public class CCom004DAO extends AbstractDAO {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
    
    /**
     * 단품코드(점별) 조회
     *
     * @param  : 
     * @return :
     */
    public List searchOnPop(ActionForm form, MultiInput mi, boolean codeLikeGb, String userId , String orgFlag) throws Exception {
      List list = null;
      SqlWrapper sql = null;
      Service svc = null;
      boolean authYn = false;
      String strCd = "";
      String buyDt = "";
	  String strWhere = "";
	  String skuVenCd = "";
	  boolean addBarcodeYn = false;
      int i;
      try {
        connect("pot");
        
        svc = (Service) form.getService();
        sql = new SqlWrapper();
        
        i=0;
        mi.next();
        
        if( !mi.getString("SKU_NAME").equals("") ){
        	strWhere += svc.getQuery("SEL_STRSKUMST_WHERE_SKU_NAME") + "\n";
            sql.setString(++i, mi.getString("SKU_NAME"));
        }
        
        if( mi.getString("AUTH_GB").equals("Y") ){
            authYn = true;
        }

        String addCondition = mi.getString("ADD_CONDITION");
        

        
		if (!"".equals(addCondition)) {
			String[] addConds = addCondition.split("#G#");
			for (int idx = 0; idx < addConds.length; idx++) {
				System.out.println(idx);
				System.out.println(addConds[idx]);
				
				switch(idx){
			        case 0: //사원번호
			            if( authYn ){
			            	userId = addConds[idx].equals("") ? userId : addConds[idx] ;
			            }
				    	break;
			        case 1: //점코드
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            strCd = addConds[idx];
				        }
				    	break;
			        case 2: //품번코드
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            strWhere += svc.getQuery("SEL_STRSKUMST_WHERE_PUMBUN_CD")+ "\n";
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
			        case 3: //품번유형
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            strWhere += svc.getQuery("SEL_STRSKUMST_WHERE_PUMBUN_TYPE")+ "\n";
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
			        case 4: //거래형태
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            strWhere += svc.getQuery("SEL_STRSKUMST_WHERE_BIZ_TYPE")+ "\n";
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
			        case 5: //사용여부
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            strWhere += svc.getQuery("SEL_STRSKUMST_WHERE_USE_YN")+ "\n";
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
			        case 6: //매입일자
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            buyDt = addConds[idx];
				        }
				    	break;
			        case 7: //단품종류
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            strWhere += svc.getQuery("SEL_STRSKUMST_WHERE_SKU_TYPE")+ "\n";
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
			        case 8: //협력사코드    
			        	if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            strWhere += svc.getQuery("SEL_STRSKUMST_WHERE_VEN_CD")+ "\n";
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
			        case 9: //스타일코드
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            strWhere += svc.getQuery("SEL_BTYPESKUMST_WHERE_STYLE_CD")+ "\n";
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
			        case 10: //칼라코드
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            strWhere += svc.getQuery("SEL_BTYPESKUMST_WHERE_COLOR_CD")+ "\n";
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
			        case 11: //사이즈코드
			        	if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            strWhere += svc.getQuery("SEL_BTYPESKUMST_WHERE_SIZE_CD")+ "\n";
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
			        case 12: //소스마킹코드 포함여부
			        	if( addConds[idx].equals("Y") && !strCd.equals("") ){
			        		addBarcodeYn = true;
				        }
				    	break;
			        case 13: //단품협력사코드
			        	if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
			        		skuVenCd = addConds[idx];
				        }
				    	break;
				}
			}
		}
		
        
		
		if(!strCd.equals("")){
            strWhere += svc.getQuery("SEL_STRSKUMST_WHERE_STR_CD_S")+ "\n";
            sql.setString(++i, strCd );
            if(!buyDt.equals("")){
                strWhere += svc.getQuery("SEL_STRSKUMST_WHERE_BUY_DT")+ "\n";
                sql.setString(++i, buyDt );
                sql.setString(++i, buyDt );
            	
            }   
            if(!skuVenCd.equals("")){
                strWhere += svc.getQuery("SEL_STRSKUMST_WHERE_SKU_VEN_CD")+ "\n";
                sql.setString(++i, skuVenCd );
            	
            }        
            strWhere += svc.getQuery("SEL_STRSKUMST_WHERE_STR_CD_E")+ "\n";
            
			if( authYn ){
	            strWhere += svc.getQuery("SEL_STRSKUMST_WHERE_AUTHORITY_STR")+ "\n";
	            sql.setString(++i, strCd );
                sql.setString(++i, userId );
                sql.setString(++i, orgFlag );
            }
		}else{
			if( authYn ){
	            strWhere += svc.getQuery("SEL_STRSKUMST_WHERE_AUTHORITY")+ "\n";
                sql.setString(++i, userId );
                sql.setString(++i, orgFlag );
            }
			
		}
		
		
		System.out.println(mi.getString("VEN_NAME"));
		System.out.println(mi.getString("PUMBUN_NAME"));
		
		if(addBarcodeYn){
	        if( !mi.getString("SKU_CD").equals("") ){
	        	if(codeLikeGb)
	        		strWhere += svc.getQuery("SEL_STRSKUMST_WHERE_LIKE_SKU_CD_BARCODE")+ "\n";
	        	else
	        		strWhere += svc.getQuery("SEL_STRSKUMST_WHERE_SKU_CD_BARCODE")+ "\n";
	        	
	            sql.setString(++i, mi.getString("SKU_CD"));
	        }
    		strWhere += svc.getQuery("SEL_STRSKUMST_WHERE_STR_CD_BARCODE")+ "\n";
            sql.setString(++i, strCd);
            
            if( !mi.getString("VEN_NAME").equals("") ){
	        	strWhere += svc.getQuery("SEL_STRSKUMST_WHERE_VEN_NAME")+ "\n";
	        	sql.setString(++i, mi.getString("VEN_NAME"));
	        }
	        
	        if( !mi.getString("PUMBUN_NAME").equals("") ){
	        	strWhere += svc.getQuery("SEL_STRSKUMST_WHERE_PUMBUN_NAME")+ "\n";
	        	sql.setString(++i, mi.getString("PUMBUN_NAME"));
	        }

	        strWhere += svc.getQuery("SEL_STRSKUMST_ORDER_BARCODE")+ "\n";
	        
	        sql.put(svc.getQuery("SEL_STRSKUMST_BARCODE"));
		} else{
			
	        if( !mi.getString("SKU_CD").equals("") ){
	        	if(codeLikeGb)
	        		strWhere += svc.getQuery("SEL_STRSKUMST_WHERE_LIKE_SKU_CD")+ "\n";
	        	else
	        		strWhere += svc.getQuery("SEL_STRSKUMST_WHERE_SKU_CD")+ "\n";
	        	
	            sql.setString(++i, mi.getString("SKU_CD"));
	        }
	        
	        
	        if( !mi.getString("VEN_NAME").equals("") ){
	        	strWhere += svc.getQuery("SEL_STRSKUMST_WHERE_VEN_NAME")+ "\n";
	        	sql.setString(++i, mi.getString("VEN_NAME"));
	        }
	        
	        if( !mi.getString("PUMBUN_NAME").equals("") ){
	        	strWhere += svc.getQuery("SEL_STRSKUMST_WHERE_PUMBUN_NAME")+ "\n";
	        	sql.setString(++i, mi.getString("PUMBUN_NAME"));
	        }

	        strWhere += svc.getQuery("SEL_STRSKUMST_ORDER")+ "\n";
	        
	        sql.put(svc.getQuery("SEL_STRSKUMST"));
			
		}
        
        sql.put(strWhere);

        list = select2List(sql);

      } catch (Exception e) {
        throw e;
      }
      return list;
    }
}
