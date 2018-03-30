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
import mcae.dao.MCae108DAO;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import common.vo.SessionInfo;

/**
 * <p></p>
 * 
 * @created  on 1.0, 2012/05/17
 * @created  by 홍종영(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MCae108Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MCae108Action.class);

	/**
	 * <p>사은행사 마스터 초기 화면</p>
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
			logger.error("", e);
		}

		return mapping.findForward("list");
	}
	
	/**
	 * <p>행사 마스터 정보 조회 </p>
	 * 
	 */
	public ActionForward getEvtMst(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MCae108DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new MCae108DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_EVTMST");
			helper.setDataSetHeader(dSet, "H_EVTMST");
			list = dao.getEvtMst(form);
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
	 * <p>사은 행사 마스터 정보 조회 </p>
	 * 
	 */
	public ActionForward getStrEvt(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MCae108DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new MCae108DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_STREVT");
			helper.setDataSetHeader(dSet, "H_STREVT");
			list = dao.getStrEvt(form);
			
			//System.out.println("AC list : " + list);
			
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
	 * <p>참여 브랜드, 사은품, 제휴카드 정보 조회 </p>
	 * 
	 */
	public ActionForward getStrEvtInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list[] = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		MCae108DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new MCae108DAO();
			dSet = new  GauceDataSet[2];
			list = new  List[2];
			helper = new GauceHelper2(request, response, form);
			dSet[0] = helper.getDataSet("DS_IO_EVTSTRPBN");
			helper.setDataSetHeader(dSet[0], "H_EVTSTRPBN");
			dSet[1] = helper.getDataSet("DS_IO_EVTSTRSKU");
			helper.setDataSetHeader(dSet[1], "H_EVTSTRSKU");
			list = dao.getStrEvtInfo(form);
			
			for(int i=0;i<list.length;i++){
				helper.setListToDataset(list[i], dSet[i]);
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
	 * <p>브랜드 마스터 </p>
	 * 
	 */
	public ActionForward getEvtPbn(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MCae108DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new MCae108DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_EVTPBN");
			helper.setDataSetHeader(dSet, "H_EVTPBN");
			list = dao.getEvtPbn(form);
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
	 * <p>대상코드 </p>
	 * 
	 */
	public ActionForward getTrg(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MCae108DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new MCae108DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_TRG");
			helper.setDataSetHeader(dSet, "H_TRG");
			list = dao.getTrg(form);
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
	 * <p>사은행사 마스터 등록 </p>
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		MCae108DAO dao = null;
		int ret = 0;
		HttpSession session = request.getSession();
		String userId = null;
		MultiInput mi[] = null;
		try {
			SessionInfo sessionInfo = (SessionInfo) session
					.getAttribute("sessionInfo");
			userId = sessionInfo.getUSER_ID();
			helper = new GauceHelper2(request, response, form);
			dSet = new  GauceDataSet[4];
			mi = new MultiInput[4];
			dSet[0] = helper.getDataSet("DS_IO_STREVT");
			helper.setDataSetHeader(dSet[0], "H_STREVT");
			dSet[1] = helper.getDataSet("DS_IO_EVTSTRPBN");
			helper.setDataSetHeader(dSet[1], "H_EVTSTRPBN");
			dSet[2] = helper.getDataSet("DS_IO_EVTSTRSKU");
			helper.setDataSetHeader(dSet[2], "H_EVTSTRSKU");
			dSet[3] = helper.getDataSet("DS_IO_STREVT_COPY");
			helper.setDataSetHeader(dSet[3], "H_STREVT");
			
			for(int i=0;i<mi.length;i++){
				mi[i] = helper.getMutiInput(dSet[i]);
			}
			dao = new MCae108DAO();
			ret = dao.save(form, mi, userId);
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet, "저장 되었습니다");
		}
		return mapping.findForward("save");
	}
	
}
