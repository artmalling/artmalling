/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mgif.action;

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
import mgif.dao.MGif210DAO;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import common.vo.SessionInfo;

/**
 * <p></p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif210Action extends DispatchAction {
	/*   
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MGif101Action.class);

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
	 * <p>
	 * 점내 불출 마스터 조회
	 * </p>
	 * 
	 */                  
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		//System.out.println("1");
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MGif210DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳
    
		try {
			dao = new MGif210DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_MASTER");
			helper.setDataSetHeader(dSet, "H_MASTER");
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
	 * <p>점내 불출신청 상세-DETAIL</p>
	 * 
	 */
	public ActionForward getDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MGif210DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new MGif210DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_DETAIL");
			helper.setDataSetHeader(dSet, "H_DETAIL");
			list = dao.getDetail(form);
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
	 * <p>행사별 조직 조회</p>
	 * 
	 */
	public ActionForward getEvtOrg(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MGif210DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new MGif210DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_I_ORG_CD");
			helper.setDataSetHeader(dSet, "H_ORG_CD");
			list = dao.getEvtOrg(form);
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
	 * <p>상품권종류&금종 조회</p>
	 */
    @SuppressWarnings("rawtypes")
	public ActionForward getEtcCodeSub(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {
        List list			= null;
        GauceHelper2 helper	= null;
        GauceDataSet dSet	= null;
        MGif210DAO dao		= null;
        String strGoTo = form.getParam("goTo");
        try {
        	String strDSName	= String2.nvl(form.getParam("strDSName"));	// 데이터셋명
        	helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet();
            dSet = helper.getDataSet(strDSName);			
            helper.setDataSetHeader(dSet, "H_ETCCODE");

            dao = new MGif210DAO();
            list = dao.getEtcCodeSub(form);
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
	 * <p>Detail 상품권종류에 대한 금종 조회</p>
	 * 
	 */
	public ActionForward getGiftType(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MGif210DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new MGif210DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_GIFT_AMT_TYPE_2");
			helper.setDataSetHeader(dSet, "H_GIFT_AMT");
			list = dao.getGiftType(form);
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
	 * <p>반품등록전표 저장/수정 </p>	
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		MGif210DAO dao = null;
		int ret = 0;
		HttpSession session = request.getSession();
		String userId = null; 
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId = sessionInfo.getUSER_ID();
			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_O_DETAIL");
			helper.setDataSetHeader(dSet[0], "H_DETAIL");
			dSet[1] = helper.getDataSet("DS_O_MASTER");
			helper.setDataSetHeader(dSet[1], "H_MASTER");
			MultiInput mi[] = new MultiInput[2];
		    mi[0] = helper.getMutiInput(dSet[0]);
		    mi[1] = helper.getMutiInput(dSet[1]);
			dao = new MGif210DAO();	
			
			ret = dao.save(form, mi, userId);
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally { 
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet, "처리되었습니다");
		}		
		return mapping.findForward("save");
	}
	
	/**
	 * <p>반품등록전표 삭제</p>
	 * 
	 */
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MGif210DAO dao = null;
		int ret = 0;
		HttpSession session = request.getSession();
		String userId = null;
		
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");	
			userId = sessionInfo.getUSER_ID();
			helper = new GauceHelper2(request, response, form);					
			dSet = helper.getDataSet("DS_O_DETAIL");
			helper.setDataSetHeader(dSet, "H_DETAIL");
			
			MultiInput mi = helper.getMutiInput(dSet);	
			dao = new MGif210DAO();
			ret = dao.delete(form, mi, userId);		
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close("처리되었습니다");
		}
		return mapping.findForward("delete");
	}
	
	public ActionForward print(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String strGoTo = form.getParam("goTo"); // 분기할곳
		GauceHelper2.initialize(form, request, response);
		return mapping.findForward(strGoTo);
	}

}
