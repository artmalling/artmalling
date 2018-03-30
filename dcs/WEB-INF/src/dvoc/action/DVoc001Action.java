/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */
 
package dvoc.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import common.vo.SessionInfo;
import dvoc.dao.DVoc001DAO;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;

/**
 * <p> 컴플레인등록 </p>
 *  
 * @created  on 1.0, 2016/11/28 
 * @created  by 윤지영
 *  
 * @modified on 
 * @modified by     
 * @caused   by 
 */
public class DVoc001Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DVoc001Action.class);

	/**
	 * <p>컴플레인등록 화면으로 이동한다.</p>
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
                System.out.println("Session Test!!!" + sessionInfo.getUSER_ID());
            } 
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("[list]", e);
		}

		return mapping.findForward("list");
	}
	
	
	
	/**
     * <p>컴플레인 리스트를 조회한다.</p>
     * 
     */      
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DVoc001DAO   dao    = null; 

        String strGoTo = form.getParam("goTo"); // 분기할곳

        try { 
            dao    = new DVoc001DAO();
            helper = new GauceHelper2(request, response, form);
            
            dSet   = helper.getDataSet("DS_IO_MASTER");
            helper.setDataSetHeader(dSet, "H_SEL_MASTER");            
            list   = dao.searchMaster(form);
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
	 * <p> 컴플레인 등록/수정/삭제 </p> 
	 * 
	 */
    public ActionForward save(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
            
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DVoc001DAO dao      = null;
        
		HttpSession session = request.getSession();
		String userId       = null;
        int ret             = 0; 
		String strMessage   = "";
		
        try {
            
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
			
            helper = new GauceHelper2(request, response, form);
             
            dSet = helper.getDataSet("DS_IO_MASTER");
            helper.setDataSetHeader(dSet, "H_SEL_MASTER"); 
            
            MultiInput mi = helper.getMutiInput(dSet); 
            
            dao    = new DVoc001DAO(); 
			// 컴플레인 등록
			if(form.getParam("strFlag").equals("save")){ 
				ret = dao.save(form, mi, userId);
				strMessage = "저장되었습니다.";
			// 컴플레인조치 등록
			}else if(form.getParam("strFlag").equals("save_Pop")){ 
				ret = dao.save_Pop(form, mi, userId);
				strMessage = "저장되었습니다.";
			// 컴플레인 삭제
			}else{ 
				ret = dao.delete(form, userId);
				strMessage = "삭제되었습니다.";
			}  
			 
        } catch (Exception e) {                
            logger.error("[updateProgram]", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close("정상적으로 처리 되었습니다.");
        }
        return mapping.findForward("save");
    } 
    
	/**
	 * <p> 컴플레인 조치등록 팝업 LOAD </p> 
	 * 
	 */  
    public ActionForward getVocPop(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 
		try { 
			
			GauceHelper2.initialize(form, request, response);
			
			HttpSession session = request.getSession(); 
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
			
           
            if (sessionInfo != null) {
                System.out.println("Session Test!!!" + sessionInfo.getUSER_ID());
            } 
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("[getVocPop]", e);
		}

		return mapping.findForward("getVocPop");
	}

	/**
     * <p> 컴플레인 조치등록 팝업 리스트를 조회한다.</p>
     * 
     */      
    public ActionForward searchMaster_Pop(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DVoc001DAO   dao    = null;  

        try { 
            dao    = new DVoc001DAO();
            helper = new GauceHelper2(request, response, form);
            
            dSet   = helper.getDataSet("DS_IO_MASTER");
            helper.setDataSetHeader(dSet, "H_SEL_MASTER");            
            list   = dao.searchMaster_Pop(form);
            helper.setListToDataset(list, dSet);

        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        
        return mapping.findForward("searchMaster_Pop");
    }
	
}
