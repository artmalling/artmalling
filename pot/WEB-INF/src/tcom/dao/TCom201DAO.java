/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package tcom.dao;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.Reader;
import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import kr.fujitsu.ffw.base.BaseProperty;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.ConnectionFactory;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.Date2;
import kr.fujitsu.ffw.util.String2;
import oracle.sql.CLOB;

import common.util.Util;
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

public class TCom201DAO extends AbstractDAO2 { 

    private final static String FILE_PATH = BaseProperty.get("pot.upload.dir")+"notice/"; 
	/**
	 * 공지사항관리페이지 : 조회
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
	 * 공지사항관리페이지 : 삭제
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int deleteNotiList(ActionForm form, MultiInput mi) throws Exception {
 
		int res = 0;
        SqlWrapper sql = null;
		Service svc = null;

		int 	ret 	= 0;
		int 	ret1 	= 0;
		int 	ret2 	= 0;	
 
		try {
			connect("pot"); 
			begin();  
			sql = new SqlWrapper();  
			svc = (Service) form.getService();  

			while (mi.next()) { 
				sql.close(); 
				
				sql.put(svc.getQuery("DEL_NOTI")); 
				sql.setString(1, mi.getString("NOTI_ID"));  
				
				res = executeUpdate(sql);     
				ret1 += res;  

				sql.close(); 
				sql.put(svc.getQuery("DEL_NOTI_RECV"));  
				sql.setString(1, mi.getString("NOTI_ID"));  
				res = executeUpdate(sql); 
				 
				ret2 += res;  
				ret = ret1+ret2;
				
				if (ret < 1) 
				{ 
					throw new Exception("" + "데이터의 적합성 문제로 인하여 데이터를 삭제하지 못했습니다.");
				}
			}
			
		} catch (Exception e) { 
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret1;
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

	/**
	 * 사용자를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List selectUserList(ActionForm form) throws Exception {
		
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	 

        try {  
        } catch (Exception e) {
            throw e;
        }
        
        return list;
	}
	
	/**
	 * 사용자/그룹을 저장, 수정, 삭제 처리한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public List save(ActionForm form, MultiInput mi[], String strUserId, String strCLOB_data[]) throws Exception {

		Service svc 		= null;
		
		SqlWrapper sql  	= null;
		SqlWrapper sql1 	= null;
		SqlWrapper sql2 	= null;

		InputStream	is      = null;
		OutputStream fout   = null;
		
		List list 			= null;
	    List rows 			= new ArrayList();
	    List cols 			= new ArrayList();
		 
		int res 			= 0; 
		int ret1 			= 0;
		int ret2 			= 0;	
        String str[] 		= new String[1];

		int i; 
        int intCLOB 		= 0;
        
		String strNotiSeq 	= "";
		String strRecvSeq 	= "";
		String delYn 		= "N";
	    String strParam 	= null; 
		String fileReName   = null; 
		String strAddFileYn	= null;  

		
		try {
			connect("pot"); 
			begin();  
			sql = new SqlWrapper();  
            sql1 = new SqlWrapper();
			sql2 = new SqlWrapper();
			svc = (Service) form.getService();   

			boolean bl = false;
			strParam   = String2.nvl(form.getParam("strNoti"));				// 점코드 	
			strAddFileYn  = String2.nvl(form.getParam("strAddFileYn"));		// 파일추가여부 	
			 
			// 게시물ID
			if (("").equals(strParam))
			{ 
				sql.close();
				 		
				sql.put(svc.getQuery("SEL_NOTI_SEQ"));		  
				Map map = this.executeQueryByMap(sql);	
				
				strNotiSeq = String2.nvl((String)map.get("NOTI_SEQ"));
				
				if( strNotiSeq.equals("")) {
					throw new Exception("[USER]"+"게시ID오류  입니다.");
				}
			}
			else strNotiSeq = strParam;
			
			System.out.println("strNotiSeq : " + strNotiSeq);

			while (mi[0].next()) { 

	            if (mi[0].IS_INSERT())
	            {
	            	System.out.println("**** ActiveSquar EDIT MIME 파일처리 시작");
	            	
	            	/***** ActiveSquar EDIT MIME 파일처리 시작 *****/ 
	            	/*
			    	File makeDir 		= null;

			    	String uploadPath = new String();
			    	String dir 			= BaseProperty.get("pot.upload.dir") + "notice/";
			    	String dirwebeditor = "webeditor"; 
			    	uploadPath 			= dir + dirwebeditor;

			    	makeDir = new File(uploadPath);  	// 업로드할 디렉토리 생성
			    	makeDir.mkdirs();
			    	makeDir = null;

			    	String uploadUrl 		= new String();
			    	String webeditorhttp 	= BaseProperty.get("pot.upload.dir.webeditor.http");
			    	uploadUrl 				= webeditorhttp + "notice/webeditor";  
			       
					//MIME 인코딩
			    	NamoMime mime;
			    	mime = new NamoMime(); 
			    	mime.setSavePath(uploadPath);
			    	mime.setSaveURL(uploadUrl); 
			    	
			    	mime.decode(strCLOB_data[intCLOB]);
		        	
			    	str[0] = ""; 
			    	try{ 
			    		str[0] = replaceString(mime.getBodyContent()); 
			    	}catch(Exception e){ 
		                throw new Exception("" + "서식을 변환 중 문제가 발생하였습니다.");
			    	}
			    	mime.saveFile();
			    	*/
			    	
