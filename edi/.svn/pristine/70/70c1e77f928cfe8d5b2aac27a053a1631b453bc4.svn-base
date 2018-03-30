/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package ecom.util;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import ecom.vo.SessionInfo2;
;
/**
 * -------------------------------------------------
 * 모든 요청의 앞단에서 SessionInfo 객체가 있는지 확인하여
 * 없다면(세션이 죽은 경우) 로그인 페이지로 보냅니다.
 * 로그인 Action은 예외.
 * -------------------------------------------------
 * @created  on 1.0, 2011/06/10
 * @created  by FUJITSU KOREA LTD.
 * @modified 
 * @modified 
 * @caused   
 */
public class SessionChkFilter implements Filter { 

  private static Logger logger = Logger.getLogger("util.SessionChkFilter");

  public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)  
    throws IOException, ServletException {
	  	          
	  try{
	      HttpServletRequest request = (HttpServletRequest) req;
	      HttpSession session     = null;      
	      SessionInfo2 sessionInfo = null;  
	      String queryString      = null;
	      String uri              = null;
	      String message		  = null;
	      
	      queryString = request.getQueryString();       //쿼리 스트링
	      uri         = request.getRequestURI().toUpperCase();  //프로그램 ID
	      
	      if (queryString != null) {
	    	  queryString = queryString.toUpperCase();
    	    	  
	    	  //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
	    	  //System.out.println("queryString : " + queryString);
	    	  //System.out.println("uri         : " + uri);
	    	  //System.out.println("url         : " + request.getRequestURL().toString());
	    	  
	          //---------------------------------------------------------------------------------
	          // goTo=list와 같이 Action을 부르는 경우엔 세션에 SessionInfo 객체가 반드시 있어야 하지만
	          // 세션이 필요없거나, 체크하지 않아도 되는 경우 필터에서 제외한다.
	          //---------------------------------------------------------------------------------
	    	  
	    	  if (queryString != null && !"".equals(queryString)){    
	    		  
	              if (queryString.indexOf("LOGIN") < 0 &&
	            	  queryString.indexOf("LOGOUT") < 0 &&
	            	  queryString.indexOf("SETSESSION") < 0 && 
	            	  queryString.indexOf("SESSIONOUT") < 0 &&
	            	  uri.indexOf("ECOM001") < 0 &&    
	                  uri.indexOf("ECOM003") < 0 &&
	                  uri.indexOf("ECOM004") < 0 &&
	                  uri.indexOf("SYRUPMEMBER") < 0 &&
	                  uri.indexOf("SYRUPPOINT") < 0 &&
	                  uri.indexOf("EDCS1010") < 0)  {
	            	  
	            	  session     = request.getSession();
	            	  sessionInfo = (SessionInfo2)session.getAttribute("sessionInfo2");
	            	  
	            	  
	            	  /*************************************************************/
	            	  /*                      접속상태 체크                                                  */
	            	  /*************************************************************/
	            	  //세션이 타임아웃되었을경우.
	                  if (sessionInfo == null) {   
	                	  message = "사용자 세션이 종료되었습니다.";
	                	  outMessage(res, uri, message);
	                      return;
	                  }

	              }
	          }
	      }
	      chain.doFilter(req, res);
	      
	  }catch(Exception e){
		  e.printStackTrace();

	  }

  } 

  
  /**
   * -------------------------------------------------
   * 페이지 로드 실패시 사용자에게 메시지를 전송한다.
   * -------------------------------------------------
   * @created  on 1.0, 2011/02/12
   * @created  by (FUJITSU KOREA LTD.)
   * @modified 
   * @modified 
   * @caused   
   */
  public void outMessage(ServletResponse res, String uri, String message) throws IOException{
	  
	  /*******************************************************************
	   * 시간을 불러올때(ajax) 세션을 체크하기 위해 xml전송한다.(중복로그인의 경우)
	   *******************************************************************/

		  res.setContentType("text/html; charset=utf-8"); 
	      PrintWriter out = res.getWriter();
	
	      out.println("<script language=JavaScript>");
	      out.println("alert('" + message + "');");
	      out.println("window.open('/edi/jsp/login.jsp','','');");
	      out.println("top.close();");
	      out.println("</script>");
  }
  
  public void init(FilterConfig filterConfig) {  
  }  

  public void destroy() {  
  }  

} 
