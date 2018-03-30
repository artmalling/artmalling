/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package common.util;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

public class IsLogin extends TagSupport { 

	/**
	 * <p>비정상 접근시 방지</p>
	 * 
	 * @created  on 1.0, 2010/12/24
	 * @created  by 정지인(FUJITSU KOREA LTD.)
	 * 
	 * @modified on 
	 * @modified by 
	 * @caused   by 
	 */
	private static final long serialVersionUID = -2041618577522515177L;

	public int doStartTag() throws JspException {
        return (SKIP_BODY);
    }

    public int doEndTag() throws JspException {
        // Is there a valid user logged on?
        boolean islogin = false;
        HttpSession session = pageContext.getSession();
        if ((session != null) && (session.getAttribute("sessionInfo") != null)) {
            islogin = true;
        }

        // Forward control based on the results
        if (islogin)
            return (EVAL_PAGE); //JSP 페이지의 다음을 수행
        else {
            try { 
            	pageContext.getOut().println("<script>");
                pageContext.getOut().println("alert('정상적인 접근이 아닙니다. 로그인 후 사용하세요.');");
                pageContext.getOut().println("window.open('/pot/jsp/login.jsp','','');");
                pageContext.getOut().println("window.opener = '';");
                pageContext.getOut().println("window.external.GetFrame(window).Provider('../').OuterWindow.top.parent.close();");
                pageContext.getOut().println("window.external.GetFrame(window).Provider('../').OuterWindow.top.parent.self.close();");
                pageContext.getOut().println("</script>");

                session.invalidate();
                
            } catch (Exception e) {
                throw new JspException(e.toString());
            }
            return (SKIP_PAGE); //JSP 페이지의 다음을 스킵
        }
    }

    /**
     * Release any acquired resources.
     */
    public void release() {
        super.release();
    }
}
