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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;
import common.dao.CCom000DAO;
import common.vo.SessionInfo;

/**
 * <p>점별협력사마스터</p>
 * 
 * @created  on 1.0, 2010/01/24	
 * @created  by 정진영(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class CCom000Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(CCom000Action.class);

    /**
     * <p>
     * 점코드를 조회한다.
     * </p>
     */
    public ActionForward getStrVenCode(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom000DAO   dao   = null;
        MultiInput   mi     = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳

		HttpSession session = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");	
		String userId = sessionInfo.getUSER_ID();
		String orgFlag = sessionInfo.getORG_FLAG();

        try {
			
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];
            dSet[0] = helper.getDataSet("DS_I_COMMON");
            dSet[1] = helper.getDataSet("DS_O_COMMON");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_COMBO_VENSTR");

            dao = new CCom000DAO();

            list = dao.getStrVenCode(form, mi, userId, orgFlag);
            
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
     * 점코드를 조회한다.
     * </p>
     */
    public ActionForward getStrPbnCode(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom000DAO   dao   = null;
        MultiInput   mi     = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳

		HttpSession session = request.getSession();
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");	
		String userId = sessionInfo.getUSER_ID();
		String orgFlag = sessionInfo.getORG_FLAG();

        try {
			
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];
            dSet[0] = helper.getDataSet("DS_I_COMMON");
            dSet[1] = helper.getDataSet("DS_O_COMMON");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_COMBO");

            dao = new CCom000DAO();

            list = dao.getStrPbnCode(form, mi, userId, orgFlag);
            
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
     * 마감체크를 한다.
     * </p>
     */
    public ActionForward getCloseCheck(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
    	List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		CCom000DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new CCom000DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_RESULT");
			helper.setDataSetHeader(dSet, "H_CLOSE_CHECK");
			list = dao.getCloseCheck(form);
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
     * 정산/입금 체크를 한다.
     * </p>
     */
    public ActionForward getCalCheck(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
    	List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		CCom000DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new CCom000DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_CALCHECK");
			helper.setDataSetHeader(dSet, "H_CAL_CHECK");
			list = dao.getCalCheck(form);
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
     * 품목 대분류를 조회한다.
     * </p>
     */
    public ActionForward getPmkLCode(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List list = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet = null;
        CCom000DAO   dao   = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
        try {
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet();
            dSet = helper.getDataSet("DS_O_COMMON");
            helper.setDataSetHeader(dSet, "H_COMBO");
            dao = new CCom000DAO();
            list = dao.getPmkLCode(form);
            if (list != null) {
                helper.setListToDataset(list, dSet);
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
     * 품목 중분류를 조회한다.
     * </p>
     */
    public ActionForward getPmkMCode(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List list = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom000DAO   dao   = null;
        MultiInput   mi     = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
        try {
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];
            dSet[0] = helper.getDataSet("DS_I_COMMON");
            dSet[1] = helper.getDataSet("DS_O_COMMON");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_COMBO");

            dao = new CCom000DAO();
            list = dao.getPmkMCode(form, mi);
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
     * 품목 소분류를 조회한다.
     * </p>
     */
    public ActionForward getPmkSCode(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List list = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom000DAO   dao   = null;
        MultiInput   mi     = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
        try {
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];
            dSet[0] = helper.getDataSet("DS_I_COMMON");
            dSet[1] = helper.getDataSet("DS_O_COMMON");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_COMBO");

            dao = new CCom000DAO();
            list = dao.getPmkSCode(form, mi);
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
     * 품목 세분류를 조회한다.
     * </p>
     */
    public ActionForward getPmkDCode(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List list = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom000DAO   dao   = null;
        MultiInput   mi     = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
        try {
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];
            dSet[0] = helper.getDataSet("DS_I_COMMON");
            dSet[1] = helper.getDataSet("DS_O_COMMON");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_COMBO");

            dao = new CCom000DAO();
            list = dao.getPmkDCode(form, mi);
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
     * 행사테마 대분류를 조회한다.
     * </p>
     */
    public ActionForward getEvtThmeLCode(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List list = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet = null;
        CCom000DAO   dao   = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
        try {
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet();
            dSet = helper.getDataSet("DS_O_COMMON");
            helper.setDataSetHeader(dSet, "H_COMBO");
            dao = new CCom000DAO();
            list = dao.getEvtThmeLCode(form);
            if (list != null) {
                helper.setListToDataset(list, dSet);
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
     * 행사테마 중분류를 조회한다.
     * </p>
     */
    public ActionForward getEvtThmeMCode(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List list = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom000DAO   dao   = null;
        MultiInput   mi     = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
        try {
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];
            dSet[0] = helper.getDataSet("DS_I_COMMON");
            dSet[1] = helper.getDataSet("DS_O_COMMON");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_COMBO");

            dao = new CCom000DAO();
            list = dao.getEvtThmeMCode(form, mi);
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
     * 행사테마 소분류를 조회한다.
     * </p>
     */
    public ActionForward getEvtThmeSCode(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List list = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom000DAO   dao   = null;
        MultiInput   mi     = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
        try {
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];
            dSet[0] = helper.getDataSet("DS_I_COMMON");
            dSet[1] = helper.getDataSet("DS_O_COMMON");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_COMBO");

            dao = new CCom000DAO();
            list = dao.getEvtThmeSCode(form, mi);
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
	 * <p> 로그인사번이 바이어/SM인지를 조회('Y') </p>
	 * 
	 */
	public ActionForward getBuyerYN(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null; 
		CCom000DAO dao = null;
		GauceDataSet dSet = null; 
		List list = null;
		
		HttpSession session = request.getSession();
		String userId = null;
		
		String org_flag = "";  // 조직구분 (1:판매, 2:매입)

		String strGoTo 		= form.getParam("goTo"); // 분기할곳
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
			org_flag = sessionInfo.getORG_FLAG();
			
			dao = new CCom000DAO();    
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_RESULT");
			helper.setDataSetHeader(dSet, "H_CLOSE_CHECK");
			list = dao.getBuyerYN(form, org_flag, userId);
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
	 * <p> 점출입이 가능한 점인지  조회('Y') </p>
	 * 
	 */
	public ActionForward getStrInOutYN(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null; 
		CCom000DAO dao = null;
		GauceDataSet dSet = null; 
		List list = null;
		
		HttpSession session = request.getSession();
		String userId = null;
		
		String org_flag = "";  // 조직구분 (1:판매, 2:매입)

		String strGoTo 		= form.getParam("goTo"); // 분기할곳
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
			org_flag = sessionInfo.getORG_FLAG();
			          
			dao = new CCom000DAO();    
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_RESULT");
			helper.setDataSetHeader(dSet, "H_CLOSE_CHECK");
			list = dao.getStrInOutYN(form);
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
	 * <p> 협력사의 반올림구분  </p>
	 * 
	 */
	public ActionForward getVenRoundFlag(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null; 
		CCom000DAO dao = null;
		GauceDataSet dSet = null; 
		List list = null; 
		
		HttpSession session = request.getSession();
		String userId = null;

		String strRoundFlag 	= "";               

		String strGoTo 		= form.getParam("goTo"); // 분기할곳
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
						
			dao = new CCom000DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_RESULT");
			helper.setDataSetHeader(dSet, "H_CLOSE_CHECK");
			list = dao.getVenRoundFlag(form);
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
	 * <p> 스타일 마스터의 품번별 브랜드  </p>
	 * 
	 */
	public ActionForward getStyleBrand(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
        List list = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom000DAO   dao   = null;
        MultiInput   mi     = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
        try {
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];
            dSet[0] = helper.getDataSet("DS_I_COMMON");
            dSet[1] = helper.getDataSet("DS_O_COMMON");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_COMBO");

            dao = new CCom000DAO();
            list = dao.getStyleBrand(form, mi);
            helper.setListToDataset(list, dSet[1]);
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
	/**
	 * <p> 스타일 마스터의 품번별 서브브랜드  </p>
	 * 
	 */
	public ActionForward getStyleSubBrand(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
        List list = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom000DAO   dao   = null;
        MultiInput   mi     = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
        try {
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];
            dSet[0] = helper.getDataSet("DS_I_COMMON");
            dSet[1] = helper.getDataSet("DS_O_COMMON");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_COMBO");

            dao = new CCom000DAO();
            list = dao.getStyleSubBrand(form, mi);
            helper.setListToDataset(list, dSet[1]);
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
     * 점별 품목별 행사코드
     * </p>
     */
    public ActionForward getEventCode(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom000DAO   dao   = null;
        MultiInput   mi     = null;
        String strGoTo = form.getParam("goTo"); // 분기할곳
        try {
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];

            dSet[0] = helper.getDataSet("DS_I_COMMON");
            dSet[1] = helper.getDataSet("DS_O_COMMON");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_COMBO_EVENT");

            dao = new CCom000DAO();

            list = dao.getEventCode(form, mi);
            
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
     * 점별 품목별 행사코드
     * </p>
     */
    public ActionForward getEventPlaceCode(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom000DAO   dao   = null;
        MultiInput   mi     = null;
        String strGoTo = form.getParam("goTo"); // 분기할곳
        try {
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];

            dSet[0] = helper.getDataSet("DS_I_COMMON");
            dSet[1] = helper.getDataSet("DS_O_COMMON");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_COMBO_EVTPLACE");

            dao = new CCom000DAO();

            list = dao.getEventPlaceCode(form, mi);
            
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
     * F&B매장중 코너매장코드
     * </p>
     */
    public ActionForward getFnBShopCornerCode(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        CCom000DAO   dao   = null;
        MultiInput   mi     = null;
        String strGoTo = form.getParam("goTo"); // 분기할곳
        try {
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];

            dSet[0] = helper.getDataSet("DS_I_COMMON");
            dSet[1] = helper.getDataSet("DS_O_COMMON");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_COMBO_FNBSHOP");

            dao = new CCom000DAO();

            list = dao.getFnBShopCornerCode(form, mi);
            
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
	 * <p> 회차별 매입매출일 조회  </p>
	 * 
	 */
	public ActionForward getSaleDate(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
	        
		HttpSession session = request.getSession();
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		String userId 		= null;  
		String org_flag 	= null;				// 조직구분 (1:판매, 2:매입)
		List list			= null;
		CCom000DAO dao 		= null;     
		
		String strGoTo      = form.getParam("goTo"); // 분기할곳
	
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   				= sessionInfo.getUSER_ID();
			org_flag 				= sessionInfo.getORG_FLAG();
	
			dao    = new CCom000DAO(); 
			helper = new GauceHelper2(request, response, form);
			dSet   = helper.getDataSet("DS_O_SALE_DATE");   
			helper.setDataSetHeader(dSet, "H_SALE_DATE");  
			list   = dao.getSaleDate(form); 
			
			if(list != null)
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
	 * <p> 회차별 지불일조회  </p>
	 * 
	 */
	public ActionForward getPayDate(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
	        
		HttpSession session = request.getSession();
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		String userId 		= null;  
		String org_flag 	= null;				// 조직구분 (1:판매, 2:매입)
		List list			= null;
		CCom000DAO dao 		= null;
		
		String strGoTo      = form.getParam("goTo"); // 분기할곳
	
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   				= sessionInfo.getUSER_ID();
			org_flag 				= sessionInfo.getORG_FLAG();
	
			dao    = new CCom000DAO(); 
			helper = new GauceHelper2(request, response, form);                     
			dSet   = helper.getDataSet("DS_O_PAY_DATE");
			helper.setDataSetHeader(dSet, "H_PAY_DATE");
			list   = dao.getPayDate(form); 
			
			if(list != null)
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
	 * <p> 회차별세금계산서 발행기간 조회  </p>
	 * 
	 */
	public ActionForward getIssueDate(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
	        
		HttpSession session = request.getSession();
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		String userId 		= null;  
		String org_flag 	= null;				// 조직구분 (1:판매, 2:매입)
		List list			= null;                         
		CCom000DAO dao 		= null;
		
		String strGoTo      = form.getParam("goTo"); // 분기할곳
	
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   				= sessionInfo.getUSER_ID();
			org_flag 				= sessionInfo.getORG_FLAG();
	
			dao    = new CCom000DAO(); 
			helper = new GauceHelper2(request, response, form);
			dSet   = helper.getDataSet("DS_O_ISSUE_DATE");
			helper.setDataSetHeader(dSet, "H_ISSUE_DATE");
			list   = dao.getIssueDate(form); 
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
	 * <p> 현재날짜 가져오기(DB)  </p>
	 * 
	 */
	public ActionForward getToday(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null; 
		CCom000DAO dao = null;
		GauceDataSet dSet = null; 
		List list = null; 
		
		HttpSession session = request.getSession();
		String userId = null;

		String strRoundFlag 	= "";               

		String strGoTo 		= form.getParam("goTo"); // 분기할곳
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
						
			dao = new CCom000DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_RESULT");
			helper.setDataSetHeader(dSet, "H_TODAY");
			list = dao.getToday(form);
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
     * 브랜드코드 팝업
     * </p>
     */
    public ActionForward brandPop(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
		GauceHelper2 helper = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			GauceHelper2.initialize(form, request, response);
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		}
		return mapping.findForward(strGoTo);
    }
    

	/**
	 * <p>
	 * 팝업에서 조회
	 * </p>
	 * 
	 */
	public ActionForward searchBrandMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
        List			list	= null;
        GauceHelper2	helper	= null;
        GauceDataSet	dSet[]	= null;
        CCom000DAO		dao     = null;
        MultiInput		mi		= null;
        
        String strGoTo = form.getParam("goTo"); // 분기할곳

        try { 
        	helper = new GauceHelper2(request, response, form);
        	dSet = new GauceDataSet[2];
        	dSet[0] = helper.getDataSet("DS_I_COND");
			dSet[1] = helper.getDataSet("DS_O_RESULT");
			
			mi = helper.getMutiInput(dSet[0]);
			helper.setDataSetHeader(dSet[1], "H_MASTER");

			dao = new CCom000DAO();
			
			list = dao.searchMaster(form, mi);

			helper.setListToDataset(list, dSet[1]);

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
	 * Popup.js 에서 조회
	 * </p>
	 * 
	 */
	public ActionForward searchOnBrandWithoutPop(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		CCom000DAO dao = null;
		MultiInput mi = null;



		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {

			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_I_COND");
			dSet[1] = helper.getDataSet("DS_O_RESULT");

			mi = helper.getMutiInput(dSet[0]);
			helper.setDataSetHeader(dSet[1], "H_MASTER");

			dao = new CCom000DAO();
			list = dao.searchMaster(form, mi);

			helper.setListToDataset(list, dSet[1]);
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
     * 전표상태를 조회 한다.
     * </p>
     */
    public ActionForward getSlipProcStat(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
    	List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		CCom000DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new CCom000DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_RESULT");
			helper.setDataSetHeader(dSet, "H_SLIP_PROC_STATE");
			list = dao.getSlipProcStat(form);
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
	 * <p> 현재날짜 가져오기(DB) AJax  </p>
	 * 
	 */
/*	public ActionForward getTodayAjax(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		CCom000DAO dao = null;
        StringBuffer ret = null;   

		String strGoTo 		= form.getParam("goTo"); // 분기할곳
		try {
			
			dao = new CCom000DAO();
			ret = dao.getTodayAjax(form);   

	        
		} catch (Exception e) {
			logger.error("", e);
		} 
        ActionUtil.sendAjaxResponse(response, ret);
		return mapping.findForward(strGoTo);
	}
*/
}
