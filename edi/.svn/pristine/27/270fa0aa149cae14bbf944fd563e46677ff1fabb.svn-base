/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package ecom.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.base.BaseProperty;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.util.String2;
import org.apache.log4j.Logger;

import ecom.vo.SessionInfo2;

import sample.ajax.dao.SAM_010DAO;
import sample.jstl.dao.BoardDAO;

import ecom.dao.ECom003DAO;


/**
 * <p>로긴 후 좌측 트리메뉴</p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class ECom003Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(ECom003Action.class);

	/**
	 * <p>메뉴를 보여준다.</p>
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list = null;
		ECom003DAO dao = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
		String strSubMenu = form.getParam("submenu").toString();
		String strGb = form.getParam("strGb").toString();
		String strVen = form.getParam("strVen").toString();
		
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~2222222222 : " + strGb);
		try {
			dao = new ECom003DAO();
			if (strSubMenu.trim() == ""){
			    //최초 메뉴를 세션에서 가지고 옴
			    
				HttpSession session = request.getSession();
			    SessionInfo2 sessionInfo = (SessionInfo2)session.getAttribute("sessionInfo2");

			    strSubMenu = sessionInfo.getSUB_MENU();
			}
			list = dao.getMenuList(form, strSubMenu, strGb, strVen);

		} catch (Exception e) {
			logger.error("", e);
		}
        request.setAttribute("ret", list);
		return mapping.findForward(strGoTo);
	}

}
