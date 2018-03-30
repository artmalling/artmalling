/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package common.dao;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import common.util.Util;
import common.vo.SessionInfo;


import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;


/**
 * <p>공통으로 사용되는  DAO</p>
 * 
 * @created  on 1.0, 2010/12/24
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class CCom900DAO extends AbstractDAO {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */

    /**
     * 버튼 권한 조회
     * 
     * @param svc
     * @return String
     */
    public String getButtonPermission(String userId, String pid) throws Exception {

        Map myMap = null;
        SqlWrapper sql = null;        

        try {            
            sql = new SqlWrapper();
            
            String sqlString = "WITH USER_PROGRAM_GRUD AS (                           \n" +  
                "    -- 사용자별 프로그램 CRUD                                            \n" +
                "    SELECT COUNT(*) CNT                                              \n" + 
                "      FROM COM.TC_USRPGM                                                 \n" +
                "     WHERE USER_ID   = ?                                              \n" +
                "       AND PID      = ?                                              \n" +
                "    ), GROUP_PROGRAM_GRUD AS (                                       \n" +
                "    -- 그룹별 프로그램 CRUD                                              \n" +
                "    SELECT COUNT(*) CNT                                              \n" +
                "      FROM COM.TC_GRPPGM                                           \n" +
                "     WHERE GROUP_CD = ( SELECT GROUP_CD                              \n" +
                "                          FROM COM.TC_USRMST                            \n" +
                "                         WHERE USER_ID = ?)                           \n" +
                "       AND PID    = ?                               				  \n" +
                "    )                                                                \n" +
                "    SELECT -- 우선 사용자별 프로그램 CRUD에서 먼저 확인, 그 다음 그룹별 프로그램 CRUD 확인 \n" +
                "       -- 그래도 없다면  권한이 없도록 처리                                                                   \n" +
                "    (                                                                \n" +
                "     CASE WHEN 'super' = ?                                            \n" +
                "         THEN (                                                      \n" +
                "                SELECT DECODE(IS_RET,'Y','1','N','0')||              \n" +
                "                       DECODE(IS_NEW,'Y','1','N','0')||              \n" +
                "                       DECODE(IS_DEL,'Y','1','N','0')||              \n" +
                "                       DECODE(IS_SAVE,'Y','1','N','0')||             \n" +
                "                       DECODE(IS_EXCEL,'Y','1','N','0')||            \n" +
                "                       DECODE(IS_PRINT,'Y','1','N','0')||            \n" +
                "                       DECODE(IS_CONFIRM,'Y','1','N','0')||          \n" +
                "                       '0' CRUD                                      \n" +          
                "                  FROM COM.TC_PGMMST                                 \n" +
                "                 WHERE PID      = ?                                  \n" +
                "               )                                                     \n" +
                "     WHEN UP.CNT > 0                                            \n" +
                "         THEN (                                                      \n" +
                "                SELECT DECODE(A.IS_RET||B.IS_RET,'YY','1','0')||           \n" +
                "                       DECODE(A.IS_NEW||B.IS_NEW,'YY','1','0')||           \n" +
                "                       DECODE(A.IS_DEL||B.IS_DEL,'YY','1','0')||           \n" +
                "                       DECODE(A.IS_SAVE||B.IS_SAVE,'YY','1','0')||         \n" +
                "                       DECODE(A.IS_EXCEL||B.IS_EXCEL,'YY','1','0')||       \n" +
                "                       DECODE(A.IS_PRINT||B.IS_PRINT,'YY','1','0')||       \n" +
                "                       DECODE(A.IS_CONFIRM||B.IS_CONFIRM,'YY','1','0')||	\n" +
                "                       '0' CRUD                                      \n" +          
                "                  FROM COM.TC_USRPGM A                               \n" +
                "                     , COM.TC_PGMMST B                               \n" +
                "                 WHERE A.USER_ID   = ?                               \n" +
                "                   AND A.PID      = ?                                \n" +
                "                   AND A.PID      = B.PID                            \n" +
                "               )                                                     \n" +
                "     WHEN  GP.CNT > 0                                                \n" +
                "         THEN (                                                      \n" +
                "                SELECT DECODE(A.IS_RET||B.IS_RET,'YY','1','0')||           \n" +
                "                       DECODE(A.IS_NEW||B.IS_NEW,'YY','1','0')||           \n" +
                "                       DECODE(A.IS_DEL||B.IS_DEL,'YY','1','0')||           \n" +
                "                       DECODE(A.IS_SAVE||B.IS_SAVE,'YY','1','0')||         \n" +
                "                       DECODE(A.IS_EXCEL||B.IS_EXCEL,'YY','1','0')||       \n" +
                "                       DECODE(A.IS_PRINT||B.IS_PRINT,'YY','1','0')||       \n" +
                "                       DECODE(A.IS_CONFIRM||B.IS_CONFIRM,'YY','1','0')||	\n" +
                "                       '0' CRUD                                      \n" +           
                "                  FROM COM.TC_GRPPGM A                               \n" +
                "                     , COM.TC_PGMMST B                               \n" +
                "                 WHERE A.GROUP_CD = ( SELECT GROUP_CD                \n" +
                "                                      FROM COM.TC_USRMST             \n" +
                "                                     WHERE USER_ID = ?)              \n" +
                "                   AND A.PID    = ?               					  \n" +
                "                   AND A.PID      = B.PID                            \n" +
                "              )                                                      \n" +
                "     ELSE                                                            \n" +
                "           (                                                         \n" +
                "               '00000000'                                            \n" +
                "           )                                                         \n" +
                "     END                                                             \n" +
                "    ) permission                                                     \n" +
                "FROM USER_PROGRAM_GRUD UP, GROUP_PROGRAM_GRUD GP                     \n";            
                        
            //logger.info("::::::::::::Button Permission::::::::::: " + sqlString);
            sql.put(sqlString);
            
/*            sql.setString(1, userId);
            sql.setString(2, pid   );
            sql.setString(3, userId);
            sql.setString(4, pid   );
            sql.setString(5, userId);
            sql.setString(6, pid   );
            sql.setString(7, userId);
            sql.setString(8, pid   );*/
            sql.setString(1, userId);
            sql.setString(2, pid   );
            sql.setString(3, userId);
            sql.setString(4, pid   );
            sql.setString(5, userId);
            sql.setString(6, pid   );
            sql.setString(7, userId);
            sql.setString(8, pid   );
            sql.setString(9, userId);
            sql.setString(10, pid   );
            
            connect("pot");
            myMap = selectMap(sql);

        } catch (Exception e) {
            throw e;
        }
        
        //logger.info("Button Permission ::::: " + myMap.get("permission").toString());

        return myMap.get("permission").toString();
    }
    
    
    /**
     * 프로그램 타이틀 조회
     * 
     * 원래 LEFT MENU 누를때 값을 던져 받을려고 했으나 한글이 깨져
     * ButtonPermission에서 999를 불러 DAO에서 Query 함
     * 
     * @param  svc
     * @return String
     */
    public String getProgramTitle(String pid) throws Exception {

        Map myMap = null;
        SqlWrapper sql = null;
        String title = "";

        try {            
            sql = new SqlWrapper();
            
            String sqlString = " SELECT SNAME TITEL FROM COM.TC_PGMSMENU "   
                             + "  WHERE  SCODE = ? ";        
                                   
            sql.put(sqlString);
            sql.setString(1, pid   );           

            connect("pot");
            myMap = selectMap(sql);
            
            if (myMap.get("title") != null) {
                title = myMap.get("title").toString();
            }

        } catch (Exception e) {
            throw e;
        }
        
        //logger.info("Program Title ::::: " + myMap.get("title").toString());

        return title;
    }
    

    /**
     * 사용자 방문 로그 셋팅
     * 
     * @param svc
     * @return Map
     */
    public void setLog(String userId, String pid, String sub_System, String lcode, String mcode) throws Exception {

        SqlWrapper sql = null;        

        try {            
            sql = new SqlWrapper();
            
            String sqlString = "INSERT INTO COM.TC_USRLOG 	\n" +  
                               "          ( USER_ID			\n" +
                               "  		  , PID				\n" +
                               "          , VISIT_DATE		\n" +
                               "          , SUB_SYSTEM		\n" +
                               "          , LCODE			\n" +
                               "          , MCODE )			\n" +
                               "     VALUES					\n" +
                               "          ( ?				\n" +
                               "          , ?				\n" +
                               "          , TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') \n" +
                               "          , ?				\n" +
                               "          , ?				\n" +
                               "          , ? )				\n" ; 
        
            sql.put(sqlString);
            
            sql.setString(1, userId    );
            sql.setString(2, pid       );
            sql.setString(3, sub_System);
            sql.setString(4, lcode     );
            sql.setString(5, mcode     );

            connect("pot");
            begin();
            update(sql);

        } catch (Exception e) {
            rollback();
            throw e;
        }finally {
            end();
        }
    }
    /**
     * 사용자 방문 로그 셋팅_접속 아이피 신규 추가(사설).
     * 
     * @param svc
     * @return Map
     */
    public void setLog(String userId, String pid, String sub_System, String lcode, String mcode, String userIp) throws Exception {

        SqlWrapper sql = null;        

        try {            
            sql = new SqlWrapper();
            
            String sqlString = "INSERT INTO COM.TC_USRLOG 	\n" +  
                               "          ( USER_ID			\n" +
                               "  		  , PID				\n" +
                               "          , VISIT_DATE		\n" +
                               "          , SUB_SYSTEM		\n" +
                               "          , LCODE			\n" +
                               "          , MCODE 			\n" +
                               "		  , USER_IP	   )	\n" +
                               "     VALUES					\n" +
                               "          ( ?				\n" +
                               "          , ?				\n" +
                               "          , TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') \n" +
                               "          , ?				\n" +
                               "          , ?				\n" +
                               "          , ?  				\n" + 
            				   "          , ? )				\n" ;            			
        
            sql.put(sqlString);
            
            sql.setString(1, userId    );
            sql.setString(2, pid       );
            sql.setString(3, sub_System);
            sql.setString(4, lcode     );
            sql.setString(5, mcode     );
            sql.setString(6, userIp     );

            connect("pot");
            begin();
            update(sql);

        } catch (Exception e) {
            rollback();
            throw e;
        }finally {
            end();
        }
    }
    /**
     * 사용자 방문 로그 셋팅_접속 아이피 신규 추가(사설, 공인).
     * 
     * @param svc
     * @return Map
     */
    public void setLog(String userId, String pid, String sub_System, String lcode, String mcode, String userIp, String userPblIp) throws Exception {

        SqlWrapper sql = null;        

        try {            
            sql = new SqlWrapper();
            
            String sqlString = "INSERT INTO COM.TC_USRLOG 	\n" +  
                               "          ( USER_ID			\n" +
                               "  		  , PID				\n" +
                               "          , VISIT_DATE		\n" +
                               "          , SUB_SYSTEM		\n" +
                               "          , LCODE			\n" +
                               "          , MCODE 			\n" +
                               "		  , USER_IP	  	 	\n" +
                               "		  , USER_PBLIP  )	\n" +
                               "     VALUES					\n" +
                               "          ( ?				\n" +
                               "          , ?				\n" +
                               "          , TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') \n" +
                               "          , ?				\n" +
                               "          , ?				\n" +
                               "          , ?  				\n" +
                               "          , ?  				\n" +
            				   "          , ? )				\n" ;            			
        
            sql.put(sqlString);
            
            sql.setString(1, userId    );
            sql.setString(2, pid       );
            sql.setString(3, sub_System);
            sql.setString(4, lcode     );
            sql.setString(5, mcode     );
            sql.setString(6, userIp     );

            connect("pot");
            begin();
            update(sql);

        } catch (Exception e) {
            rollback();
            throw e;
        }finally {
            end();
        }
    }
    
	 /**
     * 사용자가 로그인시 로그인일시 INSERT
     **/  
	public void insLogin(String userId, String sessionId) throws Exception {
	   	
		 int ret = 0;
		 String query = null;
		 SqlWrapper sql = null;
		 
		 try{
			 connect("pot");
			 begin();
			 query = "INSERT INTO COM.TC_LOGHST(           \n"
			 	   + "                          USER_ID    \n"
				   + "                        , LOGIN_DATE \n"
				   + "                        , SESSION_ID \n"
				   + "                         )           \n"
			       + "                   VALUES(           \n"
				   + "                          ?          \n"
				   + "                        , TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') \n"
				   + "                        , ?          \n"
				   + "                         )           \n";
			 	
				int i = 1;				
				sql = new SqlWrapper();
				sql.put(query);
				sql.setString(i++,  userId);
				sql.setString(i++,  sessionId);
				ret = update(sql);
				
				if(ret!=1){
					throw new Exception("데이터의 적합성 문제로 인하여"+
										"데이터 입력을 하지 못했습니다.");
				}
					
			}catch(Exception e){
				rollback();
				throw e;
			}finally{
				end();
			}
	 }
	
	
	 /**
     * 사용자가 로그아웃시 로그아웃일시 UPDATE
     **/ 
	public boolean updLogout(String userId) throws Exception {
	   	
		 int retCnt = 0;
		 boolean retVal = false;
		 String query = null;
		 SqlWrapper sql = null;
		 
		 try{
			 connect("pot");
			 begin();
			 query = "UPDATE COM.TC_LOGHST \n"
				   + "   SET LOGOUT_DATE = TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') \n"
			       + " WHERE USER_ID = ?          \n"
			       + "   AND LOGOUT_DATE IS NULL  \n"
			       + "   AND LOGIN_DATE = (SELECT MAX(LOGIN_DATE)\n"
			       + "                       FROM COM.TC_LOGHST  \n"
 	   			   + "                      WHERE USER_ID = ?)   \n";
        
			 	int i = 1;				
				sql = new SqlWrapper();
				sql.put(query);
				sql.setString(i++, userId);
				sql.setString(i++, userId);
				retCnt = update(sql);
				
				if(retCnt!=0){
					retVal = true;
				}
				
			}catch(Exception e){
				rollback();
				throw e;
			}finally{
				end();
			}
			
			return retVal;
	 }
	
	
	 /**
     * 자기 자신의 세션을 업데이트한다.(자기자신을 로그아웃처리)
     **/ 
	public boolean updLogout(String userId, String sessionId) throws Exception {
	   	
		 int retCnt = 0;
		 boolean retVal = false;
		 String query = null;
		 SqlWrapper sql = null;
		 
		 try{
			 connect("pot");
			 begin();
			 query = "UPDATE COM.TC_LOGHST         \n"
			 	   + "   SET LOGOUT_DATE = TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') \n"
			       + " WHERE USER_ID = ?     \n"
			       + "   AND SUBSTR(SESSION_ID, 1, INSTR(SESSION_ID, '.')-1 ) = ?\n";
			    // + "   AND SESSION_ID = ?  \n";
			 
			 	int i = 1;				
				sql = new SqlWrapper();
				sql.put(query);
				sql.setString(i++, userId);
				sql.setString(i++, sessionId.substring(0, sessionId.indexOf(".")));
				retCnt = update(sql);
				
				if(retCnt!=0){
					retVal = true;
				}
				System.out.println("User : " + userId + " >> updLogout : " + retVal + " >>>>>>>>>>>>");
				
				
			}catch(Exception e){
				rollback();
				throw e;
			}finally{
				end();
			}
			
			return retVal;
	 }

    /**
     * 중복로그인시 사용 
     * :중복로그인을 허용하는지 체크
	 * @param userId : 사용자 ID
	 * @return String : 
	 */

	public String chkMultiLogin(String userId) throws Exception {
        Map myMap = null;
        SqlWrapper sql = new SqlWrapper();
            
        String sqlString = "SELECT NVL(MULTI_LOGIN, 'N') AS MULTI_LOGIN \n"
                	     + "  FROM COM.TC_USRMST \n"
			             + " WHERE USER_ID = ?   \n";      
                                   
		sql.put(sqlString);
		sql.setString(0, userId);          

        connect("pot");
        myMap = selectMap(sql);
            
        return myMap.get("MULTI_LOGIN").toString();
	}	
	
    /**
     * 중복로그인시 사용 
     * :클러스터링시 세션아이디가 변경되기때문에 DB의 SESSION_ID 내용과 
     *  현재 접속한 사용자 세션아이디의 앞부분 내용만을 비교한다. 
	 * @param userId : 사용자 ID
	 * @param sessionId : 세션 ID
	 * @return int : 로그인 안됨 - 0, 로그인 됨 - 1, 로그인되어있고 세션아이디 같음 - 2
	 */
	public int loginChk(String userId, String sessionId) throws Exception{
		SqlWrapper sql = null;
		Map map = null;
		int i = 1;
		int ret = 0;
		String query = null;
		String storedSessionId = null;
		
		try {
			 query = "SELECT SESSION_ID      \n"
			       + "  FROM COM.TC_LOGHST A \n"
			       + " WHERE USER_ID = ?     \n"
			       + "   AND LOGOUT_DATE IS NULL \n"
			       + "   AND LOGIN_DATE = (SELECT MAX(LOGIN_DATE) FROM COM.TC_LOGHST\n"
	   			   + "                      WHERE USER_ID = ?)\n";
			 
			connect("pot");

			sql = new SqlWrapper();
			sql.put(query);
			sql.setString(i++, userId);
			sql.setString(i++, userId);
			map = selectMap(sql);
			
			if(map.get("session_id") == null){
				return 0;
			}
			
			int index = map.get("session_id").toString().indexOf(".");
			
			
			//운영기 jeus클러스터링될 경우 '.'뒷부분의 내용이 바뀐다.
			if(index > 0){
				storedSessionId = map.get("session_id").toString().substring(0, index);
				sessionId = sessionId.substring(0, index);
			}
			
			//로컬 혹은 개발기
			else{
				storedSessionId = map.get("session_id").toString();
			}
			
			//세션아이디가 동일하다.(정상로그인)
			if(sessionId.equals(storedSessionId)){
				ret = 2;
			}
			//세션아이디는 다르고 접속중인 아이디가 있다.(중복로그인)
			else if(map.get("session_id") != null){
				
				ret = 1;
			}
			//접속중이 아니다.
			else{
				ret = 0;
			}
			
		} catch (Exception e) {			
			throw e;
		}
		return ret;
	}
	
    /**
     * 기타코드 조회
     *
     * @param  : 
     * @return :
     */
    public List getEtcCode(ActionForm form, MultiInput mi) throws Exception {
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
        String nulGb   = mi.getString("NUL_GB");
        
        if ((allGb.equals("Y")) || (allGb.equals("y"))) {
            getSql = ("SELECT '%' AS CODE , '전체' AS NAME , -1  AS SORT FROM DUAL   ") + ("\n UNION \n");  
        }
        
        if ((nulGb.equals("Y")) || (nulGb.equals("y"))) {
            getSql = ("SELECT '' AS CODE , '' AS NAME , -1  AS SORT FROM DUAL   ") + ("\n UNION \n");  
        }
        
        getSql = getSql + svc.getQuery("SEL_ETC_CODE");
      
        sql.put(getSql);

        sql.setString(1, mi.getString("SYS_PART"));
        sql.setString(2, mi.getString("COMM_PART"));

        list = select2List(sql);

      } catch (Exception e) {
        throw e;
      }
      return list;
    }

    /**
     * 기타코드 조회REFER
     *
     * @param  : 
     * @return :
     */
    public List getEtcCodeRefer(ActionForm form, MultiInput mi) throws Exception {
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
        String nulGb   = mi.getString("NUL_GB");
        
        if ((allGb.equals("Y")) || (allGb.equals("y"))) {
            getSql = ("SELECT '%' AS CODE , '전체' AS NAME , 0  AS SORT, '' AS REFER_CODE , 0 AS REFER_VALUE FROM DUAL   ") + ("\n UNION \n");  
        }
        
        if ((nulGb.equals("Y")) || (nulGb.equals("y"))) {
            getSql = ("SELECT '' AS CODE , '' AS NAME , 0  AS SORT, '' AS REFER_CODE , 0 AS REFER_VALUE FROM DUAL   ") + ("\n UNION \n");  
        }
        
        getSql = getSql + svc.getQuery("SEL_ETC_CODE_REFER");
      
        sql.put(getSql);

        sql.setString(1, mi.getString("SYS_PART"));
        sql.setString(2, mi.getString("COMM_PART"));

        list = select2List(sql);

      } catch (Exception e) {
        throw e;
      }
      return list;
    }
    

	/**
	 * <p>
	 * 엑셀 다운로드 로그 기록
	 * </p>
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int saveExcelDownLog(ActionForm form, MultiInput mi, String strID, String pId)
			throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
	    Service svc = null;
		int i;
		
		String strPid; 
		
		try {
			connect("pot");
	        svc = (Service) form.getService();
			begin();
			sql = new SqlWrapper();

			while (mi.next()) {
				sql.close();
				//신규 입력시
				if (mi.IS_INSERT()) {
					i = 0;					
					strPid = mi.getString("PID"); // 프로그램 ID
					
					sql.put(svc.getQuery("INS_DOWNLOG"));					
					
					sql.setString(++i, strID);
					if (strPid.equals(""))
						sql.setString(++i, pId);
					else
						sql.setString(++i, strPid);
					sql.setString(++i, mi.getString("DOWN_COND"));	

					// 점정보를 신규추가한다.
					res = update(sql);
				} else {
					continue;
				}


				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				ret += res;
			}

		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}

    
    
    
}
