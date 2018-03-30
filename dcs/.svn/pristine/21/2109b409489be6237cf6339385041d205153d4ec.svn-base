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
import kr.fujitsu.ffw.util.String2;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import dmbo.dao.DMbo639DAO;

import common.util.Util;
import common.vo.SessionInfo;
/**
 * <p>OK캐쉬백상품권 교환 현황표</p>
 * 
 * @created  on 1.0, 2 2010/03/03
 * @created  by 김영진(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by 
 * @caused   by 
 */
public class DMbo639Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DMbo639Action.class);

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
     * <p>상품권 교환 현황표를 조회한다.</p>
     * 
     */
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DMbo639DAO   dao    = null; 

        String strGoTo = form.getParam("goTo"); // 분기할곳
        
        try {
 
            dao    = new DMbo639DAO();
            helper = new GauceHelper2(request, response, form);
            dSet   = helper.getDataSet("DS_O_MASTER");
            helper.setDataSetHeader(dSet, "H_MASTER");
            
            list   = dao.searchMaster(form);
            
            ArrayList arrList = new ArrayList();
			for ( int i = 0; i < list.size(); i++ )
			{
				arrList = (ArrayList)list.get(i);
				HashMap map = new HashMap();
				map.put("MOBILE_PH1", arrList.get(4));
				map.put("MOBILE_PH2", arrList.get(5));
				map.put("MOBILE_PH3", arrList.get(6));

				if(!String2.isEmpty(map.get("MOBILE_PH1").toString()) 
						&& !String2.isEmpty(map.get("MOBILE_PH2").toString())
						&& !String2.isEmpty(map.get("MOBILE_PH3").toString())){
		            String strMphone = map.get("MOBILE_PH1").toString()
		                             + "-" + map.get("MOBILE_PH2").toString()
		                             + "-" + map.get("MOBILE_PH3").toString();
			        arrList.set(4, strMphone);
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
     * <p>출력</p>
     */
    public ActionForward print(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String strGoTo = form.getParam("goTo"); // 분기할곳
		GauceHelper2.initialize(form, request, response);

		return mapping.findForward(strGoTo);
	}
    
    public ActionForward httpstore(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		DMbo639DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳    
     
		try {
 
			dao = new DMbo639DAO();
			list = dao.httpstore(form);
			//ActionUtil.sendAjaxResponse(response, Util.makeOZXML(list, new String[]{"COMM_NAME1"}));
			Util.forwardXML(response, Util.makeOZXML(list, new String[]{"CARD_NO"}));
            
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		} 
		return mapping.findForward("save");
	}
}
