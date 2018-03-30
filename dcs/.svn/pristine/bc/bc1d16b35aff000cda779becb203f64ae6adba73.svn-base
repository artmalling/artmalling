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
import dmbo.dao.DMbo609DAO;
/**
 * <p>포인트 양도 등록</p>
 * 
 * @created  on 1.0, 2010.03.21
 * @created  by jinjung.kim
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMbo609Action extends DispatchAction {
    /*
    * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
    private Logger logger = Logger.getLogger(DMbo609Action.class);

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
     * <p>포인트 양도 등록 조회.</p>
     * 
     */
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        HttpSession session = request.getSession();
        SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
        
        GauceHelper2 helper = null;
        GauceDataSet[] dSet = new GauceDataSet[2];
        DMbo609DAO   dao    = null; 
        
        String strGoTo = form.getParam("goTo");
        
        String[] brchId =  {sessionInfo.getBRCH_ID()};
        form.setParam("BRCH_ID", brchId);

        try {
             
            dao    = new DMbo609DAO();
            helper = new GauceHelper2(request, response, form);
            
            dSet[0] = helper.getDataSet("DS_O_CUST");
            dSet[1] = helper.getDataSet("DS_IO_MASTER");
            
            helper.setDataSetHeader(dSet[0], "H_CUST");
            helper.setDataSetHeader(dSet[1], "H_MASTER");
           
            List cust = dao.searchCust(form);
             
            String CUST_ID = "";
            if (cust.size() > 0) {
                CUST_ID = (String) ((List)cust.get(0)).get(0);
            }
            
            String[] CUST_IDs =  { CUST_ID };
            form.setParam("CUST_ID", CUST_IDs);
            
            List list = dao.searchMaster(form);
            
            helper.setListToDataset(cust, dSet[0]);
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
     * <p>포인트 양도 등록 저장</p>
     * 
     */
    public ActionForward saveData(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        HttpSession session = request.getSession();
        SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
        
        GauceHelper2 helper = null;
        DMbo609DAO dao      = null;
        GauceDataSet dSet   = null;
        
        String rtnCode = "";
        String rtnMsg  = "";
        String rtnMsg2 = "";
        
        int result = 0;
        
        Util util = new Util();
        
        String strGoTo = form.getParam("goTo"); // 분기할곳
        
        dao = new DMbo609DAO();
        
        final String MSG_LEN 		= "0621";
        final int	 MSG_ARR_LEN 	= 60;
        try {
            
            helper = new GauceHelper2(request, response, form);
            
            dSet = helper.getDataSet("DS_IO_MASTER");
            helper.setDataSetHeader(dSet, "H_MASTER");
            
            MultiInput mi = helper.getMutiInput(dSet);
            
            mi.initNext();
            
            String USER_ID = sessionInfo.getUSER_ID();
            String BRCH_ID = sessionInfo.getBRCH_ID();
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            Calendar cal = Calendar.getInstance();
            String time = sdf.format(cal.getTime());
            
            int REPLY_CD_POS = 42;
            
            for (int i = 0 ; i < mi.getRowNum(); i++) {
                
                mi.next();
                
                //선택
                String CHK             = mi.getString("CHK");
                
                //양도자 정보
                String GRANTOR_NM      = mi.getString("GRANTOR_NM");
                //String GRANTOR_CARD_NO = util.encryptedStr(mi.getString("GRANTOR_CARD_NO"));
                String GRANTOR_CARD_NO = mi.getString("GRANTOR_CARD_NO");
                String GRANTOR_PWD_NO  = util.encryptedPasswd(mi.getString("PWD_NO"));
                
                //양수자 정보
                String GRANTEE_NM      = mi.getString("CUST_NM");
                //String GRANTEE_CARD_NO = util.encryptedStr(mi.getString("CARD_NO"));
                String GRANTEE_CARD_NO = mi.getString("CARD_NO");
                
                mi.setString("GRANTOR_CARD_NO", GRANTOR_CARD_NO);
                mi.setString("CARD_NO",         GRANTEE_CARD_NO);
                mi.setString("USER_ID",         USER_ID);
                
                //양도 포인트
                int MOVE_POINT      = mi.getInt("MOVE_POINT");
                
                if (!"T".equals(CHK) || GRANTOR_PWD_NO.length() <= 0 || MOVE_POINT <= 0) continue;
                

                //양도
                
                String[] outputArr = new String[MSG_ARR_LEN];
                String[] inputArr  = new String[MSG_ARR_LEN];
                
                //양수
                String[] outputArr2 = new String[MSG_ARR_LEN];
                String[] inputArr2  = new String[MSG_ARR_LEN];
                
                /**
                 * 1. 포인트 양도 전문
                 */
                inputArr[0]  = MSG_LEN;                      // MSG_LEN         N    4
                inputArr[1]  = "DEPTRN0215";                 // MSG_TEXT        C   10
                inputArr[3]  = "200030";                     // TRADE_GB_CD     N    6
                inputArr[4]  = time.substring(0,8);          // SALE_DT         N    8
                inputArr[5]  = time.substring(8,14);         // SALE_TM         N    6
                inputArr[7]  = USER_ID;                      // REG_ID          N   10
                inputArr[8]  = "C";                          // IN_FLAG         N    1
                inputArr[9]  = GRANTOR_CARD_NO;              // CARD_NO         N   64
                //inputArr[10] = "0000";               // PASSWD          C   4 
                inputArr[10] = util.encryptedPasswd(mi.getString("PWD_NO"));               // PASSWD          C   4 
                inputArr[11] = BRCH_ID;                      // BRCH_ID         N   10
                inputArr[12] = "40";                         // TYPE1_CD        C    2
                inputArr[14] = String.valueOf(MOVE_POINT);   // TYPE1_AMT       N    9
                inputArr[36] = "1";                          // TYPE_CNT        N    2
                inputArr[37] = String.valueOf(MOVE_POINT);   // TRADE_AMT       N   10
                inputArr[41] = "51";                         // ADD_USE_FLAG    C    2
                inputArr[44] = GRANTOR_NM;                   // CUST_NM         C   40 
                
                result = dao.sendData(inputArr, "GRANTOR");   //포인트 양도
                //logger.info("REPLY_CD:["+REPLY_CD_POS +"]:"+ outputArr[REPLY_CD_POS]);
                System.out.println("result"+ result);
                //포인트 양도 에러
                if (result < 0) 
                {
                    helper.close("양도 전문 전송시 장애가 발생하였습니다. 에러코드 [9999]");
                    break;
                } 
                else
                { 
                    /**
                     * 2. 포인트 양수 전문
                     */
                    inputArr2[0]  = MSG_LEN;                      // MSG_LEN         N    4
                    inputArr2[1]  = "DEPTRN0216";                 // MSG_TEXT        C   10
                    inputArr2[3]  = "200020";                     // TRADE_GB_CD     N    6
                    inputArr2[4]  = time.substring(0,8);          // SALE_DT         N    8
                    inputArr2[5]  = time.substring(8,14);         // SALE_TM         N    6
                    inputArr2[7]  = USER_ID;                      // REG_ID          N   10
                    inputArr2[8]  = "C";                          // IN_FLAG         N    1
                    inputArr2[9]  = GRANTEE_CARD_NO;              // CARD_NO         N   64
                    inputArr2[11] = BRCH_ID;                      // BRCH_ID         N   10
                    inputArr2[12] = "40";                         // TYPE1_CD        C    2
                    inputArr2[14] = String.valueOf(MOVE_POINT);   // TYPE1_AMT       N    9
                    inputArr2[36] = "1";                          // TYPE_CNT        N    2
                    inputArr2[37] = String.valueOf(MOVE_POINT);   // TRADE_AMT       N   10
                    inputArr2[41] = "51";                         // ADD_USE_FLAG    C    2
                    inputArr2[44] = GRANTEE_NM;                   // CUST_NM         C   40
                      
                    result = dao.sendData(inputArr2, "GRANTEE");   //포인트 양수
                     
                    //포인트 양수 에러
                    if (result < 0) //error
                    {
                        inputArr[3] = "300050";
                        result = dao.sendData(inputArr, "GRANTOR");   //포인트 양도 취소
                        
                        if (result == 0) {
                            rtnMsg = "양도취소 처리되었습니다.";
                        } 
                        if ("".equals(rtnMsg)) {
                            helper.close("양수 전문 전송시 장애가 발생하였으나, 양도취소에 실패하였습니다. 에러코드 [9999]");
                        } else {
                            helper.close("양수 전문 전송시 장애가 발생하여, 양도취소 처리되었습니다. 에러코드 [9999]");
                        }
                        break;
                    } 
                    else 
                    {
                        /**
                         * 3. 양도이력등록
                         */
                        rtnCode = dao.saveData(form, mi, request);
                        //양도이력 등록 에러
                        if ("9999".equals(rtnCode)) 
                        { 
                            rtnMsg  = "";
                            rtnMsg2 = "";
                            
                            inputArr[3] = "300050"; 
                            result = dao.sendData(inputArr, "GRANTOR");   //포인트 양도 취소
                            
                            if (result == 0) {
                                rtnMsg = "양도취소 처리되었습니다";
                            } 
                            
                            inputArr2[3] = "300040";
                            result = dao.sendData(inputArr, "GRANTEE");   //포인트 양수 취소
                            
                            if (result == 0) {
                                rtnMsg2 = "양수취소 처리되었습니다";
                            } 
                            if (!"".equals(rtnMsg) && !"".equals(rtnMsg2)) {
                                helper.close("시스템 장애가 발생하였습니다. 에러코드 [9999]");
                            } else if ("".equals(rtnMsg)) {
                                helper.close("시스템 장애가 발생하였으나 양도/양수 취소에 실패하였습니다. 에러코드 [9999]");
                            } else if ("".equals(rtnMsg2)) {
                                helper.close("시스템 장애가 발생하였으나 양수취소에 실패하였습니다. 에러코드 [9999]");
                            }
                        }
                    }
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("[updateProgram]", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            if(rtnCode.equals("9999")){
                helper.close("시스템 장애가 발생하였습니다. 에러코드 [9999]");
            }else{
                helper.close("정상적으로 처리 되었습니다.");
            }
        }
        
        return mapping.findForward(strGoTo);
    }   

}
