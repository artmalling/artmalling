/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pord.dao;
 
import java.util.List;
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import common.util.Util;
/**
 * <p>물품 입고/반품 등록</p>  
 * 
 * @created  on 1.0, 2010/01/26
 * @created  by 박래형(FUJITSU KOREA LTD.)
 *   
 * @modified on        
 * @modified by   
 * @caused   by     
 */
 
public class POrd118DAO extends AbstractDAO {    	  
	/**
	 * 전표별 발주현황 마스터 리스트 내역 조회  
	 *     
	 * @param form
	 * @return  
	 * @throws Exception
	 */
	public List getList(ActionForm form, String userId, String org_flag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";  
		int i = 1;   
				
		String strStrCd        = String2.nvl(form.getParam("strStrCd"));
		String strBumun        = String2.nvl(form.getParam("strBumun"));
		String strTeam         = String2.nvl(form.getParam("strTeam"));
		String strPc           = String2.nvl(form.getParam("strPc"));
		String strOrgCd        = String2.nvl(form.getParam("strOrgCd"));
		String strGiJunDtType  = String2.nvl(form.getParam("strGiJunDtType"));
		String strSlipProcStat = String2.nvl(form.getParam("strSlipProcStat"));
		String strStartDt      = String2.nvl(form.getParam("strStartDt"));
		String strEndDt        = String2.nvl(form.getParam("strEndDt"));    
		String strPumbunCd     = String2.nvl(form.getParam("strPumbunCd"));    
		String strVenCd        = String2.nvl(form.getParam("strVenCd"));    
		String slipFlagList    = String2.nvl(form.getParam("slipFlagList"));    
		String strOrgFlag      = String2.nvl(form.getParam("strOrgFlag"));
		String strOrdOwnFlag   = String2.nvl(form.getParam("strOrdOwnFlag"));  
		    
		sql = new SqlWrapper();
		svc = (Service) form.getService(); 
		connect("pot"); 

		//넘어온 문자열을 쿼리 조건에 맞게 정한다.
		slipFlagList = "AND " + slipFlagList.substring(0, 11) + ' ' + slipFlagList.substring(11, slipFlagList.length());		
		 
		sql.put(svc.getQuery("SEL_LIST")); 
		sql.setString(i++, strStrCd);   
		sql.setString(i++, strGiJunDtType); 
		sql.setString(i++, strStartDt);
		sql.setString(i++, strEndDt);  
		sql.setString(i++, strSlipProcStat); 
		sql.setString(i++, strPumbunCd); 	//품번
		sql.setString(i++, strVenCd);		//협력사
		sql.setString(i++, strOrdOwnFlag);
		sql.setString(i++, userId);   
		sql.setString(i++, strOrgFlag);    
		  
		if("1".equals(org_flag)){						// 판매
			sql.put(svc.getQuery("SEL_SALE_ORG_CD"));
			sql.setString(i++, strOrgCd);
		}else if("2".equals(org_flag)){					// 매입 
			sql.put(svc.getQuery("SEL_BUY_ORG_CD")); 
			sql.setString(i++, strOrgCd);          
		}		 
		sql.put(slipFlagList);							// 전표구분 조건
		sql.put(svc.getQuery("SEL_GROUP"));
		
		ret = select2List(sql);
		return ret;
	}   	 
	/**
	 * 전표별 발주현황 디테일 리스트 내역 조회 
	 *  
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getDetail(ActionForm form, String userId, String org_flag) throws Exception { 
		
		List ret = null;
		SqlWrapper sql = null;  
		Service svc = null;
		String strQuery = "";     
		int i = 1;  
				
		String strStrCd        = String2.nvl(form.getParam("strStrCd"));
		String strBumun        = String2.nvl(form.getParam("strBumun"));  
		String strTeam         = String2.nvl(form.getParam("strTeam"));
		String strPc           = String2.nvl(form.getParam("strPc"));
		String strOrgCd        = String2.nvl(form.getParam("strOrgCd"));
		String strGiJunDtType  = String2.nvl(form.getParam("strGiJunDtType"));
		String strSlipProcStat = String2.nvl(form.getParam("strSlipProcStat"));
		String strStartDt      = String2.nvl(form.getParam("strStartDt")); 
		String strEndDt        = String2.nvl(form.getParam("strEndDt"));   
		String strPumbunCd     = String2.nvl(form.getParam("strPumbunCd"));   
		String strVenCd        = String2.nvl(form.getParam("strVenCd"));    
		String slipFlagList    = String2.nvl(form.getParam("slipFlagList"));    
		String strOrgFlag      = String2.nvl(form.getParam("strOrgFlag"));  
		String strOrdOwnFlag   = String2.nvl(form.getParam("strOrdOwnFlag"));  
		  
		sql = new SqlWrapper();  
		svc = (Service) form.getService(); 
		connect("pot"); 
 
		//넘어온 문자열을 쿼리 조건에 맞게 정한다.
		slipFlagList = "AND " + slipFlagList.substring(0, 11) + ' ' + slipFlagList.substring(11, slipFlagList.length());		
		
		sql.put(svc.getQuery("SEL_DETAIL")); 
		sql.setString(i++, strStrCd);   
		sql.setString(i++, strPumbunCd); 	//품번
		sql.setString(i++, strVenCd);		//협력사
		sql.setString(i++, strOrdOwnFlag);	
		sql.setString(i++, strGiJunDtType);
		sql.setString(i++, strStartDt);
		sql.setString(i++, strEndDt);   
		sql.setString(i++, strSlipProcStat); 
/*		
		sql.setString(i++, strStrCd);  
		sql.setString(i++, strBumun);  
		sql.setString(i++, strTeam);  
		sql.setString(i++, strPc);  
*/		
		sql.setString(i++, userId);   
		sql.setString(i++, strOrgFlag);   
		  
