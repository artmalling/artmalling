/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package tcom.dao;

import java.io.Reader;
import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.ConnectionFactory;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
import oracle.sql.CLOB;
/**
 * <p>조직조회</p>
 * 
 * @created  on 1.0, 2010/02/09
 * @created  by HSEON(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class TCom204DAO extends AbstractDAO2 { 

    /**
	 * 공지사항조회페이지 : 공지사항 리스트 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List selectNotiList(ActionForm form) throws Exception {
		
		List	   	list 	= null;
        SqlWrapper	sql 	= null; 
        Service 	svc 	= null;

		String strQuery = "";
        int i = 0;
        try {

			String strSdate 	= String2.nvl(form.getParam("strSdate"));	//게시시작일
			String strEdate   	= String2.nvl(form.getParam("strEdate"));	//게시종료일 	
			String strStrCd   	= String2.nvl(form.getParam("strStrCd"));	//점
			String strDeptCd  	= String2.nvl(form.getParam("strDeptCd"));	//부문
			String strGbn 		= String2.nvl(form.getParam("strGbn"));		//공지구분  
			String strOrgFlag   = String2.nvl(form.getParam("strOrgFlag"));	//조직  
			String strNotiFlag  = String2.nvl(form.getParam("strNotiFlag"));//게시구분  
			String strTitle  	= URLDecoder.decode(String2.nvl(form.getParam("strTitle")), "UTF-8");  //제목
			String strContent  	= URLDecoder.decode(String2.nvl(form.getParam("strContent")), "UTF-8");//내용
			
			/*
			System.out.println( "--------------------------strSdate    ===> " + strSdate );
			System.out.println( "--------------------------strEdate    ===> " + strEdate   );
			System.out.println( "--------------------------strStrCd    ===> " + strStrCd   );
			System.out.println( "--------------------------strDeptCd   ===> " + strDeptCd  );
			System.out.println( "--------------------------strGbn      ===> " + strGbn  ); 
			System.out.println( "--------------------------strNotiFlag ===> " + strNotiFlag );
			System.out.println( "--------------------------strTitle    ===> " + strTitle );
			System.out.println( "--------------------------strContent  ===> " + strContent );
			System.out.println( "--------------------------strOrgFlag  ===> " + strOrgFlag );
			*/ 
    		sql = new SqlWrapper(); 
    		svc = (Service) form.getService();  
    		
    		// 기본쿼리1
			strQuery = svc.getQuery("SEL_NOTI_LIST_1") + "\n";
			
			// 점코드
			if( !("%").equals(strStrCd) )
			{
				strQuery += svc.getQuery("SEL_NOTI_LIST_STR_CD") + "\n";
				sql.setString(++i, strStrCd); 
			}
			
			// 부문코드
			if( !("%").equals(strDeptCd) )
			{
				strQuery += svc.getQuery("SEL_NOTI_LIST_DEPT_CD") + "\n";
				sql.setString(++i, strDeptCd); 
			}
			
			// 조직
			if( !("%").equals(strOrgFlag) )
			{
				strQuery += svc.getQuery("SEL_NOTI_LIST_ORG_FLAG") + "\n";
				sql.setString(++i, strOrgFlag); 
			}

    		// 기본쿼리2
			strQuery += svc.getQuery("SEL_NOTI_LIST_2") + "\n"; 
			
    		// 기본쿼리3(점과 부문코드가 들어올 경우 IN QUERY)
			if( (!("%").equals(strStrCd) || !("%").equals(strDeptCd)) ) 
				strQuery += svc.getQuery("SEL_NOTI_LIST_3") + "\n"; 
			else 
				strQuery += svc.getQuery("SEL_NOTI_LIST_4") + "\n";  

    		// 기본쿼리4
			strQuery += svc.getQuery("SEL_NOTI_LIST_5") + "\n";
			
    		// 게시일
			if( !( ("").equals(strSdate) && ("").equals(strEdate)) )
			{
				strQuery += svc.getQuery("SEL_NOTI_LIST_NOTI_DATE") + "\n";
				sql.setString(++i, strSdate);
				sql.setString(++i, strEdate);
			} 
			
			// 공지구분
			if( !("%").equals(strGbn) )
			{
				strQuery += svc.getQuery("SEL_NOTI_LIST_NOTI_GBN") + "\n";
				sql.setString(++i, strGbn); 
			}

			if( !("").equals(strTitle) )
			{
				strQuery += svc.getQuery("SEL_NOTI_LIST_TITLE") + "\n";
				sql.setString(++i, strTitle); 
			}

			if( !("").equals(strContent) )
			{
				strQuery += svc.getQuery("SEL_NOTI_LIST_CONTENT") + "\n";
				sql.setString(++i, strContent); 
			}
			
			//게시구분
			if( !("%").equals(strNotiFlag) )
			{
				strQuery += svc.getQuery("SEL_NOTI_LIST_FLAG") + "\n";
				sql.setString(++i, strNotiFlag); 
			}
			
			// 정렬 = PID
			strQuery += svc.getQuery("SEL_NOTI_LIST_ORDER");
			
    		connect("pot");	 
			sql.put(strQuery); 

			// System.out.println( strQuery );
			list = executeQueryByList(sql); 
            
        } catch (Exception e) {
            throw e;
        }
        return list;
	}
	
	/**
	 * 공지사항조회페이지 : 사용자 리스트 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List selectNotiUserList(ActionForm form) throws Exception {
		
		List	   	list 	= null;
        SqlWrapper	sql 	= null; 
        Service 	svc 	= null;

        try {

			String strNotiID 	= String2.nvl(form.getParam("strNotiID"));	//게시시작일
			
			sql = new SqlWrapper(); 
    		svc = (Service) form.getService();  
    		
    		connect("pot");	 
    		
    		// 기본쿼리1
    		sql.put(svc.getQuery("SEL_NOTI_USER_LIST"));
    		sql.setString(1, strNotiID);
			
			list = executeQueryByList(sql); 
            
        } catch (Exception e) {
            throw e;
        }
        return list;
	}
	
	/**
     * 공지사항 상세 조회1
	 * 
	 * @param form
	 * @return
	 * @throws Exception
     */
    public List selectNotice(ActionForm form) throws Exception {
		
		List	   	list 	= null;
        SqlWrapper	sql 	= null; 
        Service 	svc 	= null;

		String strNoti   = String2.nvl(form.getParam("strNoti"));		// 게시물id 	

        try {

            // System.out.println("================ " + list);
    		sql = new SqlWrapper(); 
    		svc = (Service) form.getService();
            int i = 0;
            
            sql.put(svc.getQuery("SEL_NOTICE"));
            sql.setString(++i, "jsp/selectClob.jsp?iSelId="+strNoti+"&iTable=COM.TC_NOTI&iColumn=NOTI_CONTENT&iSelColumn=NOTI_ID");
            sql.setString(++i, "jsp/selectClob.jsp?iSelId="+strNoti+"&iTable=COM.TC_NOTI&iColumn=NOTI_CONTENT&iSelColumn=NOTI_ID");
            sql.setString(++i, strNoti);

    		connect("pot");	
            list = executeQueryByList(sql);
              
            // System.out.println("================ " + list);
        } catch (Exception e) {
            throw e;
        }
        return list;
    }
    
    public StringBuffer selectNoticeContent(String strNoti) {
    	
    	StringBuffer buf = new StringBuffer();
    	
    	CLOB clob = null;
    	
    	Connection con = null;
    	PreparedStatement psmt = null;
    	ResultSet rs = null;
    	int index = 1;
    	
    	try {
    		
    		//데이터베이스 연결
    		con = ConnectionFactory.getConnection("pot");
    		
    		con.setAutoCommit(false);
    		
    		StringBuffer strSql = new StringBuffer();
    		
    		strSql.append("\n SELECT NOTI_CONTENT   ");
    		strSql.append("\n   FROM COM.TC_NOTI    ");
    		strSql.append("\n  WHERE NOTI_ID = ?    ");
    		
    		psmt = con.prepareStatement(strSql.toString());
    		 
    		psmt.setString(index++, strNoti);

    		rs = psmt.executeQuery();
    		
    		if(rs.next())
    		{
    		    clob = (oracle.sql.CLOB)rs.getClob(1);
    		    if(clob != null) {
    			    Reader is = clob.getCharacterStream();
    			    int c =0;
    			    while ((c = is.read()) != -1){
    			        buf.append((char)c);
    			    }
    		    } else {
    		    	buf.append("내용이 존재하지 않습니다.");
    		    }
    		}
    		//System.out.println("buf ====================>" + buf.toString());
    	} catch(Exception e) {
    		e.printStackTrace();
    		//System.out.println("selectClob.jsp Exception : " + e.toString());
    	} finally {
    		if(rs != null) { try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }}
    		if(psmt != null) { try { psmt.close(); } catch (SQLException e) { e.printStackTrace(); }}
    		if(con != null) { try { con.close(); } catch (SQLException e) { e.printStackTrace(); }}
    	}
    	
    	return buf;
    }

	/**
     * 공지사항 상세 조회2 : 부문
	 * 
	 * @param form
	 * @return
	 * @throws Exception
     */
    public List selectNoticeDept(ActionForm form) throws Exception {
		
		List	   	list 	= null;
        SqlWrapper	sql 	= null; 
        Service 	svc 	= null;

		String strNoti   = String2.nvl(form.getParam("strNoti")); // 게시물id 	 
        try {
        	
    		sql = new SqlWrapper(); 
    		svc = (Service) form.getService();
            
            sql.put(svc.getQuery("SEL_NOTICE_DEPT"));
            sql.setString(1, strNoti);

    		connect("pot");	
            list = executeQueryByList(sql);
            
        } catch (Exception e) {
            throw e;
        }
        return list;
    }
    
    
	/**
     * 점정보 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
     */
    public List selStoreInfo(ActionForm form) throws Exception {
		
		List	   	list 	= null;
        SqlWrapper	sql 	= null; 
        Service 	svc 	= null;

        try {
        	
    		sql = new SqlWrapper(); 
    		svc = (Service) form.getService();
            
            sql.put(svc.getQuery("SEL_STR_CD"));

    		connect("pot");	
            list = executeQueryByList(sql);
            
        } catch (Exception e) {
            throw e;
        }
        return list;
    }
    
	/**
	 * 공지구분 -> 부문공지  :: 점 정보조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List selectStrCd(ActionForm form) throws Exception {
		
		List	   	list 	= null;
        SqlWrapper	sql 	= null;
        Service 	svc 	= null; 
 
        try {
        	
    		sql = new SqlWrapper();
    		svc = (Service) form.getService();
            
            sql.put(svc.getQuery("SEL_STR_CD")); 

    		connect("pot");	
            list = executeQueryByList(sql);
        } catch (Exception e) {
            throw e;
        }
        return list;
	}

    
	/**
	 * 공지구분 -> 부문공지  :: 점 정보  -> 부문정보조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List selectDeptCd(ActionForm form) throws Exception {
		
		List	   	list 	= null;
        SqlWrapper	sql 	= null;
        Service 	svc 	= null;

        int	i = 0;
		String strStrCd   = String2.nvl(form.getParam("strStrCd"));		//점코드 	
		String strOrgFlag = String2.nvl(form.getParam("strOrgFlag"));		//점코드 	

        try {
        	
    		sql = new SqlWrapper();
    		svc = (Service) form.getService();
            
            sql.put(svc.getQuery("SEL_DEPT_CD")); 
            sql.setString(++i, strStrCd);
            sql.setString(++i, strOrgFlag);

    		connect("pot");	
            list = executeQueryByList(sql);
        } catch (Exception e) {
            throw e;
        }
        return list;
	}

	public static String replaceString(String str)
	{
		String rStr = null;
		
		str = str.replaceAll("script", "x_script");
		str = str.replaceAll("onload=java_script:", "");
		str = str.replaceAll("onerror", "onerror2");
		rStr = str.replaceAll("onload=", "");
		
		return rStr;
	}
}