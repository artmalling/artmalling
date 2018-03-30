/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */
 
package common.action;

import java.util.List;

import org.apache.log4j.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;

import common.dao.CCom901DAO;
import common.vo.SessionInfo;

import com.gauce.GauceDataSet;

/**
 * <p>점, 부분, 팀, PC 콤보 조회</p>
 * 
 * @created  on 1.0, 2010/02/15	
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class CCom901Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(CCom901Action.class);

    /**
     * <p>
     * 점 조회
     * </p>
     */
    public ActionForward getStore(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
    	
    	
    	List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom901DAO   dao   = null;
        MultiInput   mi     = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
		HttpSession session = request.getSession();
		
        String strOrgFlag = "";
        String strUserId = "";
        try {
            //session 정보
            SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
            strUserId = sessionInfo.getUSER_ID();
            strOrgFlag = sessionInfo.getORG_FLAG();
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];
            dSet[0] = helper.getDataSet("DS_I_CONDITION");
            dSet[1] = helper.getDataSet("DS_O_STORE");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_COMBO");

            dao = new CCom901DAO();

            list = dao.getStore(form, mi, strUserId, strOrgFlag);
            
            if (list != null) {
                helper.setListToDataset(list, dSet[1]);
            }
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
     * 점 조회2
     * </p>
     */
    public ActionForward getStore2(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
       
        
    	List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom901DAO   dao   = null;
        MultiInput   mi     = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
		HttpSession session = request.getSession();
        String strOrgFlag = "";
        String strUserId = "";
        try {
            //session 정보
            SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
            strUserId = sessionInfo.getUSER_ID();
            strOrgFlag = request.getParameter("strOrgFlag"); //sessionInfo.getORG_FLAG();
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];
            dSet[0] = helper.getDataSet("DS_I_CONDITION");
            dSet[1] = helper.getDataSet("DS_O_STORE");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_COMBO");

            dao = new CCom901DAO();

            list = dao.getStore2(form, mi, strUserId, strOrgFlag);
            
            
            
            if (list != null) {
                helper.setListToDataset(list, dSet[1]);
            }
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
     * 부문 조회
     * </p>
     */
    public ActionForward getDept(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom901DAO   dao   = null;
        MultiInput   mi     = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
		
        HttpSession session = request.getSession();
        String strOrgFlag = "";
        String strUserId = "";
        try {
            //session 정보
            SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
            strUserId = sessionInfo.getUSER_ID();
            strOrgFlag = sessionInfo.getORG_FLAG();
        	
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];

            dSet[0] = helper.getDataSet("DS_I_CONDITION");
            dSet[1] = helper.getDataSet("DS_O_DEPT");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_COMBO_01");

            dao = new CCom901DAO();

            list = dao.getDept(form, mi, strUserId, strOrgFlag);
            
            if (list != null) {
                helper.setListToDataset(list, dSet[1]);
            }
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
     * 부문 조회2
     * </p>
     */
    public ActionForward getDept2(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom901DAO   dao   = null;
        MultiInput   mi     = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
		
        HttpSession session = request.getSession();
        String strOrgFlag = "";
        String strUserId = "";
        try {
            //session 정보
            SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
            strUserId = sessionInfo.getUSER_ID();
            strOrgFlag =request.getParameter("strOrgFlag");  //sessionInfo.getORG_FLAG(); 세션으로 받아 오지 않고 콤보박스에 따라 값 받기
        	
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];

            dSet[0] = helper.getDataSet("DS_I_CONDITION");
            dSet[1] = helper.getDataSet("DS_O_DEPT");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_COMBO_01");

            dao = new CCom901DAO();

            list = dao.getDept2(form, mi, strUserId, strOrgFlag);
            
            
            
            if (list != null) {
                helper.setListToDataset(list, dSet[1]);
            }
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
        return mapping.findForward(strGoTo);
    }
    
    /**
     * <p>
     * 팀 조회
     * </p>
     */
    public ActionForward getTeam(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom901DAO   dao   = null;
        MultiInput   mi     = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳

        HttpSession session = request.getSession();
        String strOrgFlag = "";
        String strUserId = "";
        
        try {
            //session 정보
            SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
            strUserId = sessionInfo.getUSER_ID();
            strOrgFlag = sessionInfo.getORG_FLAG();
            
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];

            dSet[0] = helper.getDataSet("DS_I_CONDITION");
            dSet[1] = helper.getDataSet("DS_O_TEAM");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_COMBO_01");

            dao = new CCom901DAO();

            list = dao.getTeam(form, mi, strUserId, strOrgFlag);
            
            if (list != null) {
                helper.setListToDataset(list, dSet[1]);
            }
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
     * 팀 조회
     * </p>
     */
    public ActionForward getTeam2(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom901DAO   dao   = null;
        MultiInput   mi     = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳

        HttpSession session = request.getSession();
        String strOrgFlag = "";
        String strUserId = "";
        
        try {
            //session 정보
            SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
            strUserId = sessionInfo.getUSER_ID();
            strOrgFlag = request.getParameter("strOrgFlag"); //sessionInfo.getORG_FLAG(); 세션으로 받지않고 콤보박스의 값을 받음
            
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];

            dSet[0] = helper.getDataSet("DS_I_CONDITION");
            dSet[1] = helper.getDataSet("DS_O_TEAM");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_COMBO_01");

            dao = new CCom901DAO();

            list = dao.getTeam2(form, mi, strUserId, strOrgFlag);
            
            
            
            
            if (list != null) {
                helper.setListToDataset(list, dSet[1]);
            }
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
     * PC 조회
     * </p>
     */
    public ActionForward getPc(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom901DAO   dao   = null;
        MultiInput   mi     = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳

        HttpSession session = request.getSession();
        String strUserId = "";
        String strOrgFlag = "";
        
        try {
            //session 정보
            SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
            strUserId = sessionInfo.getUSER_ID();
            strOrgFlag = sessionInfo.getORG_FLAG();
            
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];

            dSet[0] = helper.getDataSet("DS_I_CONDITION");
            dSet[1] = helper.getDataSet("DS_O_PC");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_COMBO_01");

            dao = new CCom901DAO();

            list = dao.getPc(form, mi, strUserId, strOrgFlag);
            
            if (list != null) {
                helper.setListToDataset(list, dSet[1]);
            }
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
     * PC 조회
     * </p>
     */
    public ActionForward getPc2(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom901DAO   dao   = null;
        MultiInput   mi     = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳

        HttpSession session = request.getSession();
        String strUserId = "";
        String strOrgFlag = "";
        
        try {
            //session 정보
            SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
            strUserId = sessionInfo.getUSER_ID();
            strOrgFlag = request.getParameter("strOrgFlag"); //sessionInfo.getORG_FLAG(); 세션으로 받지않고 콤보 박스의 값을 받음
            
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];

            dSet[0] = helper.getDataSet("DS_I_CONDITION");
            dSet[1] = helper.getDataSet("DS_O_PC");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_COMBO_01");

            dao = new CCom901DAO();

            list = dao.getPc2(form, mi, strUserId, strOrgFlag);
            
           
            
            if (list != null) {
                helper.setListToDataset(list, dSet[1]);
            }
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
     * CORNER 조회
     * </p>
     */
    public ActionForward getCorner(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom901DAO   dao   = null;
        MultiInput   mi     = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳

        HttpSession session = request.getSession();
        String strUserId = "";
        
        try {
            //session 정보
            SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
            strUserId = sessionInfo.getUSER_ID();
            
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];

            //2010.05.25 gauce.js에 getCorner 동일하게 수정(이재득)
            dSet[0] = helper.getDataSet("DS_I_CONDITION");
            dSet[1] = helper.getDataSet("DS_O_CORNER");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_COMBO_01");

            dao = new CCom901DAO();

            list = dao.getCorner(form, mi, strUserId);
            
            if (list != null) {
                helper.setListToDataset(list, dSet[1]);
            }
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
     * CORNER 조회
     * </p>
     */
    public ActionForward getCorner2(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom901DAO   dao   = null;
        MultiInput   mi     = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳

        HttpSession session = request.getSession();
        String strUserId = "";
        
        try {
            //session 정보
            SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
            strUserId = sessionInfo.getUSER_ID();
            
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];

            //2010.05.25 gauce.js에 getCorner 동일하게 수정(이재득)
            dSet[0] = helper.getDataSet("DS_I_CONDITION");
            dSet[1] = helper.getDataSet("DS_O_CORNER");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_COMBO_01");

            dao = new CCom901DAO();

            list = dao.getCorner(form, mi, strUserId);
            
            if (list != null) {
                helper.setListToDataset(list, dSet[1]);
            }
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
     * 시설코드 조회
     * </p>
     */
    public ActionForward getFlc(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
    	List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom901DAO   dao   = null;
        MultiInput   mi     = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
		HttpSession session = request.getSession();
        String strOrgFlag = "";
        String strUserId = "";
        try {
            //session 정보
            SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
            strUserId = sessionInfo.getUSER_ID();
            strOrgFlag = sessionInfo.getORG_FLAG();
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];
            dSet[0] = helper.getDataSet("DS_I_CONDITION");
            dSet[1] = helper.getDataSet("DS_O_RESULT");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_SEL_FCL");

            dao = new CCom901DAO();

            list = dao.getFlc(form, mi, strUserId, strOrgFlag);
            
            if (list != null) {
                helper.setListToDataset(list, dSet[1]);
            }
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
     * 매입사 코드 조회
     * </p>
     */
    public ActionForward getBcompCode(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
        List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom901DAO   dao   = null;
        MultiInput   mi     = null;
        
        String strGoTo      = form.getParam("goTo"); // 분기할곳
        try {
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];

            dSet[0] = helper.getDataSet("DS_I_COMMON");
            dSet[1] = helper.getDataSet("DS_O_COMMON");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_COMBO_01");
            dao = new CCom901DAO();
            list = dao.getBcompCode(form, mi); 
            if (list != null) {
                helper.setListToDataset(list, dSet[1]);
            }
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
     * 발급사 코드 조회
     * </p>
     */
    public ActionForward getCcompCode(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
        List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom901DAO   dao   = null;
        MultiInput   mi     = null;
        
        String strGoTo      = form.getParam("goTo"); // 분기할곳
        try {
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];

            dSet[0] = helper.getDataSet("DS_I_COMMON");
            dSet[1] = helper.getDataSet("DS_O_COMMON");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_COMBO_01");
            dao = new CCom901DAO();
            list = dao.getCcompCode(form, mi); 
            if (list != null) {
                helper.setListToDataset(list, dSet[1]);
            }
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
     * 디뷰크카드조회 
     * </p>
     */
    public ActionForward getDcardCode(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
        List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom901DAO   dao   = null;
        MultiInput   mi     = null;
        
        String strGoTo      = form.getParam("goTo"); // 분기할곳
        try {
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];

            dSet[0] = helper.getDataSet("DS_I_COMMON");
            dSet[1] = helper.getDataSet("DS_O_COMMON");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_COMBO_01");
            dao = new CCom901DAO();
            list = dao.getDcardCode(form, mi); 
            if (list != null) {
                helper.setListToDataset(list, dSet[1]);
            }
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
     * 밴사카드 코드 조회
     * </p>
     */
    public ActionForward getVcardCode(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
        List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom901DAO   dao   = null;
        MultiInput   mi     = null;
        
        String strGoTo      = form.getParam("goTo"); // 분기할곳
        try {
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];

            dSet[0] = helper.getDataSet("DS_I_COMMON");
            dSet[1] = helper.getDataSet("DS_O_COMMON");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_COMBO_01");
            dao = new CCom901DAO();
            list = dao.getVcardCode(form, mi); 
            if (list != null) {
                helper.setListToDataset(list, dSet[1]);
            }
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
     * 청구 상태 코드 조회
     * </p>
     */
    public ActionForward getChrgCode(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
        List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom901DAO   dao   = null;
        MultiInput   mi     = null;
        
        String strGoTo      = form.getParam("goTo"); // 분기할곳
        try {
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];

            dSet[0] = helper.getDataSet("DS_I_COMMON");
            dSet[1] = helper.getDataSet("DS_O_COMMON");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_COMBO_01");
            dao = new CCom901DAO();
            list = dao.getChrgCode(form, mi);  
            if (list != null) {
                helper.setListToDataset(list, dSet[1]);
            }
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
     * 출입구정보조회
     * </p>
     */
    public ActionForward getGate(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
        List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom901DAO   dao   = null;
        MultiInput   mi     = null;
        
        String strGoTo      = form.getParam("goTo"); // 분기할곳
        try {
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];

            dSet[0] = helper.getDataSet("DS_I_CONDITION");
            dSet[1] = helper.getDataSet("DS_O_GATE");            

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_SEL_GATE");
            dao = new CCom901DAO();
            list = dao.getGate(form, mi);  
            if (list != null) {
                helper.setListToDataset(list, dSet[1]);
            }
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
     * 블럭정보조회
     * </p>
     */
    public ActionForward getBlock(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
        List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom901DAO   dao   = null;
        MultiInput   mi     = null;
        
        String strGoTo      = form.getParam("goTo"); // 분기할곳
        try {
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];

            dSet[0] = helper.getDataSet("DS_I_CONDITION");
            dSet[1] = helper.getDataSet("DS_O_BLOCK");            

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_SEL_BLOCK");
            dao = new CCom901DAO();
            list = dao.getBlock(form, mi);  
            if (list != null) {
                helper.setListToDataset(list, dSet[1]);
            }
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
     * 협력사코드 조회
     * </p>
     */
    public ActionForward getVen(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
    	List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom901DAO   dao   = null;
        MultiInput   mi     = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
		HttpSession session = request.getSession();
        String strOrgFlag = "";
        String strUserId = "";
        try {
            //session 정보
            SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
            strUserId = sessionInfo.getUSER_ID();
            strOrgFlag = sessionInfo.getORG_FLAG();
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];
            dSet[0] = helper.getDataSet("DS_I_CONDITION");
            dSet[1] = helper.getDataSet("DS_O_RESULT");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_COMBO_VEN");

            dao = new CCom901DAO();

            list = dao.getVen(form, mi, strUserId, strOrgFlag);
            
            if (list != null) {
                helper.setListToDataset(list, dSet[1]);
            }
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
        return mapping.findForward(strGoTo);
    }    
}
