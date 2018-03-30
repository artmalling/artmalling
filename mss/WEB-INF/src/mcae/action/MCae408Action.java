/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mcae.action;

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
import mcae.dao.MCae408DAO;

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

public class MCae408Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MCae408Action.class);

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
	 * <p>행사 마스터 정보 조회 </p>
	 * 
	 */
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MCae408DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new MCae408DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_MASTER");
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
	 * <p>행사 디테일 정보 조회 </p>
	 * 
	 */
	public ActionForward getDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MCae408DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new MCae408DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_DETAIL");
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
     * <p> 사은행사 유형 조회 </p>
     * 
     */
    @SuppressWarnings("rawtypes")
	public ActionForward getEventType(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {
        List list			= null;
        GauceHelper2 helper	= null;
        GauceDataSet dSet	= null;
        MCae408DAO dao		= null;

        try {

            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet();
            dSet = helper.getDataSet("DS_O_RESULT");			
            helper.setDataSetHeader(dSet, "H_EVENT");

            dao = new MCae408DAO();
            list = dao.getEventType(form);
            helper.setListToDataset(list, dSet); 

        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        return mapping.findForward("getEventType");
    }
    

    /**
     * <p> 상품권 번호 정합성 체크 </p>
     * 
     */
	public ActionForward chkGiftCardNo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MCae408DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new MCae408DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_CHECK");
			helper.setDataSetHeader(dSet, "H_GIFTCARD_NO_CHK");
			list = dao.chkGiftCardNo(form);
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
     * <p> 사은행사 마감 체크 </p>
     * 
     */
    @SuppressWarnings("rawtypes")
	public ActionForward getEventMagam(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {
        List list			= null;
        GauceHelper2 helper	= null;
        GauceDataSet dSet	= null;
        MCae408DAO dao		= null;

        try {

            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet();
            dSet = helper.getDataSet("DS_O_RETURN");			
            helper.setDataSetHeader(dSet, "H_RETURN");

            dao = new MCae408DAO();
            list = dao.getEventMagam(form);
            helper.setListToDataset(list, dSet); 

        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        return mapping.findForward("getEventMagam");
    }
    
    /**
     * <p> 사은품 코드/명 조회</p>
     * 
     */
    @SuppressWarnings("rawtypes")
	public ActionForward getSkuCd(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {
        List list			= null;
        GauceHelper2 helper	= null;
        GauceDataSet dSet	= null;
        MCae408DAO dao		= null;

        try {

            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet();
            dSet = helper.getDataSet("DS_SKU_CD");			
            helper.setDataSetHeader(dSet, "H_SKU_CD");

            dao = new MCae408DAO();
            list = dao.getSkuCd(form);
            helper.setListToDataset(list, dSet); 

        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        return mapping.findForward("getSkuCd");
    }
    
    /**
     * <p> 사은품 코드에 대한 단가 조회</p>
     * 
     */
    @SuppressWarnings("rawtypes")
	public ActionForward getSkuAmt(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {
        List list			= null;
        GauceHelper2 helper	= null;
        GauceDataSet dSet	= null;
        MCae408DAO dao		= null;

        try {

            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet();
            dSet = helper.getDataSet("DS_SKU_GB");			
            helper.setDataSetHeader(dSet, "H_SKU_GB");

            dao = new MCae408DAO();
            list = dao.getSkuAmt(form);
            helper.setListToDataset(list, dSet); 

        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        return mapping.findForward("getSkuAmt");
    }
    
    /**
	 * <p>기타지급관리 저장/수정 </p>	
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		MCae408DAO dao      = null;
		
		HttpSession session = request.getSession();
		String userId       = null;
		int ret             = 0;
		String strGoTo = form.getParam("goTo");
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
			helper = new GauceHelper2(request, response, form); 
			
			dSet = new GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_DETAIL");
            dSet[1] = helper.getDataSet("DS_MASTER"); 
			  
            helper.setDataSetHeader(dSet[0], "H_DETAIL");
			helper.setDataSetHeader(dSet[1], "H_MASTER");
			  
			MultiInput miD = helper.getMutiInput(dSet[0]);
			MultiInput mi = helper.getMutiInput(dSet[1]); 

			dao = new MCae408DAO();    
			ret = dao.save(form,miD,mi,userId);
			
		} catch (Exception e) { 
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet, "처리되었습니다"); 
		}
		return mapping.findForward(strGoTo);
	} 
	 
}
