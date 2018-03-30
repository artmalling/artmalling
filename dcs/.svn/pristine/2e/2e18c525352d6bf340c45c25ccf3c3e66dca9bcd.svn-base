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
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.util.String2;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

import dctm.dao.DCtm106DAO;

/**
 * <p>세대원정보</p>
 * 
 * @created  on 1.0, 2010/02/24
 * @created  by 김영진
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DCtm106Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DCtm106Action.class);

	/**
	 * <p>메뉴를 보여준다.</p>
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
	 * <p>세대원 세대주 카드정보를 조회한다.</p>
	 * 
	 */
	public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		List list2 = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		DCtm106DAO dao = null; 

		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {

			String strSsno    = String2.nvl(form.getParam("strSsno"));
			String strCustid  = String2.nvl(form.getParam("strCustid"));
			String strCardno  = String2.nvl(form.getParam("strCardno"));
			
			String strSsno2    = String2.nvl(form.getParam("strSsno2"));
			String strCustid2  = String2.nvl(form.getParam("strCustid2"));
			String strCardno2  = String2.nvl(form.getParam("strCardno2"));
			
			dao = new DCtm106DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_O_MASTER");
            dSet[1] = helper.getDataSet("DS_O_MASTER2");
			 
            helper.setDataSetHeader(dSet[0], "H_MASTER");
			helper.setDataSetHeader(dSet[1], "H_MASTER");
			
			if(!strSsno.equals("") || !strCustid.equals("") || !strCardno.equals("")){				
				list = dao.searchMaster(form);
				helper.setListToDataset(list, dSet[0]);
			}
			if(!strSsno2.equals("") || !strCustid2.equals("") || !strCardno2.equals("")){				
				list2 = dao.searchMaster2(form);
				helper.setListToDataset(list2, dSet[1]);
			}

			//helper.setListToDataset(list,  dSet[0]);
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}

    /**
     * <p>세대원 이동 정보를 등록한다.</p>
     * 
     */
    public ActionForward saveData(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DCtm106DAO dao      = null;
        ProcedureResultSet prs = null;
        String ret = "";
        
        String strGoTo = form.getParam("goTo"); // 분기할곳
        
        try {
        	
            helper = new GauceHelper2(request, response, form);
            dSet = helper.getDataSet("DS_I_CUST");     
            dao  = new DCtm106DAO();
            
            ret = dao.saveData(form, dSet, request, response); 
            
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            if(ret.equals("OK")){ 
                helper.close("정상처리 되었습니다.");
            }else{
            	helper.close("세대원 이동이 실패하였습니다.");
            }
        }
        return mapping.findForward(strGoTo);
    }    
}
