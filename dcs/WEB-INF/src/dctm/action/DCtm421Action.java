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

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

import dctm.dao.DCtm421DAO;

/**
 * <p>회원가입경로조회</p>
 * 
 * @created  on 1.0, 2010/03/30
 * @created  by 장형욱(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DCtm421Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DCtm421Action.class);

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
     * <p> 회원가입경로조회한다.</p>
     * 
     */
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DCtm421DAO   dao    = null;
        ArrayList arrList= new ArrayList();

        String strGoTo = form.getParam("goTo"); // 분기할곳
         
        try {     
            dao    = new DCtm421DAO();
            helper = new GauceHelper2(request, response, form);
            dSet   = helper.getDataSet("DS_O_MASTER");
            helper.setDataSetHeader(dSet, "H_MASTER");
            
            list   = dao.searchList(form, request);
            
			//주민등록번호 복호화
			for ( int i = 0; i < list.size(); i++ )
			{
				arrList = (ArrayList)list.get(i);
				HashMap map = new HashMap();
				map.put("HOME_PH1",   arrList.get(5));
				map.put("HOME_PH2",   arrList.get(6));
				map.put("HOME_PH3",   arrList.get(7));
				map.put("OFFI_PH1",   arrList.get(8));
				map.put("OFFI_PH2",   arrList.get(9));
				map.put("OFFI_PH3",   arrList.get(10));
				map.put("MOBILE_PH1", arrList.get(11));
				map.put("MOBILE_PH2", arrList.get(12));
				map.put("MOBILE_PH3", arrList.get(13));
				map.put("EMAIL1",     arrList.get(17));
				map.put("EMAIL2",     arrList.get(18));
				 
				String strHomePh   = "";
				String strOffiPh   = "";
				String strMobilePh = "";
				String strEmail    = "";
				if(!map.get("HOME_PH1").toString().equals("")){
					strHomePh = map.get("HOME_PH1").toString() + "-";
				}
				if(!map.get("HOME_PH2").toString().equals("") && !map.get("HOME_PH3").toString().equals("")){
					strHomePh += map.get("HOME_PH2").toString() + "-" + map.get("HOME_PH3").toString();
				}
				
				if(!map.get("OFFI_PH1").toString().equals("")){
					strOffiPh = map.get("OFFI_PH1").toString() + "-";
				}
				if(!map.get("OFFI_PH2").toString().equals("") && !map.get("OFFI_PH3").toString().equals("")){
					strOffiPh += map.get("OFFI_PH2").toString() + "-" + map.get("OFFI_PH3").toString();
				}

				if(!map.get("MOBILE_PH1").toString().equals("") &&!map.get("MOBILE_PH2").toString().equals("") && !map.get("MOBILE_PH3").toString().equals("")){
					strMobilePh = map.get("MOBILE_PH1").toString() + "-" + map.get("MOBILE_PH2").toString() + "-" + map.get("MOBILE_PH3").toString();
				}
				
				if(!map.get("EMAIL1").toString().equals("") && !map.get("EMAIL2").toString().equals("")){
					strEmail = map.get("EMAIL1").toString() + "@" + map.get("EMAIL2").toString();
				}
				arrList.set(5,  strHomePh);
				arrList.set(8,  strOffiPh);
				arrList.set(11, strMobilePh);
				arrList.set(17, strEmail);
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
}
