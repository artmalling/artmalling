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
import mren.dao.MRen404DAO;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import common.vo.SessionInfo;

/**
 * <p>관리비입금내역관리</p>
 * 
 * @created  on 1.0, 2010.05.06
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MRen404Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MRen404Action.class);


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
	 * <p>관리비입금내역관리 조회</p>
	 */
	@SuppressWarnings("rawtypes")
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
           HttpServletRequest request, HttpServletResponse response)
	throws Exception {
	   List list			= null;
       GauceHelper2 helper	= null;
       GauceDataSet dSet	= null;
       MRen404DAO dao		= null;
       String strGoTo = form.getParam("goTo");
       try {  
           helper = new GauceHelper2(request, response, form);
           dSet = new GauceDataSet();
           dSet = helper.getDataSet("DS_O_MASTER");			
           helper.setDataSetHeader(dSet, "H_SEL_MR_CALMST");
           dao = new MRen404DAO();
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
	 * <p>관리비입금내역관리디테일 조회</p>
	 */
	@SuppressWarnings("rawtypes")
	public ActionForward getDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {
		List list[]         = null;
		GauceHelper2 helper	= null;
		GauceDataSet dSet[]	= null;
		MRen404DAO dao		= null;
		String strGoTo = form.getParam("goTo");
		try {  
			helper = new GauceHelper2(request, response, form);
			dSet    = new GauceDataSet[2];
			
			list    = new  List[2];
			dSet[0] = helper.getDataSet("DS_IO_DETAIL");
			helper.setDataSetHeader(dSet[0], "H_SEL_MR_CALPAY");
			dSet[1] = helper.getDataSet("DS_O_COUNT");			
			helper.setDataSetHeader(dSet[1], "H_SEL_MR_COUNT");			
			dao = new MRen404DAO();
			
			//MultiInput mi[] = new MultiInput[2];
			//mi[0] = helper.getMutiInput(dSet[0]);
			//mi[1] = helper.getMutiInput(dSet[1]);
			
			list = dao.getDetail(form); 
			
			for(int i=0;i<list.length;i++){      
				
				helper.setListToDataset(list[i], dSet[i]);
			}
			
			//MultiInput mi = helper.getMutiInput(dSet);
			//list = dao.searchDetail(form ,mi);
			//helper.setListToDataset(list, dSet); 
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p>관리비입금내역관리 조회</p>
	 */
	@SuppressWarnings("rawtypes")
	public ActionForward getCalBal(ActionMapping mapping, ActionForm form,
           HttpServletRequest request, HttpServletResponse response)
	throws Exception {
	   List list			= null;
       GauceHelper2 helper	= null;
       GauceDataSet dSet	= null;
       MRen404DAO dao		= null;
       String strGoTo = form.getParam("goTo");
       try {  
           helper = new GauceHelper2(request, response, form);
           dSet = new GauceDataSet();
           dSet = helper.getDataSet("DS_IO_CALBAL");			
           helper.setDataSetHeader(dSet, "H_SEL_MR_CALBAL");
           dao = new MRen404DAO();
           list = dao.getCalBal(form);
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
	 * <p>저장</p> 
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		MRen404DAO dao      = null;
		
		HttpSession session = request.getSession();
		String userId       = null;
		int ret             = 0;
		String strGoTo = form.getParam("goTo");
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
			helper = new GauceHelper2(request, response, form); 
			
			dSet =new GauceDataSet();
			dSet = helper.getDataSet("DS_IO_DETAIL");
            helper.setDataSetHeader(dSet, "H_SEL_MR_CALPAY");
			MultiInput mi = helper.getMutiInput(dSet);
	
			dao = new MRen404DAO();    
			ret = dao.save(form,mi,userId);
			
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
	 * <p>저장</p> 
	 * 
	 */
	public ActionForward balsave(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		MRen404DAO dao      = null;
		
		HttpSession session = request.getSession();
		String userId       = null;
		int ret             = 0;
		String strGoTo = form.getParam("goTo");
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
			helper = new GauceHelper2(request, response, form); 
			
			dSet =new GauceDataSet();
			dSet = helper.getDataSet("DS_IO_CALBAL");
            helper.setDataSetHeader(dSet, "H_SEL_MR_CALBAL");
			MultiInput mi = helper.getMutiInput(dSet);

			System.out.println("balsave============");			
			dao = new MRen404DAO();    
			ret = dao.balsave(form,mi,userId);
			
		} catch (Exception e) { 
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet,"처리되었습니다"); 
		}
		return mapping.findForward(strGoTo);
	}
}
