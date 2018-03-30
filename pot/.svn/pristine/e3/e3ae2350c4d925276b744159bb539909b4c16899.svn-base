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
 * @created  on 1.0, 2010/02/17
 * @created  by 정진영(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class CCom013DAO extends AbstractDAO {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
    
    /**
     * 행사 조회
     *
     * @param  : 
     * @return :
     */
    public List searchOnPop(ActionForm form, MultiInput mi, boolean codeLikeGb, String thmeCd) throws Exception {
      List list = null;
      SqlWrapper sql = null;
      Service svc = null;
      String strCd = "";
      String appSDt = "";
      String appEDt = "";
      String appDt = "";
      int i;
      try {
        connect("pot");
        
        svc = (Service) form.getService();
        sql = new SqlWrapper();
        
        i=0;
        mi.next();


        String addCondition = mi.getString("ADD_CONDITION");
        strCd = !"".equals(addCondition)?addCondition.split("#G#")[0]:"";
        sql.put(svc.getQuery("SEL_EVTMST"));
        if( !mi.getString("EVENT_CD").equals("") ){
        	if(codeLikeGb)
        		sql.put(svc.getQuery("SEL_EVTMST_WHERE_LIKE_EVENT_CD"));
        	else
        		sql.put(svc.getQuery("SEL_EVTMST_WHERE_EVENT_CD"));
        	
            sql.setString(++i, mi.getString("EVENT_CD"));
        }
        if( !mi.getString("EVENT_NAME").equals("") ){
            sql.put(svc.getQuery("SEL_EVTMST_WHERE_EVENT_NAME"));
            sql.setString(++i, mi.getString("EVENT_NAME"));
        }   

        if (thmeCd.equals("")){
		    //테마코드			
		  	if( !mi.getString("EVENT_TH_CD").equals("") ){
		        sql.put(svc.getQuery("SEL_EVTMST_WHERE_EVENT_THME_CD"));
		        sql.setString(++i, mi.getString("EVENT_TH_CD"));
		      }
		    //테마명
		   	if( !mi.getString("EVENT_TH_NAME").equals("") ){
		        sql.put(svc.getQuery("SEL_EVTMST_WHERE_EVENT_THME_NAME"));
		        sql.setString(++i, mi.getString("EVENT_TH_NAME"));
		      }
		   	
        	if(strCd.equals("")||strCd.equals("%")){
                //적용기준일
    	    	if( !mi.getString("EVENT_DT").equals("") ){
    	            sql.put(svc.getQuery("SEL_EVTMST_WHERE_EVENT_DT"));
    	            sql.setString(++i, mi.getString("EVENT_DT"));
    	        }       		
        	}else{
        		appDt =  mi.getString("EVENT_DT");
        	}
		}


		if (!"".equals(addCondition)) {
			String[] addConds = addCondition.split("#G#");
			for (int idx = 0; idx < addConds.length; idx++) {
				switch(idx){
			        case 0: //점코드
				    	break;
			        case 1: //행사테마코드
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_EVTMST_WHERE_EVENT_THME_CD"));
				            sql.setString(++i, addConds[idx] );
				        }
				    	break;
				    case 2:  //행사종류
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_EVTMST_WHERE_EVENT_TYPE"));
				            sql.setString(++i, addConds[idx]);
				        }
				    	break;
				    case 3:  //행사유형
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				            sql.put(svc.getQuery("SEL_EVTMST_WHERE_EVENT_PLU_FLAG"));
				            sql.setString(++i, addConds[idx]);
				        }
				    	break;
				    case 4:  //행사시작일
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				        	if(strCd.equals("")||strCd.equals("%")){
					            sql.put(svc.getQuery("SEL_EVTMST_WHERE_APP_S_DT"));
					            sql.setString(++i, addConds[idx]);				        		
				        	}else{
				        		appSDt =  addConds[idx];
				        	}
				        }
				    	break;
				    case 5:  //행사종료일
				        if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				        	if(strCd.equals("")||strCd.equals("%")){
					            sql.put(svc.getQuery("SEL_EVTMST_WHERE_APP_E_DT"));
					            sql.setString(++i, addConds[idx]);				        		
				        	}else{
				        		appEDt =  addConds[idx];
				        	}
				        }
				    	break;				   
				    case 6:  //행사테마명
				    	if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				    		if (!thmeCd.equals("")){
				    			sql.put(svc.getQuery("SEL_EVTMST_WHERE_EVENT_THME_NAME"));
					            sql.setString(++i, addConds[idx]);
				    		}				            
				        }
				    	break;	   
				    case 7:  //적용기준일
				    	if( !addConds[idx].equals("") && !addConds[idx].equals("%") ){
				    		if (!thmeCd.equals("")){
					        	if(strCd.equals("")||strCd.equals("%")){
					    			sql.put(svc.getQuery("SEL_EVTMST_WHERE_EVENT_DT"));
						            sql.setString(++i, addConds[idx]);
					        	}else{
					        		appDt =  addConds[idx];
					        	}      
				    		}				      
				        }
				    	break;
				    case 8:  //정상제외여부
				    	if( addConds[idx].equals("Y") ){
				    		sql.put(svc.getQuery("SEL_EVTMST_WHERE_NOT_NORM_EVENT"));
				        }
				    	break;
				}
			}
			
			if(!strCd.equals("")&&!strCd.equals("%")){
	            sql.put(svc.getQuery("SEL_EVTMST_WHERE_STR_CD_S"));
	            sql.setString(++i, strCd);	
	            
	            if(!appSDt.equals("")){
		            sql.put(svc.getQuery("SEL_EVTMST_WHERE_STR_APP_S_DT"));
		            sql.setString(++i, appSDt);				        		
	        	}
	            if(!appEDt.equals("")){
		            sql.put(svc.getQuery("SEL_EVTMST_WHERE_STR_APP_E_DT"));
		            sql.setString(++i, appEDt);			        		
	        	}
	            if(!appDt.equals("")){
		            sql.put(svc.getQuery("SEL_EVTMST_WHERE_STR_APP_DT"));
		            sql.setString(++i, appDt);			        		
	        	}
	            sql.put(svc.getQuery("SEL_EVTMST_WHERE_STR_CD_E"));
				
			}
			
		}

        sql.put(svc.getQuery("SEL_EVTMST_ORDER"));


        list = select2List(sql);

      } catch (Exception e) {
        throw e;
      }
      return list;
    }
}