			    	System.out.println("**** ActiveSquar EDIT MIME 파일처리 종료");

			    	/***** ActiveSquar EDIT MIME 파일처리 종료 *****/ 
			    	
			    	/***** 첨부파일시작 *******************************/
			    	if(strAddFileYn.equals("Y"))
			    	{
			    		// file오픈하여 추가 한 경우만 파일 upload
			    		fileReName = Date2.getDateWithMillisecond() + "_" + mi[0].getString("FILE_NM") ;

						is = (InputStream)mi[0].get("FILE_PATH");  

						bl = saveFile(is, fileReName);  
						if(!bl)
							throw new Exception("[USER]File Upload를 실패하였습니다."); 
			    	}
			    	else
			    		fileReName =  mi[0].getString("FILE_NM") ; 
					
			    	/***** 첨부파일 종료*******************************/
				
					i = 0;
					sql1.put(svc.getQuery("INS_NOTI")); 
					sql1.setString(++i, strNotiSeq); 
					sql1.setString(++i, mi[0].getString("NOTI_TITLE"));
					//sql1.setString(++i, mi[0].getString("URL_CONTENT"));
					sql1.setString(++i, mi[0].getString("NOTI_CONTENT"));
					sql1.setString(++i, mi[0].getString("S_DATE")); 
					sql1.setString(++i, mi[0].getString("E_DATE")); 
					sql1.setString(++i, mi[0].getString("SEND_TO_ALL")); 
					sql1.setString(++i, strUserId); 
					sql1.setString(++i, strUserId); 
					sql1.setString(++i, fileReName); 
					sql1.setString(++i, mi[0].getString("TEL1")); 
					sql1.setString(++i, mi[0].getString("TEL2")); 
					sql1.setString(++i, mi[0].getString("TEL3")); 
					sql1.setString(++i, mi[0].getString("NOTI_FLAG")); 

		        	i=0;
		        	sql2.put(svc.getQuery("CLOB_NOTI"));
		        	sql2.setString(++i, strNotiSeq);      		//날짜   
		            //res = executeUpdateByCLOB(sql1, sql2, str);   
		        	res = executeUpdate(sql1);
		            
		            sql1.close();
		            sql2.close();
		            
