/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package ecom.action;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.util.String2;

import org.apache.log4j.Logger;

import ecom.dao.ECom001DAO;
import ecom.vo.SessionInfo2;

public class ECom001Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(ECom001Action.class);

	/**
	 * 로그 아웃을 하는 경우
	 *
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward logout(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		try {
			HttpSession session = request.getSession();
			System.out.println("~~~~~~~~~~~~~~~~~~~~~sessionInfo~~~~~~~~~~~~~~~~~~~~~~~~~~~~ : " + session);
			session.removeAttribute("sessionInfo");
			session.invalidate();
			response.getWriter().println("<script>");
			response.getWriter().println("window.open('/edi/jsp/login.jsp', '', 'width=1024-10, height=768-55, status=1, resizable=1, titlebar=1, location=1, toolbar=1, menubar=1, scrollbars=1');");
			response.getWriter().println("parent.close();");
			response.getWriter().println("</script>");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
			throw e;
		}

		return mapping.findForward("logout");

	}

	/**
	 * 메인페이지로 이동
	 *
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward goMain(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		return mapping.findForward("goMain");
	}

	/**
	 * 로그인을 하는 경우 호출되는 Action Method
	 *
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward login(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map myMap = null;
		ECom001DAO dao = null;
		//String subSys = null;
		List list = null;
		//Util util = new Util();
		int ret = 0;

		try {

			HttpSession session = request.getSession();

			session.removeAttribute("sessionInfo");

			SessionInfo2 sessionInfo = null;
			sessionInfo = (SessionInfo2) session.getAttribute("sessionInfo2");

			//String user_id = String2.nvl(form.getParam("userid"));					//넘겨 받은 아이디
			//String user_pwd = util.encryptedPasswd(String2.nvl(form.getParam("pwd")));	//넘겨 받은 암호화 아이디
			String org = String2.nvl(form.getParam("org"));	//구분 , 1: 협력사 , 2: 품번

			// ----------- 우선 ID로 사용자의 데이터를 SELECT 해 온다.
			dao = new ECom001DAO();

			list = dao.chkID(form, sessionInfo, request);

			// =========== 신규로 로그인 버튼을 클릭하는 경우
			if( sessionInfo == null ){

				if( list.size() > 0 ){
					for( int i =0; i < list.size(); i++ ){
						myMap = (Map) list.get(i);
					}

					// ===========================================================
					// 사용자의 정보를 세션에 저장
					// ===========================================================
					// ---- 사용자 정보를 SessionInfo 빈을 이용해서 세션에 저장

					SessionInfo2 user2 = new SessionInfo2();
					if( "1".equals(org) ){	//협력사
						user2.setUSER_ID(myMap.get("USER_ID") == null ? "" : myMap.get("USER_ID").toString());
						user2.setSTR_CD(myMap.get("STR_CD") == null ? "" : myMap.get("STR_CD").toString());
						user2.setSTR_NM(myMap.get("STRNM") == null ? "" : myMap.get("STRNM").toString());
						user2.setVEN_CD(myMap.get("VEN_CD") == null ? "" : myMap.get("VEN_CD").toString());
						user2.setVEN_NAME(myMap.get("VEN_NAME") == null ? "" : myMap.get("VEN_NAME").toString());
						user2.setBIZ_TYPE(myMap.get("BIZ_TYPE") == null ? "" : myMap.get("BIZ_TYPE").toString());
						user2.setGB(myMap.get("GB") == null ? "" : myMap.get("GB").toString());
						user2.setSUB_MENU("ECMN");
					}
					else {			//품번
						user2.setUSER_ID(myMap.get("USER_ID") == null ? "" : myMap.get("USER_ID").toString());
						user2.setSTR_CD(myMap.get("STR_CD") == null ? "" : myMap.get("STR_CD").toString());
						user2.setSTR_NM(myMap.get("STRNM") == null ? "" : myMap.get("STRNM").toString());
						user2.setVEN_CD(myMap.get("VEN_CD") == null ? "" : myMap.get("VEN_CD").toString());
						user2.setVEN_NAME(myMap.get("VEN_NAME") == null ? "" : myMap.get("VEN_NAME").toString());
						user2.setBIZ_TYPE(myMap.get("BIZ_TYPE") == null ? "" : myMap.get("BIZ_TYPE").toString());
						user2.setPUMBUN_CD(myMap.get("PUMBUN_CD") == null ? "" : myMap.get("PUMBUN_CD").toString());
						user2.setPUMBUN_NAME(myMap.get("PUMBUN_NM") == null ? "" : myMap.get("PUMBUN_NM").toString());
						user2.setCHAR_BUYER_CD(myMap.get("CHAR_BUYER_CD") == null ? "" : myMap.get("CHAR_BUYER_CD").toString());
						user2.setGB(myMap.get("GB") == null ? "" : myMap.get("GB").toString());
						user2.setSUB_MENU("ECMN");
					}

					// ==========================================================
					// 사용자의 정보를 세션에 저장
					// ===========================================================
					session = request.getSession();
					session.setAttribute("sessionInfo2", user2);

					String firstLog = myMap.get("LAST_CONN_DT") == null ? "" : String2.nvl(myMap.get("LAST_CONN_DT").toString());

					// ==========================================================
					// 최초로그인 시 비밀번호 변경으로 ...
					// ===========================================================
					if( "".equals(firstLog) ){
						return mapping.findForward("pwdUpdate");
					}else {

						// ==========================================================
						// 3개월 마다 한번씩 비밀번호 변경
						// ===========================================================
						String pwdDate = (myMap.get("PWD_REG_DT") == null || myMap.get("PWD_REG_DT").equals("")) ? myMap.get("REG_DATE").toString() : myMap.get("PWD_REG_DT").toString();

						Date today = new Date();
						Date compare_date = null;

						//3개월 계산
						Calendar db_date = Calendar.getInstance ();
						SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");

						db_date.setTime(formatter.parse(pwdDate));
						db_date.add(Calendar.MONDAY, 3);
						compare_date = db_date.getTime();

						if( today.getTime() > compare_date.getTime()) {

							return mapping.findForward("pwdUpdate");
						}

						ret = dao.conn_dt(form,myMap);
					}
					mapping.findForward("mainFrame");
				}
		   }

		} catch (Exception e) {
			logger.error("", e);
		} finally {
			dao = null;
		}

		return mapping.findForward("login_ok");
	}

	/**
	 * 로그인 페이지 점코드
	 *
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward getStrcd(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception{

		StringBuffer ret = null;
		ECom001DAO dao = null;

		try{
			dao = new ECom001DAO();
			ret = dao.getStrcd(form);
		}catch(Exception e){
			e.printStackTrace();
		}

		ActionUtil.sendAjaxResponse(response, ret);

		return mapping.findForward("getStrcd");
	}

	/**
	 * 로그인 페이지 시스템관리자
	 *
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward getSystem(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception{

		StringBuffer ret = null;
		ECom001DAO dao = null;

		try{
			dao = new ECom001DAO();

			ret = dao.getSystem(form);
		}catch(Exception e){
			e.printStackTrace();
		}

		ActionUtil.sendAjaxResponse(response, ret);

		return mapping.findForward("getStrcd");
	}

	/**
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward brandNm(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		StringBuffer sb = null;
		ECom001DAO dao = null;

		String strGoto = form.getParam("goTo");

		try{
			dao = new ECom001DAO();

			sb = dao.brandNm(form);

		}catch( Exception e ){
			e.printStackTrace();
		}

		ActionUtil.sendAjaxResponse(response, sb);

		return mapping.findForward(strGoto);
	}

	/**
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward pwdSave(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)throws Exception {

		String userid = "";
		ECom001DAO dao = null;
		int ret = 0;

		//String strGoto = form.getParam("goTo");

		HttpSession session = request.getSession();
		SessionInfo2 sessionInfo = (SessionInfo2) session.getAttribute("sessionInfo2");

		try{
			userid = sessionInfo.getUSER_ID();

			dao = new ECom001DAO();
			ret = dao.pwdSave(form, userid);

			if( ret > 0){
				mapping.findForward("mainFrame");
			}

		}catch(Exception e){
			e.printStackTrace();
		}

		return mapping.findForward("login_ok");
	}

	/**
	 * [메인화면] 비밀번호 변경페이지 로드
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward pwdUpdateMain(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		return mapping.findForward("pwdUpdateMain");
	}

	/**
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward pwdSaveMain(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)throws Exception {
		String userid = "";
		ECom001DAO dao = null;
		int ret = 0;

		HttpSession session = request.getSession();
		SessionInfo2 sessionInfo = (SessionInfo2) session.getAttribute("sessionInfo2");
		String rtJson = "";
		try{
			userid = sessionInfo.getUSER_ID();

			dao = new ECom001DAO();
			ret = dao.pwdSave(form, userid);

			if( ret > 0){
				rtJson = "{\"BOOLEAN\":true,\"MSG\":\"정상처리 되었습니다.\"}";
			} else {
				rtJson = "{\"BOOLEAN\":false,\"MSG\":\"비밀번호 변경되지 않았습니다.\"}";
			}

		}catch(Exception e){
			e.printStackTrace();
		}

		ActionUtil.sendAjaxResponse(response, rtJson);
		return mapping.findForward(form.getParam("goTo"));
	}

	/**
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward getGBN(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		StringBuffer sb = null;
		ECom001DAO dao = null;

		String strGoto = form.getParam("goTo");

		try{
			dao = new ECom001DAO();

			sb = dao.getGBN(form);

		}catch( Exception e ){
			e.printStackTrace();
		}

		ActionUtil.sendAjaxResponse(response, sb);

		return mapping.findForward(strGoto);
	}
}
