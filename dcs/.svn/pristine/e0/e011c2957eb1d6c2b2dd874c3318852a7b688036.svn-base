/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dmbo.action;

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

import dmbo.dao.DMbo719DAO;

import common.vo.SessionInfo;
/**
 * <p></p>
 * 
 * @created  on 1.0, 2016.11.07
 * @created  by khj (FUJITSU KOREA LTD.)
 * 
 */

public class DMbo719Action_back extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DMbo719Action_back.class);

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
     * <p>상품권교환 리스트를 조회한다.</p>
     * 
     */
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

		List list[] = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
        DMbo719DAO   dao    = null; 

        String strGoTo = form.getParam("goTo"); // 분기할곳

        try { 
 
            dao    = new DMbo719DAO();
			dSet   = new  GauceDataSet[2];
			list   = new  List[2];
			helper = new GauceHelper2(request, response, form);
			dSet[0] = helper.getDataSet("DS_IO_RULE");
			helper.setDataSetHeader(dSet[0], "H_RULE");
			dSet[1] = helper.getDataSet("DS_O_MASTER");
			helper.setDataSetHeader(dSet[1], "H_TODAY");
            list   = dao.searchMaster(form);
            
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
     * <p>상품권금액을 조회한다.</p>
     * 
     */
    public ActionForward searchAmt(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		DMbo719DAO dao = null; 

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new DMbo719DAO();
			helper = new GauceHelper2(request, response, form);
			
			dSet = helper.getDataSet("DS_O_AMT");
			helper.setDataSetHeader(dSet, "H_AMT");
			list = dao.searchAmt(form);
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
     * <p>상품권 교환 소켓통신 및 저장</p>
     * 
     */
    public ActionForward save(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        GauceHelper2 helper = null;
        DMbo719DAO dao      = null;
        GauceDataSet dSet[] = null;
        List list           = null;
		String ret          = "";
        int rtnCode         = 0;
        String rtnMsg       = "";
        String strGoTo = form.getParam("goTo"); // 분기할곳
        
        try {
    		
			helper = new GauceHelper2(request, response, form);
			
			dSet    = new GauceDataSet[3];
			dSet[0] = helper.getDataSet("DS_I_MASTER");
			dSet[1] = helper.getDataSet("DS_I_POINT");
			dSet[2] = helper.getDataSet("DS_IO_RULE");
            
            helper.setDataSetHeader(dSet[0], "H_MASTER");
            helper.setDataSetHeader(dSet[1], "H_POINT");
            helper.setDataSetHeader(dSet[1], "H_RULE");
           
            MultiInput mi[] = new MultiInput[3];
			mi[0] = helper.getMutiInput(dSet[0]);
			mi[1] = helper.getMutiInput(dSet[1]);
			mi[2] = helper.getMutiInput(dSet[2]);

			dao = new DMbo719DAO();
			rtnCode = dao.save(form, mi, request);
			System.out.println(rtnCode+"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			
			if(rtnCode > 0){
				ret = dao.proCall(form, mi, request);
			}else { 
				rtnCode = -1;
            }
			
		} catch (Exception e) {
            e.printStackTrace();
            logger.error("[updateProgram]", e);
            helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			if(-1 == rtnCode){
                throw new Exception("[USER]"+"시스템 장애가 발생하였습니다. 에러코드 [9999]");	
            }else{
            	helper.close(dSet, "정상적으로 처리되었습니다");
            }
		}
		return mapping.findForward(strGoTo);
    }	
    
    /**
     * <p>상품권 교환 소켓통신 및 저장</p>
     * 
     */
    public ActionForward realSave(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        GauceHelper2 helper = null;
        DMbo719DAO dao      = null;
        GauceDataSet dSet[] = null;
        List list           = null;
		String ret          = "";
        int rtnCode         = 0;
        String rtnMsg       = "";
        String strGoTo = form.getParam("goTo"); // 분기할곳
        
        try {
    		
			helper = new GauceHelper2(request, response, form);
			
			dSet    = new GauceDataSet[4];
			dSet[0] = helper.getDataSet("DS_I_MASTER");
			dSet[1] = helper.getDataSet("DS_I_POINT");
			dSet[2] = helper.getDataSet("DS_IO_RULE");
			dSet[3] = helper.getDataSet("DS_I_MASTER");
            
            helper.setDataSetHeader(dSet[0], "H_MASTER");
            helper.setDataSetHeader(dSet[1], "H_POINT");
            helper.setDataSetHeader(dSet[2], "H_RULE");
            helper.setDataSetHeader(dSet[3], "H_MASTER");
           
            MultiInput mi[] = new MultiInput[4];
			mi[0] = helper.getMutiInput(dSet[0]);
			mi[1] = helper.getMutiInput(dSet[1]);
			mi[2] = helper.getMutiInput(dSet[2]);
			mi[3] = helper.getMutiInput(dSet[3]);
			
			System.out.println(rtnCode+"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			/*
			dao = new DMbo719DAO();
			rtnCode = dao.save(form, mi, request);
			System.out.println(rtnCode+"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			
			if(rtnCode > 0){
				ret = dao.proCall(form, mi, request);
			}else { 
				rtnCode = -1;
            }
			*/
			dao = new DMbo719DAO();
			//ret = dao.chkSave(form, mi, request);
			//System.out.println("DMbo719 chkSave : ret = " + ret);
			
			//if(ret.equals("00")){	
			//	System.out.println("DMbo719 chkSave : ret = " + ret);
				rtnCode = dao.realSave(form, mi, request);

			//}else { 
			//	rtnCode = -1;
            //}
			
		} catch (Exception e) {
            e.printStackTrace();
            logger.error("[updateProgram]", e);
            helper.writeException("GAUCE", "002", e.getMessage());
		} finally {

			System.out.println("rtnCode----------rtnCode    = " + rtnCode);
			if(-1 == rtnCode){
                throw new Exception("[USER]"+"시스템 장애가 발생하였습니다. 에러코드 [9999]");	
            }else{
            	helper.close(dSet, "정상적으로 처리되었습니다");
            }
		}
        
		return mapping.findForward(strGoTo);
    }	

    /**
     * <p>상품권 확인 - 저장전</p>
     * 
     */
    public ActionForward chkSave(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        GauceHelper2 helper = null;
        DMbo719DAO dao      = null;
        GauceDataSet dSet[] = null;
        List list           = null;
		String ret          = "";
        
        String strGoTo = form.getParam("goTo"); // 분기할곳
        
        try {
    		
			helper = new GauceHelper2(request, response, form);
			
			dSet    = new GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_I_MASTER");
			dSet[1] = helper.getDataSet("DS_I_POINT"); 
            
            helper.setDataSetHeader(dSet[0], "H_MASTER");
            helper.setDataSetHeader(dSet[1], "H_POINT");
           
            MultiInput mi[] = new MultiInput[2];
			mi[0] = helper.getMutiInput(dSet[0]);
			mi[1] = helper.getMutiInput(dSet[1]);

			dao = new DMbo719DAO();
		    ret = dao.chkSave(form, mi, request);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error("[updateProgram]", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			  helper.close(dSet, ret +"|정상적으로 처리되었습니다");
		}
		return mapping.findForward(strGoTo);
    }	
}