		            if (res != 1) {
		                throw new Exception("" + "데이터의 적합성 문제로 인하여 \n 데이터 입력을 하지 못했습니다.");
		            }
				}else if (mi[0].IS_DELETE()) { 

			    	sql.close();
					i = 1;						
					sql.put(svc.getQuery("SEL_NOTI_CNT"));		

		        	sql.setString(i++, strNotiSeq);
					
					Map map = executeQueryByMap( sql );	
					String cnt = String2.nvl((String)map.get("CNT")); 
					
					if (!cnt.equals("0"))
					{
	                	i = 1;
		                sql1.put(svc.getQuery("DEL_NOTI"));
			        	sql1.setString(i++, strNotiSeq);  
		            	
		                res = executeUpdate(sql1);   
		                sql1.close();
		                
		    	        if (res != 1) {
		    	            throw new Exception("" + "데이터의 적합성 문제로 인하여 데이터 삭제를 하지 못했습니다.");
		    	        } 
					}

	            }
	            intCLOB++;
        	} 
			
			while (mi[1].next()) 
			{
				if (delYn.equals("N"))
				{
					// 데이터 무조건 삭제 후 저장
					sql.close();		
					
					i = 0;
					sql.put(svc.getQuery("DEL_NOTI_RECV"));  
					sql.setString(++i, strNotiSeq); 
					res = this.executeUpdate(sql); 
					delYn = "Y";  
				}
				sql.close();		
				
				i = 0;

				if(("T").equals(mi[1].getString("CHK")))
				{ 
					// 조직코드 조합
					String strStr  = null;
					String strDept = null;
	
					strStr = mi[1].getString("STR_CD");
					
					if( ("").equals(mi[1].getString("DEPT_CD"))) strDept = "00";
					else strDept = mi[1].getString("DEPT_CD"); 
					
					sql.put(svc.getQuery("INS_NOTI_RECV"));  
					sql.setString(++i, strNotiSeq); 
					sql.setString(++i, strStr + strDept + "000000"); 
					res = executeUpdate(sql);   
					
					ret2 += res; 
				}
			}

	       if (strRecvSeq != null){ 
	    	   cols.add(strNotiSeq);
	           rows.add(cols);
	       }
	       list = rows;
			
		} catch (Exception e) { 

			rollback();
			throw e;
			
		} finally {
			end();
		}
		return list;
	} 
	 
	/**
	 * 삭제 처리한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int delete(ActionForm form, MultiInput mi) throws Exception {
 
		int res = 0;
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;
		
		String errMsg 	= null;
		int 	ret 	= 0;
		int 	ret1 	= 0;
		int 	ret2 	= 0;	
 
		try {
			connect("pot"); 
			begin();  
			sql = new SqlWrapper();  
			svc = (Service) form.getService();    

			String strParam   = String2.nvl(form.getParam("strNoti"));		//점코드 	 
			sql.close(); 
			
			sql.put(svc.getQuery("DEL_NOTI")); 
			sql.setString(1, strParam);  
			
			res = executeUpdate(sql);     
			ret1 += res;  

			sql.close(); 
			sql.put(svc.getQuery("DEL_NOTI_RECV"));  
			sql.setString(1, strParam); 
			res = executeUpdate(sql); 
			 
			ret2 += res;  

			ret = ret1+ret2;
			
			if (ret < 1) 
			{ 
				throw new Exception("" + "데이터의 적합성 문제로 인하여 데이터를 삭제하지 못했습니다.");
			}
			
			
		} catch (Exception e) { 
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret1;
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
	

    /**
	 * <p>
	 * FILE UPLOAD
	 * </p>
	 * 
	 */
	public static boolean saveFile(InputStream is, String strFileName) throws Exception
	{
		OutputStream fout 	= null; 
		int maxFileSize     = 20;
		try{
			
			System.out.println("--" + FILE_PATH);

			// File Upload    
			File filePath = new File(FILE_PATH);
			if(!filePath.exists()) filePath.mkdir(); 
			
			fout = new FileOutputStream(FILE_PATH + strFileName); 
			
			int read;
			long logSize = 0;
			byte[] buf = new byte[512]; 

			while ((read = is.read(buf)) != -1) {
				fout.write(buf, 0, read);
				logSize += read;
				if (logSize >= 1024 * 1024 * maxFileSize) {
					throw new Exception(
							"업로드되는 파일의 사이즈는 "+maxFileSize+"메가를 넘길 수 없습니다.");
				}
			} 
			 
	    } catch (Exception e) {
	        throw e;
	    } finally {
	    	fout.close();
	    }
		return true;
	}
}
