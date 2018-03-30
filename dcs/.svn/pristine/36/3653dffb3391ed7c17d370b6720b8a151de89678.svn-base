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
import kr.fujitsu.ffw.util.String2;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import dctm.dao.DCtm113DAO;

import common.vo.SessionInfo;
/**
 * <p>제휴카드사 회원탈퇴 현황</p>
 * 
 * @created  on 1.0, 2010/02/24
 * @created  by 김영진(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DCtm113Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DCtm113Action.class);

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
     * <p>제휴카드사 회원탈퇴 현황을 조회한다.</p>
     * 
     */
	public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DCtm113DAO   dao    = null; 
        String strBrchId    = null;
        HttpSession session = request.getSession();
        String strGoTo = form.getParam("goTo"); // 분기할곳

        try {
 
            dao    = new DCtm113DAO();
            helper = new GauceHelper2(request, response, form);
            dSet   = helper.getDataSet("DS_O_MASTER");
            helper.setDataSetHeader(dSet, "H_MASTER");
            
            SessionInfo sessionInfo = (SessionInfo) session
            .getAttribute("sessionInfo");
            strBrchId = sessionInfo.getBRCH_ID();
    System.out.println("1111111111111");
            list   = dao.searchMaster(form, strBrchId);
            System.out.println("2222222222");
            ArrayList arrList = new ArrayList();
			
			for ( int i = 0; i < list.size(); i++ )
			{System.out.println("3333333333333");
				arrList = (ArrayList)list.get(i);
				HashMap map = new HashMap();
				map.put("HOME_PH1", arrList.get(5));
				map.put("HOME_PH2", arrList.get(6));
				map.put("HOME_PH3", arrList.get(7));
				map.put("MOBILE_PH1", arrList.get(8));
				map.put("MOBILE_PH2", arrList.get(9));
				map.put("MOBILE_PH3", arrList.get(10));
     
				if(!String2.isEmpty(map.get("HOME_PH1").toString()) 
						&& !String2.isEmpty(map.get("HOME_PH2").toString())
						&& !String2.isEmpty(map.get("HOME_PH3").toString())){
		            String strHphone = map.get("HOME_PH1").toString()
                                     + "-" + map.get("HOME_PH2").toString()
		                             + "-" + map.get("HOME_PH3").toString();
		            arrList.set(5, strHphone);
				} 
				
				if(!String2.isEmpty(map.get("MOBILE_PH1").toString()) 
						&& !String2.isEmpty(map.get("MOBILE_PH2").toString())
						&& !String2.isEmpty(map.get("MOBILE_PH3").toString())){
		            String strMphone = map.get("MOBILE_PH1").toString()
		                             + "-" + map.get("MOBILE_PH2").toString()
		                             + "-" + map.get("MOBILE_PH3").toString();
			        arrList.set(8, strMphone);
				}
			}System.out.println("4444444444444");
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
     * <p>제휴카드사 회원탈퇴 정보를 상세 조회한다.</p>
     * 
     */
    public ActionForward searchDetail(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DCtm113DAO   dao    = null; 
        String strBrchId    = null;
        String strUserId    = null;
        HttpSession session = request.getSession();

        String strGoTo = form.getParam("goTo"); // 분기할곳

        try {
 
        	 SessionInfo sessionInfo = (SessionInfo) session
             .getAttribute("sessionInfo");
             strBrchId = sessionInfo.getBRCH_ID();
             strUserId = sessionInfo.getUSER_ID();
             
            dao    = new DCtm113DAO();
            helper = new GauceHelper2(request, response, form);
            dSet   = helper.getDataSet("DS_IO_DETAIL");
            helper.setDataSetHeader(dSet, "H_MASTER");
            list   = dao.searchDetail(form, strBrchId, strUserId);
            
            ArrayList arrList = new ArrayList();
			arrList = (ArrayList)list.get(0);
			HashMap map = new HashMap();
			map.put("HOME_PH1", arrList.get(5));
			map.put("HOME_PH2", arrList.get(6));
			map.put("HOME_PH3", arrList.get(7));
			map.put("MOBILE_PH1", arrList.get(8));
			map.put("MOBILE_PH2", arrList.get(9));
			map.put("MOBILE_PH3", arrList.get(10));
 
			
			if(!String2.isEmpty(map.get("HOME_PH1").toString()) 
					&& !String2.isEmpty(map.get("HOME_PH2").toString())
					&& !String2.isEmpty(map.get("HOME_PH3").toString())){
	            String strHphone = map.get("HOME_PH1").toString()
                                 + "-" + map.get("HOME_PH2").toString()
	                             + "-" + map.get("HOME_PH3").toString();
	            arrList.set(5, strHphone);
			} 
			
			if(!String2.isEmpty(map.get("MOBILE_PH1").toString()) 
					&& !String2.isEmpty(map.get("MOBILE_PH2").toString())
					&& !String2.isEmpty(map.get("MOBILE_PH3").toString())){
	            String strMphone = map.get("MOBILE_PH1").toString()
	                             + "-" + map.get("MOBILE_PH2").toString()
	                             + "-" + map.get("MOBILE_PH3").toString();
		        arrList.set(8, strMphone);
			}
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
     * <p>제휴카드사 회원탈퇴 정보를  등록/수정</p>
     * 
     */
    public ActionForward save(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DCtm113DAO dao      = null;
        String ret          = "";
        String strUserId    = null;
        HttpSession session = request.getSession();
        String strGoTo = form.getParam("goTo"); // 분기할곳
        
        try {

            SessionInfo sessionInfo = (SessionInfo) session
                    .getAttribute("sessionInfo");
            strUserId = sessionInfo.getUSER_ID();
            dao    = new DCtm113DAO();
            helper = new GauceHelper2(request, response, form);
            dSet = helper.getDataSet("DS_IO_DETAIL");
            helper.setDataSetHeader(dSet, "H_MASTER");
            MultiInput mi = helper.getMutiInput(dSet);
            
            ret = dao.save(form, mi, strUserId);
        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            // 등록, 수정의 경우 아래의 메시지를 사용
            helper.close("정상적으로 처리되었습니다");
        }
        return mapping.findForward(strGoTo);
    }
}

