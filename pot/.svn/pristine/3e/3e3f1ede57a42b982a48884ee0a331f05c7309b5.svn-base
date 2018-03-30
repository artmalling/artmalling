/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package common.util;

import java.io.Serializable;
import java.util.Calendar;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

import common.dao.CCom900DAO;

/**
 * <p>
 * Sesseion 관리를 위한 클래스
 * </p>
 * 
 * session이 꺼지거나 전원이 꺼졌을때처리하기위해사용
 * 
 * @created on 1.0, 2008/12/14
 * @created by (FUJITSU KOREA LTD.)
 * 
 * @modified on 2010/12/14
 * @modified by 정지인(FKL)
 * @caused 
 */


public class SessionBindManager implements HttpSessionBindingListener, Serializable{
	

	/**
	 * 객체의 serialVersionUID
	 */
//		private static final long serialVersionUID = -9080634516562556660L;
		private static final long serialVersionUID = 5862206633973367297L;
	
	private static SessionBindManager sessionBindManager = null;
	//static메소드에서는 static만 사용 하므로static으로 선언한다.
	Calendar oCalendar = Calendar.getInstance( );
	 
	private SessionBindManager(){
		super();
		//DBCP로직
	}
	public static synchronized SessionBindManager getInstance(){
		if(sessionBindManager == null){
			sessionBindManager = new SessionBindManager();
		}
		return sessionBindManager;
	}

	
	 /*
	  * 이 메소드는 세션에 HttpSessionBindingListener를 구현한 객체 즉.. 자기자신이 등록되었을때 호출된다.
	  *@see javax.servlet.http.HttpSessionBindingListener#valueUnbound(javax.servlet.http.HttpSessionBindingEvent)
	  *Hashtable에 로그인한 정보를 put한다.
	  */	 	
	public void valueBound(HttpSessionBindingEvent event){
		try{
			CCom900DAO dao = new CCom900DAO();
			//dao함수 호출 비정상 로그아웃에 대한 업데이트 (단 자신의 로그만)
			//dao.updFailedLogout(event.getName());

			//로그인시 테이블에 사용자 등록
			dao.insLogin(event.getName(), event.getSession().getId());
			
		}catch(Exception e){
			e.printStackTrace();
		}
	 }
	
	
	/*
	 * 이 메소드는 세션이 끊겼을 때, 호출됩니다.
	 *@see javax.servlet.http.HttpSessionBindingListener#valueUnbound(javax.servlet.http.HttpSessionBindingEvent)
	 *Hashtable에 저장된 로그인한 정보(사용자 id, 세션객체)를 제거해 준다.
	 */
	public void valueUnbound(HttpSessionBindingEvent event) {
		try{
			CCom900DAO dao = new CCom900DAO();
			HttpSession session = event.getSession();

			dao.updLogout(event.getName(), session.getId());
			
		}catch(Exception e){
			e.printStackTrace();
		}
	 }
	 
	 
}