		if("1".equals(org_flag)){						// 판매
			sql.put(svc.getQuery("SEL_SALE_ORG_CD"));
			sql.setString(i++, strOrgCd);
		}else if("2".equals(org_flag)){					// 매입 
			sql.put(svc.getQuery("SEL_BUY_ORG_CD")); 
			sql.setString(i++, strOrgCd);          
		}		 
		
		sql.put(slipFlagList);							// 전표구분 조건
		
		sql.put(svc.getQuery("SEL_DETAIL_GROUP_BY"));
		ret = select2List(sql);
		return ret;
	}
	
    /**
     * 점코드 조회
     * 
     * @param  :  
     * @return :
     */
    public List getStore(ActionForm form, MultiInput mi, String strUserId) throws Exception {
    	List list = null;
    	List listCnt = null;
        SqlWrapper sql = null;
        SqlWrapper sqlCnt = null;
        Service svc = null;
        String  strSql = "";
        int i = 1;
        try {
          connect("pot");
          svc = (Service) form.getService();
          sqlCnt =  new SqlWrapper();
          mi.next();
          
          String strAuthGb   = mi.getString("AUTH_GB");   // 권한 사용 유무
          String strBonsaGb  = mi.getString("BONSA_GB"); 	// 본사점 표시 유무  0:본사점, 1:매장
          String strAllGb    = mi.getString("ALL_GB");
          String addCond 	 = mi.getString("ADD_CONDITION");          
          String strOrgFlag  = String2.nvl(form.getParam("strOrgFlag"));
          
          
          String[] addConds = addCond.split("#G#");
          
          System.out.println("strAuthGb!!!!!!!!! = " + strAuthGb);
          System.out.println("addConds[0]!!!!!!!!! = " + addConds[0]);
          System.out.println("조직권한!!!!!!!!! = " + strOrgFlag);
        
          // 권한점의 개수를 조회
          if(strAuthGb.equals("Y")){ // 권한 적용
        	  strSql = svc.getQuery("SEL_STORE")+ "\n ";
        	  sqlCnt.setString(i++, strUserId);
        	  sqlCnt.setString(i++, strBonsaGb);
        	  // Y 나 ''을 보낼경우 매입, 매장조직 조건 추가  (default ; '') 
         	 if(addConds[0].equals("") || addConds[0].equals("Y")){
         		strSql += svc.getQuery("SEL_STORE_ORG_FLAG")+ "\n ";
         		sqlCnt.setString(i++, strOrgFlag);
         	 } 
         	 
          }else if(strAuthGb.equals("N")){// 권한 미적용
        	  strSql = svc.getQuery("SEL_ALL_STORE")+ "\n ";
        	  sqlCnt.setString(i++, strBonsaGb);
          }
          sqlCnt.put(strSql);
          listCnt = select2List(sqlCnt);
          sql = new SqlWrapper();
          i = 1;
          strSql = svc.getQuery("SEL_HEADER")+ "\n ";
          if(strAllGb.equals("Y") && listCnt.size() > 1){ // 전체 포함 : 전체 포함 구분 Y, 권한점의 개수가 2개 이상인경우에만 전체 추가
    		  strSql += svc.getQuery("SEL_ALLGB")+ "\n ";
    	  }
          
          if(strAuthGb.equals("Y")){ // 권한 적용
        	  strSql += svc.getQuery("SEL_STORE")+ "\n ";
        	  sql.setString(i++, strUserId);
        	  sql.setString(i++, strBonsaGb);
        	  // Y 나 ''을 보낼경우 매입, 매장조직 조건 추가  (default ; '') 
         	 if(addConds[0].equals("") || addConds[0].equals("Y")){
         		strSql += svc.getQuery("SEL_STORE_ORG_FLAG")+ "\n ";
            	  	sql.setString(i++, strOrgFlag);
         	 }
          }else if(strAuthGb.equals("N")){// 권한 미적용
        	  strSql += svc.getQuery("SEL_ALL_STORE")+ "\n ";
        	  sql.setString(i++, strBonsaGb);
          }
         
          strSql += svc.getQuery("SEL_TAIL")+ "\n ";
          sql.put(strSql);
          list = select2List(sql);

        } catch (Exception e) {
          throw e;
        }
        return list;
    }        
    /**
     * 부문(Dept) 조회
     *
     * @param  : 
     * @return :
     */
    public List getDept(ActionForm form, MultiInput mi, String strUserId, String strOrgFlag) throws Exception {
    	List list = null;
    	List listCnt = null;
        SqlWrapper sql = null;
        Service svc = null;
        String  strSql = "";
        int i = 1;
        
        try {
          connect("pot");
          
          svc = (Service) form.getService();
          sql = new SqlWrapper();
         
          mi.next();
          
          String strAuthGb   	= mi.getString("AUTH_GB");
          String strStrCd   	= mi.getString("STR_CD");
          String strAllGb   	= mi.getString("ALL_GB");
          String orgFlag   		= mi.getString("ORG_FLAG");
          String strMngOrgYn 	= mi.getString("MNG_ORG_YN");
          strOrgFlag = orgFlag.equals("")?strOrgFlag:orgFlag;
          
          
          // 권한 부분의 개수조회
          if(strAuthGb.equals("Y")){ // 권한 적용
    		  strSql = svc.getQuery("SEL_DEPT")+ "\n ";
        	  sql.setString(i++, strUserId);
        	  sql.setString(i++, strOrgFlag);
        	  sql.setString(i++, strStrCd);
    	  }else{ // 권한 미적용
    		  strSql = svc.getQuery("SEL_ALL_DEPT")+ "\n ";
        	  sql.setString(i++, strOrgFlag);
        	  sql.setString(i++, strStrCd);
    	  }
    	  
    	  if(!strMngOrgYn.equals("")){ // 관리조직 여부 조건 추가
    		  strSql += svc.getQuery("ADD_MNG_ORG_YN")+ "\n ";
    		  sql.setString(i++, strMngOrgYn);
    	  }
    	  sql.put(strSql);
    	  listCnt = select2List(sql);
          sql.close();
          sql.clearParameter();
          i =1;
          strSql = svc.getQuery("SEL_HEADER")+ "\n ";
          
    	  if(strAllGb.equals("Y") && listCnt.size() != 1){ // 전체 포함
    		  strSql += svc.getQuery("SEL_ALLGB")+ "\n ";
    	  }
    	  
    	  if(strAuthGb.equals("Y")){ // 권한 적용
    		  strSql += svc.getQuery("SEL_DEPT")+ "\n ";
        	  sql.setString(i++, strUserId);
        	  sql.setString(i++, strOrgFlag);
        	  sql.setString(i++, strStrCd);
    	  }else{ // 권한 미적용
    		  strSql += svc.getQuery("SEL_ALL_DEPT")+ "\n ";
        	  sql.setString(i++, strOrgFlag);
        	  sql.setString(i++, strStrCd);
    	  }
    	  
    	  if(!strMngOrgYn.equals("")){ // 관리조직 여부 조건 추가
    		  strSql += svc.getQuery("ADD_MNG_ORG_YN")+ "\n ";
    		  sql.setString(i++, strMngOrgYn);
    	  }
    	  
    	  strSql += svc.getQuery("SEL_TAIL")+ "\n ";
          sql.put(strSql);

          list = select2List(sql);

        } catch (Exception e) {
          throw e;
        }
        return list;
    }
    
    /**
     * 팀 조회
     *
     * @param  : 
     * @return :
     */
    public List getTeam(ActionForm form, MultiInput mi, String strUserId, String strOrgFlag) throws Exception {
    	List list = null;
        SqlWrapper sql = null;
        Service svc = null;
        String  strSql = "";
        int i = 1;
        
        try {
          connect("pot");
          
          svc = (Service) form.getService();
          sql = new SqlWrapper();
         
          mi.next();
          
          String strAuthGb   = mi.getString("AUTH_GB");
          String strStrCd   = mi.getString("STR_CD");
          String strDept   = mi.getString("DEPT");
          String strAllGb   = mi.getString("ALL_GB");
          String orgFlag   = mi.getString("ORG_FLAG");
          String strMngOrgYn 	= mi.getString("MNG_ORG_YN");
          strOrgFlag = orgFlag.equals("")?strOrgFlag:orgFlag;
          
          //권한 팀 개수 조회
          if(strAuthGb.equals("Y")){
    		  strSql = svc.getQuery("SEL_TEAM")+ "\n ";
    		  sql.setString(i++, strUserId);
        	  sql.setString(i++, strOrgFlag);
        	  sql.setString(i++, strStrCd);
    	  }else{
    		  strSql = svc.getQuery("SEL_ALL_TEAM")+ "\n ";
        	  sql.setString(i++, strOrgFlag);
    		  sql.setString(i++, strStrCd);
    	  }
    	  strSql += svc.getQuery("SEL_CONDI_DEPT_LIKE")+ "\n ";
		  sql.setString(i++, strDept);
		  if(!strMngOrgYn.equals("")){ // 관리조직 여부 조건 추가
    		  strSql += svc.getQuery("ADD_MNG_ORG_YN")+ "\n ";
    		  sql.setString(i++, strMngOrgYn);
    	  }
		  
		  sql.put(strSql);
		  list = select2List(sql);
		  sql.close();
		  sql.clearParameter();
          i =1;
          strSql = svc.getQuery("SEL_HEADER")+ "\n ";
    	  if(strAllGb.equals("Y") && list.size() != 1){ // 전체 포함
    		  strSql += svc.getQuery("SEL_ALLGB")+ "\n ";
    	  }
    	  
    	  if(strAuthGb.equals("Y")){
    		  strSql += svc.getQuery("SEL_TEAM")+ "\n ";
    		  sql.setString(i++, strUserId);
        	  sql.setString(i++, strOrgFlag);
        	  sql.setString(i++, strStrCd);
    	  }else{
    		  strSql += svc.getQuery("SEL_ALL_TEAM")+ "\n ";
        	  sql.setString(i++, strOrgFlag);
    		  sql.setString(i++, strStrCd);
    	  }
    	  strSql += svc.getQuery("SEL_CONDI_DEPT_LIKE")+ "\n ";
		  sql.setString(i++, strDept);
		  if(!strMngOrgYn.equals("")){ // 관리조직 여부 조건 추가
    		  strSql += svc.getQuery("ADD_MNG_ORG_YN")+ "\n ";
    		  sql.setString(i++, strMngOrgYn);
    	  }
    	  strSql += svc.getQuery("SEL_TAIL")+ "\n ";
          sql.put(strSql);
          list = select2List(sql);
        } catch (Exception e) {
          throw e;
        }
        return list;
    }
    
    /**
     * PC 조회
     *
     * @param  : 
     * @return :
     */
    public List getPc(ActionForm form, MultiInput mi, String strUserId, String strOrgFlag) throws Exception {
    	List list = null;
        SqlWrapper sql = null;
        Service svc = null;
        String  strSql = "";
        int i = 1;
        
        try {
          connect("pot");
          
          svc = (Service) form.getService();
          sql = new SqlWrapper();
         
          mi.next();
          
          String strAuthGb   = mi.getString("AUTH_GB");
          String strStrCd   = mi.getString("STR_CD");
          String strDept   = mi.getString("DEPT");
          String strTeam   = mi.getString("TEAM");
          String strAllGb   = mi.getString("ALL_GB");
          String orgFlag   = mi.getString("ORG_FLAG");
          String strMngOrgYn 	= mi.getString("MNG_ORG_YN");
          strOrgFlag = orgFlag.equals("")?strOrgFlag:orgFlag;
          
          //PC 권한 개수 조회
          
          if(strAuthGb.equals("Y")){
    		  strSql = svc.getQuery("SEL_PC")+ "\n ";
        	  sql.setString(i++, strUserId);
        	  sql.setString(i++, strOrgFlag);
        	  sql.setString(i++, strStrCd);
        	  
        	  if(strDept.equals("") || strDept.length() == 2){
        		  strSql += svc.getQuery("SEL_CONDI_DEPT")+ "\n ";
        		  sql.setString(i++, strDept);
        	  }
        	  if(strTeam.equals("") || strTeam.length() == 2){
        		  strSql += svc.getQuery("SEL_CONDI_TEAM")+ "\n ";
        		  sql.setString(i++, strTeam);
        	  }
    	  }else{
    		  strSql = svc.getQuery("SEL_ALL_PC")+ "\n ";
        	  sql.setString(i++, strOrgFlag);
    		  sql.setString(i++, strStrCd);
    		  strSql += svc.getQuery("SEL_CONDI_DEPT_LIKE")+ "\n ";
    		  sql.setString(i++, strDept);
    		  strSql += svc.getQuery("SEL_CONDI_TEAM_LIKE")+ "\n ";
    		  sql.setString(i++, strTeam);
    	  }
    	 
    	  if(!strMngOrgYn.equals("")){ // 관리조직 여부 조건 추가
    		  strSql += svc.getQuery("ADD_MNG_ORG_YN")+ "\n ";
    		  sql.setString(i++, strMngOrgYn);
    	  }
    	  
    	  sql.put(strSql);
    	  list = select2List(sql);
    	  
    	  sql.close();
    	  sql.clearParameter();
    	  i=1;
          strSql = svc.getQuery("SEL_HEADER")+ "\n ";
    	  if(strAllGb.equals("Y") && list.size() != 1){ // 전체 포함
    		  strSql += svc.getQuery("SEL_ALLGB")+ "\n ";
    	  }
    	  if(strAuthGb.equals("Y")){
    		  strSql += svc.getQuery("SEL_PC")+ "\n ";
        	  sql.setString(i++, strUserId);
        	  sql.setString(i++, strOrgFlag);
        	  sql.setString(i++, strStrCd);
        	  
        	  if(strDept.equals("") || strDept.length() == 2){
        		  strSql += svc.getQuery("SEL_CONDI_DEPT")+ "\n ";
        		  sql.setString(i++, strDept);
        	  }
        	  if(strTeam.equals("") || strTeam.length() == 2){
        		  strSql += svc.getQuery("SEL_CONDI_TEAM")+ "\n ";
        		  sql.setString(i++, strTeam);
        	  }
    	  }else{
    		  strSql += svc.getQuery("SEL_ALL_PC")+ "\n ";
        	  sql.setString(i++, strOrgFlag);
    		  sql.setString(i++, strStrCd);
    		  strSql += svc.getQuery("SEL_CONDI_DEPT_LIKE")+ "\n ";
    		  sql.setString(i++, strDept);
    		  strSql += svc.getQuery("SEL_CONDI_TEAM_LIKE")+ "\n ";
    		  sql.setString(i++, strTeam);
    	  }
    	 
    	  if(!strMngOrgYn.equals("")){ // 관리조직 여부 조건 추가
    		  strSql += svc.getQuery("ADD_MNG_ORG_YN")+ "\n ";
    		  sql.setString(i++, strMngOrgYn);
    	  }
    	  strSql += svc.getQuery("SEL_TAIL")+ "\n ";
    	  
          sql.put(strSql);

          list = select2List(sql);

        } catch (Exception e) {
          throw e;
        }
        return list;
    }
	   
	/** 
	 * 조회(매입,반품,점출입,매가인상하)
	 *  
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getDetail1(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null; 
		String strQuery = ""; 
		int i = 1;

		String strStrCd    = String2.nvl(form.getParam("strStrCd"));  
		String strSlip     = String2.nvl(form.getParam("strSlip"));  
		String strSlipFlag = String2.nvl(form.getParam("strSlipFlag"));  
		 
		sql = new SqlWrapper();
		svc = (Service) form.getService(); 
		connect("pot");
		
		
		sql.put(svc.getQuery("SEL_DETAIL1"));  
		sql.setString(i++, strStrCd);  
		sql.setString(i++, strSlip); 
		sql.setString(i++, strSlipFlag); 
		
 
//		System.out.println(sql); 
		ret = select2List(sql);
		System.out.println("118DAOret.size() = " +  ret.size());
		return ret;
	}
	
	/**
	 * 규격단품 대출입발주  상세 내역 조회                                                                       
	 * 
	 * @param form                     
	 * @return
	 * @throws Exception 
	 */
	public List[] getDetail2(ActionForm form) throws Exception {
		
		List ret[] = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";  
		int i = 1;
 
		String strStrCd    = String2.nvl(form.getParam("strStrCd"));			// 점
		String strSlipNo   = String2.nvl(form.getParam("strSlipNo"));		// 대입전표번호
		String strPSlipNo  = String2.nvl(form.getParam("strPSlipNo"));		// 대출전표번호 
		String strSlipFlag = String2.nvl(form.getParam("strSlipFlag"));		// 대출전표번호
 
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		ret = new List[2];
		
		connect("pot");

		sql.setString(i++, strStrCd); 
		if("C".equals(strSlipFlag)) 
			sql.setString(i++, strSlipNo);
		else
			sql.setString(i++, strPSlipNo);

		sql.close();
		i= 1;
		strQuery = svc.getQuery("SEL_DETAIL2") + "\n";
		sql.put(strQuery);   
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo);
		ret[0] = select2List(sql);                                       

		sql.close();
		i= 1;
		strQuery = svc.getQuery("SEL_DETAIL2") + "\n";
		sql.put(strQuery);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPSlipNo);
		ret[1] = select2List(sql);

		return ret;
	} 
}
