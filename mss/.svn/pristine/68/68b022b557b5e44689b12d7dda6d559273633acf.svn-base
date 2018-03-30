/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mpro.action;

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

import mpro.dao.MPro105DAO;
import mpro.dao.MPro106DAO;
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

public class MPro106Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MPro106Action.class);

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
	 * <p>해피콜관리 </p>
	 * 마스터 조회(약속대장)
	 */
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {
        
		List list			= null;
        GauceHelper2 helper	= null;
        GauceDataSet dSet	= null;
        MPro106DAO dao		= null;
        String strGoTo = form.getParam("goTo"); // 분기할곳
        
        try {

            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet();
            dSet = helper.getDataSet("DS_O_MASTER");			
            helper.setDataSetHeader(dSet, "H_SEL_MRMASTER");

            dao = new MPro106DAO();
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
	 * <p>해피콜관리 </p>
	 * 해피콜 상세 조회
	 */
	
	public ActionForward getDetail(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {
        
		List list			= null;
        GauceHelper2 helper	= null;
        GauceDataSet dSet	= null;
        MPro106DAO dao		= null;
        String strGoTo = form.getParam("goTo"); // 분기할곳
        
        try {
        
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet();
         
            dSet = helper.getDataSet("DS_O_DETAIL");
            helper.setDataSetHeader(dSet, "H_SEL_HAPPYCALLMGRDETAIL");
         
            dao = new MPro106DAO();
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
	
	
	public ActionForward save(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {
		
        GauceHelper2 helper	= null;
        GauceDataSet dSet	= null;
        MPro106DAO dao		= null;
        int ret = 0;
        HttpSession session = request.getSession();
        String userId = "";
        String strGoTo = form.getParam("goTo"); // 분기할곳
        
        
        try {
            SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
            userId = sessionInfo.getUSER_ID();
            
            helper = new GauceHelper2(request, response, form);
         
            dSet = helper.getDataSet("DS_O_DETAIL");
            helper.setDataSetHeader(dSet, "H_SEL_HAPPYCALLMGRDETAIL");
         
            MultiInput mi = helper.getMutiInput(dSet);
          
            dao = new MPro106DAO();
            
            if( form.getParam("strFlg").equals("delete") ){
            	ret = dao.delete(form, mi);
            }else {
          
            	ret = dao.save(form, mi, userId);          
            }
        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            // 저장, 삭제, 수정의 경우 아래의 메시지를 사용
            helper.close(dSet, ret + "건 처리되었습니다");
        }
        return mapping.findForward(strGoTo);
    }
	
	

}
