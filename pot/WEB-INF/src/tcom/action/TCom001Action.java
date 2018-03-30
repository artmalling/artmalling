/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package tcom.action;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.base.BaseProperty;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;

import org.apache.log4j.Logger;

import tcom.dao.TCom001DAO;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataSet;
import common.dao.CCom900DAO;
import common.util.SessionBindManager;
import common.util.Util;
import common.vo.SessionInfo;
 
/**
 * <p>
 * 로그인 후 ~ 메인화면
 * </p>
 * 
 * 통합인증 처리 사용자 정보 세션에 저장 중복로그인 확인 등의 작업을 수행
 * 
 * @created on 1.0, 2008/12/14
 * @created by FUJITSU KOREA LTD.
 * 
 * @modified on 2010/12/14
 * @modified by 정지인(FKL)
 * @caused by SSO 사용
 */

public class TCom001Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(TCom001Action.class);
	
	// Main Page ViewLevel에 따른 게시물건수
	private static int adminRowCnt  = 5;	 	
	private static int normalRowCnt = 18;

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
			session.removeAttribute("sessionInfo");
			session.invalidate();
			response.getWriter().println("<script>");
			response.getWriter().println("window.open('/pot/jsp/login.jsp', '', 'width=1024-10, height=768-55, status=1, resizable=1, titlebar=1, location=1, toolbar=1, menubar=1, scrollbars=1');");
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
	 * Update Session 이미 다른 사용자가 로그인 해 있는 경우 KILL 후 재로그인 하는 경우 호출
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */

	public ActionForward updatesession(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		try {
			// 폼을 통해 ID, PassWord를 넘기지 않으므로 session에
			// Attribute를 통해 아이디, 비밀번호를 저장 해 둔다.
			// dup_login

			CCom900DAO dao = new CCom900DAO();
			HttpSession session = request.getSession();
			String dupLoginId = (String) session.getAttribute("dupLoginId");
			session.removeAttribute("sessionInfo");

			// 기존사용자의 로그아웃 처리
			dao.updLogout(dupLoginId);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
			throw e;
		}

		return login(mapping, form, request, response);
	}

	/**
	 * Session Out
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward sessionout(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		try {
			HttpSession session = request.getSession();
			session.removeAttribute("sessionInfo");
			session.invalidate();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
			throw e;
		}
		return mapping.findForward("sessionout");
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
		TCom001DAO dao = null;
		//CCom900DAO dao9 = null;
		String subSys = null;
		boolean pop2checkOrg = false;
		Util util = new Util();

		try {
			HttpSession session = request.getSession();

			SessionInfo sessionInfo = null;
			//Properties fujitsudeptProps = Util.getFujitsudeptProperties();
			
			// sessionInfo = (SessionInfo)
			// session.getAttribute("sessionInfo");<--제거 20100623

			// ID로 사용자의 데이터를 SELECT 해 온다.
			dao = new TCom001DAO();
			myMap = dao.chkID(form, sessionInfo, request);

			// =========== 신규로 로그인 버튼을 클릭하는 경우
			// if (sessionInfo == null) { <--제거 20100623
			String isAllMenu = "N";

			// ID가 없는 경우 login_fail_id로 이동
			if (myMap.get("USER_ID") == null) {
				// 에러구분
				request.setAttribute("errFlag", "0");
				return mapping.findForward("loginfail");
				// TC_USRMST.USE_YN != "Y" 인 경우
			} else if (!myMap.get("USE_YN").equals("Y")) {
				request.setAttribute("errFlag", "4");
				return mapping.findForward("loginfail");
			} else {
				String password = null;
//				password = "BC76361D6B0874E5A4B78A874BDC7471";
				password = form.getParam("pwd").toString();		//pcs
				// 2010.07.13 BIJ 패스워드 체크
				if (!myMap.get("PWD_NO").toString().equals(password)) {
					request.setAttribute("errFlag", "1"); 
					return mapping.findForward("loginfail");
				}
				// 2010.07.13 BIJ 패스워드 체크 관련 COMMENT 처리
				/*
				if (!form.getParam("pwd").toString().equals("")) {
					password = form.getParam("pwd").toString();
				} else {
					// password =
					// (String)session.getAttribute("dupLoginPw");
					// System.out.println(">>>>>>> Passed SSO : dupLoginPw >>>>>");
				}
				*/
				// SSO 인증 사용하지 않음
				// Password가 틀린 경우 login_fail_pwd로 이동
				if (!BaseProperty.get("SSO.flag").equals("Y")) {
					// if (!myMap.get("PWD_NO").toString()
					// .equals(util.encryptedPasswd(password))) {
					//
					// System.out.println(">>>>>>> 패스워드 검사 >>>>>");
					// String[] errFlag = {"1"};
					// request.setAttribute("errFlag", "1");
					// }
				}
				// ===========================================================
				// 사용자가 이미 로그인되어있는지 확인(중복 로그인 용)
				// 나중에 중복 로그인을 막으실려면 아래 부분 주석 처리 하세요~
				// ===========================================================

				//dao9 = new CCom900DAO();
				if (1 == 2) {
//					 if(dao9.loginChk(myMap.get("USER_ID").toString(),session.getId()) > 0) {
					// 세션이 닫히지 않은 상태임TC_LOGHST
					if (myMap.get("MULTI_LOGIN").toString().trim().equals("N")) {
						// 멀티로긴 사용하지 않는 경우
						request.setAttribute("errFlag", "2");
						return mapping.findForward("loginfail");
					} else {
						session.setAttribute("dupLoginId", myMap.get("USER_ID")
								.toString());
						// 멀티로긴 사용하는 경우
						// session.setAttribute("dupLoginPw",
						// myMap.get("PASSWD").toString());
						request.setAttribute("errFlag", "3");
						return mapping.findForward("loginfail");
					}
				} else {
					// HttpSessionBindingListener를 구현하는 sessionBindManager를 등록한다.
					SessionBindManager sessionBindManager = SessionBindManager.getInstance();
					session.setAttribute(myMap.get("USER_ID").toString(), sessionBindManager);
				}

				// ===========================================================
				// 사용자의 정보를 세션에 저장
				// ===========================================================
				// ---- 사용자 정보를 SessionInfo 빈을 이용해서 세션에 저장
				SessionInfo user = new SessionInfo();
				user.setUSER_ID(myMap.get("USER_ID") == null ? "" : myMap.get("USER_ID").toString());
				user.setUSER_NAME(myMap.get("USER_NAME") == null ? "" : myMap.get("USER_NAME").toString());
				user.setGROUP_CD(myMap.get("GROUP_CD") == null ? "" : myMap.get("GROUP_CD").toString());
				user.setORG_CD(myMap.get("ORG_CD") == null ? "" : myMap.get("ORG_CD").toString());

				// 복수 조직인 경우 : 조직선택하여 로그인

				if (myMap.get("ORG_FLAG").toString().equals("11")) {
					user.setORG_FLAG("1");
				} else if (myMap.get("ORG_FLAG").toString().equals("22")) {
					user.setORG_FLAG("2");
				} else if (myMap.get("ORG_FLAG").toString().equals("12")) { 
					// BIJ -- 2010.07.01  매장 조직과 매입조직 동시 권한을 가진 경우 매장 조직으로 강제 설정
					user.setORG_FLAG("1");
					
					// BIJ -- 2010.07.01 매장조직으로 강제 설정함 & COMMENT 처리
					// 팝업 띄움 - 조직코드 고를 수 있도록
					//pop2checkOrg = true;
				}

				user.setSTR_CD(myMap.get("STR_CD") == null ? "" : myMap.get("STR_CD").toString());
				user.setDEPT_CD(myMap.get("DEPT_CD") == null ? "" : myMap.get("DEPT_CD").toString());
				user.setTEAM_CD(myMap.get("TEAM_CD") == null ? "" : myMap.get("TEAM_CD").toString());
				user.setPC_CD(myMap.get("PC_CD") == null ? "" : myMap.get("PC_CD").toString());
				user.setCORNER_CD(myMap.get("CORNER_CD") == null ? "" : myMap.get("CORNER_CD").toString());
				user.setORG_LEVEL(myMap.get("ORG_LEVEL") == null ? "" : myMap.get("ORG_LEVEL").toString());
				user.setBRCH_ID(myMap.get("BRCH_ID") == null ? "" : myMap.get("BRCH_ID").toString());
				user.setSUB_SYS(myMap.get("SUB_SYS") == null ? "" : myMap.get("SUB_SYS").toString());
				user.setVIEW_LEVEL(myMap.get("VIEW_LEVEL") == null ? "" : myMap.get("VIEW_LEVEL").toString());
				user.setMULTI_LOGIN(myMap.get("MULTI_LOGIN") == null ? "" : myMap.get("MULTI_LOGIN").toString());

				user.setHP1_NO(myMap.get("HP1_NO") == null ? "" : myMap.get("HP1_NO").toString());
				user.setHP2_NO(myMap.get("HP2_NO") == null ? "" : myMap.get("HP2_NO").toString());
				user.setHP3_NO(myMap.get("HP3_NO") == null ? "" : myMap.get("HP3_NO").toString());
				user.setPHONE1_NO(myMap.get("PHONE1_NO") == null ? "" : myMap.get("PHONE1_NO").toString());
				user.setPHONE2_NO(myMap.get("PHONE2_NO") == null ? "" : myMap.get("PHONE2_NO").toString());
				user.setPHONE3_NO(myMap.get("PHONE3_NO") == null ? "" : myMap.get("PHONE3_NO").toString());
				user.setE_MAIL(myMap.get("E_MAIL") == null ? "" : myMap.get("E_MAIL").toString());
				user.setPART_NM(myMap.get("PART_NM") == null ? "" : myMap.get("PART_NM").toString());

				// MARIO OUTLET
				user.setbu_Nm(myMap.get("BU_NM") == null ? "" : myMap.get("BU_NM").toString());
				user.setteam_Nm(myMap.get("TEAM_NM") == null ? "" : myMap.get("TEAM_NM").toString());
				user.setpc_Nm(myMap.get("PC_NM") == null ? "" : myMap.get("PC_NM").toString());
				user.setjknm(myMap.get("JKNM") == null ? "" : myMap.get("JKNM").toString());
				
				subSys = myMap.get("SUB_SYS") == null ? "" : myMap.get("SUB_SYS").toString();
				
				

				// 백화점 P 경영지원 M 포인트카드 D 문화센터 C 포탈 T
				// ------------모든 메뉴를 볼 수 있는 USER는 기본적으로 (T) 화면부터 로딩
				// ------------그리고 세션 변수 is_AllMenu에 'Y'로 Setting
				// 2010.06.30 -- BIJ COMMENT 처리
				/*
				if (subSys.equals("A")) {
					isAllMenu = "Y";
					subSys = "T;
					user.setSUB_SYS(subSys);
				}
				*/
				session.setAttribute("isAllMenu", isAllMenu);


				// ==========================================================
				// 사용자의 정보를 세션에 저장
				// ===========================================================
				session = request.getSession();
				session.setAttribute("sessionInfo", user);
				session.setAttribute("orgFlag", myMap.get("ORG_FLAG"));
				String[] arrSubSystem = { subSys };
				form.setParam("subsystem", arrSubSystem);
				mapping.findForward("mainFrame");

			}
			// }
		} catch (Exception e) {
			logger.error("", e);
			e.printStackTrace();

		} finally {
			dao = null;
		}

		// ------- 로그인 후 넘어 가는 경우엔 메인화면을 부르므로 MENU는 보이는 상태
		request.setAttribute("isMenuDisplay", "Y");
		// 조직코드가 2개인 경우 팝업창
		if (pop2checkOrg) {
			return mapping.findForward("login_page4org");
		} else {
			return mapping.findForward("login_ok");
		}
	}

	/**
	 * 조직을 선택하는 경우
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward selectOrg(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		try {
			// ---- 사용자 정보를 SessionInfo 빈을 이용해서 세션에 저장

			HttpSession session = request.getSession();
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			sessionInfo.setORG_FLAG(form.getParam("orgFlag").toString());
			session.setAttribute("sessionInfo", sessionInfo);

		} catch (Exception e) {
			logger.error("", e);
			throw e;
		}
		return mapping.findForward("login_ok");
	}

	/**
	 * 프로그램제목, 버튼권한 세션에 저장[MDI]
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward setSession(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		try {

			HttpSession session = request.getSession();

			// session.setAttribute("title", title);
			session.setAttribute("title", form.getParam("strTitle").toString());
			session.setAttribute("buttonPermission", form.getParam("strBtnPer")
					.toString());
		} catch (Exception e) {
			logger.error("", e);
			throw e;
		}
		return mapping.findForward("blank");
	}

	/**
	 * <p>
	 * 메인화면로딩
	 * </p>
	 */
	public ActionForward mainFrame(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		//String strGoTo = form.getParam("goTo"); // 분기할곳
		
		//List notice2 		= null; 
		
		Map  weatherMap		= null;	// 날씨예보(일자만 조회) 
		List weatherCastList= null;	// 날씨정보 
		
		List bannerList		= null; // 배너정보
		

		TCom001DAO dao  	= null;
		//String strOrgCd 	= null;
		//String strViewLevel = null;  

		try {
			// todoList
			//todoList 		= new ArrayList();
			dao 			= new TCom001DAO();
			
			//strOrgCd 		= Util.getOrgCd(request);
			//strViewLevel	= Util.getViewLevel(request); 
			 

			// 주간날씨
			weatherMap      = dao.searchWeater(form);
			weatherCastList = dao.searchWeaterCast(form);  

			// 배너
			bannerList		= dao.searchBanner(form);
		
			
			request.setAttribute("weatherMap", 		weatherMap);
			request.setAttribute("weatherCastList", weatherCastList); 
			request.setAttribute("bannerList", 		bannerList); 
			
			//request.setAttribute("notice2", 		notice2);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}

		return mapping.findForward("mainFrame2");
	} 

	/**
	 * <p>
	 * 메인 : 게시판관련 all
	 * </p>
	 */
	public ActionForward showNotiAll(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 
		
		String strGoTo = form.getParam("goTo"); // 분기할곳
		
		List noticeAll   	= null; 
		Map  noticeTotCnt   = null; 
		
		TCom001DAO dao  	= null;
		String strOrgCd 	= null;
		String strViewLevel = null;
		int iViewCnt		= 0;
		
		int iStartRow 		= 0;
		int iEndRow 		= 0;
		String strCurrRow  = null;
		try { 
			dao 			= new TCom001DAO();
			
			strCurrRow 		= form.getParam("iCurrRow");
			int intCurrRow  = Integer.parseInt(strCurrRow)  ;
			strOrgCd 		= Util.getOrgCd(request);
			strViewLevel	= Util.getViewLevel(request);
			
			if (strViewLevel.equals("2"))iViewCnt = normalRowCnt; 
			else iViewCnt = adminRowCnt;

			iStartRow = (intCurrRow-1) * iViewCnt + 1;
			iEndRow = iViewCnt * intCurrRow;
			
			// 게시판관련
			noticeTotCnt	= dao.searchNoticeCnt(form, "ALL" ,strOrgCd);					// 게시물 총 건수
			noticeAll       = dao.searchNotice(form, "ALL" 	, strOrgCd, iStartRow, iEndRow);  
			
			request.setAttribute("plCurrPage", 		strCurrRow);
			request.setAttribute("plRowRange", 		iViewCnt); 
			request.setAttribute("noticeAll", 		noticeAll); 
			request.setAttribute("noticeTotCnt", 	noticeTotCnt); 
			 
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}

		return mapping.findForward(strGoTo);
	}
	

	/**
	 * <p>
	 * 메인 : 게시판관련 마케팅
	 * </p>
	 */
	public ActionForward showNotiMark(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		List noticeMark   	= null;
		Map  noticeTotCnt   = null; 
		
		TCom001DAO dao  	= null;
		String strOrgCd 	= null;
		String strViewLevel = null;
		int iViewCnt		= 0;
		
		int iStartRow 		= 0;
		int iEndRow 		= 0;
		String strCurrRow  = null;
		try { 
			dao 			= new TCom001DAO();
			
			strCurrRow 		= form.getParam("iCurrRow"); 
			
			int intCurrRow  = Integer.parseInt(strCurrRow)  ;
			strOrgCd 		= Util.getOrgCd(request);
			strViewLevel	= Util.getViewLevel(request);
			
			if (strViewLevel.equals("2")) iViewCnt = normalRowCnt;
			else iViewCnt = adminRowCnt;

			iStartRow = (intCurrRow-1) * iViewCnt + 1;
			iEndRow = iViewCnt * intCurrRow;
			
			// 게시판관련
			noticeTotCnt	= dao.searchNoticeCnt(form, "1" ,strOrgCd);					// 게시물 총 건수
			noticeMark      = dao.searchNotice(form, "1" , strOrgCd, iStartRow, iEndRow);  // 게시분류(TC05) : 마케팅
			
			request.setAttribute("plCurrPage", 		strCurrRow);
			request.setAttribute("plRowRange", 		iViewCnt); 
			request.setAttribute("noticeMark", 		noticeMark); 
			request.setAttribute("noticeTotCnt", 	noticeTotCnt); 
			 
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}

		return mapping.findForward(strGoTo);
	}
	

	/**
	 * <p>
	 * 메인 : 게시판관련 영업기획
	 * </p>
	 */
	public ActionForward showNotiPlan(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		List noticePlan   	= null;
		Map  noticeTotCnt   = null; 
		
		TCom001DAO dao  	= null;
		String strOrgCd 	= null;
		String strViewLevel = null;
		int iViewCnt		= 0;
		
		int iStartRow 		= 0;
		int iEndRow 		= 0;
		String strCurrRow  = null;
		try { 
			dao 			= new TCom001DAO();
			
			strCurrRow 		= form.getParam("iCurrRow");
			int intCurrRow  = Integer.parseInt(strCurrRow)  ;
			strOrgCd 		= Util.getOrgCd(request);
			strViewLevel	= Util.getViewLevel(request);
			
			if (strViewLevel.equals("2")) iViewCnt = normalRowCnt;
			else iViewCnt = adminRowCnt;

			iStartRow = (intCurrRow-1) * iViewCnt + 1;
			iEndRow = iViewCnt * intCurrRow;
			
			// 게시판관련
			noticeTotCnt	= dao.searchNoticeCnt(form, "2" ,strOrgCd);					// 게시물 총 건수
			noticePlan      = dao.searchNotice(form, "2" , strOrgCd, iStartRow, iEndRow);  // 게시분류(TC05) : 영업기획
			
			request.setAttribute("plCurrPage", 		strCurrRow);
			request.setAttribute("plRowRange", 		iViewCnt); 
			request.setAttribute("noticePlan", 		noticePlan); 
			request.setAttribute("noticeTotCnt", 	noticeTotCnt); 
			 
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}

		return mapping.findForward(strGoTo);
	}
	

	/**
	 * <p>
	 * 메인 : 게시판관련  경영지원
	 * </p>
	 */
	public ActionForward showNotiManage(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		List noticeManage   = null;
		Map  noticeTotCnt   = null; 
		
		TCom001DAO dao  	= null;
		String strOrgCd 	= null;
		String strViewLevel = null;
		int iViewCnt		= 0;
		
		int iStartRow 		= 0;
		int iEndRow 		= 0;
		String strCurrRow  = null;
		try { 
			dao 			= new TCom001DAO();
			
			strCurrRow 		= form.getParam("iCurrRow");
			int intCurrRow  = Integer.parseInt(strCurrRow)  ;
			strOrgCd 		= Util.getOrgCd(request);
			strViewLevel	= Util.getViewLevel(request);
			
			if (strViewLevel.equals("2")) iViewCnt = normalRowCnt;
			else iViewCnt = adminRowCnt;

			iStartRow = (intCurrRow-1) * iViewCnt + 1;
			iEndRow = iViewCnt * intCurrRow;
			
			// 게시판관련
			noticeTotCnt	= dao.searchNoticeCnt(form, "3" ,strOrgCd);					   // 게시물 총 건수
			noticeManage    = dao.searchNotice(form, "3" , strOrgCd, iStartRow, iEndRow);  // 게시분류(TC05)  경영지원
			
			request.setAttribute("plCurrPage", 		strCurrRow);
			request.setAttribute("plRowRange", 		iViewCnt); 
			request.setAttribute("noticeManage", 	noticeManage); 
			request.setAttribute("noticeTotCnt", 	noticeTotCnt); 
			 
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}

		return mapping.findForward(strGoTo);
	}


	/**
	 * <p>
	 * 메인 : 게시판관련  시스템
	 * </p>
	 */
	public ActionForward showNotiSystem(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		List noticeSystem   = null;
		Map  noticeTotCnt   = null; 
		
		TCom001DAO dao  	= null;
		String strOrgCd 	= null;
		String strViewLevel = null;
		int iViewCnt		= 0;
		
		int iStartRow 		= 0;
		int iEndRow 		= 0;
		String strCurrRow  = null;
		
		try { 
			dao 			= new TCom001DAO();
			
			strCurrRow 		= form.getParam("iCurrRow");
			int intCurrRow  = Integer.parseInt(strCurrRow)  ;
			strOrgCd 		= Util.getOrgCd(request);
			strViewLevel	= Util.getViewLevel(request);
			
			if (strViewLevel.equals("2")) iViewCnt = normalRowCnt;
			else iViewCnt = adminRowCnt;

			iStartRow = (intCurrRow-1) * iViewCnt + 1;
			iEndRow = iViewCnt * intCurrRow;
			
			// 게시판관련
			noticeTotCnt	= dao.searchNoticeCnt(form, "4" ,strOrgCd);					   // 게시물 총 건수
			noticeSystem    = dao.searchNotice(form, "4" , strOrgCd, iStartRow, iEndRow);  // 게시분류(TC05)  시스템
			
			request.setAttribute("plCurrPage", 		strCurrRow);
			request.setAttribute("plRowRange", 		iViewCnt); 
			request.setAttribute("noticeSystem", 	noticeSystem); 
			request.setAttribute("noticeTotCnt", 	noticeTotCnt);  
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}

		return mapping.findForward(strGoTo);
	} 

	/**
	 * <p>
	 * 메인 : 게시판관련  기타
	 * </p>
	 */
	public ActionForward showNotiEtc(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		List noticeEtc      = null;
		Map  noticeTotCnt   = null; 
		
		TCom001DAO dao  	= null;
		String strOrgCd 	= null;
		String strViewLevel = null;
		int iViewCnt		= 0;
		
		int iStartRow 		= 0;
		int iEndRow 		= 0;
		String strCurrRow  = null;
		try { 
			dao 			= new TCom001DAO();
			
			strCurrRow 		= form.getParam("iCurrRow");
			int intCurrRow  = Integer.parseInt(strCurrRow)  ;
			strOrgCd 		= Util.getOrgCd(request);
			strViewLevel	= Util.getViewLevel(request);
			
			if (strViewLevel.equals("2")) iViewCnt = normalRowCnt;
			else iViewCnt = adminRowCnt;

			iStartRow = (intCurrRow-1) * iViewCnt + 1;
			iEndRow = iViewCnt * intCurrRow;
			
			// 게시판관련
			noticeTotCnt	= dao.searchNoticeCnt(form, "9" ,strOrgCd);					   // 게시물 총 건수
			noticeEtc       = dao.searchNotice(form, "9" , strOrgCd, iStartRow, iEndRow);  // 게시분류(TC05)  기타
			
			request.setAttribute("plCurrPage", 		strCurrRow);
			request.setAttribute("plRowRange", 		iViewCnt); 
			request.setAttribute("noticeEtc", 		noticeEtc); 
			request.setAttribute("noticeTotCnt", 	noticeTotCnt);  
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}

		return mapping.findForward(strGoTo);
	} 

	/**
	 * <p>매출속보 화면 로드</p>
	 * 
	 */
	public ActionForward showSale(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception { 

		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {

			GauceHelper2.initialize(form, request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}

		return mapping.findForward(strGoTo);
	}

	/**
	 * <p>아트몰링 조직별 매출속보 화면 로드</p>
	 * 
	 */
	public ActionForward showSale_art(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception { 

		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {

			GauceHelper2.initialize(form, request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}

		return mapping.findForward(strGoTo);
	}

	/** 
	 * <p>
	 * 매출속보를 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchSale(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		TCom001DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new TCom001DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_TEAM_LIST");
			dSet[1] = helper.getDataSet("DS_MASTER");
			MultiInput mi = new MultiInput(dSet[0]);
			MultiInput mi2 = new MultiInput(dSet[0]);
			list = dao.searchSale(form, mi);
			tmpDataSetInit(mi2,dSet[1]);
			helper.setListToDataset(list, dSet[1]);

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
	
	/** 
	 * <p>
	 * 체류객수 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchVisit(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		TCom001DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new TCom001DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_VISIT");
			helper.setDataSetHeader(dSet, "H_SEL_VISIT");
			list = dao.searchVisit(form);
			helper.setListToDataset(list, dSet);

			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}

	/**
	 * 매출 속보를 위한 데이터셋 설정
	 * 
	 * @param mi
	 * @param dSet
	 */
	private void tmpDataSetInit(MultiInput mi, GauceDataSet dSet){
		boolean flag = false;
        GauceDataColumn temp[] = dSet.getDataColumns();
        if(temp.length > 0)
            flag = true;
        if(!flag)
        {
        	dSet.addDataColumn(new GauceDataColumn("TIME_GB"       , GauceDataColumn.TB_STRING ,  4, 0, GauceDataColumn.TB_NORMAL ));
        	dSet.addDataColumn(new GauceDataColumn("TIME_NM"       , GauceDataColumn.TB_STRING , 40, 0, GauceDataColumn.TB_NORMAL ));
        	dSet.addDataColumn(new GauceDataColumn("CNT_VISIT_CUST", GauceDataColumn.TB_DECIMAL, 13, 0, GauceDataColumn.TB_NORMAL ));
        	dSet.addDataColumn(new GauceDataColumn("TOT_VISIT_CUST", GauceDataColumn.TB_DECIMAL, 13, 0, GauceDataColumn.TB_NORMAL ));
        	dSet.addDataColumn(new GauceDataColumn("TEAM_TOTAL_AMT", GauceDataColumn.TB_DECIMAL, 13, 0, GauceDataColumn.TB_NORMAL ));
        	dSet.addDataColumn(new GauceDataColumn("TEAM_TOTAL_CNT", GauceDataColumn.TB_DECIMAL, 13, 0, GauceDataColumn.TB_NORMAL ));
        	
    		while (mi.next()) {
            	dSet.addDataColumn(new GauceDataColumn("TEAM_"+mi.getString("CODE_CD")+"_AMT", GauceDataColumn.TB_DECIMAL, 13, 0, GauceDataColumn.TB_NORMAL ));
            	dSet.addDataColumn(new GauceDataColumn("TEAM_"+mi.getString("CODE_CD")+"_CNT", GauceDataColumn.TB_DECIMAL, 13, 0, GauceDataColumn.TB_NORMAL ));
    		}
        }
	}

	/**
	 * TO DO LIST
	 * 
	 * @param mi
	 * @param dSet
	 */
	public ActionForward showTodoList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 

		String strGoTo 		= form.getParam("goTo"); // 분기할곳
		HttpSession session = request.getSession();
		
		List toDoList		= null;	// ToDoList
		TCom001DAO dao  	= null; 
		try {
			dao 			= new TCom001DAO(); 
			
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo"); 
			String userId 			= sessionInfo.getUSER_ID();
			String orgFlag 			= sessionInfo.getORG_FLAG();
			
			// ToDoList
			toDoList = dao.searchToDoList(form, userId, orgFlag);
			
			request.setAttribute("toDoList", 		toDoList); 
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}

		return mapping.findForward(strGoTo);
	}
	

	/**
	 * <p>
	 * TO DO LIST 사용자열람여부 update
	 * </p>
	 * 
	 */
	public ActionForward updateTodoFlag(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		//List list 			= null;
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		TCom001DAO dao 		= null;
		MultiInput mi 		= null;

		int ret				= 0;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_I_CONDITION");  
			mi = helper.getMutiInput(dSet);

			dao = new TCom001DAO(); 
			ret = dao.saveTodoReadFlag(form, mi);  
			
 
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}

		return mapping.findForward(strGoTo);
	}
	/**
	 * <p>TO DO LIST 상세정보 POPUP.</p>
	 * 
	 */
	public ActionForward showTodoListPop(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception { 
 
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			GauceHelper2.initialize(form, request, response);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}

		return mapping.findForward(strGoTo);
	} 
	

	/** 
	 * <p>TO DO LIST 상세정보  조회.</p> 
	 * 
	 */
	public ActionForward selectTodoDetail(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
 
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		TCom001DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {  
			dao = new TCom001DAO();
			helper = new GauceHelper2(request, response, form);
			
			dSet = helper.getDataSet("DS_O_DETAIL");
			helper.setDataSetHeader(dSet, "H_TODO_DETAIL");
			
			list = dao.selectTodoDetail(form);
			helper.setListToDataset(list, dSet);

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
	
	/** 
	 * <p>
	 * 매출속보를 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchSale2(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		TCom001DAO dao = null;
		HttpSession session = request.getSession();
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo"); 
			String userId 			= sessionInfo.getUSER_ID();
			
			dao = new TCom001DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_MASTER");
			helper.setDataSetHeader(dSet, "H_TODAY_SALE");

			list = dao.searchSale2(form, userId);
			helper.setListToDataset(list, dSet);

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
	
	
	

	
	/** 
	 * <p>
	 * 아트몰링 조직별 매출속보 마스터 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchMaster_art(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list           = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		TCom001DAO dao      = null;

		HttpSession session = request.getSession();
		String OrgFlag = null;
		String userid  = null;
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			OrgFlag = sessionInfo.getORG_FLAG();
            userid  = sessionInfo.getUSER_ID();
            dao     = new TCom001DAO();
			helper  = new GauceHelper2(request, response, form);
			dSet    = helper.getDataSet("DS_O_MASTER");
			helper.setDataSetHeader(dSet, "H_SEL_MASTER_ART");
			
			list    = dao.searchMaster_art(form, userid, OrgFlag);
			
			helper.setListToDataset(list, dSet);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
	
	/** 
	 * <p>
	 * 아트몰링 조직별 매출속보 디테일 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchDetail_art(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list           = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		TCom001DAO dao      = null;

		HttpSession session = request.getSession();
		String OrgFlag = null;
		String userid  = null;
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			OrgFlag = sessionInfo.getORG_FLAG();
            userid  = sessionInfo.getUSER_ID();
            dao     = new TCom001DAO();
			helper  = new GauceHelper2(request, response, form);
			dSet    = helper.getDataSet("DS_O_DETAIL");
			helper.setDataSetHeader(dSet, "H_SEL_DETAIL_ART");
			
			list    = dao.searchDetail_art(form, userid, OrgFlag);
			helper.setListToDataset(list, dSet);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
	
}
