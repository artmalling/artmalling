/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dctm.action;

import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import common.util.Util;
import common.vo.SessionInfo;

import dctm.dao.DCtm102DAO;
import dctm.dao.DCtm103DAO;
/**
 * <p>기명개인회원가입신청서등록/수정</p>
 * 
 * @created  on 1.0, 2010/01/31
 * @created  by 남형석(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */ 

public class DCtm103Action extends DispatchAction {
    /**
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
    private Logger logger = Logger.getLogger(DCtm103Action.class);

    /**
     * <p>메뉴를 보여준다.</p>
     * 
     */
    public ActionForward list(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception { 
    	
    	String strGoTo = form.getParam("goTo"); // 분기할곳
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

        return mapping.findForward(strGoTo);
    }
    
    /**
     * <p>회원 정보를 등록한다.</p>
     * 
     */
    public ActionForward saveData(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
        GauceHelper2 helper = null;
        GauceDataSet dSet   = null;
        DCtm103DAO   dao    = null;
        String       ret    = "";
        String strGoTo = form.getParam("goTo"); // 분기할곳
        try {
        	
            helper = new GauceHelper2(request, response, form);
            
            dSet = helper.getDataSet("DS_IO_CUST");
            helper.setDataSetHeader(dSet, "H_CUSTINFO2");
            MultiInput mi = helper.getMutiInput(dSet);
            dao = new DCtm103DAO();
            dao.addrCls(form, mi, request, response);
            dSet = dao.saveData2(form, mi, dSet, request, response);  
            ret  = mi.getString("CUST_ID") + "|" 
                 + mi.getString("HHOLD_ID")+ "|" 
                 + mi.getString("CARD_NO");
            
            
            /*
             * 신규 회원가입시 SMS수신동의여부  
             * 작성일 : 2015.04.23
             * 작성자 : 전주원
             */
            /*
            System.out.println("111111111111111111111111111 수신동의여부 SMS 발송 111111111111111111111111111");
            
            Map<String, String> data = new HashMap<String, String>();
            String mem_phone = mi.getString("MOBILE_PH1") + "" + mi.getString("MOBILE_PH2") + mi.getString("MOBILE_PH3");
            
            data.put("enc_type", "UTF-8");
            data.put("user_id", "mario1");
            data.put("mem_id", mem_phone);
            data.put("mem_name", mem_phone);
            data.put("mem_phone", mem_phone);
            data.put("M1", Util.formatDate(new Date(), "yyyy-MM-dd"));
            data.put("M2", "");
            data.put("M3", "");
            
            String[] strSendSite = {"001"};
            String[] strSendType = {""};
            String[] strCustName = {mi.getString("CUST_NAME")};
            String[] strCustId = {mi.getString("CUST_ID")};
            String[] strCellPhoneService = {""};
            String[] strMobilePh1 = {mi.getString("MOBILE_PH1")};
            String[] strMobilePh2 = {mi.getString("MOBILE_PH2")};
            String[] strMobilePh3 = {mi.getString("MOBILE_PH3")};
            String[] strSMSMsg = {""};
            
            
            if ("Y".equalsIgnoreCase(mi.getString("SMS_YN"))) {
            	// 수신동의
            	data.put("mail_code", "S0248");
            	data.put("auth_key", "H5R0FJ-EKU0PO-0124MI-RESYCS");
            	
            	strSendType[0] = "002"; // 수신동의
            	strSMSMsg[0] = URLEncoder.encode("[형지 아트몰링] 귀하가 "+Util.formatDate(new Date(), "yyyy-MM-dd") +" 일에 요청하신 수신동의가 정상적으로 처리되었습니다.", "UTF-8") ;
            } else {
            	// 수신거부
            	data.put("mail_code", "S0249");
            	data.put("auth_key", "U7H1GA-23HAKM-8PMM29-7CJ3KB");
            	
            	strSendType[0] = "003"; // 수신거부
            	strSMSMsg[0] = URLEncoder.encode("[형지 아트몰링] 귀하가 "+Util.formatDate(new Date(), "yyyy-MM-dd")+" 일에 요청하신 수신거부가 정상적으로 처리되었습니다", "UTF-8") ;
            }
            
            DCtm102DAO smsDao  = new DCtm102DAO();
            smsDao.sendSMS(data, "postman.co.kr", "/open/auto_message_sender.jsp", "UTF-8");
            
            System.out.println("2222222222222222222222222 SMS 발송 로그등록 222222222222222222222222222");
            
            form.setParam("strSendSite",  strSendSite);
            form.setParam("strSendType",  strSendType);
            form.setParam("strCustName",  strCustName);
            form.setParam("strCustId",  strCustId);
            form.setParam("strCellPhoneService",  strCellPhoneService);
            form.setParam("strMobilePh1",  strMobilePh1);
            form.setParam("strMobilePh2",  strMobilePh2);
            form.setParam("strMobilePh3",  strMobilePh3);
            form.setParam("strSMSMsg",  strSMSMsg);
            
            smsDao.insRealMobile(form, request);
            
            System.out.println("222222222222222222222222222222222222222222222222222222222222222222");
            */

        } catch (Exception e) {
            e.printStackTrace();
            logger.error("[updateProgram]", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            //helper.close(dSet, ret + "건 변경 되었습니다.");
            helper.close(dSet,ret);
        }
    
        return mapping.findForward(strGoTo);
    }    
    
    /**
     * <p>주민번호로 회원번호를 조회 한다.</p>
     * 
     */
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet = null;
        DCtm103DAO dao = null; 

        String strGoTo = form.getParam("goTo"); // 분기할곳
        try {

            dao = new DCtm103DAO();
            helper = new GauceHelper2(request, response, form);
            dSet = helper.getDataSet("DS_IO_CUST");   
            helper.setDataSetHeader(dSet, "H_CUSTINFO");
            list = dao.searchCustinfo(form, request, response);  
            if(list.size()>0){
                helper.setListToDataset(list,  dSet);
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
     * <p>카드정보 팝업을 보여준다.</p>
     * 
     */
    public ActionForward popCard(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception { 
        
        String strGoTo = form.getParam("goTo"); // 분기할곳
        
        String str1 = form.getParam("str1");     // 회원명
        String str2 = form.getParam("str2");     // 주민번호
        String str3 = form.getParam("str3");     // 카드번호
        
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

        return mapping.findForward(strGoTo);
    }    
}
