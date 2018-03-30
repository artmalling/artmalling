/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dctm.action;

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

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import common.vo.SessionInfo;

import dctm.dao.DCtm432DAO;

/**
 * <p></p>
 * 
 * @created  on 1.0, 2010/03/30
 * @created  by 장형욱(FUJITSU KOREA LTD.)
 * @caused   by 데이터변경이력조회
 * 
 * @modified on 
 * @modified by 
 */

public class DCtm432Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DCtm431Action.class);

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
            int listday = calendar.getActualMaximum(calendar.DATE);
            String fromDate = dateFormat.format(calendar.getTime()) + Integer.toString(listday);
            
            request.setAttribute("fromDate", toDay);       
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("[list]", e);
		}

		return mapping.findForward("list");
	}
	
    /**
     * <p> 데이터조회이력조회한다.</p>
     * 
     */
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DCtm432DAO      dao     = null;

        String strGoTo = form.getParam("goTo"); // 분기할곳
         
        try {     
            dao    = new DCtm432DAO();
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
     * <p>
     *  테이블명 콤보박스 처리
     * </p>
     */
    public ActionForward getTableNm(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List list = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        DCtm432DAO   dao   = null;
        MultiInput   mi     = null;
        try {
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];
            dSet[0] = helper.getDataSet("DS_I_COMMON");
            dSet[1] = helper.getDataSet("DS_O_COMMON");
            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_COMMON");
            dao = new DCtm432DAO();
            list = dao.getEtcCode(form, mi);
            
            if (list != null) {
                helper.setListToDataset(list, dSet[1]);
            }
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
        return mapping.findForward("getTableNm");
    }
}
