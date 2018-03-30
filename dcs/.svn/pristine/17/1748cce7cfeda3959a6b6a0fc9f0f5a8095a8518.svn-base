/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dctm.action;

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
import kr.fujitsu.ffw.model.ProcedureResultSet;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

import dctm.dao.DCtm105DAO;
/**
 * <p>법인회원가입신청서등록 </p>
 * 
 * @created  on 1.0, 2010/2/25
 * @created  by 
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DCtm105Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DCtm105Action.class);

	/**
	 * <p>화면을  보여준다.</p>
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 
		
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {

			GauceHelper2.initialize(form, request, response);
			
			HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");	
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}

		return mapping.findForward(strGoTo);
	}
	
    /**
     * <p>법인 회원 정보를 등록한다.</p>
     * 
     */
    public ActionForward saveData(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
        GauceHelper2 helper = null;
        GauceDataSet dSet = null;
        DCtm105DAO dao = null;
        ProcedureResultSet prs = null;
        String ret = "";
        String strGoTo = form.getParam("goTo"); // 분기할곳
        try {
            helper = new GauceHelper2(request, response, form);

            dSet = helper.getDataSet("DS_IO_CUST");
            helper.setDataSetHeader(dSet, "H_CUST");
            MultiInput mi = helper.getMutiInput(dSet);
            
            dao = new DCtm105DAO();
            if(ret.equals("")){   
               dao.addrCls(form, mi, request, response);
               ret = dao.saveData(form, dSet, request, response, mi);
            }
                
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("[updateProgram]", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close("cid:"+ret);
        }
    
        return mapping.findForward(strGoTo);
    }    

    /**
     * <p>사업자번호로 회원정보를 조회 한다.</p>
     * 
     */
    public ActionForward showCustInfo(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet = null;
        DCtm105DAO dao = null; 

        String strGoTo = form.getParam("goTo"); // 분기할곳
 
        try {

            dao = new DCtm105DAO();
            helper = new GauceHelper2(request, response, form); 
            dSet = helper.getDataSet("DS_IO_CUST");
            helper.setDataSetHeader(dSet, "H_CUST");
            list = dao.showCustInfo(form, request, response);
            
            if(list.size()>0){
                helper.setListToDataset(list,  dSet);
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
     * <p>법인회원의 카드리스트를  조회 한다.</p>
     * 
     */    
    public ActionForward searchCardList(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List list  = null;
        List list2 = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        DCtm105DAO dao = null; 

        String strGoTo = form.getParam("goTo"); // 분기할곳

        try {

            dao = new DCtm105DAO();
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_O_CARD");
            dSet[1] = helper.getDataSet("DS_O_CARDPRINT");

            helper.setDataSetHeader(dSet[0], "H_CARD");
            helper.setDataSetHeader(dSet[1], "H_CARD_PRINT");
            list  = dao.searchCardList(form);
            list2 = dao.cardPrintList(form);
            helper.setListToDataset(list,  dSet[0]);
            helper.setListToDataset(list2, dSet[1]);

        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        return mapping.findForward(strGoTo);
    }
    
    /**
     * <p>가사업자번호 생성.</p>
     * 
     */    
    public ActionForward insSsno(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        String rst = "";
        GauceHelper2 helper = null;
        GauceDataSet dSet = null;
        DCtm105DAO dao = null; 

        String strGoTo = form.getParam("goTo"); // 분기할곳

        try {

            dao = new DCtm105DAO();
            helper = new GauceHelper2(request, response, form);
           
            rst = dao.insSSno(form);
            System.out.println(rst);
            request.setAttribute("strSSno", rst);
            
        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close("rst:"+rst);
        }
        return mapping.findForward(strGoTo);
    }
    
}
