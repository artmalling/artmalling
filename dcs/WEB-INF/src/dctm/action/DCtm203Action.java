/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dctm.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import common.vo.SessionInfo;
import dctm.dao.DCtm203DAO;
import kr.fujitsu.ffw.control.*;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
//import kr.fujitsu.ffw.control.ActionForm;
//import kr.fujitsu.ffw.control.ActionForward;
//import kr.fujitsu.ffw.control.ActionMapping;
//import kr.fujitsu.ffw.control.DispatchAction;
//import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
//import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>개인회원조회/수정 </p>
 * 
 * @created  on 1.0, 2010/03/02
 * @created  by 김영진(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DCtm203Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DCtm203Action.class);
	

    
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
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}

		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p>주민번호 변경팝업</p>
	 * 
	 */
	public ActionForward editSsno(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {

			GauceHelper2.initialize(form, request, response);
			
			HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
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
        DCtm203DAO dao = null; 

        String strGoTo = form.getParam("goTo"); // 분기할곳
        System.out.println("goto : " + strGoTo);
        try {

            dao = new DCtm203DAO();
            System.out.println("new instance DAO");
            helper = new GauceHelper2(request, response, form);
            System.out.println("new instance GauceHelger");
            dSet = helper.getDataSet("DS_IO_CUST");   
            helper.setDataSetHeader(dSet, "H_CUSTINFO");
            System.out.println("start searchCustinfo");
            list = dao.searchCustinfo(form, request, response);  
            if(list.size()>0){
                helper.setListToDataset(list,  dSet);
            }
            System.out.println("end searchCustinfo");
        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
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
        DCtm203DAO   dao    = null;
        String       ret    = "";
        String strGoTo = form.getParam("goTo"); // 분기할곳
        try {
        	
            helper = new GauceHelper2(request, response, form);
            
            dSet = helper.getDataSet("DS_IO_CUST");
            helper.setDataSetHeader(dSet, "H_CUSTINFO2");
            MultiInput mi = helper.getMutiInput(dSet);
            
            dao = new DCtm203DAO();
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
	 * <p>주민번호 변경</p>
	 * 
	 */
    public ActionForward editSsnoPro(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
            GauceHelper2 helper = null;
            GauceDataSet dSet = null;
            DCtm203DAO dao = null;
            ProcedureResultSet prs = null;
            int ret = 0;
            String chk = "";
            String strNm = "";
            String strGoTo = form.getParam("goTo"); // 분기할곳
            
            try {
                helper = new GauceHelper2(request, response, form);
                dSet = helper.getDataSet("DS_I_DATA");                          
                dao = new DCtm203DAO();
                
                String strSsNoFlag  = String2.nvl(form.getParam("strSsNoFlag"));
                
                chk = dao.chkSsNo(form, dSet, request, response);
                if(!chk.equals("Y")){
                    ret = dao.editSsnoPro(form, dSet, request);
                }
                if(strSsNoFlag.equals("2")){
                	strNm = "사업자번호";
                }else{
                    strNm = "주민번호";
                }
            } catch (Exception e) {
                e.printStackTrace();
                logger.error("[updateProgram]", e);
                helper.writeException("GAUCE", "002", e.getMessage());
            } finally {
            	if(chk.equals("Y")){
                    helper.close(dSet, "이미 존재하는 "+strNm+"입니다.|"+chk);
                }else{
                    helper.close("정상적으로 저장 되었습니다.|"+chk);
                }
            }
            return mapping.findForward(strGoTo);
    }     	
	
    /**
	 * <p>회원명 변경팝업</p>
	 * 
	 */
	public ActionForward editCustnm(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 

		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {

			GauceHelper2.initialize(form, request, response);
			
			HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}

		return mapping.findForward(strGoTo);
	}	
	
    /**
	 * <p>회원명 변경</p>
	 * 
	 */
    public ActionForward editCustnmPro(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
            GauceHelper2 helper = null;  
            GauceDataSet dSet = null;
            DCtm203DAO dao = null;
            ProcedureResultSet prs = null;
            int ret = 0;
            String strGoTo = form.getParam("goTo"); // 분기할곳
            try {
                helper = new GauceHelper2(request, response, form);
                dSet = helper.getDataSet("DS_I_DATA");               
                dao = new DCtm203DAO();
                ret = dao.editCustnmPro(form, dSet, request);
                
            } catch (Exception e) {
                e.printStackTrace();
                logger.error("[updateProgram]", e);
                helper.writeException("GAUCE", "002", e.getMessage());
            } finally {
                helper.close("정상적으로 저장 되었습니다.");
            }
            return mapping.findForward(strGoTo);
    }
    
    /**
	 * <p>주소 변경팝업</p>
	 * 
	 */
	public ActionForward editJuso(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 

		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {

			GauceHelper2.initialize(form, request, response);
			
			HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}

		return mapping.findForward(strGoTo);
	}	
	
    /**
	 * <p>주소 변경</p>
	 * 
	 */
    public ActionForward editJusoPro(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
            GauceHelper2 helper = null;  
            GauceDataSet dSet[] = null;
            DCtm203DAO dao = null;
            ProcedureResultSet prs = null;
            int ret = 0;
            String strGoTo = form.getParam("goTo"); // 분기할곳
            
            try {
                helper = new GauceHelper2(request, response, form);
                dSet = new GauceDataSet[2];
    			dSet[0] = helper.getDataSet("DS_HOME_DATA");
                dSet[1] = helper.getDataSet("DS_OFFI_DATA");               
                helper.setDataSetHeader(dSet[0], "H_HOME_JUSO");
                helper.setDataSetHeader(dSet[1], "H_OFFI_JUSO");
                
                MultiInput mi[] = new MultiInput[2];
    			mi[0] = helper.getMutiInput(dSet[0]);
    			mi[1] = helper.getMutiInput(dSet[1]);
    			
                dao = new DCtm203DAO();
                //dao.addrCls(form, mi, request, response);
               	ret = dao.editJuso(form, mi, request);
            } catch (Exception e) {
                e.printStackTrace();
                logger.error("[updateProgram]", e);
                helper.writeException("GAUCE", "002", e.getMessage());
            } finally {
                helper.close("정상적으로 저장 되었습니다.");
            }
            return mapping.findForward(strGoTo);
    }
            
    /**
	 * <p>카드번호 변경팝업</p>
	 * 
	 */
	public ActionForward editCardno(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 

		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {

			GauceHelper2.initialize(form, request, response);
			
			HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}

		return mapping.findForward(strGoTo);
	}	
	
    /**
	* <p>카드번호 변경</p>
	* 
	*/
    public ActionForward editCardnoPro(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
            GauceHelper2 helper = null;  
            GauceDataSet dSet = null;
            DCtm203DAO dao = null;
            ProcedureResultSet prs = null;
            int ret = 0;
            String strGoTo = form.getParam("goTo"); // 분기할곳
            
            try {
                helper = new GauceHelper2(request, response, form);
    			dSet = helper.getDataSet("DS_I_DATA");              
                helper.setDataSetHeader(dSet, "H_CARD_NO"); 
                MultiInput mi = helper.getMutiInput(dSet); 
    			
                dao = new DCtm203DAO(); 
               	ret = dao.editCardno(form, mi, request);
            } catch (Exception e) {
                e.printStackTrace();
                logger.error("[updateProgram]", e);
                helper.writeException("GAUCE", "002", e.getMessage());
            } finally {
                helper.close("정상적으로 저장 되었습니다.");
            }
            return mapping.findForward(strGoTo);
    }
    
    /**
    * <p>카드상태를 체크한다.</p>
    * 
    */
    public ActionForward searchChk_Card(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet = null;
        DCtm203DAO dao = null; 

        String strGoTo = form.getParam("goTo"); // 분기할곳
        try {

            dao = new DCtm203DAO();
            helper = new GauceHelper2(request, response, form);
            dSet = helper.getDataSet("DS_IO_CARD");   
            helper.setDataSetHeader(dSet, "H_CARD");
            list = dao.searchChk_Card(form);  
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
	 * <p>휴대전화 변경팝업</p>
	 * 
	 */
	public ActionForward edit_Telno(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 

		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {

			GauceHelper2.initialize(form, request, response);
			
			HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}

		return mapping.findForward(strGoTo);
	}	
	
    /**
	* <p>휴대전화 변경</p>
	* 
	*/
    public ActionForward editTelnoPro(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        
            GauceHelper2 helper = null;  
            GauceDataSet dSet = null;
            DCtm203DAO dao = null;
            ProcedureResultSet prs = null;
            int ret = 0;
            String strGoTo = form.getParam("goTo"); // 분기할곳
            
            try {
                helper = new GauceHelper2(request, response, form);
    			dSet = helper.getDataSet("DS_I_DATA");              
                helper.setDataSetHeader(dSet, "H_TEL_NO"); 
                MultiInput mi = helper.getMutiInput(dSet); 
    			
                dao = new DCtm203DAO(); 
               	ret = dao.editTelno(form, mi, request);
            } catch (Exception e) {
                e.printStackTrace();
                logger.error("[updateProgram]", e);
                helper.writeException("GAUCE", "002", e.getMessage());
            } finally {
                helper.close("정상적으로 저장 되었습니다.");
            }
            return mapping.findForward(strGoTo);
    }
    
    /**
    * <p>카드등급을 조회한다.</p>
    * 
    */
    public ActionForward searchCard(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List list = null;

        GauceHelper2 helper = null;
        GauceDataSet dSet = null;
        DCtm203DAO dao = null; 

        String strGoTo = form.getParam("goTo"); // 분기할곳
        try {

            dao = new DCtm203DAO();
            helper = new GauceHelper2(request, response, form);
            dSet = helper.getDataSet("DS_IO_CARD");   
            helper.setDataSetHeader(dSet, "H_CARD_GRADE");
            list = dao.searchCard(form);  
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
}
