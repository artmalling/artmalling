/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dmbo.action;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;

import org.apache.log4j.Logger;
import com.gauce.GauceDataSet;
import common.vo.SessionInfo;
import dmbo.dao.DMbo610DAO;
/**
 * <p>포인트 양도 현황</p>
 * 
 * @created  on 1.0, 2010.03.23
 * @created  by jinjung.kim
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMbo610Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DMbo610Action.class);

	/**
	 * <p>메뉴를 보여준다.</p>
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception { 
        try {
            GauceHelper2.initialize(form, request, response);

            HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");

            if (sessionInfo != null) {
                System.out.println("USER : " + sessionInfo.getUSER_ID());
            } 
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("[list]", e);
        }
        return mapping.findForward("list");
    }
	
	/**
     * <p>포인트 양도 현황.</p>
     * 
     */
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List list           = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DMbo610DAO   dao    = null; 
        
        String strGoTo = form.getParam("goTo");

        try {
            
            dao    = new DMbo610DAO();
            helper = new GauceHelper2(request, response, form);
            dSet   = helper.getDataSet("DS_O_MASTER");
            helper.setDataSetHeader(dSet, "H_MASTER");
            
            list = dao.searchMaster(form);
            
            System.out.println("list size:" + list.size());
            
            for (int j = 0; j < list.size(); j++) {
                List tmplist = (List) list.get(j);
                String mp1 = tmplist.get(3).toString(); //MOBILE_PH1
                String mp2 = tmplist.get(4).toString(); //MOBILE_PH2
                String mp3 = tmplist.get(5).toString(); //MOBILE_PH3
                if (mp1.length() > 0 || mp2.length() > 0 || mp3.length() > 0) {
                    tmplist.set(3, mp1 + "-" +mp2 + "-" + mp3); //MOBILE_PH1
                }
                list.set(j, tmplist);
            }
            helper.setListToDataset(list, dSet);

        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        
        return mapping.findForward(strGoTo);
    }
	

}
