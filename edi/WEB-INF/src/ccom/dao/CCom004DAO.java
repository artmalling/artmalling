/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package ccom.dao;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;


/**
 * <p>공통으로 사용되는  DAO</p>
 * 
 * @created  on 1.0, 2011/08/20
 * @created  by 김경은
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class CCom004DAO extends AbstractDAO2 {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
    
    /**
     * 단품코드(점별) 조회
     *
     * @param  : 
     * @return :
     */
	
	/**
	 * 단품코드 상세정보 조회
	 *       
	 * @param form
	 * @return
	 * @throws Exception          
	 */
	public StringBuffer searchOnPop(ActionForm form, boolean codeLikeGb, String userId , String orgFlag) throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		int i = 0;          

		String strCd = "";
		String skuCd = String2.nvl(form.getParam("skuCd"));
		String skuNm = String2.nvl(form.getParam("skuNm"));
		String auth  = String2.nvl(form.getParam("auth"));
		String cond  = String2.nvl(form.getParam("cond"));
		boolean authYn = false;
		String strWhere = "";
		boolean addBarcodeYn = false;
		String buyDt = "";
		String skuVenCd = "";
		
		sb  = new StringBuffer();
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		i=0;
        
        if( !"".equals(skuNm)){
        	strWhere += svc.getQuery("SEL_STRSKUMST_WHERE_SKU_NAME") + "\n";
            sql.setString(++i, skuNm);
        }
        System.out.println("skuNm::"+skuNm);
        if( "Y".equals(auth)){
            authYn = true;
        }

        String addCondition = cond;

		if (!"".equals(addCondition)) {    
			String[] addConds = addCondition.split("#G#");
			for (int idx = 0; idx < addConds.length; idx++) {
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
			        	strWhere += svc.getQuery("SEL_STRSKUMST_WHERE_PUMBUN_TYPE")+ "\n";
//				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
//				            strWhere += svc.getQuery("SEL_STRSKUMST_WHERE_PUMBUN_TYPE")+ "\n";
//				            sql.setString(++i, addConds[idx] );
//				        }
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
            
//			if( authYn ){
//	            strWhere += svc.getQuery("SEL_STRSKUMST_WHERE_AUTHORITY_STR")+ "\n";
//	            sql.setString(++i, strCd );
//                sql.setString(++i, userId );
//                sql.setString(++i, orgFlag );
//            }
		}else{
			if( authYn ){
	            strWhere += svc.getQuery("SEL_STRSKUMST_WHERE_AUTHORITY")+ "\n";
                sql.setString(++i, userId );
                sql.setString(++i, orgFlag );
            }
			
		}
		
		if(addBarcodeYn){
	        if( !"".equals(skuCd) ){
	        	if(codeLikeGb)
	        		strWhere += svc.getQuery("SEL_STRSKUMST_WHERE_LIKE_SKU_CD_BARCODE")+ "\n";
	        	else
	        		strWhere += svc.getQuery("SEL_STRSKUMST_WHERE_SKU_CD_BARCODE")+ "\n";
	        	
	            sql.setString(++i, skuCd);
	        }
    		strWhere += svc.getQuery("SEL_STRSKUMST_WHERE_STR_CD_BARCODE")+ "\n";
            sql.setString(++i, strCd);

	        strWhere += svc.getQuery("SEL_STRSKUMST_ORDER_BARCODE")+ "\n";
	        
	        sql.put(svc.getQuery("SEL_STRSKUMST_BARCODE"));
		} else{
			
	        if(  !"".equals(skuCd) ){
	        	if(codeLikeGb)
	        		strWhere += svc.getQuery("SEL_STRSKUMST_WHERE_LIKE_SKU_CD")+ "\n";
	        	else
	        		strWhere += svc.getQuery("SEL_STRSKUMST_WHERE_SKU_CD")+ "\n";
	        	
	            sql.setString(++i, skuCd);
	        }

	        strWhere += svc.getQuery("SEL_STRSKUMST_ORDER")+ "\n";
	        
	        sql.put(svc.getQuery("SEL_STRSKUMST"));
			
		}
        
        sql.put(strWhere);

        sb = executeQueryByAjax(sql);
        return sb;
	}
	
}
