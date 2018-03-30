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

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.model.ProcedureResultSet;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

import dctm.dao.DCtm101DAO;
/**
 * <p>무기명카드 발급매수 등록</p>
 * 
 * @created  on 1.0, 2010/02/16
 * @created  by 김영진
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DCtm101Action extends DispatchAction {
    /**
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
    private Logger logger = Logger.getLogger(DCtm101Action.class);

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
            
            
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("[list]", e);
        }

        return mapping.findForward("list");
    }
    
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List list = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet = null;
        DCtm101DAO dao = null; 

        String strGoTo = form.getParam("goTo"); // 분기할곳

        try {

            dao = new DCtm101DAO();
            helper = new GauceHelper2(request, response, form);
            dSet = helper.getDataSet("DS_O_MASTER");
            helper.setDataSetHeader(dSet, "H_MASTER");
            list = dao.searchMaster(form, request);
            helper.setListToDataset(list, dSet);

        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        return mapping.findForward(strGoTo);
    }
    
    public ActionForward searchDetail(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List list = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet = null;
        DCtm101DAO dao = null; 

        String strGoTo = form.getParam("goTo"); // 분기할곳

        try {

            dao = new DCtm101DAO();
            helper = new GauceHelper2(request, response, form);
            dSet = helper.getDataSet("DS_IO_DATA");
            helper.setDataSetHeader(dSet, "H_INS");
            list = dao.searchDetail(form, request);
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
     * <p>카드발급매수 엑셀로 조회하기 위한 조회.</p>
     * 
     */
    public ActionForward searchMaster2(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List list = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet = null;
        DCtm101DAO dao = null; 

        String strGoTo = form.getParam("goTo"); // 분기할곳

        try {

            dao = new DCtm101DAO();
            helper = new GauceHelper2(request, response, form);
            dSet = helper.getDataSet("DS_O_MASTER2");
            helper.setDataSetHeader(dSet, "H_MASTER2");
            
            list = dao.searchMaster2(form);
            
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
     * <p>카드발급매수를 등록한다.</p>
     * 
     */
    public ActionForward saveData(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
            GauceHelper2 helper = null;
            GauceDataSet dSet = null;
            DCtm101DAO dao = null;
            ProcedureResultSet prs = null;
            int ret = 0;
           
            try {
                helper = new GauceHelper2(request, response, form);
                dSet = helper.getDataSet("DS_IO_DATA");          
                dao = new DCtm101DAO();
                ret = dao.saveData(form, dSet, request);

            } catch (Exception e) {
                e.printStackTrace();
                logger.error("[updateProgram]", e);
                helper.writeException("GAUCE", "002", e.getMessage());
            } finally {
                helper.close("카드번호 생성이 완료되었습니다.");
            }
    
            return mapping.findForward("searchMaster");
    }        
    
    /**
     * <p>카드발급매수를 삭제한다.</p>
     * 
     */
    public ActionForward delData(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
            GauceHelper2 helper = null;
            GauceDataSet dSet = null;
            DCtm101DAO dao = null;
            ProcedureResultSet prs = null;
            int ret = 0;
           
            try {
            	
                helper = new GauceHelper2(request, response, form);
                dSet = helper.getDataSet("DS_IO_DATA");       
                dao = new DCtm101DAO();
                ret = dao.delData(form, dSet, request);
                
            } catch (Exception e) {
                e.printStackTrace();
                logger.error("[updateProgram]", e);
                helper.writeException("GAUCE", "002", e.getMessage());
            } finally {

                helper.close("1건 삭제 처리가 정상적으로 완료되었습니다.");
            }
    
            return mapping.findForward("searchMaster");
    }        
}
