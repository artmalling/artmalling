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
import mren.dao.MRen110DAO;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

/**
 * <p>월요금표 관리</p>
 * 
 * @created  on 1.0, 2010/04/04
 * @created  by 신익수(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MRen110Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MRen110Action.class);

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
			//System.out.println(session.getAttribute("sessionInfo").getClass().getCanonicalName());
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
	 * <p>온수_주택용 조회</p>
	 */
    public ActionForward getWarmWtrprch(ActionMapping mapping, ActionForm form,
           HttpServletRequest request, HttpServletResponse response) throws Exception {
       List list			= null;
       GauceHelper2 helper	= null;
       GauceDataSet dSet	= null;
       MRen110DAO dao		= null;
       
       String strGoTo = form.getParam("goTo");
       
       try {  
           helper = new GauceHelper2(request, response, form);
           dSet = new GauceDataSet();
           dSet = helper.getDataSet("DS_IO_MASTER");			
           helper.setDataSetHeader(dSet, "H_MASTER");
           dao = new MRen110DAO();
           list = dao.getWarmWtrprch(form);
       
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
	 * <p>온수_업무용 조회</p>
	 */
    public ActionForward getWarmWtrprcb(ActionMapping mapping, ActionForm form,
           HttpServletRequest request, HttpServletResponse response) throws Exception {
       List list			= null;
       GauceHelper2 helper	= null;
       GauceDataSet dSet	= null;
       MRen110DAO dao		= null;
       
       String strGoTo = form.getParam("goTo");
       
       try {  
           helper = new GauceHelper2(request, response, form);
           dSet = new GauceDataSet();
           dSet = helper.getDataSet("DS_IO_MASTER1");			
           helper.setDataSetHeader(dSet, "H_MASTER1");
           dao = new MRen110DAO();
           list = dao.getWarmWtrprcb(form);
       
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
	 * <p>증기 조회</p>
	 */
    public ActionForward getSteamPrc(ActionMapping mapping, ActionForm form,
           HttpServletRequest request, HttpServletResponse response) throws Exception {
       List list			= null;
       GauceHelper2 helper	= null;
       GauceDataSet dSet	= null;
       MRen110DAO dao		= null;
       
       String strGoTo = form.getParam("goTo");
       
       try {  
           helper = new GauceHelper2(request, response, form);
           dSet = new GauceDataSet();
           dSet = helper.getDataSet("DS_IO_MASTER2");			
           helper.setDataSetHeader(dSet, "H_MASTER2");
           dao = new MRen110DAO();
           list = dao.getSteamPrc(form);
       
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
	 * <p>냉수-기본요금 조회</p>
	 */
    public ActionForward getColdWtrBa(ActionMapping mapping, ActionForm form,
           HttpServletRequest request, HttpServletResponse response) throws Exception {
       List list			= null;
       GauceHelper2 helper	= null;
       GauceDataSet dSet	= null;
       MRen110DAO dao		= null;
       
       String strGoTo = form.getParam("goTo");
       
       try {  
           helper = new GauceHelper2(request, response, form);
           dSet = new GauceDataSet();
           dSet = helper.getDataSet("DS_IO_MASTER3");			
           helper.setDataSetHeader(dSet, "H_MASTER3");
           dao = new MRen110DAO();
           list = dao.getColdWtrBa(form);
       
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
	 * <p>냉수-사용요금 조회</p>
	 */
    public ActionForward getcoldWtr(ActionMapping mapping, ActionForm form,
           HttpServletRequest request, HttpServletResponse response) throws Exception {
       List list			= null;
       GauceHelper2 helper	= null;
       GauceDataSet dSet	= null;
       MRen110DAO dao		= null;
       
       String strGoTo = form.getParam("goTo");
       
       try {  
           helper = new GauceHelper2(request, response, form);
           dSet = new GauceDataSet();
           dSet = helper.getDataSet("DS_IO_MASTER4");			
           helper.setDataSetHeader(dSet, "H_MASTER4");
           dao = new MRen110DAO();
           list = dao.getcoldWtr(form);
       
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
	 * <p> 열요금표 관리 등록/수정/삭제 </p> 
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println("여기 안타나????");
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		MRen110DAO dao      = null;
		
		HttpSession session = request.getSession();
		String userId       = null;
		String org_flag     = null;  // 조직구분 (1:판매, 2:매입) 
		int ret             = 0;
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
			org_flag = sessionInfo.getORG_FLAG();                  
			
			helper = new GauceHelper2(request, response, form); 
			
			dSet = new GauceDataSet[5];
			dSet[0] = helper.getDataSet("DS_IO_MASTER");
            dSet[1] = helper.getDataSet("DS_IO_MASTER1"); 
            dSet[2] = helper.getDataSet("DS_IO_MASTER2"); 
            dSet[3] = helper.getDataSet("DS_IO_MASTER3"); 
            dSet[4] = helper.getDataSet("DS_IO_MASTER4"); 
			  
            helper.setDataSetHeader(dSet[0], "H_MASTER");
			helper.setDataSetHeader(dSet[1], "H_MASTER1");
			helper.setDataSetHeader(dSet[2], "H_MASTER2");
			helper.setDataSetHeader(dSet[3], "H_MASTER3");
			helper.setDataSetHeader(dSet[4], "H_MASTER4");
			  
			MultiInput mi0 = helper.getMutiInput(dSet[0]);
			MultiInput mi1 = helper.getMutiInput(dSet[1]); 
			MultiInput mi2 = helper.getMutiInput(dSet[2]);
			MultiInput mi3 = helper.getMutiInput(dSet[3]); 
			MultiInput mi4 = helper.getMutiInput(dSet[4]);
			 
			
			dao = new MRen110DAO();    
			// 등록및수정, 삭제 분기
			ret = dao.save(form,mi0,mi1, mi2,mi3,mi4,userId);
			
		} catch (Exception e) { 
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet, "처리되었습니다"); 
		}
		return mapping.findForward("save");
	}
}
