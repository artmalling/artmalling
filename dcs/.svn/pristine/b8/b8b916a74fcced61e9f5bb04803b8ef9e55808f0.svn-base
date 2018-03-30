/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dmbo.action;

import java.text.SimpleDateFormat;
import java.util.Calendar;
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

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;
import common.util.Util;
import common.vo.SessionInfo;

import dcom.socket.dClientDept;
import dmbo.dao.DMbo613DAO;

/**
 * <p></p>
 * 
 * @created  on 1.0, 2010/03/08
 * @created  by 장형욱(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMbo613Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DMbo613Action.class);

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
			//System.out.println(session.getAttribute("sessionInfo").getClass().getCanonicalName());
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
     * <p>포인트 강제 적립/차감 정보를 조회한다</p>
     * 
     */
    
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DMbo613DAO      dao     = null;

        String strGoTo = form.getParam("goTo"); // 분기할곳
         
        try {     
            dao    = new DMbo613DAO();
            helper = new GauceHelper2(request, response, form);
            dSet   = helper.getDataSet("DS_IO_MASTER");
            helper.setDataSetHeader(dSet, "H_MASTER");
            
            list   = dao.searchMaster(form, request);
            helper.setListToDataset(list, dSet);

        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        return mapping.findForward(strGoTo);
    }   
    
    public ActionForward searchDetail(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List         list   = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DMbo613DAO   dao    = null; 

        String strGoTo = form.getParam("goTo"); // 분기할곳

        try {
            dao    = new DMbo613DAO();
            helper = new GauceHelper2(request, response, form);
            dSet   = helper.getDataSet("DS_IO_DETAIL");
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
     * <p>포인트 강제 적립/차감 등록</p>
     * 
     */
    public ActionForward saveData(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
    	
        GauceHelper2 helper = null;
        GauceDataSet dSet = null;
        DMbo613DAO dao = null;
        dClientDept client = null;
        Util util = new Util();
        
        int ret = 0;
        int result = 0;
        String rtnMsg  = "";
        HttpSession session = request.getSession();
        String userId = null;
        String strGoTo = form.getParam("goTo"); // 분기할곳
        
        String[] rMsg = new String[60];
        String[] arrData = new String[60];
        try {
            SessionInfo sessionInfo = (SessionInfo) session
                    .getAttribute("sessionInfo");
            userId = sessionInfo.getUSER_ID();
            helper = new GauceHelper2(request, response, form);
            dSet = helper.getDataSet("DS_IO_MASTER");
            helper.setDataSetHeader(dSet, "H_MASTER");
            MultiInput mi = helper.getMutiInput(dSet);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            Calendar cal = Calendar.getInstance();
            String time = sdf.format(cal.getTime());
            System.out.println("1:"+ time);
            while (mi.next()) {
            	 
    	        arrData[0]  = "0621";                                         //	MSG_LEN	        N	 4
                if ("A".equals(mi.getString("PROC_FLAG"))) {
    	            arrData[1]  = "DEPTRN0213";                               //	MSG_TEXT	    C	10
                    arrData[3]  = "200020";  
                } else {
                	arrData[1]  = "DEPTRN0214";
                	arrData[3]  = "200030";  
                }
    	        //arrData[3]  = "200020";	                                  //	TRADE_CD	    N	 6
    	        arrData[4]  = time.substring(0,8);                            //    SALE_DT         N    8
    	        arrData[5]  = time.substring(8,14);                           //    SALE_TM         N    6
    	        arrData[7] = userId;	                                      //	REG_ID	        N	10
    	        arrData[8] = "C";	                                          //	IN_FLAG	        N	 1
    	        arrData[9]  = mi.getString("CARD_NO");     //	CARD_NO	        N	64
    	        arrData[11] = mi.getString("BRCH_ID");                        //	BRCH_ID	        N	10
    	        arrData[44] = mi.getString("CUST_NAME");                      //	CUST_NM	        C	40
    	        arrData[12] = "40";                                           //    TYPE1_CD        C    2
    	        arrData[14] = mi.getString("POINT");                          //    TYPE1_AMT       N    9
    	        arrData[36] = "1";                                            //    TYPE_CNT        N    2
    	        arrData[37] = mi.getString("POINT");	                      //	TRADE_AMT	    N	10
    	        arrData[41] = "31";//mi.getString("REASON_CD");	              //	ADD_USE_FLAG    C    2
    	         
                //***2. 전문송신
                //송신후에 결과값 처리..
    			//client = new dClientDept();
    	     	dao = new DMbo613DAO();
    	     	
    			result = dao.sendData(arrData);
    		    System.out.println(" result " + result);
    		    System.out.println(" rMsg " + rMsg[42]);
    		    
    		    //if ( "0000".equals(rMsg[42])) {
    		    if ( result == 0) {
    		    	dao = new DMbo613DAO();
    		    	
    		    	String USER_ID[] = {userId};
    		    	String PROC_DT[] = {mi.getString("PROC_DT")};
    		    	String BRCH_ID[] = {mi.getString("BRCH_ID")};
    		    	String CARD_NO[] = {mi.getString("CARD_NO")};
    		    	String SEQ_NO[]  = {mi.getString("SEQ_NO")};
    		    	
    		    	form.setParam("USER_ID", USER_ID);
    		    	form.setParam("PROC_DT", PROC_DT);
    		    	form.setParam("BRCH_ID", BRCH_ID);
    		    	form.setParam("CARD_NO", CARD_NO);
    		    	form.setParam("SEQ_NO",  SEQ_NO);
                    
    		    	ret += dao.saveData(form, dSet, request, mi);
    		    	System.out.println("saveData Action" + ret);
    		    } else {
    		    	rtnMsg = "포인트강제적립차감승인에 실패하였습니다.<br>";
    		    	helper.close(rtnMsg + " 에러코드 [9999]");
    		    	return mapping.findForward(strGoTo);
    		    }
            }
        } catch (Exception e) {
        	e.printStackTrace();
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            // 등록, 수정의 경우 아래의 메시지를 사용            
        	if (result < 0)
        	    helper.close("시스템 장애가 발생하였습니다. 에러코드 [9999]");
        	else if (result == 0)
                helper.close(ret + "건 처리되었습니다");
        }
        return mapping.findForward(strGoTo);
    }    
}
