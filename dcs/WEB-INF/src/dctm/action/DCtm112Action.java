/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dctm.action;

import java.util.ArrayList;
import java.util.HashMap;
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

import dctm.dao.DCtm112DAO;

/**
 * <p>회원메모관리</p>
 * 
 * @created  on 1.0, 2010/02/21
 * @created  by 김영진(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class DCtm112Action extends DispatchAction {
	/**
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DCtm112Action.class);

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
     * <p>회원메모 리스트를 조회한다.</p>
     * 
     */
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

    	List list           = null;
		List list2          = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
        DCtm112DAO   dao    = null; 
        ArrayList arrList= new ArrayList();
        String strGoTo = form.getParam("goTo"); // 분기할곳

        try {
        	
            dao     = new DCtm112DAO();
			helper  = new GauceHelper2(request, response, form);
			dSet    = new GauceDataSet[1];
			dSet[0] = helper.getDataSet("DS_O_MASTER");
            
            helper.setDataSetHeader(dSet[0], "H_MASTER");
             
			list  = dao.searchMaster(form);
			
			//주민등록번호 복호화
			for ( int i = 0; i < list.size(); i++ )
			{
				arrList = (ArrayList)list.get(i);
				HashMap map = new HashMap();
				map.put("SS_NO", arrList.get(5));
				String strSsNo  = map.get("SS_NO").toString();
				arrList.set(5, strSsNo);
			}
			
			helper.setListToDataset(list,  dSet[0]);

        } catch (Exception e) {
            logger.error("", e); 
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        return mapping.findForward(strGoTo);
    }
    
    /**
     * <p>회원메모  정보를 상세 조회한다.</p>
     * 
     */
    public ActionForward searchDetail(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DCtm112DAO   dao    = null; 

        String strGoTo = form.getParam("goTo"); // 분기할곳

        try {
 
            dao    = new DCtm112DAO();
            helper = new GauceHelper2(request, response, form);
            dSet   = helper.getDataSet("DS_IO_DETAIL");
            helper.setDataSetHeader(dSet, "H_DETAIL");
            list   = dao.searchDetail(form);
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
     * <p>회원메모를  등록/수정</p>
     * 
     */
    public ActionForward save(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DCtm112DAO dao      = null;
        String ret          = "";
        HttpSession session = request.getSession();
        String userId = null;
        String strGoTo = form.getParam("goTo"); // 분기할곳
        
        try {

            SessionInfo sessionInfo = (SessionInfo) session
                    .getAttribute("sessionInfo");
            userId = sessionInfo.getUSER_ID();
            helper = new GauceHelper2(request, response, form);
            dSet = helper.getDataSet("DS_IO_DETAIL");
            helper.setDataSetHeader(dSet, "H_DETAIL");
            MultiInput mi = helper.getMutiInput(dSet);
            dao = new DCtm112DAO();
            ret = dao.save(form, mi, userId);
        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            // 등록, 수정의 경우 아래의 메시지를 사용
            helper.close(dSet, "정상적으로 처리되었습니다");
        }
        return mapping.findForward(strGoTo);
    }
}
