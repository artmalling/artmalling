/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */
 
package psal.action;

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

import psal.dao.PSal923DAO;
import psal.dao.PSal932DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

/**
 * <p>입금상세데이터조회 Action</p>
 * 
 * @created  on 1.0, 2010/06/01	
 * @created  by 김영진 
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PSal932Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PSal932Action.class);

	/**
	 * <p>입금상세데이터조회 조회 화면으로 이동한다.</p>
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
     * <p>재청구진행 현황를 조회한다.</p>
     * 
     */      
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        PSal932DAO   dao    = null; 

        String strGoTo = form.getParam("goTo"); // 분기할곳

        try { 
            dao    = new PSal932DAO();
            helper = new GauceHelper2(request, response, form);
            
            dSet   = helper.getDataSet("DS_O_MASTER");
            helper.setDataSetHeader(dSet, "H_MASTER");            
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
     * <p>회계기표일자 저장</p>
     * 
     */
    public ActionForward saveData(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        PSal932DAO dao      = null;
        int ret             = 0;
       
        String strGoTo = form.getParam("goTo"); // 분기할곳

        try { 
            helper = new GauceHelper2(request, response, form);
            dSet = helper.getDataSet("DS_O_MASTER");
            helper.setDataSetHeader(dSet, "H_MASTER");
            MultiInput mi = helper.getMutiInput(dSet);
            dao = new PSal932DAO();  
            System.out.println(111111);
            ret = dao.save(form, mi, request, response);
            System.out.println(22222);
        } catch (Exception e) {
        	e.printStackTrace();
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            // 등록, 수정의 경우 아래의 메시지를 사용
            helper.close(dSet, "처리되었습니다.");
        }
        return mapping.findForward(strGoTo);
    }
    
    /**
     * <p>청구대상데이터 리스트를 조회한다.</p>
     * 
     */      
    public ActionForward recData(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        int recvResult = 0;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        PSal932DAO   dao    = null; 
        
        String strGoTo = form.getParam("goTo"); // 분기할곳

        try { 
            dao    = new PSal932DAO();
            helper = new GauceHelper2(request, response, form);
            
            dSet   = helper.getDataSet("DS_O_MASTER");
            helper.setDataSetHeader(dSet, "H_MASTER");
            
//            GauceDataSet dsDetail = new GauceDataSet();
//            helper.setDataSetHeader(dsDetail, "H_DETAIL");
            
            recvResult   = dao.recData(form, request);
            
            //helper.setListToDataset(list, dSet);
            
        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet, "수신 처리되었습니다");
        }
        
        return mapping.findForward(strGoTo);
    }
    
    public ActionForward recData_first(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        int recvResult = 0;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        PSal932DAO   dao    = null; 
        
        String strGoTo = form.getParam("goTo"); // 분기할곳

        try { 
            dao    = new PSal932DAO();
            helper = new GauceHelper2(request, response, form);
            
            dSet   = helper.getDataSet("DS_O_MASTER");
            helper.setDataSetHeader(dSet, "H_MASTER");
            
//            GauceDataSet dsDetail = new GauceDataSet();
//            helper.setDataSetHeader(dsDetail, "H_DETAIL");
            
            recvResult   = dao.recData_first(form, request);
            
            //helper.setListToDataset(list, dSet);
            
        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet, "수신 처리되었습니다");
        }
        
        return mapping.findForward(strGoTo);
    }
}
