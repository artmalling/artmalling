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
 * <p>점, 부분, 팀, PC 콤보 조회</p>
 * 
 * @created  on 1.0, 2010/02/15	
 * @created  by 김성미(FUJITSU KOREA LTD.) 
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class CCom901DAO extends AbstractDAO {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
	// ToDo:: 세션 정보 체크  => 매입/ 매장조직 
    /**
     * 점코드 조회
     *
     * @param  : 
     * @return : 
     */
    public List getStore(ActionForm form, MultiInput mi, String strUserId, String strOrgFlag) throws Exception {
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
          String strBonsaGb   = mi.getString("BONSA_GB"); 	// 본사점 표시 유무  0:본사점, 1:매장
          String strAllGb   = mi.getString("ALL_GB");
          String addCond 	= mi.getString("ADD_CONDITION");
          String[] addConds = addCond.split("#G#");
        
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
          strSql = svc.getQuery("SEL_STR_HEADER")+ "\n ";
          if(strAllGb.equals("Y") && listCnt.size() > 1){ // 전체 포함 : 전체 포함 구분 Y, 권한점의 개수가 2개 이상인경우에만 전체 추가
    		  strSql += svc.getQuery("SEL_ALLGB_STR")+ "\n ";
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
     * 점코드 조회
     *
     * @param  : 
     * @return : 
     */
    public List getStore2(ActionForm form, MultiInput mi, String strUserId, String strOrgFlag) throws Exception {
    	    	
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
          String strBonsaGb   = mi.getString("BONSA_GB"); 	// 본사점 표시 유무  0:본사점, 1:매장
          String strAllGb   = mi.getString("ALL_GB");
          String addCond 	= mi.getString("ADD_CONDITION");
          String[] addConds = addCond.split("#G#");
                    
          
          // 권한점의 개수를 조회
          if(strAuthGb.equals("Y")){ // 권한 적용
        	 
        	  strSql = svc.getQuery("SEL_STORE2")+ "\n ";
        	  sqlCnt.setString(i++, strUserId);
        	  sqlCnt.setString(i++, strBonsaGb);
        	           	 
         	  strSql += svc.getQuery("SEL_STORE_ORG_FLAG2")+ "\n ";         	 
              sqlCnt.setString(i++, strOrgFlag);
         	 
          }else if(strAuthGb.equals("N")){// 권한 미적용
        	  
        	  strSql = svc.getQuery("SEL_ALL_STORE2")+ "\n ";        	  
        	  sqlCnt.setString(i++, strBonsaGb);
          }
          sqlCnt.put(strSql);
          listCnt = select2List(sqlCnt);
          sql = new SqlWrapper();
          i = 1;
          
          strSql = svc.getQuery("SEL_STR_HEADER2")+ "\n ";          
          //if(strAllGb.equals("Y") && listCnt.size() > 1){ // 전체 포함 : 전체 포함 구분 Y, 권한점의 개수가 2개 이상인경우에만 전체 추가
          
          
          //  3관 데이터 1관으로 이전 후 점구분 전체 조건 해제   2013-11-14 
          //if(strAllGb.equals("Y")){
    		//  strSql += svc.getQuery("SEL_ALLGB_STR2")+ "\n ";
    		  
    	  //}
          
          if(strAuthGb.equals("Y")){ // 권한 적용
        	  
        	  strSql += svc.getQuery("SEL_STORE2")+ "\n ";
        	  
        	  sql.setString(i++, strUserId);
        	  sql.setString(i++, strBonsaGb);
        		
     		  strSql += svc.getQuery("SEL_STORE_ORG_FLAG2")+ "\n ";
     		  
        	  sql.setString(i++, strOrgFlag);
         	 
          }else if(strAuthGb.equals("N")){// 권한 미적용
        	  
        	  strSql += svc.getQuery("SEL_ALL_STORE2")+ "\n ";
        	  
        	  sql.setString(i++, strBonsaGb);
          }
          strSql += svc.getQuery("SEL_TAIL2")+ "\n "; 
         
          sql.put(strSql);
          
          list = select2List(sql);
          
         
        } catch (Exception e) {
        	e.printStackTrace();
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
     * 부문(Dept) 조회
     *
     * @param  : 
     * @return :
     */
    public List getDept2(ActionForm form, MultiInput mi, String strUserId, String strOrgFlag) throws Exception {
    	
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
          /*strOrgFlag = orgFlag.equals("")?strOrgFlag:orgFlag;*/
          
          
          // 권한 부분의 개수조회
          if(strAuthGb.equals("Y")){ // 권한 적용
        	 
    		  strSql = svc.getQuery("SEL_DEPT2")+ "\n ";
        	  sql.setString(i++, strUserId);
        	  sql.setString(i++, strOrgFlag);
        	  sql.setString(i++, strStrCd);
    	  }else{ // 권한 미적용
    		  
    		  strSql = svc.getQuery("SEL_ALL_DEPT2")+ "\n ";
        	  sql.setString(i++, strOrgFlag);
        	  sql.setString(i++, strStrCd);
    	  }
    	  
    	  if(!strMngOrgYn.equals("")){ // 관리조직 여부 조건 추가
    		 
    		  strSql += svc.getQuery("ADD_MNG_ORG_YN2")+ "\n ";
    		  sql.setString(i++, strMngOrgYn);
    	  }
    	  sql.put(strSql);
    	  listCnt = select2List(sql);
    	 
          sql.close();
          sql.clearParameter();
          i =1;
          
          strSql = svc.getQuery("SEL_HEADER2")+ "\n ";
          
    	 // if(strAllGb.equals("Y") && listCnt.size() != 1){ // 전체 포함
         // if(strAllGb.equals("Y") && listCnt.size() != 0){ // 전체 포함
          if(strAllGb.equals("Y") ){ // 전체 포함
    		 
    		  strSql += svc.getQuery("SEL_ALLGB2")+ "\n ";
    	  }
    	  
    	  if(strAuthGb.equals("Y")){ // 권한 적용
    		  
    		  strSql += svc.getQuery("SEL_DEPT2")+ "\n ";
        	  sql.setString(i++, strUserId);
        	  sql.setString(i++, strOrgFlag);
        	  sql.setString(i++, strStrCd);
    	  }else{ // 권한 미적용
    		  
    		  strSql += svc.getQuery("SEL_ALL_DEPT2")+ "\n ";
        	  sql.setString(i++, strOrgFlag);
        	  sql.setString(i++, strStrCd);
    	  }
    	  
    	  if(!strMngOrgYn.equals("")){ // 관리조직 여부 조건 추가
    		 
    		  strSql += svc.getQuery("ADD_MNG_ORG_YN2")+ "\n ";
    		  sql.setString(i++, strMngOrgYn);
    	  }
    	  
    	  strSql += svc.getQuery("SEL_TAIL2")+ "\n ";
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
    	  
          //BIJ. COMMENT 2011-07-20
          //if(strAllGb.equals("Y") && list.size() != 1){ // 전체 포함
          if(strAllGb.equals("Y") && list.size() != 0){ // 전체 포함
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
     * 팀 조회
     *
     * @param  : 
     * @return :
     */
    public List getTeam2(ActionForm form, MultiInput mi, String strUserId, String strOrgFlag) throws Exception {
    	
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
          // strOrgFlag =strOrgFlag; //orgFlag.equals("")?strOrgFlag:orgFlag;
         
          
          //권한 팀 개수 조회
          if(strAuthGb.equals("Y")){
        	  
    		  strSql = svc.getQuery("SEL_TEAM2")+ "\n ";
    		  sql.setString(i++, strUserId);
        	  sql.setString(i++, strOrgFlag);
        	  sql.setString(i++, strStrCd);
    	  }else{
    		 
    		  strSql = svc.getQuery("SEL_ALL_TEAM2")+ "\n ";
        	  sql.setString(i++, strOrgFlag);
    		  sql.setString(i++, strStrCd);
    	  }
          
    	  strSql += svc.getQuery("SEL_CONDI_DEPT_LIKE2")+ "\n ";
		  sql.setString(i++, strDept);
		  if(!strMngOrgYn.equals("")){ // 관리조직 여부 조건 추가
			
    		  strSql += svc.getQuery("ADD_MNG_ORG_YN2")+ "\n ";
    		  sql.setString(i++, strMngOrgYn);
    	  }
		  
		  sql.put(strSql);
		  list = select2List(sql);
		  sql.close();
		  sql.clearParameter();
          i =1;
          
          strSql = svc.getQuery("SEL_HEADER2")+ "\n ";
    	  
          //BIJ. COMMENT 2011-07-20
          //if(strAllGb.equals("Y") && list.size() != 1){ // 전체 포함
          if(strAllGb.equals("Y") && list.size() != 0){ // 전체 포함
        	
    		  strSql += svc.getQuery("SEL_ALLGB2")+ "\n ";
    	  }
    	  
    	  if(strAuthGb.equals("Y")){
    		
    		  strSql += svc.getQuery("SEL_TEAM2")+ "\n ";
    		  sql.setString(i++, strUserId);
        	  sql.setString(i++, strOrgFlag);
        	  sql.setString(i++, strStrCd);
    	  }else{
    		
    		  strSql += svc.getQuery("SEL_ALL_TEAM2")+ "\n ";
        	  sql.setString(i++, strOrgFlag);
    		  sql.setString(i++, strStrCd);
    	  }
    	  
    	  strSql += svc.getQuery("SEL_CONDI_DEPT_LIKE2")+ "\n ";
		  sql.setString(i++, strDept);
		  if(!strMngOrgYn.equals("")){ // 관리조직 여부 조건 추가
			 
    		  strSql += svc.getQuery("ADD_MNG_ORG_YN2")+ "\n ";
    		  sql.setString(i++, strMngOrgYn);
    	  }
		  
    	  strSql += svc.getQuery("SEL_TAIL2")+ "\n ";
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
          
          //BIJ. COMMENT 2011-07-20
          //if(strAllGb.equals("Y") && list.size() != 1){ // 전체 포함
    	  if(strAllGb.equals("Y") && list.size() != 0){ // 전체 포함
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
     * PC 조회
     *
     * @param  : 
     * @return :
     */
    public List getPc2(ActionForm form, MultiInput mi, String strUserId, String strOrgFlag) throws Exception {
    	
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
          //strOrgFlag = orgFlag.equals("")?strOrgFlag:orgFlag;
                   
          //PC 권한 개수 조회
          
          if(strAuthGb.equals("Y")){
    		  strSql = svc.getQuery("SEL_PC2")+ "\n ";
        	  sql.setString(i++, strUserId);
        	  sql.setString(i++, strOrgFlag);
        	  sql.setString(i++, strStrCd);
        	  
        	  if(strDept.equals("") || strDept.length() == 2){
        		  strSql += svc.getQuery("SEL_CONDI_DEPT2")+ "\n ";
        		  sql.setString(i++, strDept);
        	  }
        	  if(strTeam.equals("") || strTeam.length() == 2){
        		  strSql += svc.getQuery("SEL_CONDI_TEAM2")+ "\n ";
        		  sql.setString(i++, strTeam);
        	  }
    	  }else{
    		  strSql = svc.getQuery("SEL_ALL_PC2")+ "\n ";
        	  sql.setString(i++, strOrgFlag);
    		  sql.setString(i++, strStrCd);
    		  strSql += svc.getQuery("SEL_CONDI_DEPT_LIKE2")+ "\n ";
    		  sql.setString(i++, strDept);
    		  strSql += svc.getQuery("SEL_CONDI_TEAM_LIKE2")+ "\n ";
    		  sql.setString(i++, strTeam);
    	  }
    	 
    	  if(!strMngOrgYn.equals("")){ // 관리조직 여부 조건 추가
    		  strSql += svc.getQuery("ADD_MNG_ORG_YN2")+ "\n ";
    		  sql.setString(i++, strMngOrgYn);
    	  }
    	  
    	  sql.put(strSql);
    	  list = select2List(sql);
    	  
    	  sql.close();
    	  sql.clearParameter();
    	  i=1;
          strSql = svc.getQuery("SEL_HEADER2")+ "\n ";
          
          //BIJ. COMMENT 2011-07-20
          //if(strAllGb.equals("Y") && list.size() != 1){ // 전체 포함
    	  if(strAllGb.equals("Y") && list.size() != 0){ // 전체 포함
    		  strSql += svc.getQuery("SEL_ALLGB2")+ "\n ";
    	  }
    	  if(strAuthGb.equals("Y")){
    		  strSql += svc.getQuery("SEL_PC2")+ "\n ";
        	  sql.setString(i++, strUserId);
        	  sql.setString(i++, strOrgFlag);
        	  sql.setString(i++, strStrCd);
        	  
        	  if(strDept.equals("") || strDept.length() == 2){
        		  strSql += svc.getQuery("SEL_CONDI_DEPT2")+ "\n ";
        		  sql.setString(i++, strDept);
        	  }
        	  if(strTeam.equals("") || strTeam.length() == 2){
        		  strSql += svc.getQuery("SEL_CONDI_TEAM2")+ "\n ";
        		  sql.setString(i++, strTeam);
        	  }
    	  }else{
    		  strSql += svc.getQuery("SEL_ALL_PC2")+ "\n ";
        	  sql.setString(i++, strOrgFlag);
    		  sql.setString(i++, strStrCd);
    		  strSql += svc.getQuery("SEL_CONDI_DEPT_LIKE2")+ "\n ";
    		  sql.setString(i++, strDept);
    		  strSql += svc.getQuery("SEL_CONDI_TEAM_LIKE2")+ "\n ";
    		  sql.setString(i++, strTeam);
    	  }
    	 
    	  if(!strMngOrgYn.equals("")){ // 관리조직 여부 조건 추가
    		  strSql += svc.getQuery("ADD_MNG_ORG_YN2")+ "\n ";
    		  sql.setString(i++, strMngOrgYn);
    	  }
    	  strSql += svc.getQuery("SEL_TAIL2")+ "\n ";
    	  
          sql.put(strSql);

          list = select2List(sql);

        } catch (Exception e) {
          throw e;
        }
        return list;
    }

    /**
     * CORNER 조회
     *
     * @param  : 
     * @return :
     */
    public List getCorner2(ActionForm form, MultiInput mi, String strUserId) throws Exception {
    	
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
          
          //CORNER 권한 개수 조회
		  strSql = svc.getQuery("SEL_CORNER")+ "\n ";
		  sql.setString(i++, mi.getString("STR_CD"));
		  sql.setString(i++, mi.getString("DEPT"));
		  sql.setString(i++, mi.getString("TEAM"));
		  sql.setString(i++, mi.getString("PC"));
    	  sql.put(strSql);
    	  list = select2List(sql);
    	  
    	  sql.close();
    	  sql.clearParameter();
    	  i=1;
          strSql = svc.getQuery("SEL_HEADER")+ "\n ";
    	  
          //BIJ. COMMENT 2011-07-20
          //if(mi.getString("ALL_GB").equals("Y") && list.size() != 1){ // 전체 포함
          if(mi.getString("ALL_GB").equals("Y") && list.size() != 0){ // 전체 포함
    		  strSql += svc.getQuery("SEL_ALLGB")+ "\n ";
    	  }
    	  
          strSql += svc.getQuery("SEL_CORNER")+ "\n ";
		  sql.setString(i++, mi.getString("STR_CD"));
		  sql.setString(i++, mi.getString("DEPT"));
		  sql.setString(i++, mi.getString("TEAM"));
		  sql.setString(i++, mi.getString("PC"));
    	  
    	  strSql += svc.getQuery("SEL_TAIL")+ "\n ";
    	  
          sql.put(strSql);
          list = select2List(sql);
        } catch (Exception e) {
          throw e;
        }
        return list;
    }
    /**
     * CORNER 조회
     *
     * @param  : 
     * @return :
     */
    public List getCorner(ActionForm form, MultiInput mi, String strUserId) throws Exception {
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
          
          //CORNER 권한 개수 조회
		  strSql = svc.getQuery("SEL_CORNER2")+ "\n ";
		  sql.setString(i++, mi.getString("STR_CD"));
		  sql.setString(i++, mi.getString("DEPT"));
		  sql.setString(i++, mi.getString("TEAM"));
		  sql.setString(i++, mi.getString("PC"));
    	  sql.put(strSql);
    	  list = select2List(sql);
    	  
    	  sql.close();
    	  sql.clearParameter();
    	  i=1;
          strSql = svc.getQuery("SEL_HEADER2")+ "\n ";
    	  
          //BIJ. COMMENT 2011-07-20
          //if(mi.getString("ALL_GB").equals("Y") && list.size() != 1){ // 전체 포함
          if(mi.getString("ALL_GB").equals("Y") && list.size() != 0){ // 전체 포함
    		  strSql += svc.getQuery("SEL_ALLGB2")+ "\n ";
    	  }
    	  
          strSql += svc.getQuery("SEL_CORNER2")+ "\n ";
		  sql.setString(i++, mi.getString("STR_CD"));
		  sql.setString(i++, mi.getString("DEPT"));
		  sql.setString(i++, mi.getString("TEAM"));
		  sql.setString(i++, mi.getString("PC"));
    	  
    	  strSql += svc.getQuery("SEL_TAIL2")+ "\n ";
    	  
          sql.put(strSql);
          list = select2List(sql);
        } catch (Exception e) {
          throw e;
        }
        return list;
    }
    
    /**
     * 시설코드 조회
     *
     * @param  : 
     * @return :
     */
	public List getFlc(ActionForm form, MultiInput mi, String strUserId, String strOrgFlag) throws Exception {
    	List list = null;
        SqlWrapper sql = null;
        Service svc = null;
        int i = 0;
        try {
			connect("pot");
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			mi.next();
			// 전체추가 구분(Y/N)
            if (mi.getString("ALLGBN").equals("Y")) {
            	sql.put(svc.getQuery("SEL_FCL_ALLGB"));
            }
            
            // 시설구분데이터 위치 구분(C:공통점마스터, M:임대관리마스터)
            if (mi.getString("STAGBN").equals("C")) {
            	// 권한구분(Y/N)
                if (mi.getString("AUTHGBN").equals("Y")) {
                	sql.put(svc.getQuery("SEL_FCL_AUTH_COM"));
                	sql.setString(++i, strUserId);
                } else {
                	sql.put(svc.getQuery("SEL_FCL_COM"));
                }
            } else {
            	// 권한구분(Y/N)
                if (mi.getString("AUTHGBN").equals("Y")) {
                	sql.put(svc.getQuery("SEL_FCL_AUTH"));
                	sql.setString(++i, strUserId);
                } else {
                	sql.put(svc.getQuery("SEL_FCL"));
                }
            }
            
            
            
            // 주거/비주거구분(1:비주거, 2:주거[아파트,CES] )
            if (mi.getString("HUSFLAG").equals("2")) { 			//주거
            	sql.put(svc.getQuery("SEL_FCL_WHERE_J"));
            } else if (mi.getString("HUSFLAG").equals("1")) { 	//비주거
            	sql.put(svc.getQuery("SEL_FCL_WHERE_B"));
            } else if (mi.getString("HUSFLAG").equals("3")) { 	//CES
            	sql.put(svc.getQuery("SEL_FCL_WHERE_CES"));
            }

			//추가 조건이 있을경우
			String addCondition = mi.getString("ADD_CONDITION");
			if (!addCondition.equals("")) {
				String[] addConds = addCondition.split("#G#");
				for (int idx = 0; idx < addConds.length; idx++) {
					switch(idx){ 
				        case 0: // STR_FLAG(0:본사, 1:점포)
				        	if (!addConds[idx].equals("")) {
					        	sql.put(svc.getQuery("SEL_FCL_WHERE_STR_FLAG"));
						        sql.setString(++i, addConds[idx] );
				        	}
					    	break;
				        case 1: // CES_YN(N:미포함, Y:포함)
				        	sql.put(svc.getQuery("SEL_FCL_WHERE_CES_YN"));
					    	break;
				     
					}
				}
			}
          
			sql.put(svc.getQuery("SEL_FCL_ORDER"));
			list = select2List(sql);

        } catch (Exception e) {
          throw e;
        }
        return list;
    }
	
    /**
     * 매입사 코드 조회
     *
     * @param  : 
     * @return :
     */
	public List getBcompCode(ActionForm form, MultiInput mi ) throws Exception {
    	List list = null;
        SqlWrapper sql = null;
        Service svc = null;
        int i = 0;
        try {
			connect("pot");
			svc = (Service) form.getService();
			sql = new SqlWrapper();

			mi.next();
			 
			//전체추가 구분(Y/N)
            if (mi.getString("ALL_GB").equals("Y")) {
            	sql.put(svc.getQuery("SEL_ALLGB"));
            }
			sql.put(svc.getQuery("SEL_BCOMP_CODE"));
			list = select2List(sql);

        } catch (Exception e) {
          throw e;
        }
        return list;
    }	

    /**
     * 발급사 코드 조회
     *
     * @param  : 
     * @return :
     */
	public List getCcompCode(ActionForm form, MultiInput mi ) throws Exception {
    	List list = null;
        SqlWrapper sql = null;
        Service svc = null;
        int i = 0;
        try {
			connect("pot");
			svc = (Service) form.getService();
			sql = new SqlWrapper();

			mi.next();
			 
			//전체추가 구분(Y/N)
            if (mi.getString("ALL_GB").equals("Y")) {
            	sql.put(svc.getQuery("SEL_ALLGB"));
            }
			sql.put(svc.getQuery("SEL_CCOMP_CODE"));
			list = select2List(sql);

        } catch (Exception e) {
          throw e;
        }
        return list;
    }	
	
	/**
     * 디뷰크카드조회 
     *
     * @param  : 
     * @return :
     */
	public List getDcardCode(ActionForm form, MultiInput mi ) throws Exception {
    	List list = null;
        SqlWrapper sql = null;
        Service svc = null;
        int i = 0;
        try {
			connect("pot");
			svc = (Service) form.getService();
			sql = new SqlWrapper();

			mi.next();
			//전체추가 구분(Y/N)
            if (mi.getString("ALL_GB").equals("Y")) {
            	sql.put(svc.getQuery("SEL_ALLGB"));
            }
			sql.put(svc.getQuery("SEL_DCARD_CODE"));
			list = select2List(sql);

        } catch (Exception e) {
          throw e;
        }
        return list;
    }	

	/**
     * 밴사카드 조회
     *
     * @param  : 
     * @return :
     */
	public List getVcardCode(ActionForm form, MultiInput mi ) throws Exception {
    	List list = null;
        SqlWrapper sql = null;
        Service svc = null;
        int i = 0;
        try {
			connect("pot");
			svc = (Service) form.getService();
			sql = new SqlWrapper();

			mi.next();
			//전체추가 구분(Y/N)
            if (mi.getString("ALL_GB").equals("Y")) {
            	sql.put(svc.getQuery("SEL_ALLGB"));
            }
			sql.put(svc.getQuery("SEL_VCARD_CODE"));
			list = select2List(sql);

        } catch (Exception e) {
          throw e;
        }
        return list;
    }		
	
	/**
     * 밴사카드 조회
     *
     * @param  : 
     * @return :
     */
	public List getChrgCode(ActionForm form, MultiInput mi ) throws Exception {
    	List list = null;
        SqlWrapper sql = null;
        Service svc = null;
        int i = 0;
        try {
			connect("pot");
			svc = (Service) form.getService();
			sql = new SqlWrapper();

			mi.next();
			
			sql.put(svc.getQuery("SEL_CHRG_CODE"));
			list = select2List(sql);

        } catch (Exception e) {
          throw e;
        }
        return list;
    }		
	
	
    /**
     * 출입구명조회
     *
     * @param  : 
     * @return : 
     */
    public List getGate(ActionForm form, MultiInput mi) throws Exception {
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
          
          String strCd        = mi.getString("STR_CD");   // 점코드
          String strBlockCd   = mi.getString("BLOCK_CD"); // 블럭코드
          
          sql = new SqlWrapper();
          i = 1;
          strSql = svc.getQuery("SEL_GATE_LIST")+ "\n ";
    	  sql.setString(i++, strCd);
    	  sql.setString(i++, strBlockCd);
          
          sql.put(strSql);
          list = select2List(sql);

        } catch (Exception e) {
          throw e;
        }
        return list;
    }	
	
    /**
     * 블럭명조회
     *
     * @param  : 
     * @return : 
     */
    public List getBlock(ActionForm form, MultiInput mi) throws Exception {
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
          
          String strCd   = mi.getString("STR_CD");   // 점코드
          
          sql = new SqlWrapper();
          i = 1;
          strSql = svc.getQuery("SEL_BLOCK_LIST")+ "\n ";
    	  sql.setString(i++, strCd);
          
          sql.put(strSql);
          list = select2List(sql);

        } catch (Exception e) {
          throw e;
        }
        return list;
    }
    	
    
    /**
     * 협력사 조회
     *
     * @param  : 
     * @return :
     */
	public List getVen(ActionForm form, MultiInput mi, String strUserId, String strOrgFlag) throws Exception {
    	List list = null;
        SqlWrapper sql = null;
        Service svc = null;
        int i = 0;
        try {
			connect("pot");
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			mi.next();
			// 전체추가 구분(Y/N)
            if (mi.getString("ALLGBN").equals("Y")) {
            	sql.put(svc.getQuery("SEL_ALLGB"));
            } 
          
			sql.put(svc.getQuery("SEL_VEN_LIST"));
			sql.setString(++i, mi.getString("STAGBN"));
			list = select2List(sql);

        } catch (Exception e) {
          throw e;
        }
        return list;
    }
}
