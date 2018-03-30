/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */
 
package common.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.util.String2;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;
import common.dao.CCom420DAO;


/**
 * <p>법인명 찾기  팝업</p>
 * 
 * @created  on 1.0, 2010/02/28	 
 * @created  by 김영진
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class CCom420Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(CCom420Action.class);

    /**
     * <p>
     * 분류 코드 Pop-up 헤더
     * </p>
     *
     * <p>
     * 분류 코드 Pop-up 헤더 정보를 가져온다.
     * </p>
     */
	
    public ActionForward list(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception 
    {
        GauceHelper2  helper = null;
        String strGoTo = form.getParam("goTo"); // 분기할곳
      
        try 
        {
            GauceHelper2.initialize(form, request, response);
            request.setAttribute("flag", request.getParameter("flag"));
        } 
        catch (Exception e) 
        {
            logger.error("", e);
            helper.writeException("GAUCE","002",e.getMessage());
        }
        return mapping.findForward(strGoTo);
    }
    
	/**
     * <p>법인명 조회 Pop</p>
     *
     */ 
	public ActionForward searchComp(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		CCom420DAO dao = null;
		MultiInput mi = null;
		ArrayList    arrList= new ArrayList();
		
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			helper = new GauceHelper2(request, response, form);
			dSet   = new GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_I_CONDITION");
			dSet[1] = helper.getDataSet("DS_O_RESULT");
			mi = helper.getMutiInput(dSet[0]);
			helper.setDataSetHeader(dSet[1], "H_CUSTINFO");
			dao = new CCom420DAO(); 
			list = dao.getCustomer(form, mi);
			
			//전화번호 복호화
			for ( int i = 0; i < list.size(); i++ )
			{
				arrList = (ArrayList)list.get(i);
				HashMap map = new HashMap();
				map.put("OFFI_PH1", arrList.get(2));
				map.put("OFFI_PH2", arrList.get(3));
				map.put("OFFI_PH3", arrList.get(4));
				map.put("HOME_PH1", arrList.get(5));
				map.put("HOME_PH2", arrList.get(6));
				map.put("HOME_PH3", arrList.get(7));
				map.put("EMAIL1",   arrList.get(8));
				map.put("EMAIL2",   arrList.get(9));
				
				if(!String2.isEmpty(map.get("OFFI_PH1").toString()) 
						&& !String2.isEmpty(map.get("OFFI_PH2").toString())
						&& !String2.isEmpty(map.get("OFFI_PH3").toString())){
		            String strMphone = map.get("OFFI_PH1").toString()
		                             + "-" + map.get("OFFI_PH2").toString()
		                             + "-" + map.get("OFFI_PH3").toString();
			        arrList.set(2, strMphone);
				}else if(String2.isEmpty(map.get("OFFI_PH1").toString()) 
						&& !String2.isEmpty(map.get("OFFI_PH2").toString())
						&& !String2.isEmpty(map.get("OFFI_PH3").toString())){
		            String strMphone = map.get("OFFI_PH2").toString()
		                             + "-" + map.get("OFFI_PH3").toString();
			        arrList.set(2, strMphone);
				}
				if(!String2.isEmpty(map.get("HOME_PH1").toString()) 
						&& !String2.isEmpty(map.get("HOME_PH2").toString())
						&& !String2.isEmpty(map.get("HOME_PH3").toString())){
		            String strHphone = map.get("HOME_PH1").toString()
                                     + "-" + map.get("HOME_PH2").toString()
		                             + "-" + map.get("HOME_PH3").toString();
		            arrList.set(5, strHphone);
				}else if(String2.isEmpty(map.get("HOME_PH1").toString()) 
						&& !String2.isEmpty(map.get("HOME_PH2").toString())
						&& !String2.isEmpty(map.get("HOME_PH3").toString())){
					 String strHphone = map.get("HOME_PH2").toString()
                                      + "-" + map.get("HOME_PH3").toString();
					 arrList.set(5, strHphone);
				}
				if(!String2.isEmpty(map.get("EMAIL1").toString()) 
						&& !String2.isEmpty(map.get("EMAIL2").toString())){
		            String strEmail  = map.get("EMAIL1").toString()
		                             + "@" + map.get("EMAIL2").toString();
			        arrList.set(8, strEmail);
				}
			}
			
			helper.setListToDataset(list, dSet[1]);
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}

		return mapping.findForward(strGoTo);
	}
}
