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
import dcom.socket.dClientRest;
import dmbo.dao.DMbo615DAO;
/**
 * <p>포인트승인테스트</p>
 * 
 * @created  on 1.0, 2010/04/05
 * @created  by jinjung.kim
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMbo615Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DMbo614Action.class);

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
     * <p>포인트승인테스트 조회</p>
     * 
     */
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
        GauceHelper2 helper = null;
        GauceDataSet[] dSet   = new GauceDataSet[3];
        DMbo615DAO   dao    = null; 
        
        HttpSession session = request.getSession();
        SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
        
        String BRCH_ID = sessionInfo.getBRCH_ID();
        String USER_ID = sessionInfo.getUSER_ID();
        
        try {
            
            dao    = new DMbo615DAO();
            helper = new GauceHelper2(request, response, form);
            
            dSet[0]   = helper.getDataSet("DS_IO_MASTER");
            helper.setDataSetHeader(dSet[0], "H_MASTER");
            String[] sqlId = {"SEL_MASTER"};
            form.setParam("sqlId", sqlId);
            List list = dao.searchMaster(form);
            
            //현재시간;
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            String time = sdf.format(Calendar.getInstance().getTime());
            
            for (int i = 0; i < list.size(); i++) {
                List tmplist = (List) list.get(i);
                
                String value = tmplist.get(dSet[0].indexOfColumn("GBN")).toString(); 
                if ("MSG_LEN".equals(value)) {
                    tmplist.set(dSet[0].indexOfColumn("INPUT"), "0731");
                }
                if ("REG_ID".equals(value)) {
                    tmplist.set(dSet[0].indexOfColumn("INPUT"), USER_ID);
                }
                if ("BRCH_ID".equals(value)) {
                    tmplist.set(dSet[0].indexOfColumn("INPUT"), BRCH_ID);
                }
                if ("SALE_DT".equals(value)) {
                    tmplist.set(dSet[0].indexOfColumn("INPUT"), time.substring(0,8));
                }
                if ("SALE_TM".equals(value)) {
                    tmplist.set(dSet[0].indexOfColumn("INPUT"), time.substring(8,14));
                }
                list.set(i, tmplist);
            }
            
            
            dSet[1]   = helper.getDataSet("DS_IO_MASTER2");
            helper.setDataSetHeader(dSet[1], "H_MASTER");
            String[] sqlId2 = {"SEL_MASTER2"};
            form.setParam("sqlId", sqlId2);
            List list2 = dao.searchMaster(form);
            
            for (int i = 0; i < list2.size(); i++) {
                List tmplist = (List) list2.get(i);
                
                String value = tmplist.get(dSet[1].indexOfColumn("GBN")).toString(); 
                if ("MSG_LEN".equals(value)) {
                    tmplist.set(dSet[1].indexOfColumn("INPUT"), "0267");
                }
                if ("REG_ID".equals(value)) {
                    tmplist.set(dSet[1].indexOfColumn("INPUT"), USER_ID);
                }
                if ("BRCH_ID".equals(value)) {
                    tmplist.set(dSet[1].indexOfColumn("INPUT"), BRCH_ID);
                }
                if ("SALE_DT".equals(value)) {
                    tmplist.set(dSet[0].indexOfColumn("INPUT"), time.substring(0,8));
                }
                if ("SALE_TM".equals(value)) {
                    tmplist.set(dSet[0].indexOfColumn("INPUT"), time.substring(8,14));
                }
                list2.set(i, tmplist);
            }
            
            dSet[2]   = helper.getDataSet("DS_IO_MASTER3");
            helper.setDataSetHeader(dSet[2], "H_MASTER");
            String[] sqlId3 = {"SEL_MASTER3"};
            form.setParam("sqlId", sqlId3);
            List list3 = dao.searchMaster(form);
            
            for (int i = 0; i < list3.size(); i++) {
                List tmplist = (List) list3.get(i);
                
                String value = tmplist.get(dSet[2].indexOfColumn("GBN")).toString(); 
                if ("MSG_LEN".equals(value)) {
                    tmplist.set(dSet[2].indexOfColumn("INPUT"), "0264");
                }
                if ("REG_ID".equals(value)) {
                    tmplist.set(dSet[2].indexOfColumn("INPUT"), USER_ID);
                }
                if ("BRCH_ID".equals(value)) {
                    tmplist.set(dSet[2].indexOfColumn("INPUT"), BRCH_ID);
                }
                if ("SALE_DT".equals(value)) {
                    tmplist.set(dSet[0].indexOfColumn("INPUT"), time.substring(0,8));
                }
                if ("SALE_TM".equals(value)) {
                    tmplist.set(dSet[0].indexOfColumn("INPUT"), time.substring(8,14));
                }
                list3.set(i, tmplist);
            }
            
            helper.setListToDataset(list, dSet[0]);
            helper.setListToDataset(list2, dSet[1]);
            helper.setListToDataset(list3, dSet[2]);


        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        
        return mapping.findForward(form.getParam("goTo"));
    }

	/**
     * <p>포인트승인테스트</p>
     * 
     */
    public ActionForward saveData(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        HttpSession session = request.getSession();
        SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
        
        GauceHelper2 helper = null;
        
        String REPLY_CD = "";
        String rtnMsg  = "";
        
        String BRCH_ID = sessionInfo.getBRCH_ID();
        String USER_ID = sessionInfo.getUSER_ID();
        
        try {
            
            helper = new GauceHelper2(request, response, form);
            
            int REPLY_CD_POS = 0;
            String[] inputArr  = null;
            String[] outputArr = null;
            
            Util util = new Util();
            
            if ("A".equals(form.getParam("GBN"))) 
            {
                GauceDataSet dSet = helper.getDataSet("DS_IO_MASTER");
                helper.setDataSetHeader(dSet, "H_MASTER");
                MultiInput input1 = helper.getMutiInput(dSet);
                
                REPLY_CD_POS = 58;

                dClientDept client = new dClientDept();
                
                inputArr  = new String[63];
                outputArr = new String[63];
                
                input1.initNext();
                
                for (int i = 0; i < input1.getRowNum(); i++) {
                    input1.next();
                    String input = input1.getString("INPUT") ;
                    if (i == 12 || i == 13) {
                        input = util.encryptedStr(input);
                    } else if (i == 16) {
                        if (null != input && input.length() > 0) {
                            input = util.encryptedPasswd(input);
                        }
                    }
                    inputArr[i] = input;
                }
                
                inputArr[10] = USER_ID;
                inputArr[15] = BRCH_ID;
                
                outputArr = client.sendData(inputArr);
            }            
            else if ("C".equals(form.getParam("GBN"))) 
            {
                GauceDataSet dSet = helper.getDataSet("DS_IO_MASTER3");
                helper.setDataSetHeader(dSet, "H_MASTER");
                MultiInput input1 = helper.getMutiInput(dSet);
                
                REPLY_CD_POS = 17;

                dClientRest client = new dClientRest();
                
                inputArr  = new String[20];
                outputArr = new String[20];
                
                input1.initNext();
                
                for (int i = 0; i < input1.getRowNum(); i++) {
                    input1.next();
                    String input = input1.getString("INPUT") ;
                    if (i == 7) {
                        input = util.encryptedStr(input);
                    } else if (i == 9) {
                        if (null != input && input.length() > 0) {
                            input = util.encryptedPasswd(input);
                        }
                    }
                    inputArr[i] = input;
                }
                
                inputArr[6] = USER_ID;
                inputArr[8] = BRCH_ID;
                
                outputArr = client.sendData(inputArr);
            }
           
            REPLY_CD = outputArr[REPLY_CD_POS].trim();
            
            if (!"0000".equals(REPLY_CD)) {
                REPLY_CD = "9999";
                rtnMsg = " 전문전송에 실패하였습니다.<br>";
                helper.close(rtnMsg + " 에러코드 [9999]");
            } 
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("[updateProgram]", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            if(REPLY_CD.equals("9999")){
                helper.close (rtnMsg + " 에러코드 [9999]");
            }else{
                helper.close("정상적으로 처리 되었습니다.");
            }
        }
        
        return mapping.findForward(form.getParam("goTo"));
    }   
}
