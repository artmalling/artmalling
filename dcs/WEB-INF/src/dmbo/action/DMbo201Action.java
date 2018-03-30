/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dmbo.action;

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

import dmbo.dao.DMbo201DAO;

import common.vo.SessionInfo;
/**
 * <p>캠페인 조회</p>
 * 
 * @created  on 1.0, 2010/01/18
 * @created  by 남형석(FUJITSU KOREA LTD.)
 * 
 * @modified on 1.1, 2010/03/17
 * @modified by 김영진
 * @caused   by 캠페인 조회
 */

public class DMbo201Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DMbo201Action.class);

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
     * <p>캠페인 조회</p>
     * 
     */
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DMbo201DAO   dao    = null; 

        String strGoTo = form.getParam("goTo"); // 분기할곳
        
        try {
 
            dao    = new DMbo201DAO();
            helper = new GauceHelper2(request, response, form);
            dSet   = helper.getDataSet("DS_O_MASTER");
            helper.setDataSetHeader(dSet, "H_MASTER");
            
            list   = dao.searchMaster(form);
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
     * <p>가맹점 코드 정보를 상세 조회한다.</p>
     * 
     */
    public ActionForward searchDetail(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DMbo201DAO   dao    = null; 

        String strGoTo = form.getParam("goTo"); // 분기할곳

        try {

            dao    = new DMbo201DAO();
            helper = new GauceHelper2(request, response, form);
            dSet   = helper.getDataSet("DS_O_DETAIL");
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
	 * <p>Segment명 POPUP open</p>
	 */
	public ActionForward popCust(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 
        GauceHelper2 helper = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			GauceHelper2.initialize(form, request, response);
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		}
		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p>Segment명 POPUP 조회</p>
	 */
    public ActionForward popCustSearch(ActionMapping mapping, ActionForm form,
	            HttpServletRequest request, HttpServletResponse response)
	            throws Exception {

        List         list   = null;
	    GauceHelper2 helper = null;
	    GauceDataSet dSet   = null;
	    DMbo201DAO   dao    = null; 
	    ArrayList    arrList= new ArrayList();

	    String strGoTo = form.getParam("goTo"); // 분기할곳
	        
	    try {
	 
	        dao    = new DMbo201DAO();
	        helper = new GauceHelper2(request, response, form);
	        dSet   = helper.getDataSet("DS_O_CUSTLIST");
	        helper.setDataSetHeader(dSet, "H_POPCUST");
	            
	        list   = dao.popCustSearch(form);
	        
	      //전화번호 복호화
			for ( int i = 0; i < list.size(); i++ )
			{
				arrList = (ArrayList)list.get(i);
				HashMap map = new HashMap();
				map.put("MOBILE_PH1", arrList.get(5));
				map.put("MOBILE_PH2", arrList.get(6));
				map.put("MOBILE_PH3", arrList.get(7));
				
				if(!String2.isEmpty(map.get("MOBILE_PH1").toString()) 
						&& !String2.isEmpty(map.get("MOBILE_PH2").toString())
						&& !String2.isEmpty(map.get("MOBILE_PH3").toString())){
		            String strMphone = map.get("MOBILE_PH1").toString()
		                             + "-" + map.get("MOBILE_PH2").toString()
		                             + "-" + map.get("MOBILE_PH3").toString();
			        arrList.set(5, strMphone);
				}
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
     * <p>적용가맹점수 상세조회 POPUP open</p>
     * 
     */
    public ActionForward popBrch(ActionMapping mapping, ActionForm form,
				HttpServletRequest request, HttpServletResponse response)
				throws Exception { 
        GauceHelper2 helper = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
        try {
			GauceHelper2.initialize(form, request, response);
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		}
	    return mapping.findForward(strGoTo);
    }
      
    /**
	 * <p>적용가맹점수 상세조회 POPUP 조회</p>
	 */
    public ActionForward popBrchSearch(ActionMapping mapping, ActionForm form,
	            HttpServletRequest request, HttpServletResponse response)
	            throws Exception {

        List         list   = null;
	    GauceHelper2 helper = null;
	    GauceDataSet dSet   = null;
	    DMbo201DAO   dao    = null; 

	    String strGoTo = form.getParam("goTo"); // 분기할곳
	        
	    try {
	 
	        dao    = new DMbo201DAO();
	        helper = new GauceHelper2(request, response, form);
	        dSet   = helper.getDataSet("DS_O_BRCHLIST");
	        helper.setDataSetHeader(dSet, "H_POPBRCH");
	            
	        list   = dao.popBrchSearch(form);
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
	  * <p> 시도,시군구 콤보 조회 </p>
	  */
	 public ActionForward getEtcCode(ActionMapping mapping, ActionForm form,
	         HttpServletRequest request, HttpServletResponse response)
	         throws Exception {
	     List list = null;
	     GauceHelper2 helper = null;
	     GauceDataSet dSet[] = null;
	     DMbo201DAO   dao    = null;
	     MultiInput   mi     = null;
	     
	     String strGoTo      = form.getParam("goTo"); // 분기할곳
	       
	     try {
	         helper = new GauceHelper2(request, response, form);
	         dSet = new GauceDataSet[2];
	         dSet[0] = helper.getDataSet("DS_I_COMMON");
	         dSet[1] = helper.getDataSet("DS_O_COMMON");
	         mi = helper.getMutiInput(dSet[0]);
	         helper.setDataSetHeader(dSet[1], "H_COMMON");
	         dao = new DMbo201DAO(); 
	         list = dao.getEtcCode(form, mi);
	         
	         if (list != null) {
	             helper.setListToDataset(list, dSet[1]);
	         }
	 } catch (Exception e) {
	 	logger.error("", e);
	 	helper.writeException("GAUCE", "002", e.getMessage());
	 } finally {
	 	helper.close(dSet);
	 }
	     return mapping.findForward(strGoTo);
	 }	 
}
