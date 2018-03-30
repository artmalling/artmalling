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

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import common.vo.SessionInfo;
import dmbo.dao.DMbo642DAO;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>영수증사후적립(일괄)</p>
 * 
 * @created  on 1.0, 2016.12.01
 * @created  by 윤지영
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */ 
public class DMbo642Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DMbo642Action.class);

	/**
	 * <p>영수증 사후적립(일괄) 이동한다.</p>
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
	* 영수증 사후 적립(일괄) 회원정보 조회
	* 
	*/ 
    public ActionForward searchCust(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

		List         list   = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		DMbo642DAO   dao    = null;  

        try { 
            dao    = new DMbo642DAO();
            helper = new GauceHelper2(request, response, form);
            
            dSet   = helper.getDataSet("DS_O_CUSTDETAIL");
            helper.setDataSetHeader(dSet, "H_CUST"); 
                             
            //회원정보 조회 { 
            List cust = dao.searchCust(form);
            String strFlag = String2.nvl(form.getParam("strCompFlag"));
            
            for (int j = 0; j < cust.size(); j++) {
                List tmplist = (List) cust.get(j);
                
                String HOME_PH1 = tmplist.get(dSet.indexOfColumn("HOME_PH1")).toString(); //HOME_PH1
                String HOME_PH2 = tmplist.get(dSet.indexOfColumn("HOME_PH2")).toString(); //HOME_PH2
                String HOME_PH3 = tmplist.get(dSet.indexOfColumn("HOME_PH3")).toString(); //HOME_PH3
                
                if(strFlag.equals("C")){
                    HOME_PH1 = tmplist.get(dSet.indexOfColumn("OFFI_PH1")).toString(); //OFFI_PH1
                    HOME_PH2 = tmplist.get(dSet.indexOfColumn("OFFI_PH2")).toString(); //OFFI_PH2
                    HOME_PH3 = tmplist.get(dSet.indexOfColumn("OFFI_PH3")).toString(); //OFFI_PH3
                }
                
                String MOBILE_PH1 = tmplist.get(dSet.indexOfColumn("MOBILE_PH1")).toString(); //MOBILE_PH1
                String MOBILE_PH2 = tmplist.get(dSet.indexOfColumn("MOBILE_PH2")).toString(); //MOBILE_PH2
                String MOBILE_PH3 = tmplist.get(dSet.indexOfColumn("MOBILE_PH3")).toString(); //MOBILE_PH3   
                
                String EMAIL1 = tmplist.get(dSet.indexOfColumn("EMAIL1")).toString(); //EMAIL1
                String EMAIL2 = tmplist.get(dSet.indexOfColumn("EMAIL2")).toString(); //EMAIL2
                
                if (HOME_PH1.length() > 0 || HOME_PH2.length() > 0 || HOME_PH3.length() > 0) {
                    tmplist.set(dSet.indexOfColumn("HOME_PH1"), HOME_PH1 + " - " + HOME_PH2 + " - " + HOME_PH3); //HOME_PH1
                }
                if (MOBILE_PH1.length() > 0 || MOBILE_PH2.length() > 0 || MOBILE_PH3.length() > 0) {
                    tmplist.set(dSet.indexOfColumn("MOBILE_PH1"), MOBILE_PH1 + " - " + MOBILE_PH2 + " - " + MOBILE_PH3); //MOBILE_PH1
                }
                if (EMAIL1.length() > 0 || EMAIL2.length() > 0) {
                    tmplist.set(dSet.indexOfColumn("EMAIL1"), EMAIL1 + "@" + EMAIL2 ); //EMAIL1
                }
               
                cust.set(j, tmplist);
            }
            
            helper.setListToDataset(cust, dSet);
	             

        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        
        return mapping.findForward("searchCust");
    }
    
	/**
	* <p> 영수증내역을 마스터 조회한다.</p>
	* 
	*/      
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DMbo642DAO   dao    = null;  

        try { 
            dao    = new DMbo642DAO();
            helper = new GauceHelper2(request, response, form); 
            
            dSet   = helper.getDataSet("DS_IO_RECPINFO");
            helper.setDataSetHeader(dSet, "H_MASTER");  
            
            list = dao.searchMaster(form);
            helper.setListToDataset(list, dSet);       

        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
        } 
        return mapping.findForward("searchMaster");
    }

	/**
     * <p> 영수증내역을 디테일 조회한다.</p>
     * 
     */      
    public ActionForward searchDetail(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DMbo642DAO   dao    = null;  

        try { 
            dao    = new DMbo642DAO();
            helper = new GauceHelper2(request, response, form);
            
            dSet   = helper.getDataSet("DS_IO_DETAIL");
            helper.setDataSetHeader(dSet, "H_DETAIL");  
            
            String recpNo = String2.nvl(form.getParam("strRecpNo"));
            String brchId = String2.nvl(form.getParam("strBrchId")); 
            
            list = dao.searchDetail(form, recpNo, brchId);
            helper.setListToDataset(list, dSet);       

        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        
        return mapping.findForward("searchDetail");
    }
     
    /**
	* <p>영수증 사후 적립 저장</p>
	* 
	*/
    public ActionForward save(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
            
        GauceHelper2 helper = null;
        GauceDataSet dSet1   = null;
        GauceDataSet dSet2   = null;
        GauceDataSet dSet3   = null;
        DMbo642DAO dao      = null;
        
		HttpSession session = request.getSession();
		String userId       = null;
        int ret             = 0; 
		String strMessage   = "";
		
        try {  
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId   = sessionInfo.getUSER_ID();
			
            helper = new GauceHelper2(request, response, form);
            
            dSet1 = helper.getDataSet("DS_O_CUSTDETAIL");
            helper.setDataSetHeader(dSet1, "H_CUST"); 
            
            dSet2 = helper.getDataSet("DS_IO_MASTER");
            helper.setDataSetHeader(dSet2, "H_MASTER");  
            
            dSet3 = helper.getDataSet("DS_IO_DETAIL");
            helper.setDataSetHeader(dSet3, "H_DETAIL");  
            
            MultiInput [] mi = new MultiInput[3]; 

            mi[0] = helper.getMultiInput(dSet1);
            mi[1] = helper.getMultiInput(dSet2); 
            mi[2] = helper.getMultiInput(dSet3); 
            
            dao    = new DMbo642DAO();  
            
            ret = dao.save(form, mi, userId); 
            
        } catch (Exception e) {                
            logger.error("[updateProgram]", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close("정상적으로 처리 되었습니다.");
        }
        return mapping.findForward("save"); 
    }  

}
