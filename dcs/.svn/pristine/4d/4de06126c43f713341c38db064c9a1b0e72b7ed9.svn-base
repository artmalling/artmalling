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
import kr.fujitsu.ffw.util.String2;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;
import common.util.Util;
import common.vo.SessionInfo;

import dcom.socket.dClientDept;
import dmbo.dao.DMbo621DAO;
/**
 * <p>영수증사후적립(회원등록이전)</p>
 * 
 * @created  on 1.0, 2010.08.25
 * @created  by 김영진
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMbo621Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DMbo621Action.class);

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
	 * 영수증 사후 적립 조회.
	 * 
	 */
	public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
	    
        GauceHelper2 helper = null;
        GauceDataSet[] dSet   = new GauceDataSet[2];
        DMbo621DAO   dao    = null; 
        
        String strGoTo = form.getParam("goTo");
        
        try {
            
            dao    = new DMbo621DAO();
            helper = new GauceHelper2(request, response, form);
            
            dSet[0]   = helper.getDataSet("DS_IO_MASTER");
            dSet[1]   = helper.getDataSet("DS_IO_DETAIL");
            
            helper.setDataSetHeader(dSet[0], "H_MASTER");
            helper.setDataSetHeader(dSet[1], "H_DETAIL");
            
            String recpNo 	= String2.nvl(form.getParam("RECP_NO"));
            String brchId 	= String2.nvl(form.getParam("BRCH_ID"));
            String strCd 	= dao.searchRecpNoStrCd(form, brchId);
            String saleDt 	= "20" + recpNo.substring(1, 7);
            String posNo 	= recpNo.substring(7, 11);
            String tranNo 	= recpNo.substring(11, 16);
            
            List list = dao.searchMaster(form, strCd, saleDt, posNo, tranNo, brchId);
            helper.setListToDataset(list, dSet[0]);
            
            List list2 = dao.searchDetail(form, strCd, saleDt, posNo, tranNo);
            helper.setListToDataset(list2, dSet[1]);

        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        
        return mapping.findForward(strGoTo);
    }

    /**
     * <p>영수증 사후 적립</p>
     * 
     */
    public ActionForward saveData(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
    	final String MSG_LEN 		= "0612";
        final int	 MSG_ARR_LEN 	= 60;
        final int 	 REPLAY_CD_POS 	= 42;
        
        HttpSession session = request.getSession();
        SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
        
        GauceHelper2 helper = null;
        DMbo621DAO dao      = null;
        GauceDataSet[] dSet   = new GauceDataSet[3];
        
        String rtnCode = "";
        String rtnMsg  = "";
        
        Util util = new Util();
        
        String USER_ID = sessionInfo.getUSER_ID();
        //String BRCH_ID = sessionInfo.getBRCH_ID();
        
        //String[] brchId =  {sessionInfo.getBRCH_ID()};
        String[] userId =  {sessionInfo.getUSER_ID()};
        //form.setParam("BRCH_ID", brchId);
        form.setParam("USER_ID", userId);
        
        String strGoTo = form.getParam("goTo"); // 분기할곳
        
        dao = new DMbo621DAO();
        int result = 0;
        try {
            
            helper = new GauceHelper2(request, response, form);
            
            dSet[0] = helper.getDataSet("DS_IO_MASTER");
            dSet[1] = helper.getDataSet("DS_IO_DETAIL");

            helper.setDataSetHeader(dSet[0], "H_MASTER");
            helper.setDataSetHeader(dSet[1], "H_DETAIL");
            
            MultiInput input1 = helper.getMutiInput(dSet[0]);
            MultiInput input2 = helper.getMutiInput(dSet[1]);
            
            input1.initNext(); 
            input2.initNext();
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            Calendar cal = Calendar.getInstance();
            String time = sdf.format(cal.getTime());

            String CARD_NO = String2.nvl(form.getParam("strCardNo")); //회원카드번호
            String CUST_NM = ""; //회원명
             
            input1.next();
            String STR_CD  = input1.getString("STR_CD");
            String SALE_DT = input1.getString("SALE_DT");
            String POS_NO  = input1.getString("POS_NO");
            String TRAN_NO = input1.getString("TRAN_NO");

            /* 영수증번호 = 시설구분 + 매출일자(yyMMdd) + 포스번호 + 거래번호 */
            // 영수증번호 포맷 변경 (2011.08.17)
//          String RECP_NO = STR_CD + SALE_DT + POS_NO + TRAN_NO;
            String RECP_NO = "1" + SALE_DT.substring(2,8) + POS_NO + TRAN_NO;
            
            /**/
            if (dao.searchTrpointCount(form, STR_CD, SALE_DT, POS_NO, TRAN_NO) < 1) {
	            GauceDataSet pSet = helper.getDataSet("DS_I_DATA");            
	            String BRCH_ID = pSet.getDataRow(0).getColumnValue(0).toString();
	            
	            long POINT       	= 0 ;
	            long PAY_AMT_SUM 	= 0;
	            String[] TYPE_CD 	= new String[8];
	            long[] TYPE_AMT 	= new long[8];
	            int TYPE_CNT 		= 0;
	            for (int i = 0 ; i < input2.getRowNum(); i++) {
	                input2.next();
	                if ("PAY_AMT_SUM".equals(input2.getString("COL_ID"))) {
	                    PAY_AMT_SUM  = input2.getLong("COL_VAL"); //거래금액 합계;
	                }
	                if ("PAY_AMT".equals(input2.getString("COL_ID"))) {
	                    if (input2.getLong("COL_VAL2") > 0) {
	                        TYPE_CD[TYPE_CNT] = input2.getString("COL_VAL3");
	                        TYPE_AMT[TYPE_CNT] = input2.getLong("COL_VAL2");
	                        TYPE_CNT++;
	                    }
	                }
	            }
	            for (int i = 0 ; i < TYPE_CD.length; i++) {
	                if (null == TYPE_CD[i]) {
	                    TYPE_CD[i] = "";
	                }
	            }
	            
	            /**
	             * 2. 영수증 포인트 적립 전문
	             */
	            String[] arrData   = new String[MSG_ARR_LEN];
	            String[] outputArr = new String[MSG_ARR_LEN];
	            
	            arrData[ 0]  = MSG_LEN;                      // MSG_LEN         N    4
	            arrData[ 1]  = "DEPTRN0212";                 // MSG_TEXT        C   10
	            arrData[ 3]  = "200020";                     // TRADE_GB_CD     C    6
	            arrData[ 4]  = SALE_DT;                      // SALE_DT         C    8
	            arrData[ 5]  = time.substring(8,14);         // SALE_TM         C    6
	            arrData[ 6] = RECP_NO;                       // RECP_NO         C   20
	            arrData[ 7] = USER_ID;                       // REG_ID          C   10
	            arrData[ 8] = "C";                           // IN_FLAG         C    1
	            arrData[ 9] = CARD_NO;                       // CARD_NO         C   64
	            arrData[11] = BRCH_ID;                       // BRCH_ID         C   10
	            arrData[44] = CUST_NM;                       // CUST_NM         C   40
	            arrData[12] = TYPE_CD[0];                    // TYPE1_CD        C    2
	            arrData[14] = String.valueOf(TYPE_AMT[0]);   // TYPE1_AMT       N    9            
	            arrData[15] = TYPE_CD[1];                    // TYPE2_CD        C    2
	            arrData[17] = String.valueOf(TYPE_AMT[1]);   // TYPE2_AMT       N    9            
	            arrData[18] = TYPE_CD[2];                    // TYPE3_CD        C    2
	            arrData[20] = String.valueOf(TYPE_AMT[2]);   // TYPE3_AMT       N    9            
	            arrData[21] = TYPE_CD[3];                    // TYPE4_CD        C    2
	            arrData[23] = String.valueOf(TYPE_AMT[3]);   // TYPE4_AMT       N    9            
	            arrData[24] = TYPE_CD[4];                    // TYPE5_CD        C    2
	            arrData[26] = String.valueOf(TYPE_AMT[4]);   // TYPE5_AMT       N    9            
	            arrData[27] = TYPE_CD[5];                    // TYPE6_CD        C    2
	            arrData[29] = String.valueOf(TYPE_AMT[5]);   // TYPE6_AMT       N    9            
	            arrData[30] = TYPE_CD[6];                    // TYPE7_CD        C    2
	            arrData[32] = String.valueOf(TYPE_AMT[6]);   // TYPE7_AMT       N    9            
	            arrData[33] = TYPE_CD[7];                    // TYPE8_CD        C    2
	            arrData[35] = String.valueOf(TYPE_AMT[7]);   // TYPE8_AMT       N    9            
	            arrData[36] = String.valueOf(TYPE_CNT);      // TYPE_CNT        N    2            
	            arrData[37] = String.valueOf(PAY_AMT_SUM);   // TRADE_AMT       N   10
	            arrData[41] = "12";                          // ADD_USE_FLAG    C    2
	            arrData[49] = String.valueOf(POINT);         // ADD_POINT       N    9
	            
	            
	            dClientDept client = new dClientDept();
	            outputArr = client.sendData(arrData);  
	            
	            
	            if ("0000".equals(outputArr[REPLAY_CD_POS].trim())) {
	            	result = dao.saveData(form, outputArr, STR_CD);
	            } 
	            else { 
	            	result = -1;
	            	rtnCode = "9999";
	                rtnMsg = "영수증 사후적립 전문전송에 실패하였습니다.<br>";
	                helper.close(rtnMsg + " 에러코드 [9999]");
	            }
            }
            else {
            	result = -1;
            	helper.close("이미 승인처리되었습니다.");
            }
            
            /**/
            if (result >0 ) {
            	helper.close("정상적으로 처리 되었습니다.");
            }
            else {
            	throw new Exception();
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("[updateProgram]", e);
            helper.writeException("GAUCE", "002", e.getMessage());
            helper.close (rtnMsg + " 에러코드 [9999]");
        } 
        
        return mapping.findForward(strGoTo);
    }  

}
