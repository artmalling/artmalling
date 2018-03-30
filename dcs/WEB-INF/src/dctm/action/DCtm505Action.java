/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dctm.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import common.vo.SessionInfo;

import dctm.dao.DCtm505DAO;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;

/**
 * <p></p>
 * 
 * @created  on 1.0, 2016.11.01
 * @created  by KHJ
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class DCtm505Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DCtm505Action.class);

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
     * <p> 회원조회</p>
     * 
     */
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DCtm505DAO      dao     = null;

        String strGoTo = form.getParam("goTo"); // 분기할곳
         
        try {     
            dao    = new DCtm505DAO();
            helper = new GauceHelper2(request, response, form);
            dSet   = helper.getDataSet("DS_O_MASTER2");
            helper.setDataSetHeader(dSet, "H_MASTER2");
            
            list   = dao.searchList(form, request);
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
	 * 문자 발송 합니다.
	 * </p>
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		DCtm505DAO dao      = null;
		int ret             = 0;
		HttpSession session = request.getSession();
		String userId       = null;
		
		String strGoTo      	= form.getParam("goTo"); // 분기할곳
		String strOpGubun      	= form.getParam("strOpGubun"); // 영업구분
		
		//System.out.println("action start");
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");

			userId = sessionInfo.getUSER_ID();
			
			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_O_TEMP");
			dSet[1] = helper.getDataSet("DS_O_CONTENT");
			
			
			
			if (strOpGubun.equals("2"))
					helper.setDataSetHeader(dSet[0], "H_ONLINE");
			else
				helper.setDataSetHeader(dSet[0], "H_MASTER");
			
			helper.setDataSetHeader(dSet[1], "H_CONTENT");
			
			MultiInput mi[] = new MultiInput[2];
			mi[0] = helper.getMutiInput(dSet[0]);
			mi[1] = helper.getMutiInput(dSet[1]);
			//System.out.println("action start");
			dao = new DCtm505DAO();
			ret = dao.save(form, mi, userId);
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet, ret + "건 처리되었습니다");
		}
		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p>
	 * 문자 발송 합니다.
	 * </p>
	 * 
	 */
	public ActionForward sendProcess(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		DCtm505DAO dao      = null;
		int ret             = 0;
		HttpSession session = request.getSession();
		String userId       = null;
		
		String strGoTo      = form.getParam("goTo"); // 분기할곳
		
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");

			userId = sessionInfo.getUSER_ID();
			
			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[1];
			dSet[0] = helper.getDataSet("DS_O_MASTER2");
			helper.setDataSetHeader(dSet[0], "H_MASTER2");
			
			MultiInput mi[] = new MultiInput[1];
			mi[0] = helper.getMutiInput(dSet[0]);
			dao = new DCtm505DAO();
			ret = dao.sendProcess(form, mi, userId);
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet, "처리되었습니다");
		}
		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p>
	 * 문자 발송 대기내역을 삭제 합니다.
	 * </p>
	 * 
	 */
	public ActionForward delProcess(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		DCtm505DAO dao      = null;
		int ret             = 0;
		HttpSession session = request.getSession();
		String userId       = null;
		
		String strGoTo      = form.getParam("goTo"); // 분기할곳
		
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");

			userId = sessionInfo.getUSER_ID();
			
			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[1];
			dSet[0] = helper.getDataSet("DS_O_MASTER2");
			helper.setDataSetHeader(dSet[0], "H_MASTER2");
			
			MultiInput mi[] = new MultiInput[1];
			mi[0] = helper.getMutiInput(dSet[0]);
			dao = new DCtm505DAO();
			ret = dao.delProcess(form, mi, userId);
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet, "처리되었습니다");
		}
		return mapping.findForward(strGoTo);
	}
	
	
	 /**
     * <p> 회원조회</p>
     * 
     */
    public ActionForward searchCust(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DCtm505DAO      dao     = null;
		System.out.println("action start");
        String strGoTo = form.getParam("goTo"); // 분기할곳
        String strGb = form.getParam("strGb"); // 분기할곳
         
        try {     
            dao    = new DCtm505DAO();
            helper = new GauceHelper2(request, response, form);

            if (strGb.equals("sch")){
            	dSet   = helper.getDataSet("DS_O_RESULT");
            	System.out.println("action DS_O_RESULT");
            }
            	
            else {
            	dSet   = helper.getDataSet("DS_O_RESULT");
            	System.out.println("action DS_O_RESULT");
            }
            
            helper.setDataSetHeader(dSet, "H_MASTER");
            
            System.out.println("action req");
            list   = dao.searchCust(form, request);
            helper.setListToDataset(list, dSet);
            System.out.println("action end");
        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        return mapping.findForward(strGoTo);
    }  
    
    /**
     * <p> 회원조회</p>
     * 
     */
    public ActionForward regCust(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DCtm505DAO      dao     = null;
		System.out.println("action start");
        String strGoTo = form.getParam("goTo"); // 분기할곳
        String strGb = form.getParam("strGb"); // 분기할곳
         
        try {     
            dao    = new DCtm505DAO();
            helper = new GauceHelper2(request, response, form);

            if (strGb.equals("sch")){
            	dSet   = helper.getDataSet("DS_O_MASTER");
            	System.out.println("action DS_O_MASTER");
            }
            	
            else {
            	dSet   = helper.getDataSet("DS_O_RESULT");
            	System.out.println("action DS_O_RESULT");
            }
            
            helper.setDataSetHeader(dSet, "H_MASTER");
            
            System.out.println("action req");
            list   = dao.regCust(form, request);
            helper.setListToDataset(list, dSet);
            System.out.println("action end");
        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        return mapping.findForward(strGoTo);
    } 
    
    public ActionForward seqSlpNo(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

    	List list           = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		DCtm505DAO dao      = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		HttpSession session     = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
		String userId  = sessionInfo.getUSER_ID();
		String orgFlag = sessionInfo.getORG_FLAG();
		
		try {
			dao    = new DCtm505DAO();
			helper = new GauceHelper2(request, response, form);
			dSet   = helper.getDataSet("DS_O_SEQ");
			helper.setDataSetHeader(dSet, "H_SEL_SEQ");
			
			list = dao.seqSlpNo(form, request);
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
