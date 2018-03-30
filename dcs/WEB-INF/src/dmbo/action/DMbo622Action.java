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
import dmbo.dao.DMbo622DAO;
/**
 * <p>영수증사후적립</p>
 * 
 * @created  on 1.0, 2010.03.23
 * @created  by jinjung.kim
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMbo622Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DMbo622Action.class);

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
        GauceDataSet[] dSet   = new GauceDataSet[3];
        DMbo622DAO   dao    = null; 
        
        String strGoTo = form.getParam("goTo");
        
        try {
            
            dao    = new DMbo622DAO();
            helper = new GauceHelper2(request, response, form);
            
            dSet[0]   = helper.getDataSet("DS_O_CUSTDETAIL");
            dSet[1]   = helper.getDataSet("DS_IO_MASTER");
            dSet[2]   = helper.getDataSet("DS_IO_DETAIL");
            
            helper.setDataSetHeader(dSet[0], "H_CUST");
            helper.setDataSetHeader(dSet[1], "H_MASTER");
            helper.setDataSetHeader(dSet[2], "H_DETAIL");
            
            List cust = dao.searchCust(form,dSet[0]);
            String strFlag = String2.nvl(form.getParam("COMP_PERS_FLAG"));
            for (int j = 0; j < cust.size(); j++) {
                List tmplist = (List) cust.get(j);
                
                String HOME_PH1 = tmplist.get(dSet[0].indexOfColumn("HOME_PH1")).toString(); //HOME_PH1
                String HOME_PH2 = tmplist.get(dSet[0].indexOfColumn("HOME_PH2")).toString(); //HOME_PH2
                String HOME_PH3 = tmplist.get(dSet[0].indexOfColumn("HOME_PH3")).toString(); //HOME_PH3
                
                if(strFlag.equals("C")){
                    HOME_PH1 = tmplist.get(dSet[0].indexOfColumn("OFFI_PH1")).toString(); //OFFI_PH1
                    HOME_PH2 = tmplist.get(dSet[0].indexOfColumn("OFFI_PH2")).toString(); //OFFI_PH2
                    HOME_PH3 = tmplist.get(dSet[0].indexOfColumn("OFFI_PH3")).toString(); //OFFI_PH3
                }
                
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
               
                cust.set(j, tmplist);
            }
            
            helper.setListToDataset(cust, dSet[0]);
            
            String recpNo = String2.nvl(form.getParam("RECP_NO"));
            String brchId = String2.nvl(form.getParam("BRCH_ID"));
            //recpNo = dao.searchRecpNoStrCd(form, brchId) + "20" + recpNo.substring(1, 16); 
            
            System.out.println(" recpNo : " + recpNo); 
            System.out.println(" brchId : " + brchId); 
            
            List list = dao.searchMaster(form, recpNo, brchId);
            helper.setListToDataset(list, dSet[1]);
            
            List list2 = dao.searchDetail(form, recpNo);
            helper.setListToDataset(list2, dSet[2]);

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
    	final String MSG_LEN 		= "0621";
        final int	 MSG_ARR_LEN 	= 60;
        final int 	 REPLAY_CD_POS 	= 42;
        
        HttpSession session = request.getSession();
        SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
        
        GauceHelper2 helper = null;
        DMbo622DAO dao      = null;
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
        
        dao = new DMbo622DAO();
        int result = 0;
        try {
            
            helper = new GauceHelper2(request, response, form);
            
            dSet[0] = helper.getDataSet("DS_O_CUSTDETAIL");
            dSet[1] = helper.getDataSet("DS_IO_MASTER");
            dSet[2] = helper.getDataSet("DS_IO_DETAIL");
            
            helper.setDataSetHeader(dSet[0], "H_CUST");
            helper.setDataSetHeader(dSet[1], "H_MASTER");
            helper.setDataSetHeader(dSet[2], "H_DETAIL");
            
            MultiInput input1 = helper.getMutiInput(dSet[0]);
            MultiInput input2 = helper.getMutiInput(dSet[1]);
            MultiInput input3 = helper.getMutiInput(dSet[2]);
            
            input1.initNext(); 
            input2.initNext();
            input3.initNext();
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            Calendar cal = Calendar.getInstance();
            String time = sdf.format(cal.getTime());
            
            
            
            input1.next();
            String CARD_NO = input1.getString("CARD_NO"); //회원카드번호
            String CUST_NM = input1.getString("CUST_NAME"); //회원명
            String CUST_ID = input1.getString("CUST_ID"); //고객번호
             
            input2.next();
            String STR_CD  = input2.getString("STR_CD");
            String SALE_DT = input2.getString("SALE_DT");
            String POS_NO  = input2.getString("POS_NO");
            String TRAN_NO = input2.getString("TRAN_NO");
            String RECP_NO = "1" + SALE_DT.substring(2, 8) + POS_NO + TRAN_NO + "    ";
            
            System.out.println(RECP_NO);
            //String RECP_NO = STR_CD + SALE_DT + POS_NO + TRAN_NO;           
            
//            String recpNo = String2.nvl(form.getParam("RECP_NO"));
//            String brchId = String2.nvl(form.getParam("BRCH_ID"));
//            System.out.println("RECP_NO:" + recpNo);
//            RECP_NO = dao.searchRecpNoStrCd(form, brchId) + "20" + recpNo.substring(1, 16);
//            System.out.println("RECP_NO:" + RECP_NO);
            String RECP_NO_FULL = STR_CD + SALE_DT + POS_NO + TRAN_NO;
            System.out.println(RECP_NO_FULL);
            
            
            if (dao.searchTrpointCount(form, RECP_NO_FULL) < 1) {
//            	throw new Exception("이미 승인처리되었습니다.");
	            GauceDataSet pSet = helper.getDataSet("DS_I_DATA");            
	            String BRCH_ID = pSet.getDataRow(0).getColumnValue(0).toString();
	            
	            System.out.println("BRCH_ID"+ BRCH_ID);
	            
	            long POINT       	= 0 ;
	            long PAY_AMT_SUM 	= 0;
	            String[] TYPE_CD 	= new String[30];
	            long[] TYPE_AMT 	= new long[30];
	            int TYPE_CNT 		= 0;
	            for (int i = 0 ; i < input3.getRowNum(); i++) {
	                input3.next();
	                System.out.println(i);
	                if ("PAY_AMT_SUM".equals(input3.getString("COL_ID"))) {
	                    PAY_AMT_SUM  = input3.getLong("COL_VAL"); //거래금액 합계;
	                    System.out.println(PAY_AMT_SUM);
	                }
	                if ("PAY_AMT".equals(input3.getString("COL_ID"))) {
	                    if (input3.getLong("COL_VAL2") > 0) {
	                        TYPE_CD[TYPE_CNT] = input3.getString("COL_VAL3");
	                        System.out.println(TYPE_CD[TYPE_CNT]);
	                        TYPE_AMT[TYPE_CNT] = input3.getLong("COL_VAL2");
	                        System.out.println(TYPE_AMT[TYPE_CNT]);
	                        TYPE_CNT++;
	                    }
	                }
	            }
	            for (int i = 0 ; i < TYPE_CD.length; i++) {
	                if (null == TYPE_CD[i]) {
	                    TYPE_CD[i] = "";
	                }
	            }
	            System.out.println("DDDD");
	            //
	            //2. 영수증 포인트 적립 전문
	             //
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
	            //arrData[ 9] = util.encryptedStr(CARD_NO);  // CARD_NO         C   64
	            arrData[ 9] = CARD_NO;    					 // CARD_NO         C   64
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
	            arrData[41] = "13";                          // ADD_USE_FLAG    C    2		12 : 포스사후적립 -> 13 : 인포사후적립
	            arrData[50] = String.valueOf(POINT);         // ADD_POINT       N    9 49--> 50으로 변경 201111 FKSS
	            
	            //dClientDept client = new dClientDept();
	            //outputArr = client.sendData(arrData);  
	            
	            result = dao.sendData(form, arrData);
	            System.out.println(result);
	            if(result == 0){
	            	//result = dao.saveData(form, arrData);
	            	
	            	/* 20141119 품목별 고객 매출 정보 처리 Start */
		            String[] arrData1   = new String[10];
		            String[] outputArr1 = new String[2];
		            
		            for (int i = 0 ; i < input2.getRowNum() ; i++) {
		                arrData1[ 0]  = STR_CD;								// 점코드
			            arrData1[ 1]  = SALE_DT;								// 매출일자
			            arrData1[ 2]  = CUST_ID;								// 고객번호
			            arrData1[ 3]  = input2.getString("PUMBUN_CD");		// 품번코드
			            arrData1[ 4]  = input2.getString("SALE_AMT");		// 순매출금액
			            arrData1[ 5]  = "0";									// 반품금액
			            arrData1[ 6]  = input2.getString("TOT_SALE_AMT");	// 총매출액
			            arrData1[ 7]  = input2.getString("NORM_SALE_AMT");	// 매출액
			            result = dao.sendPumbunCust(form, arrData1);
			            input3.next();
		            }
	            
		            if(result == 0){
		            }else{
		            	rtnMsg = "영수증 사후적립 에 실패하였습니다.<br>";
		                helper.close(rtnMsg + " 에러코드 [9998]");
		            }
		            /* 20141119 품목별 고객 매출 정보 처리 End */
	            	
	            }else{
	            	rtnMsg = "영수증 사후적립 에 실패하였습니다.<br>";
	                helper.close(rtnMsg + " 에러코드 [9999]");
	            }
	            

	            /*
	            if ("0000".equals(outputArr[REPLAY_CD_POS].trim())) {
	            	
	            } 
	            else { 
	            	result = -1;
	            	rtnCode = "9999";
	                rtnMsg = "영수증 사후적립 전문전송에 실패하였습니다.<br>";
	                helper.close(rtnMsg + " 에러코드 [9999]");
	            }*/
	            
            }
            else {
            	//result = -1;
            	helper.close("이미 승인처리되었습니다.");
            }
            
            //
            if (result == 0 ) {
            	helper.close("정상적으로 처리 되었습니다.");
            }
            else {
            	throw new Exception();
            }
        } catch (Exception e) {
            logger.error("[updateProgram]", e);
            helper.writeException("GAUCE", "002", e.getMessage());
            helper.close (rtnMsg + " 에러코드 [9999]");
        } 
        
        return mapping.findForward(strGoTo);
    }

	

}
