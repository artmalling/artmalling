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
import mren.dao.MRen108DAO;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import common.vo.SessionInfo;

/**
 * <p>계량기관리</p>
 * 
 * @created  on 1.0, 2010.04.01
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MRen108Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MRen108Action.class);


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
	 * <p>계량기마스터 조회</p>
	 */
	@SuppressWarnings("rawtypes")
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
           HttpServletRequest request, HttpServletResponse response)
	throws Exception {
	   List list			= null;
       GauceHelper2 helper	= null;
       GauceDataSet dSet	= null;
       MRen108DAO dao		= null;
       String strGoTo = form.getParam("goTo");
       try {  
           helper = new GauceHelper2(request, response, form);
           dSet = new GauceDataSet();
           dSet = helper.getDataSet("DS_IO_MASTER");			
           helper.setDataSetHeader(dSet, "H_SEL_MR_GAUGMST");
           dao = new MRen108DAO();
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
	 * <p>계량기디테일 조회</p>
	 */
	@SuppressWarnings("rawtypes")
	public ActionForward getDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {
		List list			= null;
		GauceHelper2 helper	= null;
		GauceDataSet dSet	= null;
		MRen108DAO dao		= null;
		String strGoTo = form.getParam("goTo");
		try {  
			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet();
			dSet = helper.getDataSet("DS_IO_DETAIL");			
			helper.setDataSetHeader(dSet, "H_SEL_MR_GAUGMST_DTL");
			dao = new MRen108DAO();
			list = dao.getDetail(form);
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
	 * <p> 저장 </p> 
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		MRen108DAO dao      = null;
		
		HttpSession session = request.getSession();
		String userId       = null;
		int ret             = 0;
		String strGoTo = form.getParam("goTo");
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
			helper = new GauceHelper2(request, response, form); 
			
			dSet = new GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_IO_MASTER");
            dSet[1] = helper.getDataSet("DS_IO_DETAIL"); 
			  
            helper.setDataSetHeader(dSet[0], "H_SEL_MR_GAUGMST");
			helper.setDataSetHeader(dSet[1], "H_SEL_MR_GAUGMST_DTL");
			  
			MultiInput miMst = helper.getMutiInput(dSet[0]);
			MultiInput miDtl = helper.getMutiInput(dSet[1]); 
			
			dao = new MRen108DAO();    
			ret = dao.save(form,miMst,miDtl,userId);
			
		} catch (Exception e) { 
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet, ret + "건 처리되었습니다"); 
		}
		return mapping.findForward(strGoTo);
	}
}
