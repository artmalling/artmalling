/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package tcom.action;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;
import tcom.dao.TCom002DAO;

import common.util.Util;

/**
 * 메인화면의 시간을 갱신하기 위한 Action
 * @created  on 1.0, 2008/12/20
 * @created  by FUJITSU KOREA LTD
 * 
 * @modified on 2010/05/14
 * @modified by 정지인(FKL)
 * @caused   by 
 */
public class TCom002Action extends DispatchAction {

    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
    //private static Logger logger = Logger.getLogger("common.ccom.action.CCom017Action");

    /**
     * <p>DUAL TABLE에서 읽어 시간을 갱신 합니다.</p>
     * 
     */
    public ActionForward refresh(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
        TCom002DAO dao  = null;
        StringBuffer sb = null;
        String msg      = null;
        
        try {
            dao = new TCom002DAO();
            sb = dao.getDateTime(form);   

            HttpSession session = request.getSession();
//			String dupLoginId = (String) session.getAttribute("dupLoginId");
			
			
            
            //긴급 공지 메시지가 있는지 파악 후 있으면 메시지 전송
            Properties fujitsudeptProps = Util.getFujitsudeptProperties();
		msg = kr.fujitsu.ffw.util.String2.toKor(fujitsudeptProps.getProperty("alert.msg"));
		
			if (msg != null) {	

				if (!"".equals(msg)) {	
					String tmp = sb.toString();
					String front = tmp.substring(0, tmp.indexOf("<c")-1);

					String end   = tmp.substring(tmp.indexOf("<c")-1);
			
					String insertStr = "<c id=\"1\">alert</c><c id=\"msg\">" + msg + "</c>";
					String alert_msg = front + insertStr + end;

					sb = new StringBuffer(alert_msg);
					System.out.println(sb);
				}
			}
        } catch (Exception e) {
            e.printStackTrace();
        }

        ActionUtil.sendAjaxResponse(response, sb);
        return mapping.findForward("refresh");
    }
	
}

