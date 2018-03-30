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

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;
import common.util.Util;
import common.vo.SessionInfo;

import dmbo.dao.DMbo603DAO;
/**
 * <p>영수증적립내역상세조회</p>
 * 
 * @created  on 1.0,  2010.03.25
 * @created  by jinjung.kim
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMbo603Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DMbo603Action.class);

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
     * 영수증적립내역조회
     * 
     */
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
        GauceHelper2 helper = null;
        GauceDataSet[] dSet = new GauceDataSet[2];
        DMbo603DAO dao      = null; 
        
        String strGoTo = form.getParam("goTo");
        
        try {
            
            dao    = new DMbo603DAO();
            helper = new GauceHelper2(request, response, form);
            
            dSet[0] = helper.getDataSet("DS_O_CUST");
            dSet[1] = helper.getDataSet("DS_O_MASTER");
            
            helper.setDataSetHeader(dSet[0], "H_CUST");
            helper.setDataSetHeader(dSet[1], "H_MASTER");
            
            String CUST_ID = "";
            String CARD_NO = "";
            
            HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
            
            form = Util.setParam(form, "BRCH_ID", sessionInfo.getBRCH_ID()) ;
            List custList = dao.select1(form, dSet[0]);
            
            for (int j = 0; j < custList.size(); j++) {
                List tmplist = (List) custList.get(j);
                
                CUST_ID = tmplist.get(dSet[0].indexOfColumn("CUST_ID")).toString();
                //CARD_NO = new Util().decryptedStr(tmplist.get(dSet[0].indexOfColumn("CARD_NO")).toString());
                
                String HOME_PH1 = tmplist.get(dSet[0].indexOfColumn("HOME_PH1")).toString(); //HOME_PH1
                String HOME_PH2 = tmplist.get(dSet[0].indexOfColumn("HOME_PH2")).toString(); //HOME_PH2
                String HOME_PH3 = tmplist.get(dSet[0].indexOfColumn("HOME_PH3")).toString(); //HOME_PH3
                
                String MOBILE_PH1 = tmplist.get(dSet[0].indexOfColumn("MOBILE_PH1")).toString(); //MOBILE_PH1
                String MOBILE_PH2 = tmplist.get(dSet[0].indexOfColumn("MOBILE_PH2")).toString(); //MOBILE_PH2
                String MOBILE_PH3 = tmplist.get(dSet[0].indexOfColumn("MOBILE_PH3")).toString(); //MOBILE_PH3
                
                String EMAIL1 = tmplist.get(dSet[0].indexOfColumn("EMAIL1")).toString(); //EMAIL1
                String EMAIL2 = tmplist.get(dSet[0].indexOfColumn("EMAIL2")).toString(); //EMAIL2
                
                if (HOME_PH1.length() > 0 || HOME_PH2.length() > 0 || HOME_PH3.length() > 0) {
                    tmplist.set(dSet[0].indexOfColumn("HOME_PH1"), HOME_PH1 + " - " + HOME_PH2 + " - " + HOME_PH3); //HOME_PH1
                }
                if (MOBILE_PH1.length() > 0 || MOBILE_PH2.length() > 0 || MOBILE_PH3.length() > 0) {
                    tmplist.set(dSet[0].indexOfColumn("MOBILE_PH1"), MOBILE_PH1 + " - " + MOBILE_PH2 + " - " + MOBILE_PH3); //MOBILE_PH1
                }
                if (EMAIL1.length() > 0 || EMAIL2.length() > 0) {
                    tmplist.set(dSet[0].indexOfColumn("EMAIL1"), EMAIL1 + "@" + EMAIL2 ); //EMAIL1
                }
                custList.set(j, tmplist);
            }
            
            form = Util.setParam(form, "CUST_ID", (0 == custList.size() ? "X" : CUST_ID)) ;
            form = Util.setParam(form, "CARD_NO", CARD_NO) ;
            
            
            List sub  = dao.select5(form);
            
            StringBuffer sb = new StringBuffer();
            sb.append("");
            String comma = "";
            for (int i = 0 ; i < sub.size(); i++) {
                List tmplist = (List) sub.get(i);
                sb.append(comma + "'" + tmplist.get(0).toString() + "'");
                comma = ",";
            }
            
            String MBSH_NO_IN = " AND B.MBSH_NO IN (" + ("".equals(sb.toString()) ? " 'X' " : sb.toString()) + ") "; 
            List masterList  = dao.select2(form, dSet[1], MBSH_NO_IN);
            
            helper.setListToDataset(custList,    dSet[0]);
            helper.setListToDataset(masterList,  dSet[1]);

        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        
        return mapping.findForward(strGoTo);
    }
    
    /**
     * 영수증적립내역조회 2
     * 
     */
    public ActionForward searchDetail(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
        GauceHelper2 helper = null;
        GauceDataSet[] dSet = new GauceDataSet[2];
        DMbo603DAO dao      = null; 
        
        String strGoTo = form.getParam("goTo");
        
        try {
            
            dao    = new DMbo603DAO();
            helper = new GauceHelper2(request, response, form);
            
            dSet[0] = helper.getDataSet("DS_O_DETAIL");
            dSet[1] = helper.getDataSet("DS_O_DETAIL2");

            helper.setDataSetHeader(dSet[0], "H_DETAIL");
            helper.setDataSetHeader(dSet[1], "H_DETAIL2");
            
            HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
            
            form = Util.setParam(form, "BRCH_ID", sessionInfo.getBRCH_ID()) ;
            
            List detailList  = dao.select3(form, dSet[0]);
            List detail2List = dao.select4(form, dSet[1]);
            
            helper.setListToDataset(detailList,  dSet[0]);
            helper.setListToDataset(detail2List, dSet[1]);

        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        
        return mapping.findForward(strGoTo);
    }
	

}
