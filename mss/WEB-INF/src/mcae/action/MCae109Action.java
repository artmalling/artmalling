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

import org.apache.log4j.Logger;

import mcae.dao.MCae109DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

/**
 * <p>리콜행사 대상회원 등록</p>
 * 
 * @created  on 1.0, 2011/01/24
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MCae109Action extends DispatchAction {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
    private Logger logger = Logger.getLogger(MCae109Action.class);

    /**
     * <p>화면 LODA</p>
     * 
     */
    public ActionForward list(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {
        try {
            GauceHelper2.initialize(form, request, response);
        } catch (Exception e) {
            logger.error("", e);
        }
        return mapping.findForward("list");
    }
    
    /**
     * <p> 마스터 조회 </p>
     * 
     */
    public ActionForward getMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {
        List list			= null;
        GauceHelper2 helper	= null;
        GauceDataSet dSet	= null;
        MCae109DAO dao		= null;
        
        String strGoTo = form.getParam("goTo");
        try {

            helper = new GauceHelper2(request, response, form);
            dSet = helper.getDataSet("DS_O_MASTER");			//조회된 내역을 담을 DateSet(JSP:TR_MAIN.KeyValue시 정의 한 DateSet명) (1)
            helper.setDataSetHeader(dSet, "H_SEL_PRMMENTY_MST");//조회된 내역을 담을 DateSet의 Header(xxx000_service.xml에 정의된 가우스헤더) (2)

            dao = new MCae109DAO();
            list = dao.getMaster(form); //DAO에서 처리된 내역을 List타입으로 받음
            helper.setListToDataset(list, dSet); //앞서 정의된 DataSet(1)에 List를 앞서정의된 Header정보(2)를 기준으로 매핑

        } catch (Exception e) {//오류처리
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {//모든행위가 끝난뒤 처리해야할 내역
            helper.close(dSet);
        }
        return mapping.findForward(strGoTo); //(xxxx_config.xml)에 정의된 매핑 Forward명 입력
    }

    /**
     * <p> 디테일(상세) 조회 </p>
     * 
     */
    public ActionForward getDetail(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {
        List list			= null;
        GauceHelper2 helper	= null;
        GauceDataSet dSet	= null;
        MCae109DAO dao		= null;
        
        String strGoTo = form.getParam("goTo");
        try {

            helper = new GauceHelper2(request, response, form);
            dSet = helper.getDataSet("DS_IO_DETAIL");			
            helper.setDataSetHeader(dSet, "H_SEL_PRMMENTY_DTL"); 


            dao = new MCae109DAO();
            list = dao.getDetail(form); //DAO에서 처리된 내역을 List타입으로 받음
            helper.setListToDataset(list, dSet); 

        } catch (Exception e) {//오류처리
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
            
        } finally {//모든행위가 끝난뒤 처리해야할 내역
            helper.close(dSet);
        }
        return mapping.findForward(strGoTo); //(xxxx_config.xml)에 정의된 매핑 Forward명 입력
    }

    /**
     * <p> 회원ID 정합성 체크 </p>
     * 
     */
	public ActionForward chkCardNo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MCae109DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new MCae109DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_CHECK");
			helper.setDataSetHeader(dSet, "H_SEL_CARD_NO");
			list = dao.chkCardNo(form);
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
     * <p>응모자 내역을 저장한다. </p>
     * 
     */
    public ActionForward save(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {

        GauceHelper2 helper	= null;
        GauceDataSet dSet	= null;
        MCae109DAO dao		= null;
        int ret = 0;
        HttpSession session = request.getSession();
        String userId = null;

        try {
            //session 정보
            SessionInfo sessionInfo = (SessionInfo) session
            .getAttribute("sessionInfo");
            userId = sessionInfo.getUSER_ID();

            helper = new GauceHelper2(request, response, form);
            dSet = helper.getDataSet("DS_IO_DETAIL");
            helper.setDataSetHeader(dSet, "H_SEL_PRMMENTY_DTL");
            MultiInput mi = helper.getMutiInput(dSet);
            dao = new MCae109DAO();
            ret = dao.save(form, mi, userId);
        } catch (Exception e) {
            //logger.error("", e);
            //helper.writeException("GAUCE", "002", e.getMessage());
        	e.printStackTrace();
        } finally {
            // 저장, 삭제, 수정의 경우 아래의 메시지를 사용
            helper.close(dSet, ret + "건 처리되었습니다");
        }
        return mapping.findForward("save");
    }

}
