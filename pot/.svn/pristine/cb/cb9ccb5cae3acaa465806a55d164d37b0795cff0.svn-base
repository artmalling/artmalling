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
import java.net.URLDecoder;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import common.namo.NamoMime;
import common.util.Util;

import kr.fujitsu.ffw.base.BaseProperty;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;



/**
 * <p>메뉴/프로그램을 조회합니다.</p>
 *
 * @created  on 1.0, 2010.12.12
 * @created  by 정지인(FUJITSU KOREA LTD.)
 *
 * @modified on
 * @modified by
 * @caused   by
 */

public class TCom202DAO extends AbstractDAO2 { 

    /**
     * <p>트리뷰를 위한 List를 리턴한다. </p>
     * 
     */
	public List getTreeList(ActionForm form) throws Exception {

		List	   	list 	= null;
        SqlWrapper	sql 	= null;
        Service 	svc 	= null;

		String strSubSystem	= null;
        try {
        	
        	strSubSystem = String2.nvl(form.getParam("strSubSystem"));	// 시스템구분
        	//System.out.println("_________________" + strSubSystem);
        	
    		sql = new SqlWrapper();
    		svc = (Service) form.getService();
            
            sql.put(svc.getQuery("SEL_TREE_VIEW"));  
            sql.setString(1, strSubSystem);     

    		connect("pot");	
            list = executeQueryByList(sql);
        } catch (Exception e) {
            throw e;
        }
        return list;
	}

    /**
     * <p>도움말을 조회한다.</p>
     * 
     */
	public List selectHelp(ActionForm form) throws Exception {

		List	   	list 	= null;
        SqlWrapper	sql 	= null;
        Service 	svc 	= null;
        int 		i 		= 0;
        try {
        	String strPid = String2.nvl(form.getParam("strPid"));	// 시스템구분
        	
    		sql = new SqlWrapper();
    		svc = (Service) form.getService();
            
            sql.put(svc.getQuery("SEL_HELPMSG"));  

            sql.setString(++i, "jsp/selectClob.jsp?iSelId="+strPid+"&iTable=COM.TC_HELPMSG&iColumn=HELP_MSG&iSelColumn=PID");
            sql.setString(++i, "jsp/selectClob.jsp?iSelId="+strPid+"&iTable=COM.TC_HELPMSG&iColumn=HELP_MSG&iSelColumn=PID");
            sql.setString(++i, strPid);

    		connect("pot");	
            list = executeQueryByList(sql);
        } catch (Exception e) {
            throw e;
        }
        return list;
	}
	
