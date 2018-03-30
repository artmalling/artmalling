/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dmtc.action;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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
import kr.fujitsu.ffw.util.String2;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;
import dmtc.dao.DMtc605DAO;

import common.vo.SessionInfo;
/**
 * <p></p>
 * 
 * @created  on 1.0, 2010/03/24
 * @created  by 장형욱(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMtc605Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DMtc605Action.class);

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
            
            String toDay   = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date()); 
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMM"); 
            
            Calendar calendar = Calendar.getInstance(); 
            Date date = dateFormat.parse(toDay); 
            calendar.setTime(date); 
            calendar.add(Calendar.MONTH, -1); 

            toDay = dateFormat.format(calendar.getTime())+ "01"; 
            
            request.setAttribute("toDate", toDay);
			
           
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
     * <p> 마감일자관리 조회한다.</p>
     * 
     */
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DMtc605DAO      dao     = null;

        String strGoTo = form.getParam("goTo"); // 분기할곳
         
        try {     
            dao    = new DMtc605DAO();
            helper = new GauceHelper2(request, response, form);
            dSet   = helper.getDataSet("DS_O_MASTER");
            helper.setDataSetHeader(dSet, "H_MASTER");
            
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
     * <p> 마감일자관리 상세 조회한다.</p>
     * 
     */
    public ActionForward searchDetail(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DMtc605DAO      dao     = null;

        String strGoTo = form.getParam("goTo"); // 분기할곳
         
        try {     
            dao    = new DMtc605DAO();
            helper = new GauceHelper2(request, response, form);
            dSet   = helper.getDataSet("DS_IO_DETAIL");
            helper.setDataSetHeader(dSet, "H_DETAIL");
            
            list   = dao.searchDetail(form, request);
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
     * <p> 마감일차 관리를 등록한다.</p>
     * 
     */
    public ActionForward saveData(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
        GauceHelper2 helper = null;
        GauceDataSet dSet = null;
        DMtc605DAO dao = null;

        int ret = 0;
        String userId = null;
            
        try {
        	
            helper = new GauceHelper2(request, response, form);
 
            dSet = helper.getDataSet("DS_IO_DETAIL");
            helper.setDataSetHeader(dSet, "H_DETAIL");
            MultiInput mi = helper.getMutiInput(dSet);
                
            HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
            userId = sessionInfo.getUSER_ID();
            dao = new DMtc605DAO();
            ret = dao.saveData(form, mi, userId);
                
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("[updateProgram]", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close("정상적으로 처리 되었습니다.");
        }
        return mapping.findForward("saveData");
    }       
}
