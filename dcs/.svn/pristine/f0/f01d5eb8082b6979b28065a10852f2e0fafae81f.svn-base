/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dctm.action;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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

import dctm.dao.DCtm435DAO;

/**
 * <p></p>
 * 
 * @created  on 1.0, 2010/03/30
 * @created  by 장형욱(FUJITSU KOREA LTD.)
 * @caused   by 데이터변경이력조회
 * 
 * @modified on 
 * @modified by 
 */

public class DCtm435Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DCtm431Action.class);

	/**
	 * <p>메뉴를 보여준다.</p>
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 

		try { 
			GauceHelper2.initialize(form, request, response);
			
			      
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("[list]", e);
		}

		return mapping.findForward("list");
	}
	
    /**
     * <p> 데이터조회이력조회한다.</p>
     * 
     */
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DCtm435DAO      dao     = null;

        String strGoTo = form.getParam("goTo"); // 분기할곳
         
        try {     
            dao    = new DCtm435DAO();
            helper = new GauceHelper2(request, response, form);
            dSet   = helper.getDataSet("DS_IO_MASTER");
            helper.setDataSetHeader(dSet, "H_MASTER");
            System.out.println("111");
            list   = dao.searchMaster(form, request);
            helper.setListToDataset(list, dSet);

        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        return mapping.findForward(strGoTo);
    }
    
public ActionForward searchdetail(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		DCtm435DAO dao = null;
		MultiInput mi = null;
		
		String strGoTo = form.getParam("goTo"); // 분기할곳
		
		try {
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_DETAIL");
			helper.setDataSetHeader(dSet, "H_DETAIL");
			dao = new DCtm435DAO();
			
			list = dao.searchdetail(form, mi, request);
			
			
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
	 * 실사재고를 저장/수정
	 * </p>
	 * 
	 */
    public ActionForward save(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		DCtm435DAO dao      = null;
		String strGoTo      = form.getParam("goTo"); // 분기할곳
		HttpSession session = request.getSession();
		String userId       = null;
		String org_flag     = null;  // 조직구분 (1:판매, 2:매입) 
		int ret             = 0;
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
			org_flag = sessionInfo.getORG_FLAG();                  
			
			helper = new GauceHelper2(request, response, form); 
			
			//dSet = new GauceDataSet;
			
			dSet = helper.getDataSet("DS_IO_MASTER");			  
            helper.setDataSetHeader(dSet, "H_MASTER");			  
			MultiInput mi1 = helper.getMutiInput(dSet);
			 
			dao = new DCtm435DAO();    
			// 등록및수정, 삭제 분기
			
			ret = dao.save(form, mi1, userId, org_flag);
			System.out.println("save end");
		} catch (Exception e) { 
			//logger.error("", e);
			//helper.writeException("GAUCE", "002", e.getMessage());
			
			e.printStackTrace();
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			//helper.close(dSet[0], "저장되었습니다");
			System.out.println(ret);
			helper.close(dSet, ret + "건 처리되었습니다");
		}
		return mapping.findForward(strGoTo);
	}
	
	public ActionForward savedetail(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		DCtm435DAO dao      = null;
		String strGoTo      = form.getParam("goTo"); // 분기할곳
		HttpSession session = request.getSession();
		String userId       = null;
		String org_flag     = null;  // 조직구분 (1:판매, 2:매입) 
		int ret             = 0;
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
			org_flag = sessionInfo.getORG_FLAG();                  
			
			helper = new GauceHelper2(request, response, form); 
			
			//dSet = new GauceDataSet;
			
			dSet = helper.getDataSet("DS_IO_DETAIL");			  
            helper.setDataSetHeader(dSet, "H_DETAIL");			  
			MultiInput mi1 = helper.getMutiInput(dSet);
			 
			dao = new DCtm435DAO();    
			// 등록및수정, 삭제 분기
			
			ret = dao.savedetail(form, mi1, userId, org_flag);
			System.out.println("save end");
		} catch (Exception e) { 
			//logger.error("", e);
			//helper.writeException("GAUCE", "002", e.getMessage());
			
			e.printStackTrace();
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			//helper.close(dSet[0], "저장되었습니다");
			System.out.println(ret);
			helper.close(dSet, ret + "건 처리되었습니다");
		}
		return mapping.findForward(strGoTo);
	}
	
	public ActionForward delete(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		DCtm435DAO dao      = null;
		String strGoTo      = form.getParam("goTo"); // 분기할곳
		HttpSession session = request.getSession();
		String userId       = null;
		String org_flag     = null;  // 조직구분 (1:판매, 2:매입) 
		int ret             = 0;
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
			org_flag = sessionInfo.getORG_FLAG();                  
			
			helper = new GauceHelper2(request, response, form); 
			
			//dSet = new GauceDataSet;
			
			dSet = helper.getDataSet("DS_IO_MASTER");			  
            helper.setDataSetHeader(dSet, "H_MASTER");			  
			MultiInput mi1 = helper.getMutiInput(dSet);
			 
			dao = new DCtm435DAO();    
			// 등록및수정, 삭제 분기
			
			
			ret = dao.delete(form, mi1, userId, org_flag);
			
		} catch (Exception e) { 
			//logger.error("", e);
			//helper.writeException("GAUCE", "002", e.getMessage());
			
			e.printStackTrace();
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			//helper.close(dSet[0], "저장되었습니다");
			helper.close(dSet, ret + "건 처리되었습니다");
		}
		return mapping.findForward(strGoTo);
	}
	
	public ActionForward send(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		DCtm435DAO dao      = null;
		List list           = null;
		String strGoTo      = null;
		int ret             = 0;
		
		try {
			dao     = new DCtm435DAO();
			dSet    = new GauceDataSet();
			helper  = new GauceHelper2(request, response, form);
			strGoTo = form.getParam("goTo");
			System.out.println("111");
			//현황 DETAIL 리스트 데이터 가져오기
			helper.setDataSetHeader(dSet, "H_SEND");
			System.out.println("222");
			ret    = dao.send(form);
			
			System.out.println("999");
			helper.setListToDataset(list, dSet);
		} catch (Exception e) {
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.toString());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward("blank");
	}
}
