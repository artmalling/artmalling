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
import kr.fujitsu.ffw.util.String2;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import common.vo.SessionInfo;

import dmbo.dao.DMbo617DAO;
/**
 * <p>회원정보안내</p>
 * 
 * @created  on 1.0, 2010/03/31
 * @created  by 김영진(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMbo617Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DMbo617Action.class);

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
     * <p>회원정보 전체 조회</p>
     * 
     */
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

    	List list[]         = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        DMbo617DAO   dao    = null; 

        String strGoTo = form.getParam("goTo"); // 분기할곳
        
        try {

            dao    = new DMbo617DAO();
            helper = new GauceHelper2(request, response, form);
        	dSet   = new GauceDataSet[3];
        	list   = new List[3];
			dSet[0] = helper.getDataSet("DS_O_MASTER");
			dSet[1] = helper.getDataSet("DS_O_POINT");
			dSet[2] = helper.getDataSet("DS_O_CLR_POINT");
			
			String strCompPersFlag = String2.nvl(form.getParam("strCompPersFlag"));
			if(strCompPersFlag.equals("C")){
			    helper.setDataSetHeader(dSet[0], "H_MASTER_C");
			}else if(strCompPersFlag.equals("P")){
				helper.setDataSetHeader(dSet[0], "H_MASTER_P");
			}

            helper.setDataSetHeader(dSet[1], "H_POINT");
            helper.setDataSetHeader(dSet[2], "H_CLR_POINT");
             
            list = dao.searchMaster(form);
          
            for (int i = 0; i < list.length; i++) {
				helper.setListToDataset(list[i], dSet[i]);
			}

        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        return mapping.findForward(strGoTo);
    }

    /**
     * <p>포인트 적립/사용 이력 조회</p>
     * 
     */
    public ActionForward searchPoint(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List   listPoint    = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DMbo617DAO   dao    = null; 

        String strGoTo = form.getParam("goTo"); // 분기할곳
        
        try {

            dao    = new DMbo617DAO();
            helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_POINT");
			
            helper.setDataSetHeader(dSet, "H_POINT");
            listPoint     = dao.searchPoint(form);
            helper.setListToDataset(listPoint,    dSet);

        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        return mapping.findForward(strGoTo);
    }
    
    /**
     * <p>소멸예정안내 조회</p>
     * 
     */
    public ActionForward searchClrPoint(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List   listClrPoint = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DMbo617DAO   dao    = null; 

        String strGoTo = form.getParam("goTo"); // 분기할곳
        
        try {

            dao    = new DMbo617DAO();
            helper = new GauceHelper2(request, response, form);
			dSet   = helper.getDataSet("DS_O_CLR_POINT");

            helper.setDataSetHeader(dSet, "H_CLR_POINT");
            listClrPoint  = dao.searchClrPoint(form);
            helper.setListToDataset(listClrPoint, dSet);
  
        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        return mapping.findForward(strGoTo);
    }
}
