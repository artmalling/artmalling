/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mren.action;

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
import mren.dao.MRen105DAO;
import mren.dao.MRen113DAO;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

/**
 * <p>전력 시간대 관리</p>
 * 
 * @created  on 1.0, 2010/04/04
 * @created  by 신익수(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MRen113Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MRen113Action.class);

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
	 * <p>전력 시간대  조회/p>
	 */
    public ActionForward getPowerTime(ActionMapping mapping, ActionForm form,
           HttpServletRequest request, HttpServletResponse response) throws Exception {
       List list			= null;
       GauceHelper2 helper	= null;
       GauceDataSet dSet	= null;
       MRen113DAO dao		= null;
       
       String strGoTo = form.getParam("goTo");
       System.out.println(strGoTo);
       try {  
           helper = new GauceHelper2(request, response, form);
           System.out.println("1111111111");
           dSet = new GauceDataSet();
           System.out.println("22222222");
           dSet = helper.getDataSet("DS_IO_MASTER");
           System.out.println("33333");
           helper.setDataSetHeader(dSet, "H_MASTER");
           System.out.println("4444");
           dao = new MRen113DAO();
           
           list = dao.getPowerTime(form);
       
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
	 * <p>중복내용체크</p>
	 */
    @SuppressWarnings("rawtypes")
	public ActionForward getDupKeyValue(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {
        List list			= null;
        GauceHelper2 helper	= null;
        GauceDataSet dSetR	= null;	//마스터 
        GauceDataSet dSet	= null; //중복키값
        MRen113DAO dao		= null;
        String strGoTo = form.getParam("goTo");
        try {

            helper = new GauceHelper2(request, response, form);
            dSet  = new GauceDataSet();
            dSetR = new GauceDataSet();
            dSetR = helper.getDataSet("DS_IO_MASTER");			
            helper.setDataSetHeader(dSet, "H_MASTER");
            MultiInput mi = helper.getMutiInput(dSetR);
            dSet = helper.getDataSet("DS_O_DUPKEYVALUE");			
            helper.setDataSetHeader(dSet, "H_SEL_DUP_KEYVALUE");
            dao = new MRen113DAO();
            list = dao.getDupKeyValue(form, mi);
            helper.setListToDataset(list, dSet); 

        } catch (Exception e) {
            logger.error("", e);
            helper.close(dSet);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        return mapping.findForward(strGoTo);
    }
    
    /**
	 * <p> 전력시간대 등록/수정/삭제 </p> 
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		MRen113DAO dao      = null;
		
		HttpSession session = request.getSession();
		String userId       = null;
		int ret             = 0;
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
			
			helper = new GauceHelper2(request, response, form); 
			
			dSet = new GauceDataSet[1];
			dSet[0] = helper.getDataSet("DS_IO_MASTER"); 
              
            helper.setDataSetHeader(dSet[0], "H_MASTER");
			  
			MultiInput mi0 = helper.getMutiInput(dSet[0]);
			
			dao = new MRen113DAO();    
			// 등록및수정, 삭제 분기
			ret = dao.save(form,mi0,userId);
			
		} catch (Exception e) { 
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet, ret + "건 처리되었습니다"); 
		}
		return mapping.findForward("save");
	}
}
