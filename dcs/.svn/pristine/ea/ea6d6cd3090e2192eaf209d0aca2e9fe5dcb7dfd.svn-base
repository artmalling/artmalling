/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dcom.action;

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

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import dcom.dao.DCom100DAO;

/**
 * <p>
 * 공통코드 처리
 * </p>
 * 
 * @created on 1.0, 2010/02/25
 * @created by 김영진(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class DCom100Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DCom100Action.class);

	
	/**
	 * <p>
	 * 팝업 안띄우고 조회(1건)
	 * </p>
	 * 
	 */
	public ActionForward searchCustinfo(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		DCom100DAO dao = null;
		MultiInput mi = null;
		ArrayList arrList= new ArrayList();

		String strGoTo = form.getParam("goTo"); // 분기할곳
		
		try { 
			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_I_CONDITION");
			dSet[1] = helper.getDataSet("DS_O_CUSTDETAIL");

			mi = helper.getMutiInput(dSet[0]);
			helper.setDataSetHeader(dSet[1], "H_COMMON");

			dao = new DCom100DAO();
			list = dao.searchCustinfo(form, mi, request, response);
			
			String strFlag = dSet[0].getDataRow(0).getColumnValue(4).toString(); 
			
			//법인일경우 개인회원이동전화==> 담당자전화
			if(strFlag.equals("C")){
			    for ( int i = 0; i < list.size(); i++ )
			    {
			    	arrList = (ArrayList)list.get(i);
			    	HashMap map = new HashMap();
			    	map.put("OFFI_PH1", arrList.get(13));
			    	map.put("OFFI_PH2", arrList.get(14));
			    	map.put("OFFI_PH3", arrList.get(15));
			    	String strOffiPh1  = map.get("OFFI_PH1").toString();
			    	String strOffiPh2  = map.get("OFFI_PH2").toString();
			    	String strOffiPh3  = map.get("OFFI_PH3").toString();
			    	arrList.set(4, strOffiPh1);
			    	arrList.set(5, strOffiPh2);
			    	arrList.set(6, strOffiPh3);
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
    
	/**
	 * <p>회원정보 팝업 안띄우고 조회(1건)</p>
	 * 
	 */
	public ActionForward getOneWithoutPop(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		DCom100DAO dao = null;
		MultiInput mi = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[2];
			dSet[0] = helper.getDataSet("DS_I_CONDITION");
			dSet[1] = helper.getDataSet("DS_O_RESULT");
			mi = helper.getMutiInput(dSet[0]);
			helper.setDataSetHeader(dSet[1], "H_CUSTINFO");
			dao = new DCom100DAO();
			list = dao.getOneWithoutPop(form, mi);
			helper.setListToDataset(list, dSet[1]);
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}

		return mapping.findForward(strGoTo);
	}
	
	/**
	 * 가맹점 AUTHORITY 조회
	 * 
	 */
	public ActionForward getCommonResult(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
        List list = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet = null;
        DCom100DAO   dao   = null;

        try {
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet();

            dSet = helper.getDataSet(form.getParam("dsName"));
            
            //업무에 따른 분기;
            helper.setDataSetHeader(dSet, "H_" + form.getParam("sqlId"));
            
            dao = new DCom100DAO();

            list = dao.getCommonResult(form);
            
            if (list != null) {
                helper.setListToDataset(list, dSet);
            }
        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        String strGoTo = form.getParam("goTo"); // 분기할곳
        
        return mapping.findForward(strGoTo);
    }
	
	
	/**
     * <p>클럽목록(조건콤보)을 조회한다.</p>
     * 
     */
	public ActionForward getClubCode(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        DCom100DAO   dao   = null;
        MultiInput   mi     = null;
        
        String strGoTo      = form.getParam("goTo"); // 분기할곳
        try {
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];

            dSet[0] = helper.getDataSet("DS_I_COMMON");
            dSet[1] = helper.getDataSet("DS_O_COMMON");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_CLUB_CODE");
            dao = new DCom100DAO();
            list = dao.getClubCode(form, mi); 
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
	
	/**
     * <p>제휴신용카드사(조건콤보)을 조회한다.</p>
     * 
     */
	public ActionForward getCardCode(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet[] = null;
        DCom100DAO   dao   = null;
        MultiInput   mi     = null;
        
        String strGoTo      = form.getParam("goTo"); // 분기할곳
        try {
            helper = new GauceHelper2(request, response, form);
            dSet = new GauceDataSet[2];

            dSet[0] = helper.getDataSet("DS_I_COMMON");
            dSet[1] = helper.getDataSet("DS_O_COMMON");

            mi = helper.getMutiInput(dSet[0]);
            helper.setDataSetHeader(dSet[1], "H_CLUB_CODE");
            dao = new DCom100DAO();
            list = dao.getCardCode(form, mi); 
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