	  public String save(ActionForm form, MultiInput mi, String userId, String strCLOB_data[]) throws Exception { 
	        String ret 	= null;
	        int res 	= 0;
	        
	        int intCLOB 	= 0;
	        SqlWrapper sql  = null;
	        SqlWrapper sql1 = null;
	        SqlWrapper sql2 = null;
	        String str[] 	= new String[1];
	        
	        Service svc    	= null;  

	        String strSubSystem= String2.nvl(form.getParam("strSubSystem"));	// 시스템구분
        	int i=1;
        	
	        try { 
	            connect("pot");
	            begin();
	            sql  = new SqlWrapper();
	            sql1 = new SqlWrapper();
				sql2 = new SqlWrapper();
				
	            svc = (Service) form.getService();
	        	sql1.close();
	        	
	        	while (mi.next()) { 
	        		
		            if (mi.IS_INSERT())
		            { 
			        	sql1.close(); 
		            	/***** ActiveSquar EDIT MIME 파일처리 시작 *****/
			        	 
				    	File makeDir 		= null;

				    	String uploadPath = new String();
				    	String dir 			= BaseProperty.get("pot.upload.dir") + "help/";
				    	String dirwebeditor = "webeditor"; 
				    	uploadPath 			= dir + dirwebeditor;

				    	makeDir = new File(uploadPath);  	// 업로드할 디렉토리 생성
				    	makeDir.mkdirs();
				    	makeDir = null;
				    	
				    	
				    	/* url경로와 path경로 동일하게 써도 무관
				    	 * 
				    	 * 
				        <property>
				            <property-name>pot.upload.dir.webeditor.http</property-name>
				            <property-value>http://127.0.0.1:8088/pot/upload/</property-value>  
				        </property>
				        */
				    	String uploadUrl 		= new String();
				    	String webeditorhttp 	= BaseProperty.get("pot.upload.dir.webeditor.http");
				    	uploadUrl 				= webeditorhttp + "help/webeditor"; 

						//MIME 인코딩
				    	NamoMime mime;
				    	mime = new NamoMime(); 
				    	mime.setSavePath(uploadPath);
				    	mime.setSaveURL(uploadUrl);

		            	// System.out.println("------------------------- :: Dao " +  intCLOB  +  "// "+ strCLOB_data[intCLOB]);
				    	mime.decode(strCLOB_data[intCLOB]);   
			
				    	str[0] = "";
				    	try{
				    		str[0] = replaceString(mime.getBodyContent());   // 작은 따옴표(') 는 SQL에서 필드 구분자로 쓰이므로 \\'로 대체합니다.
				    		//System.out.println(str[0]);
					    }catch(Exception e){ 
			                throw new Exception("[USER]서식을 변환 중 문제가 발생하였습니다.");
				    	}
					    	
				    	mime.saveFile();

				    	/***** ActiveSquar EDIT MIME 파일처리 종료 *****/
			            String strPId   	= mi.getString("PID");
			            String strLcode		= mi.getString("LCODE");
			            String strMcode  	= mi.getString("MCODE");
			            String strScode   	= mi.getString("SCODE");
			            String strSubSys  	= strSubSystem;
			            String strRegId 	= userId;
			            
			        	sql1.put(svc.getQuery("INS_HELPMSG"));
			        	
			        	i = 1;
			        	sql1.setString(i++, strPId);      		// 프로그램ID
			        	sql1.setString(i++, strLcode);    		// 대분류코드
			        	sql1.setString(i++, strMcode);      	// 중분류코드
			        	sql1.setString(i++, strScode);    		// 소분류코드
			        	sql1.setString(i++, strSubSys);       	// 시스템구분
			        	sql1.setString(i++, userId);            // 수정작성ID 
			        	sql1.setString(i++, userId);            // 수정작성ID 
		                  
			        	i=1;
			        	sql2.put(svc.getQuery("CLOB_HELPMSG"));
			        	sql2.setString(i++, strPId);      		//날짜  
			        	sql2.setString(i++, strScode);    		//일련번호 
			        	//System.out.println("---------------------------------------------- " + str[0]);
			            res = executeUpdateByCLOB(sql1, sql2, str); 
			        	//System.out.println("---------------------------------------------- " + res);
			            
			            sql1.close();
			            sql2.close();
			            
			            if (res != 1) {
			                throw new Exception("" + "데이터의 적합성 문제로 인하여"
			                        + "데이터 입력을 하지 못했습니다.");
			            }
		            }else if (mi.IS_DELETE()) { 
		            	
				    	sql.close();
						i = 1;						
						sql.put(svc.getQuery("SEL_HELPMSG_CNT"));		

			        	sql.setString(i++, mi.getString("PID"));      		//프로그램ID  
			        	sql.setString(i++, mi.getString("SCODE"));    		//소분류코드
						
						Map map = executeQueryByMap( sql );	
						String cnt = String2.nvl((String)map.get("CNT")); 
						
						if (!cnt.equals("0"))
						{
		                	i = 1;
			                sql1.put(svc.getQuery("DEL_HELPMSG"));
				        	sql1.setString(i++, mi.getString("PID"));      		//프로그램ID  
				        	sql1.setString(i++, mi.getString("SCODE"));    		//소분류코드
			            	
			                res = executeUpdate(sql1);   
			                sql1.close();
			                
			    	        if (res != 1) {
			    	            throw new Exception("" + "데이터의 적합성 문제로 인하여 데이터 삭제를 하지 못했습니다.");
			    	        }
							
						}

		            }
		            intCLOB++;
	        	}
	        } catch (Exception e) {
	            rollback();
	            throw e;
	        } finally {
	            end();
	        }  
	        return ret;
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
