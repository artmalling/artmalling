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
import java.util.Map;


import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;


/**
 * <p>공통으로 사용되는  DAO</p>
 * 
 * @created  on 1.0, 2010/01/24
 * @created  by 정진영(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class CCom000DAO extends AbstractDAO {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
    
    /**
     * 점별 협력사코드 조회
     *
     * @param  : 
     * @return :
     */
    public List getStrVenCode(ActionForm form, MultiInput mi, String userId, String orgFlag) throws Exception {
      List list = null;
      SqlWrapper sql = null;
      Service svc = null;
      boolean authYn = false;
      int i =0;
      try {
        connect("pot");
        
        svc = (Service) form.getService();
        sql = new SqlWrapper();
        
        
        mi.next();
        

        sql.put( svc.getQuery("SEL_STRVENMST"));						
		sql.setString(++i, mi.getString("VEN_CD"));	
		
        if( mi.getString("AUTH_GB").equals("Y")){
            sql.put(svc.getQuery("SEL_STRVENMST_WHERE_AUTHORITY"));
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
		                sql.setString(++i, orgFlag );
		            }
			    	break;
				}
			}			
		}else{
			if( authYn ){
                sql.setString(++i, userId );
            }
		}

        sql.put(svc.getQuery("SEL_STRVENMST_ORDER"));
        
        list = select2List(sql);

      } catch (Exception e) {
        throw e;
      }
      return list;
    }
    /**
     * 점별 품번코드 조회
     *
     * @param  : 
     * @return :
     */
    public List getStrPbnCode(ActionForm form, MultiInput mi, String userId, String orgFlag) throws Exception {
      List list = null;
      SqlWrapper sql = null;
      Service svc = null;
      boolean authYn = false;
      int i =0;
      try {
        connect("pot");
        
        svc = (Service) form.getService();
        sql = new SqlWrapper();
        
        
        mi.next();
        

        sql.put( svc.getQuery("SEL_STRPBNMST"));						
		sql.setString(++i, mi.getString("PUMBUN_CD"));	
		
        if( mi.getString("AUTH_GB").equals("Y")){
            sql.put(svc.getQuery("SEL_STRPBNMST_WHERE_AUTHORITY"));
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
		                sql.setString(++i, orgFlag );
		            }
			    	break;
				}
			}			
		}else{
			if( authYn ){
                sql.setString(++i, userId );
            }
		}

        sql.put(svc.getQuery("SEL_STRPBNMST_ORDER"));
        
        list = select2List(sql);

      } catch (Exception e) {
        throw e;
      }
      return list;
    }  
   /**
    * 마감체크
    *
    * @param  : 
    * @return :
    */
   public List getCloseCheck(ActionForm form) throws Exception {
     List list = null;
     SqlWrapper sql = null;
     Service svc = null;      
     String strQuery = "";
     int i =1;
     try {
       connect("pot");
       
       svc = (Service) form.getService();
       sql = new SqlWrapper();        
       
       String strStrCd          = String2.nvl(form.getParam("strStrCd"));
		String strCloseDt        = String2.nvl(form.getParam("strCloseDt"));
		String strCloseTaskFlag  = String2.nvl(form.getParam("strCloseTaskFlag"));
		String strCloseUnitFlag  = String2.nvl(form.getParam("strCloseUnitFlag"));
		String strCloseAcntFlag  = String2.nvl(form.getParam("strCloseAcntFlag"));
		String strCloseFlag      = String2.nvl(form.getParam("strCloseFlag"));		
		
		sql.setString(i++, strStrCd);		
		sql.setString(i++, strCloseDt);
		sql.setString(i++, strCloseTaskFlag);
		sql.setString(i++, strCloseUnitFlag);
		sql.setString(i++, strCloseAcntFlag);
		sql.setString(i++, strCloseFlag);		
		
		strQuery = svc.getQuery("SEL_CLOSECHECK");
		
		sql.put(strQuery);		

		list = select2List(sql);

     } catch (Exception e) {
       throw e;
     }
     return list;
   }

   

	
	/**
   * 정산/입금 체크
   *
   * @param  : 
   * @return :
   */
  public List getCalCheck(ActionForm form) throws Exception {
    List list = null;
    SqlWrapper sql = null;
    Service svc = null;      
    String strQuery = "";
    int i =1;
    try {
       connect("pot");
      
       svc = (Service) form.getService();
       sql = new SqlWrapper();        
      
       String strStrCd       = String2.nvl(form.getParam("strStrCd"));
		String strYM        = String2.nvl(form.getParam("strYM"));
		String strGbn       = String2.nvl(form.getParam("strGbn"));
		
		sql.setString(i++, strStrCd);		
		sql.setString(i++, strYM);
		sql.setString(i++, strGbn);
		
		strQuery = svc.getQuery("SEL_CALCHECK");
		
		sql.put(strQuery);		

		list = select2List(sql);

    } catch (Exception e) {
      throw e;
    }
    return list;
  }
  
    /**
     * 품목 대분류 조회
     *
     * @param  : 
     * @return :
     */
    public List getPmkLCode(ActionForm form) throws Exception {
      List list = null;
      SqlWrapper sql = null;
      Service svc = null;
      int i =0;
      try {
        connect("pot");
        
        svc = (Service) form.getService();
        sql = new SqlWrapper();
        sql.put( svc.getQuery("SEL_PMKMST_L_CD"));
        
        list = select2List(sql);

      } catch (Exception e) {
        throw e;
      }
      return list;
    }

    /**
     * 품목 중분류 조회
     *
     * @param  : 
     * @return :
     */
    public List getPmkMCode(ActionForm form, MultiInput mi) throws Exception {
      List list = null;
      SqlWrapper sql = null;
      Service svc = null;
      int i =0;
      try {
        connect("pot");
        
        svc = (Service) form.getService();
        sql = new SqlWrapper();

        mi.next();	
        sql.put( svc.getQuery("SEL_PMKMST_M_CD"));				
		sql.setString(++i, mi.getString("L_CD"));	
        
        list = select2List(sql);

      } catch (Exception e) {
        throw e;
      }
      return list;
    }
    
    /**
     * 품목 소분류 조회
     *
     * @param  : 
     * @return :
     */
    public List getPmkSCode(ActionForm form, MultiInput mi) throws Exception {
      List list = null;
      SqlWrapper sql = null;
      Service svc = null;
      int i =0;
      try {
        connect("pot");
        
        svc = (Service) form.getService();
        sql = new SqlWrapper();

        mi.next();	
        sql.put( svc.getQuery("SEL_PMKMST_S_CD"));				
		sql.setString(++i, mi.getString("L_CD"));				
		sql.setString(++i, mi.getString("M_CD"));	
        
        list = select2List(sql);

      } catch (Exception e) {
        throw e;
      }
      return list;
    }

    /**
     * 품목 세분류 조회
     *
     * @param  : 
     * @return :
     */
    public List getPmkDCode(ActionForm form, MultiInput mi) throws Exception {
      List list = null;
      SqlWrapper sql = null;
      Service svc = null;
      int i =0;
      try {
        connect("pot");
        
        svc = (Service) form.getService();
        sql = new SqlWrapper();

        mi.next();	
        sql.put( svc.getQuery("SEL_PMKMST_D_CD"));				
		sql.setString(++i, mi.getString("L_CD"));				
		sql.setString(++i, mi.getString("M_CD"));			
		sql.setString(++i, mi.getString("S_CD"));
		
        list = select2List(sql);

      } catch (Exception e) {
        throw e;
      }
      return list;
    }

    /**
     * 행사테마 대분류 조회
     *
     * @param  : 
     * @return :
     */
    public List getEvtThmeLCode(ActionForm form) throws Exception {
      List list = null;
      SqlWrapper sql = null;
      Service svc = null;
      int i =0;
      try {
        connect("pot");
        
        svc = (Service) form.getService();
        sql = new SqlWrapper();
        sql.put( svc.getQuery("SEL_EVTTHMEMST_L_CD"));
        
        list = select2List(sql);

      } catch (Exception e) {
        throw e;
      }
      return list;
    }

    /**
     * 행사테마 중분류 조회
     *
     * @param  : 
     * @return :
     */
    public List getEvtThmeMCode(ActionForm form, MultiInput mi) throws Exception {
      List list = null;
      SqlWrapper sql = null;
      Service svc = null;
      int i =0;
      try {
        connect("pot");
        
        svc = (Service) form.getService();
        sql = new SqlWrapper();

        mi.next();	
        sql.put( svc.getQuery("SEL_EVTTHMEMST_M_CD"));				
		sql.setString(++i, mi.getString("L_CD"));	
        
        list = select2List(sql);

      } catch (Exception e) {
        throw e;
      }
      return list;
    }
    
    /**
     * 행사테마 소분류 조회  
     *
     * @param  :  
     * @return :
     */
    public List getEvtThmeSCode(ActionForm form, MultiInput mi) throws Exception {
      List list = null;
      SqlWrapper sql = null;
      Service svc = null;
      int i =0;
      try {
        connect("pot");
        
        svc = (Service) form.getService();
        sql = new SqlWrapper();

        mi.next();	
        sql.put( svc.getQuery("SEL_EVTTHMEMST_S_CD"));				
		sql.setString(++i, mi.getString("L_CD"));				
		sql.setString(++i, mi.getString("M_CD"));	
        
        list = select2List(sql);

      } catch (Exception e) {
        throw e;
      }
      return list;
    }

	/**
	 * 로그인사번이 바이어/SM인지를 조회('Y')
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getBuyerYN(ActionForm form, String org_flag, String userId) throws Exception {
		
		List list       = null;
		SqlWrapper sql 	= null;
		Service svc 	= null;      
		String strQuery = "";
		
		int i = 1;
	
		String strStrCd   = String2.nvl(form.getParam("strStrCd"));
		String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));
		String strOrdDt = String2.nvl(form.getParam("strOrdDt"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		
		if("1".equals(org_flag))
			strQuery = svc.getQuery("SEL_SMYN") + "\n";
		else
			strQuery = svc.getQuery("SEL_BUYERYN") + "\n";
		
		sql.put(strQuery);
		
		sql.setString(i++, strStrCd); 
		sql.setString(i++, strPumbunCd); 
		sql.setString(i++, strOrdDt);     
		sql.setString(i++, userId);  

		list = select2List(sql);
		
		return list;
	}
	
	/**
	 * 점출입이 가능한 점인지  조회('Y')
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getStrInOutYN(ActionForm form) throws Exception {
		
		List list       = null;
		SqlWrapper sql 	= null;
		Service svc 	= null;      
		String strQuery = "";
		
		int i = 1;
	
		String strEStrCd = String2.nvl(form.getParam("strEStrCd"));
		String strFStrCd = String2.nvl(form.getParam("strFStrCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		
		strQuery = svc.getQuery("SEL_STRINOUT") + "\n";    
		sql.put(strQuery);
		sql.setString(i++, strEStrCd); 
		sql.setString(i++, strFStrCd); 

		list = select2List(sql);
		
		return list;
	}
	
	/**
	 * 협력사별 반올림구분
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getVenRoundFlag(ActionForm form) throws Exception {
		
		List list       = null;
		SqlWrapper sql 	= null;
		Service svc 	= null;      
		String strQuery = "";
		int i = 1;
	
		String strToday    = String2.nvl(form.getParam("strToday"));
		String strStrCd    = String2.nvl(form.getParam("strStrCd"));
		String strVenCd = String2.nvl(form.getParam("strVenCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");

		strQuery = svc.getQuery("SEL_ROUNDFLAG") + "\n";
		sql.put(strQuery);
	
		sql.setString(i++, strStrCd);     
		sql.setString(i++, strVenCd);  
		//sql.setString(i++, strToday); 

		list = select2List(sql);
		
		return list;
	}


    /**
     * 스타일 마스터의 품번별 브랜드
     *
     * @param  : 
     * @return :
     */
    public List getStyleBrand(ActionForm form, MultiInput mi) throws Exception {
      List list = null;
      SqlWrapper sql = null;
      Service svc = null;
      int i =0;
      try {
        connect("pot");
        
        svc = (Service) form.getService();
        sql = new SqlWrapper();

        mi.next();	
        sql.put( svc.getQuery("SEL_STYLE_BRAND"));				
		sql.setString(++i, mi.getString("PUMBUN_CD"));	
		
        list = select2List(sql);

      } catch (Exception e) {
        throw e;
      }
      return list;
    }

    /**
     * 스타일 마스터의 품번별 서브브랜드
     *
     * @param  : 
     * @return :
     */
    public List getStyleSubBrand(ActionForm form, MultiInput mi) throws Exception {
      List list = null;
      SqlWrapper sql = null;
      Service svc = null;
      int i =0;
      try {
        connect("pot");
        
        svc = (Service) form.getService();
        sql = new SqlWrapper();

        mi.next();	
        sql.put( svc.getQuery("SEL_STYLE_SUB_BRAND"));				
		sql.setString(++i, mi.getString("PUMBUN_CD"));	
		
        list = select2List(sql);

      } catch (Exception e) {
        throw e;
      }
      return list;
    }
    
    /**
     * 점별 품번별 행사코드
     *
     * @param  : 
     * @return :              
     */
    public List getEventCode(ActionForm form, MultiInput mi) throws Exception {
      List list = null;
      SqlWrapper sql = null;
      Service svc = null;
      String      getSql = "";

      try {
        connect("pot");
        svc = (Service) form.getService();
        sql = new SqlWrapper();
        
           
        mi.next();
        String allGb   = mi.getString("ALL_GB");
        
        if ((allGb.equals("Y")) || (allGb.equals("y"))) {
            getSql = ("SELECT '%' AS CODE , '전체' AS NAME FROM DUAL   ") + ("\n UNION \n");  
        }
       
        getSql = getSql + svc.getQuery("SEL_EVENT_CODE");
      
        sql.put(getSql);

        sql.setString(1, mi.getString("STR_CD"));                    
        sql.setString(2, mi.getString("PUMBUN_CD"));
        sql.setString(3, mi.getString("PRC_APP_DT"));

        list = select2List(sql);

      } catch (Exception e) {
        throw e;
      }
      return list;
    }
    /**
     * 행사장코드
     *
     * @param  : 
     * @return :              
     */
    public List getEventPlaceCode(ActionForm form, MultiInput mi) throws Exception {
      List list = null;
      SqlWrapper sql = null;
      Service svc = null;

      try {
        connect("pot");
        svc = (Service) form.getService();
        sql = new SqlWrapper();
        
           
        mi.next();      
        sql.put(svc.getQuery("SEL_EVENT_PLACE_CODE"));
        int i = 1;
        if(!mi.getString("STR_CD").equals("")&&!mi.getString("STR_CD").equals("%")){
            sql.put(svc.getQuery("SEL_EVENT_PLACE_CODE_WHERE_STR_CD"));
            sql.setString(i++, mi.getString("STR_CD"));     
        }               
        if(!mi.getString("USE_YN").equals("")&&!mi.getString("USE_YN").equals("%")){
            sql.put(svc.getQuery("SEL_EVENT_PLACE_CODE_WHERE_USE_YN"));
            sql.setString(i++, mi.getString("USE_YN"));     
        }               
        sql.put(svc.getQuery("SEL_EVENT_PLACE_CODE_ORDER"));

        list = select2List(sql);

      } catch (Exception e) {
        throw e;
      }
      return list;
    }
    /**
     * 행사장코드
     *
     * @param  : 
     * @return :              
     */
    public List getFnBShopCornerCode(ActionForm form, MultiInput mi) throws Exception {
      List list = null;
      SqlWrapper sql = null;
      Service svc = null;

      try {
        connect("pot");
        svc = (Service) form.getService();
        sql = new SqlWrapper();
        
           
        mi.next();      
        sql.put(svc.getQuery("SEL_FNB_SHOP_CORNER_CODE"));
        int i = 1;
        if(!mi.getString("STR_CD").equals("")&&!mi.getString("STR_CD").equals("%")){
            sql.put(svc.getQuery("SEL_FNB_SHOP_CORNER_CODE_WHERE_STR_CD"));
            sql.setString(i++, mi.getString("STR_CD"));     
        }               
        
        if(!mi.getString("USE_YN").equals("")&&!mi.getString("USE_YN").equals("%")){
            sql.put(svc.getQuery("SEL_FNB_SHOP_CORNER_CODE_WHERE_USE_YN"));
            sql.setString(i++, mi.getString("USE_YN"));     
        }               
        sql.put(svc.getQuery("SEL_FNB_SHOP_CORNER_CODE_ORDER"));

        list = select2List(sql);

      } catch (Exception e) {
        throw e;
      }
      return list;
    }
    
	/**
	 * 회차별 매출시작일 종료일 조회
	 *       
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getSaleDate(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;               

		String strYyyymm     = String2.nvl(form.getParam("strYyyymm"));
		String strPayCyc     = String2.nvl(form.getParam("strPayCyc"));
		String strPayCnt     = String2.nvl(form.getParam("strPayCnt"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		
		if(strYyyymm.length() == 6){
			sql.put(svc.getQuery("SEL_SALE_DATE"));   
			sql.setString(i++, strPayCyc);
			sql.setString(i++, strPayCnt);
			sql.setString(i++, strYyyymm);   
			sql.setString(i++, strPayCyc);
			sql.setString(i++, strPayCnt);
			sql.setString(i++, strYyyymm);   
			ret = select2List(sql);
		}
		return ret;
		
	}
	
	
	/**
	 * 회차별 매출시작일 종료일 조회
	 *       
	 * @param form
	 * @return
	 * @throws Exception
	 */                
	public List getPayDate(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;               

		String strYyyymm     = String2.nvl(form.getParam("strYyyymm"));
		String strPayCyc     = String2.nvl(form.getParam("strPayCyc"));
		String strPayCnt     = String2.nvl(form.getParam("strPayCnt"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");

		if(strYyyymm.length() == 6){
			sql.put(svc.getQuery("SEL_PAY_DATE"));       
			sql.setString(i++, strPayCyc);
			sql.setString(i++, strPayCnt);
			sql.setString(i++, strYyyymm);   
			ret = select2List(sql);
		}
		return ret;
	}
	
	/**
	 * 세금계산서시작일 종료일 조회
	 *       
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getIssueDate(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;               

		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strYyyymm     = String2.nvl(form.getParam("strYyyymm"));
		String strPayCyc     = String2.nvl(form.getParam("strPayCyc"));
		String strPayCnt     = String2.nvl(form.getParam("strPayCnt"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_ISSUE_DATE"));  
		sql.setString(i++, strPayCyc);
		sql.setString(i++, strPayCnt);
		sql.setString(i++, strYyyymm);  
		sql.setString(i++, strPayCyc);
		sql.setString(i++, strPayCnt);                   
		sql.setString(i++, strYyyymm); 
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strYyyymm);
		sql.setString(i++, strPayCyc);                               
		sql.setString(i++, strPayCnt);
		
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 현재날짜(DB)가져오기
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getToday(ActionForm form) throws Exception {
		
		List list       = null;
		SqlWrapper sql 	= null;
		Service svc 	= null;      
		String strQuery = "";

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");

		strQuery = svc.getQuery("SEL_SYSDATE") + "\n";
		sql.put(strQuery);

		list = select2List(sql);
		
		return list;
	}
	/**
	 * 현재날짜(DB)가져오기
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public String getToday() throws Exception {
		
		Map map       = null;
		SqlWrapper sql 	= null;
		String strQuery = "";

		sql = new SqlWrapper();
		connect("pot");

		strQuery = "SELECT TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS') AS TODAY FROM DUAL";
		sql.put(strQuery);

		map = selectMap(sql);
		
		return String2.nvl((String)map.get("TODAY"));
	}
	
    /**
     * 브랜드조회
     *
     * @param  : 
     * @return :
     */
    public List searchMaster(ActionForm form, MultiInput mi) throws Exception {
    	List list = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        int i = 1;
        

    	try {
    		
    		connect("pot");
            svc = (Service) form.getService();
            sql = new SqlWrapper();
            i=0;
            mi.next();
            
            sql.put(svc.getQuery("SEL_BRAND_MASTER"));
            
            sql.setString(++i, mi.getString("BRAND_CD"));
            sql.setString(++i, mi.getString("BRAND_NM"));


            list = select2List(sql);

          } catch (Exception e) {
            throw e;
          }
          return list;
    }
    
    /**
	* 전표상태를 조회한다.
	*
	* @param  : 
	* @return :
	*/
	public List getSlipProcStat(ActionForm form) throws Exception {
	     List list = null;   
	     SqlWrapper sql = null;
	     Service svc = null;      
	     String strQuery = "";
		 int i =1;
		 try {
		   connect("pot");
		   
		   svc = (Service) form.getService();
		   sql = new SqlWrapper();        
		   
		   String strStrCd          = String2.nvl(form.getParam("strStrCd"));
		   String strSlipNo        = String2.nvl(form.getParam("strSlipNo"));
					
		   sql.setString(i++, strStrCd);		
		   sql.setString(i++, strSlipNo);
		   
		   strQuery = svc.getQuery("SEL_SLIP_PROC_STAT");
		   
		   sql.put(strQuery);		
	    
		   list = select2List(sql);
	
	     } catch (Exception e) {
	       throw e;
	     }
	     return list;
	}

	/**
	 * 현재날짜(DB)가져오기 Ajax
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
/*	public StringBuffer getTodayAjax(ActionForm form) throws Exception {
		
		StringBuffer sb = null;
		SqlWrapper sql 	= null;
		Service svc 	= null;      
		String strQuery = "";

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");

		strQuery = svc.getQuery("SEL_SYSDATE");
		sql.put(strQuery);

		sb = selectAjax(sql);
		
		return sb;
	}
*/

}
