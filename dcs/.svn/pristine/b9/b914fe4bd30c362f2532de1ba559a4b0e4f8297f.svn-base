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

import dmbo.dao.DMbo405DAO;

import common.vo.SessionInfo;
/**
 * <p>기간별가입회원List조회</p>
 * 
 * @created  on 1.0, 2010/01/18
 * @created  by 남형석(FUJITSU KOREA LTD.)
 * 
 * @modified on 1.1, 2010/03/21
 * @modified by 
 * @caused   by 기간별가입회원List조회
 */

public class DMbo405Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DMbo405Action.class);

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
	
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
            
		HttpSession session = request.getSession();
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		String userId 		= null;  
		String org_flag 	= null;				
		List list			= null;
		DMbo405DAO dao 		= null;
		ArrayList    arrList= new ArrayList();
		String strGoTo      = form.getParam("goTo"); // 분기할곳                            

		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   				= sessionInfo.getUSER_ID();
			org_flag 				= sessionInfo.getORG_FLAG();
	
			dao    = new DMbo405DAO();  
			helper = new GauceHelper2(request, response, form);
			dSet   = helper.getDataSet("DS_IO_MASTER");
			helper.setDataSetHeader(dSet, "H_MASTER");                    
			list   = dao.getMaster(form, userId, org_flag); 
			
			//전화번호 복호화
			for ( int i = 0; i < list.size(); i++ )
			{
				arrList = (ArrayList)list.get(i);
				HashMap map = new HashMap();
			
				//map.put("HOME_PH1",   arrList.get(13));
				//map.put("HOME_PH2",   arrList.get(14));
				//map.put("HOME_PH3",   arrList.get(15));
				map.put("MOBILE_PH1", arrList.get(16));
				map.put("MOBILE_PH2", arrList.get(17));
				map.put("MOBILE_PH3", arrList.get(18));
				map.put("EMAIL1", arrList.get(19));
				map.put("EMAIL2", arrList.get(20));
				
				 /*
				if(!String2.isEmpty(map.get("HOME_PH1").toString()) 
						&& !String2.isEmpty(map.get("HOME_PH2").toString())
						&& !String2.isEmpty(map.get("HOME_PH3").toString())){
		            String strHphone = map.get("HOME_PH1").toString()
                                     + "-" + map.get("HOME_PH2").toString()
		                             + "-" + map.get("HOME_PH3").toString();
		            arrList.set(3, strHphone);
		            System.out.println("111>>>>"+strHphone);
				}
				*/
				
				if(!String2.isEmpty(map.get("MOBILE_PH1").toString()) 
						&& !String2.isEmpty(map.get("MOBILE_PH2").toString())
						&& !String2.isEmpty(map.get("MOBILE_PH3").toString())){
		            String strMphone = map.get("MOBILE_PH1").toString()
		                             + "-" + map.get("MOBILE_PH2").toString()
		                             + "-" + map.get("MOBILE_PH3").toString();
			        arrList.set(4, strMphone);
			        System.out.println("222>>>>"+strMphone);
				}
				
				if(!String2.isEmpty(map.get("EMAIL1").toString()) 
						&& !String2.isEmpty(map.get("EMAIL2").toString())){
		            String strEmail = map.get("EMAIL1").toString()
		                             + "@" + map.get("EMAIL2").toString();
			        arrList.set(5, strEmail);
			        System.out.println("333>>>>"+strEmail);
				}
				
		       
			}
			
			helper.setListToDataset(list, dSet);            

		} catch (Exception e) {
			logger.error("", e);                       
			System.out.println(e.getMessage());
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}        
		return mapping.findForward(strGoTo);
	}
}
