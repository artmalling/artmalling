/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pord.action;

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

import pord.dao.POrd118DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

/**
 * <p></p>
 *  
 * @created  on 1.0, 2010/01/25
 * @created  by 박래형(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class POrd118Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(POrd118Action.class);

	/**
	 * <p>품목 매입발주 매입/반품  마스터 내용 조회</p>
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
	 * <p> 전표별 발주현황 마스터 리스트 조회  </p>
	 * 
	 */
	public ActionForward getList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
                 
		HttpSession session = request.getSession();
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		List list 			= null;
		String userId 		= null;  
		String org_flag 	= null;				// 조직구분 (1:판매, 2:매입)
		POrd118DAO dao 		= null;

		String strGoTo = form.getParam("goTo"); // 분기할곳		
		
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
		userId   				= sessionInfo.getUSER_ID();
		org_flag 				= sessionInfo.getORG_FLAG();

		try {
			dao = new POrd118DAO(); 
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_MASTER");
			helper.setDataSetHeader(dSet, "H_LIST");
			list = dao.getList(form, userId, org_flag); 

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
	 * <p> 전표별 발주현황 디테일 리스트 조회 </p>
	 * 
	 */
	public ActionForward getDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
                 
		HttpSession session = request.getSession();
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		List list 			= null;
		String userId 		= null;  
		String org_flag 	= null;				// 조직구분 (1:판매, 2:매입)
		POrd118DAO dao 		= null;

		String strGoTo = form.getParam("goTo"); // 분기할곳		
		
		SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
		userId   				= sessionInfo.getUSER_ID();
		org_flag 				= sessionInfo.getORG_FLAG();

		try {
			dao = new POrd118DAO(); 
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_DETAIL");
			helper.setDataSetHeader(dSet, "H_DETAIL");
			list = dao.getDetail(form, userId, org_flag); 

			helper.setListToDataset(list, dSet);            

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}	
	

    public ActionForward getStore(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
    	List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        POrd118DAO   dao   = null;
        MultiInput   mi     = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
		HttpSession session = request.getSession();
//        String strOrgFlag = "";
        String strUserId = "";
        try {
            //session 정보
            SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
            strUserId = sessionInfo.getUSER_ID();
//            strOrgFlag = sessionInfo.getORG_FLAG();
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];
            dSet[0] = helper.getDataSet("DS_I_CONDITION");
            dSet[1] = helper.getDataSet("DS_O_STORE");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_COMBO");

            dao = new POrd118DAO();

            list = dao.getStore(form, mi, strUserId);
            
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
        POrd118DAO   dao   = null;
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
            helper.setDataSetHeader(dSet[1], "H_COMBO");

            dao = new POrd118DAO();

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
     * 팀 조회
     * </p>
     */
    public ActionForward getTeam(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        POrd118DAO   dao   = null;
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
            helper.setDataSetHeader(dSet[1], "H_COMBO");

            dao = new POrd118DAO();

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
     * PC 조회
     * </p>
     */
    public ActionForward getPc(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        POrd118DAO   dao   = null;
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
            helper.setDataSetHeader(dSet[1], "H_COMBO");

            dao = new POrd118DAO();

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
     * 전표별 발주현황 조회 팝업
     * </p>
     */
    public ActionForward selDetailPop(ActionMapping mapping, ActionForm form,
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
	 * <p> 규격단품 매입발주 리스트 조회 </p>
	 * 
	 */
	public ActionForward getDetail1(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
                 
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		List list 			= null;				// 조직구분 (1:판매, 2:매입)
		POrd118DAO dao 		= null;

		String strGoTo = form.getParam("goTo"); // 분기할곳		

		try {
			dao = new POrd118DAO(); 
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_DETAIL1");
			helper.setDataSetHeader(dSet, "H_DETAIL1");
			list = dao.getDetail1(form); 
//			System.out.println("118Action list.size() = " +  list.size());
			
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
	 * <p> 규격단품 대출입발주 상세 조회 </p> 
	 * 
	 */
	public ActionForward getDetail2(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list[] = null;

		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		POrd118DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new POrd118DAO();
			helper = new GauceHelper2(request, response, form);
			
			dSet = new GauceDataSet[2];
			             
			list = new  List[2];
			helper = new GauceHelper2(request, response, form);
			dSet[0] = helper.getDataSet("DS_DETAIL2");     
			helper.setDataSetHeader(dSet[0], "H_DETAIL2");         
			dSet[1] = helper.getDataSet("DS_DETAIL3");
			helper.setDataSetHeader(dSet[1], "H_DETAIL2");
			               
			list = dao.getDetail2(form);                

			for(int i=0;i<list.length;i++){
				helper.setListToDataset(list[i], dSet[i]);
//				System.out.println("list:::::"+list[i].size());
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
