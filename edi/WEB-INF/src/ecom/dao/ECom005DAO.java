/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package ecom.dao;

import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.swing.text.html.HTMLDocument.HTMLReader.FormAction;

import org.apache.taglibs.standard.tag.el.sql.UpdateTag;
import org.omg.CORBA.Request;

import ecom.vo.SessionInfo2;
import ecom.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;



/**
 * <p>
 * 로그인 체크
 * </p>
 * 
 * @created on 1.0, 2010/12/10
 * @created by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class ECom005DAO extends AbstractDAO{
  
	// MASTER조회	
    public String chkIdPwd(ActionForm form) throws Exception {
		int i = 0;
		SqlWrapper sql = null;
		Service svc = null;
		Util util2 = new Util();
		List list = null;
		String rtJson ="";
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String orgCode = String2.nvl(form.getParam("orgCode"));
			String strcd = String2.nvl(form.getParam("strcd"));
			String userId = String2.nvl(form.getParam("userId"));
			String password = String2.nvl(form.getParam("password"));
			String erny_pwd = util2.encryptedPasswd(String2.nvl(form.getParam("password")));
			
			connect("pot");
			
			if( "2".equals(orgCode) ){ 
				sql.put(svc.getQuery("SEL_PUMBUN"));
				sql.setString(++i, strcd);
				sql.setString(++i, userId);
				sql.setString(++i, password);
				//sql.setString(++i, erny_pwd); 
				sql.setString(++i, password);
			}else if( "1".equals(orgCode) ){
				sql.put(svc.getQuery("SEL_VEN")); 
				 
				sql.setString(++i, strcd);
				sql.setString(++i, userId);
				sql.setString(++i, password);
				sql.setString(++i, erny_pwd); 
				sql.setString(++i, strcd);
				sql.setString(++i, userId);
				sql.setString(++i, password);
				sql.setString(++i, erny_pwd); 
			}

			list = select2List(sql);  
			
			Util util = new Util();
			String	cols= "STR_CD,STRNM,USER_ID,PWD_NO,PWD_REG_DT,EMAIL,USE_END_DT,LAST_CONN_DT";
            		cols += ",REG_ID,MOD_ID,VEN_CD,VEN_NAME,BIZ_TYPE,PWD_CNT,GB"; 
		
			rtJson = util.listToJsonOBJ(list, cols); 
			System.out.println(">>>>>>>>>>rtJson  :" + rtJson);
		}catch(Exception e){
			throw e;
		}
		
		return rtJson;
	}
  
    
    /**
	 * 비밀번호 정보 조회
	 * 
	 * @param string
	 * 
	 * @param svc
	 * @return Map
	 */ 
    public String xmlPwd(ActionForm form) throws Exception {
		int i = 0;
		SqlWrapper sql = null;
		Service svc = null;
		Util util2 = new Util();
		List list = null;
		String rtJson ="";
		try{
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String userid = String2.nvl(form.getParam("id"));
			String strcd  = String2.nvl(form.getParam("strcd"));
			String er_pwd = util2.encryptedPasswd(String2.nvl(form.getParam("pwd")));//사용자 비밀번호 암호화
			String pwd = String2.nvl(form.getParam("pwd"));//사용자 비밀번호
			
			connect("pot");
			
			sql.put(svc.getQuery("SEL_PWDCH"));
			sql.setString(++i, strcd);
			sql.setString(++i, userid);

			list = select2List(sql);  
			
			String dbPwd = ((List)list.get(0)).get(0).toString();
			
			String strYn = "N";
			if (dbPwd.equals(er_pwd) || dbPwd.equals(pwd))  strYn = "Y";
			
			//Util util = new Util();
			//String	cols= "PWD_NO,LAST_CONN_DT";
			//rtJson = util.listToJsonOBJ(list, cols); 
			rtJson = "[{'PW_CHK_YN':'"+ strYn +"'}]";
		}catch(Exception e){
			throw e;
		}
		
		return rtJson;
	} 
    
    /**
	 * 비밀번호 에러시 증가, 증가 값 가져오기
	 * 
	 * @param string
	 * 
	 * @param svc
	 * @return Map
	 */
    public String idUpSelect(ActionForm form)
    throws Exception {
        int res = 0;
        String  rtString = null;
        SqlWrapper sql = null;
        Service svc = null;
        Util util = new Util();

        try {
            connect("pot");
            begin(); //DB트렌젝션 시작
            sql = new SqlWrapper();
            svc = (Service) form.getService();
             
            String strcd	= String2.nvl(form.getParam("strcd"));	//점 코드
            String userId	= String2.nvl(form.getParam("userId"));	//로그인사번 
             
            sql.close();
            sql.put(svc.getQuery("UPD_USER_CNT"));
            sql.setString(1, strcd);
            sql.setString(2, userId);   
            res = update(sql);
			
	/*		if (res == 1) {
				rtString = "정상 처리되었습니다.";
			} else {
				throw new Exception("[USER]" + "정상적으로 처리 되지 않았습니다." );
			}*/

        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }

        return rtString;
    }
    
public String excelExportLog(ActionForm form, String userId) throws Exception {
    	
    	int ret 		= 0;
    	SqlWrapper sql 	= null;
    	Service svc 	= null;
    	Util util 		= new Util();
    	String rtString 	= null;
    	//ProcedureWrapper psql = null;
    	String strQuery = null;
    	
    	try {
    		
    		connect("pot");
    		begin();
    		
    		
            int i=1;        
            ProcedureResultSet prs = null;
    		svc  = (Service)form.getService();
    		sql  = new SqlWrapper();
    		//psql = new ProcedureWrapper();

    		String filenm    =     String2.nvl(form.getParam("filenm"));
			String pid    =     String2.nvl(form.getParam("pid"));
    		
			 strQuery = svc.getQuery("INS_DOWNLOG") + "\n";

	    	 sql.setString(i++, userId);
	    	 sql.setString(i++, pid);
	    	 sql.setString(i++, filenm);
	    		
	    	 System.out.println("strQuery : " + strQuery); 
	    	 
             sql.put(strQuery);  
	
             ret = update(sql);

	          System.out.println("ret : " + ret); 
	            
	            if ( String.valueOf(ret).equals("0")) {
	            	rtString = "[{'CD':'F','MSG':'LOG기록에 실패하였습니다.'}]";
	            	rollback();
	            }
	            else {
		            System.out.println("################### rtJson : " + rtString);
		            String Msg = "처리가 완료되었습니다.";
		            rtString = "[{'CD':'T','MSG':'"+Msg+"'}]";
		            commit();
	            }
	            
		}catch(Exception e){
			System.out.println("######################## DAO e : " + e);
			rollback();
			throw e;
			
		} finally {
			end();
		}
    	return rtString;
    }
}
