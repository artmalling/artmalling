/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dmbo.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
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
import common.util.OCBNetUtil;
import common.vo.SessionInfo;

import dmbo.dao.DMbo641DAO;
import dmbo.dao.DMbo641sDAO;
/**
 * <p></p>
 * 
 * @created  on 1.0, 2010/01/18
 * @created  by 남형석(FUJITSU KOREA LTD.)
 * 
 * @modified on 1.1, 2010/03/02
 * @modified by 김영진
 * @caused   by OKCASHBAG상품권교환 추가
 */

public class DMbo641Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DMbo641Action.class);

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
     * <p>상품권교환 리스트를 조회한다.</p>
     * 
     */
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

		List list[] = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
        DMbo641DAO   dao    = null; 
        DMbo641sDAO  daoL    = null; 

        String strGoTo = form.getParam("goTo"); // 분기할곳
        String strCardNo = form.getParam("strCardNo"); // 카드번호
        String strPwdNo = form.getParam("strPwdNo"); // 비밀번호
        String strVaildNo = form.getParam("strVaildNo"); // 유효기간
        String strTranNo = "";
        String strEncryptedSign = "";
        String strApprNo = "";	// 원거래승인번호
        String strApprDt = "";	// 원거래승인일자

        try {
            dao    = new DMbo641DAO();
            daoL   = new DMbo641sDAO();
			dSet   = new  GauceDataSet[3];
			list   = new  List[3];

			// 전문번호 SEQ
			strTranNo = dao.getOCBTranNo(form).get("OCB_TRAN_NO").toString();
        	
			// OCBNet 전송을 위한 맵핑
			HashMap<String, String> hm = OCBNetUtil.makeForm("BI", strTranNo, strCardNo, strVaildNo, "0", strPwdNo,
					strApprNo, strApprDt, strEncryptedSign);
        	
        	Hashtable<String, String> m_hash = OCBNetUtil.send(hm);
        	
        	// 전문 송신 정보를 저장한다.
        	daoL.insOCBData(form, hm, m_hash);

        	if (m_hash != null) {
        		// 전문 수신 정보를 저장한다.
        		daoL.updOCBData(form, hm, m_hash);
        	}
        	
			helper = new GauceHelper2(request, response, form);
			dSet[0] = helper.getDataSet("DS_IO_RULE");
			helper.setDataSetHeader(dSet[0], "H_RULE");
			dSet[1] = helper.getDataSet("DS_O_MASTER");
			helper.setDataSetHeader(dSet[1], "H_TODAY");
			dSet[2] = helper.getDataSet("DS_O_CUSTDETAIL");
			helper.setDataSetHeader(dSet[2], "H_OCB_NET_SRCH");

        	// 응답 전문이 없을 때 처리
			if (m_hash == null) {
        		helper.setListToDataset(new ArrayList(), dSet[0]);
        		helper.setListToDataset(new ArrayList(), dSet[1]);

        		List ocb = new ArrayList();
        		ocb.add("0");										// point2:			가용포인트
        		ocb.add("0");										// point1:			발생포인트
        		ocb.add("0");										// point3:			누적포인트
        		ocb.add("OK캐시백 서버 송수신 실패");				// Message1:		메제지1
        		ocb.add("");										// Message2:		메제지2
        		
        		list[2] = new ArrayList();
        		list[2].add(ocb);
        		
        		helper.setListToDataset(list[2], dSet[2]);
        		
			} else {
            	// 응답 전문은 정상 수신, 응답 상태 코드가 거절일 때 처리
        		if (m_hash.get("Status").equals("X")) {
            		helper.setListToDataset(new ArrayList(), dSet[0]);
            		helper.setListToDataset(new ArrayList(), dSet[1]);
            		
            		List ocb = new ArrayList();
            		ocb.add(m_hash.get("point2"));					// point2:			가용포인트
            		ocb.add(m_hash.get("point1"));					// point1:			발생포인트
            		ocb.add(m_hash.get("point3"));					// point3:			누적포인트
            		ocb.add(m_hash.get("Message1"));				// Message1:		메제지1
            		ocb.add(m_hash.get("Message2"));				// Message2:		메제지2
            		
            		list[2] = new ArrayList();
            		list[2].add(ocb);
            		
            		helper.setListToDataset(list[2], dSet[2]);
            		
            	} else {
                    list   = dao.searchMaster(form);
                    
        			for(int i=0;i<list.length;i++){
        				helper.setListToDataset(list[i], dSet[i]);
        			}
        			
            		List ocb = new ArrayList();
            		ocb.add(m_hash.get("point2"));					// point2:			가용포인트
            		ocb.add(m_hash.get("point1"));					// point1:			발생포인트
            		ocb.add(m_hash.get("point3"));					// point3:			누적포인트
            		ocb.add(m_hash.get("Message1"));				// Message1:		메제지1
            		ocb.add(m_hash.get("Message2"));				// Message2:		메제지2

            		list[list.length-1] = new ArrayList();
            		list[list.length-1].add(ocb);
            		
            		helper.setListToDataset(list[list.length-1], dSet[2]);
            	}
        	}
        	
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
    }
    
	 /**
     * <p>상품권금액을 조회한다.</p>
     * 
     */
    public ActionForward searchAmt(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		DMbo641DAO dao = null; 

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new DMbo641DAO();
			helper = new GauceHelper2(request, response, form);
			
			dSet = helper.getDataSet("DS_O_AMT");
			helper.setDataSetHeader(dSet, "H_AMT");
			list = dao.searchAmt(form);
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
     * <p>상품권 교환 소켓통신 및 저장</p>
     * 
     */
    public ActionForward save(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        GauceHelper2 helper = null;
        DMbo641DAO dao      = null;
        GauceDataSet dSet[] = null;
        List list           = null;
		String ret          = "";
        int rtnCode         = 0;
        String rtnMsg       = "";
        String strGoTo = form.getParam("goTo"); // 분기할곳
        
        try {
    		
			helper = new GauceHelper2(request, response, form);
			
			dSet    = new GauceDataSet[3];
			dSet[0] = helper.getDataSet("DS_I_MASTER");
			dSet[1] = helper.getDataSet("DS_I_POINT");
			dSet[2] = helper.getDataSet("DS_IO_RULE");
            
            helper.setDataSetHeader(dSet[0], "H_MASTER");
            helper.setDataSetHeader(dSet[1], "H_POINT");
            helper.setDataSetHeader(dSet[1], "H_RULE");
           
            MultiInput mi[] = new MultiInput[3];
			mi[0] = helper.getMutiInput(dSet[0]);
			mi[1] = helper.getMutiInput(dSet[1]);
			mi[2] = helper.getMutiInput(dSet[2]);

			dao = new DMbo641DAO();
			rtnCode = dao.save(form, mi, request);
			
		} catch (Exception e) {
            e.printStackTrace();
            logger.error("[updateProgram]", e);
            helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			if(-1 == rtnCode){
                throw new Exception("[USER]"+"시스템 장애가 발생하였습니다. 에러코드 [9999]");	
            }else{
            	helper.close(dSet, "정상적으로 처리되었습니다");
            }
		}
		return mapping.findForward(strGoTo);
    }	
    
}

