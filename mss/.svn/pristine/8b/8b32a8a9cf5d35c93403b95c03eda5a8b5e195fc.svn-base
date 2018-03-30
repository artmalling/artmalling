/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mren.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import mren.dao.MRen107DAO;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import common.vo.SessionInfo;

/**
 * <p>주거세대마스터관리</p>
 * 
 * @created  on 1.0, 2010.03.28
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MRen107Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MRen107Action.class);

    /**
     * <p>화면 LODA</p>
     * 
     */
    public ActionForward list(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {
        try {
            GauceHelper2.initialize(form, request, response);
        } catch (Exception e) {
            logger.error("", e);
        }
        return mapping.findForward("list");
    }
	

	/**
	 * <p>주거세대마스터관리 내역조회</p>
	 */
	@SuppressWarnings("rawtypes")
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
           HttpServletRequest request, HttpServletResponse response)
	throws Exception {
	   List list			= null;
       GauceHelper2 helper	= null;
       GauceDataSet dSet	= null;
       MRen107DAO dao		= null;
       String strGoTo = form.getParam("goTo");
       try {  
           helper = new GauceHelper2(request, response, form);
           dSet = new GauceDataSet();
           dSet = helper.getDataSet("DS_IO_MASTER");			
           helper.setDataSetHeader(dSet, "H_SEL_MR_HHOLDMST");
           dao = new MRen107DAO();
           list = dao.getMaster(form);
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
    * <p>주거세대마스터관리 저장</p>
    */
   public ActionForward save(ActionMapping mapping, ActionForm form,
           HttpServletRequest request, HttpServletResponse response)
   throws Exception {

       GauceHelper2 helper	= null;
       GauceDataSet dSet	= null;
       MRen107DAO dao		= null;
       int ret = 0;
       HttpSession session = request.getSession();
       String userId = null;
       String strGoTo = form.getParam("goTo");
       try {
           SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
           userId = sessionInfo.getUSER_ID();
           helper = new GauceHelper2(request, response, form);
           dSet = helper.getDataSet("DS_IO_MASTER");
           helper.setDataSetHeader(dSet, "H_SEL_MR_HHOLDMST");
           MultiInput mi = helper.getMutiInput(dSet);
           dao = new MRen107DAO();
           ret = dao.save(form, mi, userId);
       } catch (Exception e) {
           logger.error("", e);
           helper.writeException("GAUCE", "002", e.getMessage());
       } finally {
           helper.close(dSet, ret + "건 처리되었습니다");
       }
       
       return mapping.findForward(strGoTo);
   }
}
